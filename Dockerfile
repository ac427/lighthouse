FROM node:slim
RUN apt-get update \
    && apt-get install -y wget gnupg2 \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub |  apt-key add -   \
    && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list  \
    && apt-get update && apt-get install -y google-chrome-stable \
    && groupadd -r -g 9000 lh_user && useradd -m -r -u 9000 -g lh_user lh_user \
    && apt-get purge -y --auto-remove \
    && npm install -g lighthouse
USER lh_user
ENTRYPOINT ["lighthouse"]
