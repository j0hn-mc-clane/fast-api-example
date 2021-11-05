## Example API
*To be honest I would use PyCharm as an IDE for this project*
### Package Management - Poetry
Why poetry you ask?

Here's a [nice read](https://nanthony007.medium.com/stop-using-pip-use-poetry-instead-db7164f4fc72#:~:text=Publishing%20Packages,publish%20to%20other%2Fprivate%20repositories.)
### Docker
The different required services (at least for now in local environment) are composed
using - you guessed it- a docker-compose.local.yml file

The images that are being built for our own applications:
1. API: FastApi image running on uvicorn
2. Celery: Distributed Task Queue for running Background Tasks (outside of the HTTP context)
3. Flower: monitoring tool for Celery (I dont really like the CLI)

Currently the images are built for 2 targets: development and production

I still need to implement appropriate .env files for the environments


#### Build and Compose
Now, to get started:

(if you have cloned the repository simply cd into repo)

`````shell
docker compose -f docker-compose-local.yml  build --no-cache --force-rm && docker compose -f docker-compose-local.yml up
`````

## Resources

- [Docker Compose reference](https://docs.docker.com/compose/compose-file/)
- [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
- [Poetry reference](https://python-poetry.org/docs/)
- [FastAPI reference](https://fastapi.tiangolo.com/)
- [Flower](https://flower.readthedocs.io/en/latest/)
- [Docker install Windows](https://docs.docker.com/desktop/windows/install/)