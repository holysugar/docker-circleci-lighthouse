FROM circleci/node:8-browsers
LABEL maintainer "holysugar <holysugar@gmail.com>"
USER root

WORKDIR /lighthouse

RUN npm install -g lighthouse

RUN chown -R root:root /usr/local/lib/node_modules

COPY lighthouse_wrapper /usr/local/bin/
RUN chmod 755 /usr/local/bin/lighthouse_wrapper

ENTRYPOINT ["lighthouse_wrapper"]
CMD ["-h"]
