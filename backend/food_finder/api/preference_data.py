""" User Preference Class """

from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.forms.models import model_to_dict

import json
import random
import numpy as np
from .models import Restaurant

"""
This is the function that gets run after the recommendations/get endpoint.
It is responsible for pulling the user data, calculate the recommendations
and adjust for filters.
"""
@csrf_exempt
def get_recommendations(request):
    if not request.method == 'GET':
        return HttpResponse(status=400)

    if not request.user.is_authenticated:
        return HttpResponse(status=401)

    filters = None

    if 'type' in request.GET and 'price' in request.GET and 'distance' in request.GET:
        filters = json.loads(request.GET['filters'])

    user = request.user

    vec = np.array(get_user_preferences_vec(user))
    vec += 1
    if vec.max() == vec.min():
        vec = vec/vec.sum()
    else:
        vec = (vec - vec.min())/(vec.max() - vec.min())

    vec[vec == 0] = 1/vec.sum()

    if filters is not None and filters['type'] is not None:
        vec[np.delete(np.arange(vec.size), filters['type'])] = 0

    vec = vec/vec.sum()

    categories = np.random.choice(vec.size, 10, p = vec)

    recommendations = []
    for category in categories:
        choices = Restaurant.objects.filter(category=category)
        # Filter by price if filters exits. I think with these conditions,
        # it is just save to remove while choices is 0, and just don't add
        # anything if that is the case
        while choices.count() == 0:
            choices = Restaurant.objects.filter(category=np.random.randint(0, 21))
        random_item = random.choice(choices)
        recommendations.append(model_to_dict(random_item))

    return JsonResponse({'recommendations': recommendations}, status=200)

"""
This is the endpoint that is called when a user likes a recommendation
"""
@csrf_exempt
def update_preferences_liked(request):
    return update_preferences(request, True)

"""
This is the endpoint that is called when a user dislikes a recommendation
"""
@csrf_exempt
def update_preferences_disliked(request):
    return update_preferences(request, False)


"""
This is the helper method that starts to actually do the computation.
It grabs the user, make sure they are authenticated, and submitted a
proper request to the server. If so, it will grab the restaurant they liked,
and call the update_profile_recommendations function.
"""
def update_preferences(request, liked):
    if not request.method == 'POST' or request.POST.get('restaurant_id') is None:
        return HttpResponse(status=400)

    if not request.user.is_authenticated:
        return HttpResponse(status=401)

    restaurant_id = request.POST.get('restaurant_id')
    restaurant = Restaurant.objects.get(id=restaurant_id)
    restaurant_category = restaurant.category
    user = request.user

    update_profile_recommendations(user, restaurant_category, liked)

    return HttpResponse(status=200)

"""
This helper function takes the user, category, and whether it was liked
and actually updates the users preference vector.
"""
def update_profile_recommendations(user, category, liked):
    like = 0
    if liked:
        like = 1
    else:
        like = -1

    vec = json.loads(user.profile.preference_vec)

    preferences = vec['preference_vec']
    preferences[category] += like

    vec['preference_vec'] = preferences
    user.profile.preference_vec = json.dumps(vec)

    user.save()


"""
Given the user, returns the parsed preference vec.
"""
def get_user_preferences_vec(user):
    obj = json.loads(user.profile.preference_vec)
    return obj['preference_vec']

# TODO: set_user_preferences_vec
