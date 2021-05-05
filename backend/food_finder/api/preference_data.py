from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.forms.models import model_to_dict

import json
import random
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

    total = sum(vec) + len(vec)
    for item in vec:
        prob = (item + 1)/total
        if prob == 0:
            prob = 1/total

        probabilities.append(prob)

    categories = []
    while len(categories) <= 10:
        for i, prob in enumerate(probabilities):
            if len(categories) > 10:
                break

            epsilon = random.uniform(0, 1)
            if epsilon < prob:
                categories.append(i)

    recommendations = []
    for category in categories:
        choices = Restaurant.objects.filter(category=category)
        random_item = random.choice(choices)
        recommendations.append(model_to_dict(random_item))

    return JsonResponse({'recommendations': recommendations}, status=200)

@csrf_exempt
def update_preferences_liked(request):
    if not request.method == 'POST' or request.POST.get('restaurant_id') is None:
        return HttpResponse(status=400)

    if not request.user.is_authenticated:
        return HttpResponse(status=401)

    restaurant_id = request.POST.get('restaurant_id')
    restaurant = Restaurant.objects.get(id=restaurant_id)
    restaurant_category = restaurant.category
    user = request.user

    update_profile_recommendations(user, restaurant_category, True)

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
