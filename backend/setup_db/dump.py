import csv
import requests

with open('rdb.csv', newline='') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    for row in reader:
        payload = {'name': row[1], 'category': row[2], 'rating': row[3], 'num_ratings': row[4], 'price': row[5], 'latitude': row[6], 'longitude': row[7]}
        headers = {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Cookie': 'csrftoken=3qFd73terPY2zbLA9Ot17Sza3KytQJxU4ZJVoGPExMWvmzrJqrOsyVXp8MthkHbV; sessionid=mx8fnhizhsqt6rvni4gt13hlsszfwsau'
        }
        requests.put('http://csds393.herokuapp.com/api/restaurant/new', data=payload, headers=headers)
