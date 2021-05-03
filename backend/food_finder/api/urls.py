from django.urls import path

from . import views
from . import user_accounts

urlpatterns = [
    path('restaurant/<str:restaurant_name>', views.restaurant_detail),
    path('login/', user_accounts.login_user),
    path('logout/', user_accounts.logout_user),
    path('signup/', user_accounts.signup_user)
]
