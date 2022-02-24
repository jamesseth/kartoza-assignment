"""Common django view implementations."""
from django.views.decorators.http import require_http_methods
from django.http import HttpResponse

@require_http_methods(['GET'])
def health_check_view(request):  # noqa pylint:disable=unused-argument
    """
    Health chech endpoint.
    
    :return: A status 200 if healthy.
    """
    return HttpResponse('Healthy')
