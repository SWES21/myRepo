from django.db import models
from django.utils.translation import gettext_lazy as _

# Create your models here.

class Restaurant(models.Model):
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

    name = models.CharField(max_length=200)
    category = models.IntegerField(choices=Classification.choices)
    rating = models.DecimalField(max_digits=1, decimal_places=1)
    num_ratings = models.IntegerField()
    price = models.IntegerField()
