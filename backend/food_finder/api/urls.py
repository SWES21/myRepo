from django.urls import path

from . import restaurant_data
from . import user_accounts

urlpatterns = [
    path('restaurant/new', restaurant_data.restaurant_add),
    path('restaurant/<str:restaurant_name>', restaurant_data.restaurant_detail),
    path('login/', user_accounts.login_user),
    path('logout/', user_accounts.logout_user),
    path('signup/', user_accounts.signup_user)
]
