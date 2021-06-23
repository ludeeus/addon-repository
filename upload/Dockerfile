ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Copy data for add-on
COPY app /app
RUN \
    python3 -m pip install flask

WORKDIR "/app"

CMD [ "python3", "-u", "app.py" ]