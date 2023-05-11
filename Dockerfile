FROM cimg/node:16.20-browsers
LABEL maintainer "holysugar <holysugar@gmail.com>"
USER root

WORKDIR /lighthouse

RUN sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN sudo apt-get update && sudo apt-get install -y google-chrome-stable

RUN npm install -g lighthouse

RUN chown -R root:root /usr/local/lib/node_modules

COPY lighthouse_wrapper /usr/local/bin/
RUN chmod 755 /usr/local/bin/lighthouse_wrapper

# don't write ENTRYPOINT for ciecleci use
#ENTRYPOINT ["lighthouse_wrapper"]
#CMD ["-h"]
