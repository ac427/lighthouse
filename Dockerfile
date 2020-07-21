FROM node:slim
RUN apt-get update \
    && apt-get install -y wget gnupg2 \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub |  apt-key add -   \
    && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list  \
    && apt-get update && apt-get install -y google-chrome-stable \
    && groupadd -r -g 9000 lh_user && useradd -m -r -u 9000 -g lh_user lh_user \
    && apt-get purge -y --auto-remove \
    &&  su lh_user -c 'npm install totp-generator lighthouse puppeteer-core --prefix /home/lh_user/.npm'

USER lh_user

ENV NODE_PATH=/home/lh_user/.npm/node_modules
ENV PATH=/home/lh_user/.npm/bin:$PATH

ENTRYPOINT ["lighthouse"]
