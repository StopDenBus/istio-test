FROM pfeiffermax/python-poetry:1.11.0-poetry1.8.3-python3.12.3-bookworm

RUN apt update; \
    apt upgrade -y; \
    apt install -y curl; \
    groupadd -g 10001 app; \
    useradd -u 10000 -g app app; \
    mkdir /app && mkdir /home/app; \
    chown app:app /app && chown app:app /home/app;

WORKDIR /app

COPY istio-test/ ./

RUN /opt/poetry/bin/poetry install

USER app:app

EXPOSE 8080

ENTRYPOINT [ "python3", "-m", "http.server", "8080" ]