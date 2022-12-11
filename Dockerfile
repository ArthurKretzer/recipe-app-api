FROM python:3.9-alpine3.13
LABEL maintainer="arthurkretzer"

# Shows python output directly on the console
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8080

# Creates an arg with default value, so an arg from docker-compose overwrite this
ARG DEV=false
# Creates a virtual environment on python. A venv on docker images are not always necessary.
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    # Small shell script to conditionally run some commands
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    # you should finish the shell script with fi
    fi && \
    # Removes temporary folder to reduce image size
    rm -rf /tmp && \
    # Best practice not to use root user, so just adds a new user
    # This avoids compromising the whole container if someone gets access to it
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# Python commands will be run on the virtual environment, so path should be updated
ENV PATH="/py/bin:$PATH"

USER django-user
