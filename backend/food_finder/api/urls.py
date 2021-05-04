from django.urls import path

from . import restaurant_data
from . import user_accounts

urlpatterns = [
    path('restaurant/new', restaurant_data.restaurant_add, name='restaurant-new'),
    path('restaurant/<int:restaurant_id>', restaurant_data.restaurant_detail, name='restaurant-detail'),

    # path('user/get_recommendations'i, )

    path('login/', user_accounts.login_user),
    path('logout/', user_accounts.logout_user),
    path('signup/', user_accounts.signup_user)
]
