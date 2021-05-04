from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt

import json
from .models import Restaurant

@csrf_exempt
def update_preferences_liked(request):
    if not request.method == 'POST': # or request.POST.get('restaurant_id') is None:
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
