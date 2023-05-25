FROM cimg/node:16.20-browsers
LABEL maintainer "holysugar <holysugar@gmail.com>"
USER root

WORKDIR /lighthouse

# NOTE: https://www.google.com/linuxrepositories/
# NOTE: apt-keyによる単一のAPTキーリング上に、GPGの鍵を登録するのを推奨しない動きになっているため、Chrome用に別途GPG鍵を登録するようにする
# apt-keyの詳しい解説は→ https://gihyo.jp/admin/serial/01/ubuntu-recipe/0675?page=1
RUN sudo wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/chrome-keyring.gpg
RUN sudo echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/usr/share/keyrings/chrome-keyring.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
  | tee /etc/apt/sources.list.d/chrome.list > /dev/null
RUN cat /etc/apt/sources.list.d/chrome.list
RUN sudo apt update && sudo apt install -y google-chrome-stable

RUN npm install -g lighthouse

RUN chown -R root:root /usr/local/lib/node_modules

COPY lighthouse_wrapper /usr/local/bin/
RUN chmod 755 /usr/local/bin/lighthouse_wrapper

# don't write ENTRYPOINT for ciecleci use
#ENTRYPOINT ["lighthouse_wrapper"]
#CMD ["-h"]
