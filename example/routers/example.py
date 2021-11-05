from fastapi import APIRouter

router = APIRouter(prefix='/example', tags=['example'])


@router.get("/")
def compute_volume_attribution():
    return 'example'
