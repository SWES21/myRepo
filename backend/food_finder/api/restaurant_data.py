"""Restaurant Data Class."""

from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.http import QueryDict
from django.forms.models import model_to_dict
from .models import Restaurant


# pylint: disable=no-member
@csrf_exempt
def restaurant_detail(request, restaurant_id):
    """Take the restaurant id and returns the basic information stored about it."""
    if request.method == 'GET':
        restaurant = Restaurant.objects.get(id=restaurant_id)
        return JsonResponse(model_to_dict(restaurant), content_type='application/json', status=200)

    return HttpResponse(status=400)


# pylint: disable=no-member
# pylint: disable=invalid-name
@csrf_exempt
def restaurant_add(request):
    """Admin command to programatically add new restaurants to the databse.

    It ensures the user is authenticated and is a staff member (that is they have
    permissions to add restaurants). if so, it then takes the fields from the PUT
    request and adds the restaurant. If the restaurant exists, it update it. If not,
    it will insert a new restaurant.
    """
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

            # pylint: disable=too-many-boolean-expressions
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

        return HttpResponse(status=400)

    return HttpResponse(status=401)
