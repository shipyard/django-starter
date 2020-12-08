FROM python:3.9.0-alpine

WORKDIR /srv

# Install system dependencies for poetry
RUN apk add --update --no-cache \
  gcc \
  libc-dev \
  libffi-dev \
  openssl-dev \
  bash \
  git \
  libtool \
  m4 \
  g++ \
  autoconf \
  automake \
  build-base \
  postgresql-dev

# Install poetry
RUN pip install poetry

# Install Python dependencies
ADD pyproject.toml poetry.lock ./
RUN poetry install

# Add the project
# NOTE Run the install again to install the project
ADD src ./src
RUN poetry install

# Set the default command
CMD ["poetry", "run", "python", "src/manage.py", "runserver", "0:8080"]