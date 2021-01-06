FROM python:3.7-slim

ENV AWS_ENDPOINT_URL http://minio.minio:9000
ENV AWS_ACCESS_KEY_ID YOURACCESSKEY
ENV AWS_SECRET_ACCESS_KEY YOURSECRETKEY

COPY ./kfserving ./kfserving
RUN pip install --upgrade pip && pip install ./kfserving

COPY ./storage-initializer /storage-initializer
COPY third_party third_party

RUN chmod +x /storage-initializer/scripts/initializer-entrypoint
RUN mkdir /work
WORKDIR /work
ENTRYPOINT ["/storage-initializer/scripts/initializer-entrypoint"]
