from django.test import TestCase
from django.http import HttpResponse

from .models import Restaurant
from . import restaurant_data

class RestaurantTestCase(TestCase):
    def test_tests(self):
        self.assertEqual(True, False)
