from django.test import TestCase, Client, RequestFactory
from django.contrib.auth.models import User, Group
from django.urls import reverse

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
        self.assertTrue(str(self.user.profile), 'ford')

    def test_update_prefs_liked(self):
        url = '/api/user/recommendations/update/liked'
        response = Client().get(url) # Needs to create new instance otherwise it doesnt work, django bug.
        self.assertEqual(response.status_code, 400)

        response = Client().post(url)
        self.assertEqual(response.status_code, 400)

        response = Client().post(url, {'restaurant_id': 5})
        self.assertEqual(response.status_code, 401)

        restaurant = create_restaurant('Test', 0, 4.5, 3, 2, 1, -1)
        response = self.create_request(url, 'POST', preference_data.update_preferences_liked,
                                       data='restaurant_id=' + str(restaurant.id))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(self.user.profile.preference_vec,
                         '{"preference_vec": [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}')
