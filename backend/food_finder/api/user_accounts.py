"""User Accounts Class."""

from django.contrib.auth import authenticate, login, logout
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.models import User, Group
from django.db import IntegrityError


@csrf_exempt
def login_user(request):
    """Authenticate the user.

    If the username and password are correct, return a cookie with a session id
    that identifies them. If they are already logged in, then just
    return a 200 code.
    """
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

    return HttpResponse(status=400)


@csrf_exempt
def logout_user(request):
    """Invalidate the sessionid and logout the user."""
    logout(request)
    return HttpResponse(status=200)


@csrf_exempt
def signup_user(request):
    """Create a new user and log them in."""
    if request.method == 'POST':
        name = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')

        if name is None or email is None or password is None:
            return JsonResponse(
                {"error": "incomplete_values", "text": "Username, email, or password missing."},
                status=400)

        try:
            user = User.objects.create_user(name, email, password)
            user_group = Group.objects.get(name='User')
            user_group.user_set.add(user)
            login(request, user)
            return HttpResponse(status=200)
        except IntegrityError:
            return JsonResponse({"error": "invalid_username", "text": "Username already taken."}, status=403)

    else:
        return HttpResponse(status=400)
