FROM python:3.12-slim-bookworm

RUN apt update; \
    # apt upgrade -y; \
    pip3 install poetry; \
    whereis poetry; \
    groupadd -g 10001 app; \
    useradd -u 10000 -g app app;

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

WORKDIR /app

USER app:app

EXPOSE 8080

ENTRYPOINT [ "python3", "-m", "http.server", "8080" ]