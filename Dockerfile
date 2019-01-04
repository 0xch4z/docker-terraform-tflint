FROM alpine:latest

WORKDIR /usr/src

ARG VERSION=latest

LABEL org.label-schema.version=${VERSION} \
  org.label-schema.vcs-url="https://github.com/charliekenney23/docker-terraform-tflint" \
  org.label-schema.name="docker-terraform-tflint" \
  org.label-schema.vendor="Charles Kenney" \
  org.label-schema.schema-version="1.0" \
  maintainer="Charles Kenney <me@chaz.codes>"

ENV TERRAFORM_VERSION=0.11.11 \
  TERRAFORM_SHA256SUM="94504f4a67bad612b5c8e3a4b7ce6ca2772b3c1559630dfd71e9c519e3d6149c" \
  TFLINT_VERSION=0.7.3
                                                                                                                                                                                 
RUN apk add --no-cache --update ca-certificates git curl tar openssl \
  && update-ca-certificates

RUN tmpd=$(mktemp -d build.XXXXXX) && cd $tmpd \
  && curl -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS \
  && sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin \
  && curl -L https://github.com/wata727/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip > tflint_${TFLINT_VERSION}.zip \
  && unzip tflint_${TFLINT_VERSION}.zip -d /bin \
  && cd /usr/src \
  && rm -r $tmpd

COPY bin/entrypoint /bin/entrypoint

CMD [ "sh", "/bin/entrypoint" ]
