from django.db import models

class Counter(models.Model):
    value = models.IntegerField(default=1)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    RESET_THRESHOLD = 1000000000

    def increment(self, amount=1):
        self.value += amount
        if self.value > self.RESET_THRESHOLD:
            self.value = 0
        self.save()
