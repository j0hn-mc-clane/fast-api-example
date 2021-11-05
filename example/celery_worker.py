import config
from celery import Celery

celery = Celery(__name__)
celery.config_from_object(config)

if not celery.conf.broker_url:
    raise ValueError('Broker URL not supplied')
if not celery.conf.result_backend:
    raise ValueError('Result Backend URL not supplied')


@celery.task(name='do_this_with_worker')
def do_this_with_worker():
    return 'Did it'
