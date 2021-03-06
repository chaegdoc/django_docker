# 公式からpython3.7 on alpine linuxイメージをpull
FROM python:3.8-alpine
WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk update \
  && apk add --virtual build-deps gcc python3-dev musl-dev \
  && apk add postgresql-dev \
  && pip install psycopg2 \
  && apk del build-deps

RUN pip install --upgrade pip \
  && pip install pipenv

COPY . /usr/src/app/

RUN pipenv install --skip-lock --system --dev

COPY ./entrypoint.sh /usr/src/app/entrypoint.sh

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]