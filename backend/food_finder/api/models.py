from django.db import models
from django.db.models.signals import post_save
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import User
from django.dispatch import receiver

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    preference_vec = models.TextField(default=
                                     '{"preference_vec": [0, 0, 0, 0, 0, 0, 0, 0, ' \
                                     '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}')

    @receiver(post_save, sender=User)
    def create_user_profile(sender, instance, created, **kwargs):
        if created:
            Profile.objects.create(user=instance)

    @receiver(post_save, sender=User)
    def save_user_profile(sender, instance, **kwargs):
        instance.profile.save()

    def __str__(self):
        return self.user.username


class Restaurant(models.Model):
    class Meta:
        unique_together = ('name', 'category')

    class Classification(models.IntegerChoices):
        AMERICAN = 0, _('American')
        FRENCH = 1, _('French')
        CAFE = 2, _('Cafe')
        SOUTHERN = 3, _('Southern')
        ITALIAN = 4, _('Italian')
        MEXICAN = 5, _('Mexican')
        BBQ = 6, _('BBQ')
        ICE_CREAM = 7, _('Ice Cream')
        VIETNAMESE = 8, _('Vietnamese')
        CHINESE = 9, _('Chinese')
        MEDITERRANEAN = 10, _('Mediterranean')
        CAJUN = 11, _('Cajun')
        JAPANESE = 12, _('Japanese')
        SEAFOOD = 13, _('Seafood')
        THAI = 14, _('Thai')
        CARIBBEAN = 15, _('Caribbean')
        KOREAN = 16, _('Korean')
        SZECHUAN = 17, _('Szechuan')
        INDIAN = 18, _('Indian')
        BRAZILIAN = 19, _('Brazilian')
        LATIN_AMERI = 20, _('Latin American')

        @classmethod
        def from_string(cls, value):
            for choice in cls.choices:
                if choice[1] == value:
                    return choice[0]

    name = models.CharField(max_length=200)
    category = models.IntegerField(choices=Classification.choices)
    rating = models.DecimalField(max_digits=3, decimal_places=1)
    num_ratings = models.IntegerField()
    price = models.IntegerField()
    latitude = models.DecimalField(default=0, max_digits=13, decimal_places=10)
    longitude = models.DecimalField(default=0, max_digits=13, decimal_places=10)

    def __str__(self):
        return self.name
