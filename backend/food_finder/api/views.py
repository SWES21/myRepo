from django.shortcuts import render
from django.http import HttpResponse, JsonResponse

from django.contrib.auth.models import User, Group
from rest_framework import viewsets
from rest_framework import permissions

def restaurant_detail(request, restaurant_name):
    if request.method == 'GET':
        return HttpResponse("Welcome to, " + restaurant_name)

    elif request.method == 'PUT':
        return JsonResponse(b'{error: "error"}', status=400)

    elif request.method == 'DELETE':
        return HttpResponse(status=204)

