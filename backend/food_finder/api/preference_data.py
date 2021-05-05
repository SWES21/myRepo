from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.forms.models import model_to_dict

import json
import random
import numpy as np
from .models import Restaurant

@csrf_exempt
def get_recommendations(request):
    if not request.method == 'GET':
        return HttpResponse(status=400)

    if not request.user.is_authenticated:
        return HttpResponse(status=401)

    user = request.user

    vec = get_user_preferences_vec(user)
    probabilities = []

    vec = np.array(vec)
    total = np.sum(vec) + vec.size
    probabilities = (vec + 1) / total
    probabilities[probabilities == 0] = 1 / total

    categories = np.random.choice(np.arange(vec.size), 10, p = probabilities)

    recommendations = []
    for category in categories:
        choices = Restaurant.objects.filter(category=category)
        while choices.count() == 0:
            choices = Restaurant.objects.filter(category=np.random.randint(0, 21))
        random_item = random.choice(choices)
        recommendations.append(model_to_dict(random_item))

    return JsonResponse({'recommendations': recommendations}, status=200)

@csrf_exempt
def update_preferences_liked(request):
    return update_preferences(request, True)

@csrf_exempt
def update_preferences_disliked(request):
    return update_preferences(request, False)

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

def get_user_preferences_vec(user):
    obj = json.loads(user.profile.preference_vec)
    return obj['preference_vec']

# TODO: set_user_preferences_vec
