from django.contrib.auth import authenticate, login, logout
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse, JsonResponse

@csrf_exempt
def login_user(request):
    if request.method == 'POST':
        if request.user.is_authenticated:
            return HttpResponse(200)

        username = request.POST.get('username')
        password = request.POST.get('password')

        user = authenticate(username=username, password=password)
        if user is not None:
            login(request, user)
            return HttpResponse(status=200)

        return HttpResponse(status=401)

    else:
        return HttpResponse(status=400)


@csrf_exempt
def logout_user(request):
    logout(request)
    return HttpResponse(200)
