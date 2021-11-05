from fastapi import FastAPI
from starlette.responses import JSONResponse
from celery_worker import do_this_with_worker
from fastapi.security import OAuth2PasswordBearer
from routers import example


api = FastAPI()
api.include_router(example.router)


@api.post('/test')
def test_celery():
    task = do_this_with_worker.delay()
    return JSONResponse({"Result": task.get()})
