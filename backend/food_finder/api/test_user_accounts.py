from django.test import TransactionTestCase, Client

from django.contrib.auth.models import User, Group
from . import user_accounts

class UserAccountTestCase(TransactionTestCase):
    def setUp(self):
        self.user = User.objects.create_user('ford', 'fms34@case.edu', 'root')
        self.user.save()
        group = Group.objects.create(name='User')
        group.save()
        self.client = Client()

    def test_login(self):
        url = '/api/login/'
        response = self.client.get(url)
        self.assertEqual(response.status_code, 400)

        response = self.client.post(url, {'username': 'ford', 'password': 'incorrect'})
        self.assertEqual(response.status_code, 401)

        response = self.client.post(url, {'username': 'ford', 'password': 'root'})
        self.assertEqual(response.status_code, 200)

        response = self.client.post(url, {'username': 'ford', 'password': 'root'})
        self.assertEqual(response.status_code, 200)

    def test_logout(self):
        response = self.client.get('/api/logout/')
        self.assertEqual(response.status_code, 200)

    def test_signup(self):
        url = '/api/signup/'

        response = self.client.get(url)
        self.assertEqual(response.status_code, 400)

        response = self.client.post(url, {})
        self.assertEqual(response.status_code, 400)

        response = self.client.post(url, {'username': 'ford', 'email': 'me@case.edu', 'password': '1'})
        self.assertEqual(response.status_code, 403)

        response = self.client.post(url, {'username': 'something', 'email': 'u@case.edu', 'password': 'ye'})
        self.assertEqual(response.status_code, 200)
