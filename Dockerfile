# ---------------------------------------------------------------------------------------------------------------------#
# BASE IMAGE - BUILDERS
# ---------------------------------------------------------------------------------------------------------------------#
FROM python:3.9.6-slim as base-image

LABEL maintainer="Joachim Cardoen <LX6097@engie.com>"

# If you are wondering: https://stackoverflow.com/questions/59812009/what-is-the-use-of-pythonunbuffered-in-docker-file
# I had to look it up too :D
ENV PYTHONUNBUFFERED=1 \
    # Let's lock the version
    # Who knows what they might change...
    POETRY_VERSION=1.1.11 \
    # We are a container, why even create a virtual env?!
    POETRY_VIRTUALENVS_CREATE=0

# Update image and install curl to fetch poetry installation
RUN apt-get update \
    && apt install -y curl netcat \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python - -y
ENV PATH="${PATH}:/root/.local/bin"

# I dont want poetry to do some naughty stuff
# I'll make sure to replicate the exact environment by copying deps file and lock
COPY pyproject.toml poetry.lock ./

# ---------------------------------------------------------------------------------------------------------------------#
# DEVELOPMENT IMAGE
# ---------------------------------------------------------------------------------------------------------------------#
FROM base-image as development
ENV FASTAPI_ENV=development

# Change to the application folder
WORKDIR /example

# Let's just install the dependencies
# We are programmers, of course --no-interaction ;-)
# And we are at the bottom of the food chain, sadly --no-root :'(
RUN poetry install --no-root --no-interaction

# ---------------------------------------------------------------------------------------------------------------------#
# PRODUCTION IMAGE
# ---------------------------------------------------------------------------------------------------------------------#
FROM base-image as production
ENV FASTAPI_ENV=production

# Change to the application folder
WORKDIR /example

# Let's just install the dependencies
# But not the dev deps!
RUN poetry install --no-root --no-interaction --no-dev

# Copy our code to the image
# You might think this is not needed when we are mounting the volumes for our development PC
# And you're right, but in production, we dont want to bind volumes
# We want the image to contain the necessary code
# Basically you're image should be easy to replicate (otherwise what's the point?)
COPY /example .

# TODO: Fix entrypoints
# TODO: separate Dockerfiles for Celery, Flower, FastApi
