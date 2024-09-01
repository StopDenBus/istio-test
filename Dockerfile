FROM python:3.12-slim-bookworm

RUN apt update; \
    apt upgrade -y; \
    apt install pipx; \
    /usr/bin/pipx ensurepath; \
    /usr/bin/pipx install poetry;

EXPOSE 8080

ENTRYPOINT [ "python3", "-m", "http.server", "8080" ]