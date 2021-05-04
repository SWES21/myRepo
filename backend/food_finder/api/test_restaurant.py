from django.test import TestCase
from django.http import HttpResponse
from django.urls import reverse

from .models import Restaurant
from . import restaurant_data

def create_restaurant(name, category, rating, num_ratings, price, lat, lon):
    return Restaurant.objects.create(name=name, category=category, rating=rating,
                                     num_ratings=num_ratings, price=price,
                                     latitude=lat, longitude=lon)

class RestaurantTestCase(TestCase):
    def test_name(self):
        restaurant = create_restaurant('Test', 1, 2, 3, 4, 5, 6)
        self.assertIs(str(restaurant), 'Test')

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
