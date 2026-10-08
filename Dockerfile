FROM node:20-nanoserver-ltsc2022

WORKDIR C:\\app

COPY package.json .
RUN npm install

COPY server.js .
COPY public ./public

EXPOSE 80

CMD ["node", "server.js"]