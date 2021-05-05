from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.http import QueryDict
from django.core import serializers
from django.forms.models import model_to_dict
from decimal import Decimal

import json
from .models import Restaurant

@csrf_exempt
def restaurant_detail(request, restaurant_id):
    if request.method == 'GET':
        restaurant = Restaurant.objects.get(id=restaurant_id)
        model_dict = model_to_dict(restaurant)
        return JsonResponse(model_dict, encoder=RestaurantJSONEncoder, status=200)

    else:
        return HttpResponse(status=400)

@csrf_exempt
def restaurant_add(request):
    if request.user.is_authenticated:
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
                obj = Restaurant.objects.get(name=name, category=category)
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


class RestaurantJSONEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Decimal):
            return float(obj)
        return json.JSONEncoder.default(self, obj)
