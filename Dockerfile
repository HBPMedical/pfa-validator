FROM python:2

MAINTAINER ludovic.claude@chuv.ch

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

WORKDIR /usr/src/app

RUN pip install psycopg2 titus==0.8.4

COPY . .

ENV JOB_ID=1
ENV INPUT_METHOD=POSTGRESQL \
    DB_HOST=db \
    DB_PORT=5432 \
    DB_NAME=woken \
    DB_USER=woken \
    DB_PASSWORD=... \
    DB_TABLE=job_result \
    DB_COLUMN=data \
    DB_WHERE_LVALUE=job_id \
    DB_WHERE_RVALUE=${JOB_ID}

CMD [ "python", "./src/main.py" ]

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="hbpmip/pfa-validator" \
      org.label-schema.description="Validates PFA documents" \
      org.label-schema.url="https://github.com/HBPMedical/pfa-validator" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/HBPMedical/pfa-validator" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version="$VERSION" \
      org.label-schema.vendor="LREN CHUV" \
      org.label-schema.license="Apache2.0" \
      org.label-schema.docker.dockerfile="Dockerfile" \
      org.label-schema.schema-version="1.0"
