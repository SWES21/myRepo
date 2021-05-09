from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.http import QueryDict
from django.core import serializers
from django.forms.models import model_to_dict
from decimal import Decimal

import json
from .models import Restaurant

"""
Upon a proper request for restaurant detail, it takes the restaurant id and
returns the basic information stored about it.
"""
@csrf_exempt
def restaurant_detail(request, restaurant_id):
    if request.method == 'GET':
        restaurant = Restaurant.objects.get(id=restaurant_id)
        return JsonResponse(model_to_dict(restaurant), content_type='application/json', status=200)

    else:
        return HttpResponse(status=400)

"""
This is an admin command to programatically add new restaurants to the databse.
It ensures the user is authenticated and is a staff member (that is they have
permissions to add restaurants). if so, it then takes the fields from the PUT
request and adds the restaurant. If the restaurant exists, it update it. If not,
it will insert a new restaurant.
"""
@csrf_exempt
def restaurant_add(request):
    if request.user.is_authenticated and request.user.is_staff:
        if request.method == 'PUT':
            PUT         = QueryDict(request.body)
            name        = PUT.get('name')
            category    = Restaurant.Classification.from_string(PUT.get('category'))
            rating      = PUT.get('rating')
            num_ratings = PUT.get('num_ratings')
            price       = PUT.get('price')
            latitude    = PUT.get('latitude')
            longitude   = PUT.get('longitude')

            if name is None or category is None or rating is None \
               or rating is None or num_ratings is None or price is None \
               or latitude is None or longitude is None:
                return JsonResponse({"error": "Missing required fields."}, status=400)

            try:
                obj = Restaurant.objects.get(name=name, category=category, latitude=latitude, longitude=longitude)
                obj.rating = rating
                obj.num_ratings = num_ratings
                obj.price = price
                obj.latitude = latitude
                obj.longitude = longitude
                obj.save()
            except Restaurant.DoesNotExist:
                obj = Restaurant(name=name, category=category, rating=rating, num_ratings=num_ratings,
                                 price=price, latitude=latitude, longitude=longitude)
                obj.save()

            return HttpResponse(status=200)

        else:
            return HttpResponse(status=400)

    else:
        return HttpResponse(status=401)
