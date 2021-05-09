from django.contrib.auth import authenticate, login, logout
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.models import User, Group
import json

"""
On a proper POST request, authenticate the user. If the username
and password are correct, return a cookie with a session id
that identifies them. If they are already logged in, then just
return a 200 code.
"""
@csrf_exempt
def login_user(request):
    if request.method == 'POST':
        if request.user.is_authenticated:
            return HttpResponse(status=200)

        username = request.POST.get('username')
        password = request.POST.get('password')

        user = authenticate(username=username, password=password)
        if user is not None:
            login(request, user)
            return HttpResponse(status=200)

        return HttpResponse(status=401)

    else:
        return HttpResponse(status=400)


"""
Invalidate the sessionid and logout the user.
"""
@csrf_exempt
def logout_user(request):
    logout(request)
    return HttpResponse(status=200)


"""
Upon a proper request, create a new user account and log them in.
"""
@csrf_exempt
def signup_user(request):
    if request.method == 'POST':
        name = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')

        if name is None or email is None or password is None:
            return JsonResponse({"error": "incomplete_values", "text": "Username, email, or password missing."}, status=400)

        try:
            user = User.objects.create_user(name, email, password)
            user_group = Group.objects.get(name='User')
            user_group.user_set.add(user)
            login(request, user)
            return HttpResponse(status=200)
        except:
            return JsonResponse({"error": "invalid_username", "text": "Username already taken."}, status=403)

    else:
        return HttpResponse(status=400)
