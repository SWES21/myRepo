from django.contrib import admin

from .models import Restaurant, Profile

"""
Registers the 2 custom models we created in the django admin panel.
This can be found at localhost:8000/admin

Essentially gives admins the ability to control users accounts and
restaurants.
"""
admin.site.register(Restaurant)
admin.site.register(Profile)
