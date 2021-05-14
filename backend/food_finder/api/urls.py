from django.urls import path

from . import restaurant_data
from . import user_accounts
from . import preference_data

"""
Sets the URL patterns and what function endpoints they redirect to. It also
sets names for the endpoints, which assits in testing.
"""
urlpatterns = [
    path('restaurant/new', restaurant_data.restaurant_add, name='restaurant-new'),
    path('restaurant/<int:restaurant_id>', restaurant_data.restaurant_detail, name='restaurant-detail'),

    path('user/recommendations/update/liked', preference_data.update_preferences_liked, name='update-pref-like'),
    path('user/recommendations/update/disliked', preference_data.update_preferences_disliked,
         name='update-pref-dislike'),
    path('user/recommendations/get', preference_data.get_recommendations),

    path('login/', user_accounts.login_user, name='login'),
    path('logout/', user_accounts.logout_user, name='logout'),
    path('signup/', user_accounts.signup_user, name='signup')
]
