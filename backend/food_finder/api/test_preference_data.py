from django.test import TestCase, Client, RequestFactory
from django.contrib.auth.models import User, Group
from django.urls import reverse

import json
from .models import Restaurant
from . import preference_data

def create_restaurant(name, category, rating, num_ratings, price, lat, lon):
    return Restaurant.objects.create(name=name, category=category, rating=rating,
                                     num_ratings=num_ratings, price=price,
                                     latitude=lat, longitude=lon)

class PreferenceDataTestCase(TestCase):
    def setUp(self):
        self.user = User.objects.create_user('ford', 'fms34@case.edu', 'toor')
        self.request_fac = RequestFactory()

    def create_request(self, url, method, func, data=None):
        if data is None:
            data = {'random': 'data'}

        req = self.request_fac.post(url, data, content_type='application/x-www-form-urlencoded')
        req.method = method
        req.user = self.user

        return func(req)

    def test_profile_name(self):
        self.assertTrue(self.user.profile)
        self.assertEqual(str(self.user.profile), 'ford')

    def test_get_recommendations(self):
        url = '/api/user/recommendations/get'

        response = Client().post(url)
        self.assertEqual(response.status_code, 400)

        response = Client().get(url)
        self.assertEqual(response.status_code, 401)

        for i in range(0, 15):
            create_restaurant('Test' + str(i), i, 4.5, 3, 2, 1, -1)

        response = self.create_request(url, 'GET', preference_data.get_recommendations)
        self.assertEqual(response.status_code, 200)

        response = self.create_request(url + '?filters={"type": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],"price": ' \
                                       '[2],"distance": 25,"latitude": 1,"longitude": -1}', 'GET',
                                       preference_data.get_recommendations)
        self.assertEqual(response.status_code, 200)

        response = self.create_request(url + '?filters={"type": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],"price": ' \
                                       '[2],"distance": 25,"latitude": 100,"longitude": -100}', 'GET',
                                       preference_data.get_recommendations)
        self.assertEqual(response.status_code, 200)
        response_json = json.loads(response.content)
        self.assertEqual(len(response_json['recommendations']), 0)

        self.user.profile.preference_vec = '{"preference_vec": [2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}'
        response = self.create_request(url, 'GET', preference_data.get_recommendations)
        self.assertEqual(response.status_code, 200)

    def test_user_preferences_vec(self):
        preference_vec = preference_data.get_user_preferences_vec(self.user)
        self.assertEqual(preference_vec,
                         [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                          0, 0, 0, 0, 0, 0, 0, 0])

    def test_update_prefs_liked(self):
        url = '/api/user/recommendations/update/liked'
        self.helper_test(url)

        restaurant = create_restaurant('Test', 0, 4.5, 3, 2, 1, -1)
        response = self.create_request(url, 'POST', preference_data.update_preferences_liked,
                                       data='restaurant_id=' + str(restaurant.id))
        self.assertEqual(response.status_code, 200)
        preference_vec = preference_data.get_user_preferences_vec(self.user)
        self.assertEqual(preference_vec,
                         [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                          0, 0, 0, 0, 0])

    def test_update_prefs_disliked(self):
        url = '/api/user/recommendations/update/disliked'
        self.helper_test(url)

        restaurant = create_restaurant('Test', 0, 4.5, 3, 2, 1, -1)
        response = self.create_request(url, 'POST', preference_data.update_preferences_disliked,
                                       data='restaurant_id=' + str(restaurant.id))
        self.assertEqual(response.status_code, 200)
        preference_vec = preference_data.get_user_preferences_vec(self.user)
        self.assertEqual(preference_vec,
                         [-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                          0, 0, 0, 0, 0])

    def helper_test(self, url):
        response = Client().get(url) # Needs to create new instance otherwise it doesnt work, django bug.
        self.assertEqual(response.status_code, 400)

        response = Client().post(url)
        self.assertEqual(response.status_code, 400)

        response = Client().post(url, {'restaurant_id': 5})
        self.assertEqual(response.status_code, 401)
