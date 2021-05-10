"""User Preference Class."""
import json
import random
from functools import reduce
import numpy as np

from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.forms.models import model_to_dict
from django.db.models import Q
from .models import Restaurant


# pylint: disable=no-member
@csrf_exempt
def get_recommendations(request):
    """Get recommendations for user.

    This is the function that gets run after the recommendations/get endpoint.
    It is responsible for pulling the user data, calculate the recommendations
    and adjust for filters.
    """
    if not request.method == 'GET':
        return HttpResponse(status=400)

    if not request.user.is_authenticated:
        return HttpResponse(status=401)

    filters = None

    if 'filters' in request.GET:
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

    categories = np.random.choice(vec.size, 10, p=vec)

    recommendations = []
    for category in categories:
        choices = Restaurant.objects.filter(category=category)

        if filters is not None:
            choices = choices.filter(reduce(
                lambda x, y: x | y, [Q(price=price) for price in filters['price']]
            ))

        print(choices)

        if choices.count() != 0:
            random_item = random.choice(choices)
            recommendations.append(model_to_dict(random_item))

    return JsonResponse({'recommendations': recommendations}, status=200)


@csrf_exempt
def update_preferences_liked(request):
    """Update preferences with like request."""
    return update_preferences(request, True)


@csrf_exempt
def update_preferences_disliked(request):
    """Update preferences with disliked request."""
    return update_preferences(request, False)


def update_preferences(request, liked):
    """Verify integrity of request and user, then update recommendations.

    It grabs the user, make sure they are authenticated, and submitted a
    proper request to the server. If so, it will grab the restaurant they liked,
    and call the update_profile_recommendations function.
    """
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


def update_profile_recommendations(user, category, liked):
    """Update the users preference vector given the category and whether they liked it."""
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


def get_user_preferences_vec(user):
    """Return the parsed preference vec of the user."""
    obj = json.loads(user.profile.preference_vec)
    return obj['preference_vec']
