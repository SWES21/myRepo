from django.urls import path

from . import restaurant_data
from . import user_accounts
from . import preference_data

urlpatterns = [
    path('restaurant/new', restaurant_data.restaurant_add, name='restaurant-new'),
    path('restaurant/<int:restaurant_id>', restaurant_data.restaurant_detail, name='restaurant-detail'),

    path('user/update_preferences/liked', preference_data.update_preferences_liked),

    path('login/', user_accounts.login_user, name='login'),
    path('logout/', user_accounts.logout_user, name='logout'),
    path('signup/', user_accounts.signup_user, name='signup')
]
