FROM python:3.12-slim-bookworm

RUN apt update; \
    apt upgrade -y; \
    apt install pipx; \
    pipx ensurepath; \
    pipx install poetry;