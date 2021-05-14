from django.test import TestCase, Client, RequestFactory
from django.http import HttpResponse
from django.urls import reverse
from django.contrib.auth.models import User
from django.forms.models import model_to_dict

from .models import Restaurant
from . import restaurant_data

def create_restaurant(name, category, rating, num_ratings, price, lat, lon):
    return Restaurant.objects.create(name=name, category=category, rating=rating,
                                     num_ratings=num_ratings, price=price,
                                     latitude=lat, longitude=lon)

class RestaurantTestCase(TestCase):
    def setUp(self):
        self.user = User.objects.create_user('ford', 'fms34@case.edu', 'root', is_staff=True)
        self.client = Client()
        self.request_fac = RequestFactory()


    def create_request(self, url, method, func, data=None, user=False):
        if data is None:
            data = {'random': 'data'}

        req = self.request_fac.post(url, data, content_type='application/x-www-form-urlencoded')
        req.method = method
        if user is True:
            req.user = self.user

        return func(req)


    def test_restaurant_add(self):
        url = '/api/restaurant/new'

        response = self.client.get(url)
        self.assertEqual(response.status_code, 401)

        response = self.create_request(url, 'POST', restaurant_data.restaurant_add, user=True)
        self.assertEqual(response.status_code, 400)

        response = self.create_request(url, 'PUT', restaurant_data.restaurant_add, user=True)
        self.assertEqual(response.status_code, 400)

        response = self.create_request(url, 'PUT', restaurant_data.restaurant_add,
                                       data='name=Test&category=American&rating=4.5&num_ratings=111&' \
                                       'price=2&latitude=41.03286&longitude=-81.39326', user=True)
        self.assertEqual(response.status_code, 200)

        restaurant = Restaurant.objects.get(name='Test', latitude=41.03286, longitude=-81.39326)
        self.assertTrue(restaurant)
        self.assertEqual(restaurant.num_ratings, 111)

        response = self.create_request(url, 'PUT', restaurant_data.restaurant_add,
                                       data='name=Test&category=American&rating=4.5&num_ratings=999&' \
                                       'price=2&latitude=41.03286&longitude=-81.39326', user=True)
        self.assertEqual(response.status_code, 200)

        restaurant = Restaurant.objects.get(name='Test')
        self.assertTrue(restaurant)
        self.assertEqual(restaurant.num_ratings, 999)

    def test_get_details(self):
        response = self.client.post('/api/restaurant/1')
        self.assertEqual(response.status_code, 400)

        restaurant = create_restaurant('Test', 0, 4.5, 999, 2, 1, -2)
        response = self.client.get('/api/restaurant/1')
        self.assertEqual(model_to_dict(restaurant), {'id': 1, 'name': 'Test', 'category': 0,
                                             'rating': 4.5, 'num_ratings': 999,
                                             'price': 2, 'latitude': 1,
                                             'longitude': -2})

    def test_dict(self):
        restaurant = create_restaurant('Test', 0, 4.5, 999, 2, 1, -2)
        self.assertEqual(model_to_dict(restaurant), {'id': 1, 'name': 'Test', 'category': 0,
                                             'rating': 4.5, 'num_ratings': 999,
                                             'price': 2, 'latitude': 1,
                                             'longitude': -2})

    def test_name(self):
        restaurant = create_restaurant('AnotherTest', 1, 2, 3, 4, 5, 6)
        self.assertIs(str(restaurant), 'AnotherTest')

    def test_urls(self):
        add_restaurant_url    = reverse('restaurant-new')
        restaurant_detail_url = reverse('restaurant-detail', args=[5])
        self.assertEqual(add_restaurant_url,    '/api/restaurant/new')
        self.assertEqual(restaurant_detail_url, '/api/restaurant/5')

    def test_classification(self):
        self.assertIs(Restaurant.Classification.from_string('American'),       0)
        self.assertIs(Restaurant.Classification.from_string('French'),         1)
        self.assertIs(Restaurant.Classification.from_string('Cafe'),           2)
        self.assertIs(Restaurant.Classification.from_string('Southern'),       3)
        self.assertIs(Restaurant.Classification.from_string('Italian'),        4)
        self.assertIs(Restaurant.Classification.from_string('Mexican'),        5)
        self.assertIs(Restaurant.Classification.from_string('BBQ'),            6)
        self.assertIs(Restaurant.Classification.from_string('Ice Cream'),      7)
        self.assertIs(Restaurant.Classification.from_string('Vietnamese'),     8)
        self.assertIs(Restaurant.Classification.from_string('Chinese'),        9)
        self.assertIs(Restaurant.Classification.from_string('Mediterranean'),  10)
        self.assertIs(Restaurant.Classification.from_string('Cajun'),          11)
        self.assertIs(Restaurant.Classification.from_string('Japanese'),       12)
        self.assertIs(Restaurant.Classification.from_string('Seafood'),        13)
        self.assertIs(Restaurant.Classification.from_string('Thai'),           14)
        self.assertIs(Restaurant.Classification.from_string('Caribbean'),      15)
        self.assertIs(Restaurant.Classification.from_string('Korean'),         16)
        self.assertIs(Restaurant.Classification.from_string('Szechuan'),       17)
        self.assertIs(Restaurant.Classification.from_string('Indian'),         18)
        self.assertIs(Restaurant.Classification.from_string('Brazilian'),      19)
        self.assertIs(Restaurant.Classification.from_string('Latin American'), 20)
