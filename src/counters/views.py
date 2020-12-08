from django.shortcuts import render
from django.http import HttpResponse

from .models import Counter

def index(request):
    counter = Counter.objects.last()
    if counter:
        counter.increment()
    else:
        counter = Counter()
        counter.save()
    context = {'count': counter.value}
    return render(request, 'counters/index.html', context)
