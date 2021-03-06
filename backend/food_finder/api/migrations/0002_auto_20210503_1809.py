# Generated by Django 3.2 on 2021-05-03 18:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Restaurant',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('category', models.IntegerField(choices=[(0, 'No'), (1, 'Yes')])),
                ('rating', models.DecimalField(decimal_places=1, max_digits=1)),
                ('num_ratings', models.IntegerField()),
                ('price', models.IntegerField()),
            ],
        ),
        migrations.DeleteModel(
            name='Choice',
        ),
        migrations.DeleteModel(
            name='Question',
        ),
    ]
