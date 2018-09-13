FROM python:3

LABEL maintainer="jose.salandeando@datiobd.com" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="salandeando" \
      org.label-schema.description="QA utilities from unit test bash" \
      org.label-schema.vendor="Salandeando" \
      org.label-schema.vcs-url=""


RUN apt-get update && apt-get install -y git && git clone https://github.com/sstephenson/bats.git

RUN chmod +x /bats/install.sh

RUN mkdir /batsTest

COPY ["start-tests.sh","utils-test.sh","utils-print.sh","example/*","tests/*","/"]

RUN chmod +x /start-tests.sh /utils-test.sh /utils-print.sh /example-unit-test.bats /example-unit-test.sh

RUN /bats/install.sh /batsTest

RUN chmod +x /batsTest/bin/bats

ARG MODE_TESTS
ENV MODE_TESTS=$MODE_TESTS

ARG SCRIPT_TEST
ENV SCRIPT_TEST=$SCRIPT_TEST

ENTRYPOINT ["/start-tests.sh"]
