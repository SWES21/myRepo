from django.urls import path

from . import views
from . import login

urlpatterns = [
    path('restaurant/<str:restaurant_name>', views.restaurant_detail),
    path('login/', login.login_user),
    path('logout/', login.logout_user)
]
