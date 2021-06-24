ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Copy data for add-on
COPY app /app
COPY requirements.txt requirements.txt 

# Add Home Assistant wheels repository
ARG BUILD_ARCH
ENV WHEELS_LINKS=https://wheels.home-assistant.io/alpine-3.13/${BUILD_ARCH}/

RUN python3 -m pip install -r requirements.txt --find-links ${WHEELS_LINKS}

WORKDIR "/app"

CMD [ "python3", "-u", "app.py" ]