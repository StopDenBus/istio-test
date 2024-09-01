FROM python:3.12-slim-bookworm as builder

RUN apt update; \
    apt upgrade -y; \
    apt install -y curl; \
    pip3 install poetry; \
    groupadd -g 10001 app; \
    useradd -u 10000 -g app app; \
    mkdir /app && chown app:app /app;

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

WORKDIR /app

COPY istio-test/pyproject.toml istio-test/poetry.lock ./

RUN /usr/local/bin/poetry install --no-root && rm -rf $POETRY_CACHE_DIR

FROM python:3.12-slim-bookworm as runtime

ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}

COPY istio-test/ ./istio-test

USER app:app

EXPOSE 8080

ENTRYPOINT [ "python3", "-m", "http.server", "8080" ]