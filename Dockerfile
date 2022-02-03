# use Alpine linux base image
FROM node:alpine

# update alpine & install stuff
# note: git is needed by bower
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh python make g++

# Install nodemon, bower
RUN npm install -g nodemon bower pm2

# Create app directory
RUN mkdir -p /app

# Copy package files
COPY package.json /app/

# Install app dependencies
WORKDIR /app
RUN npm install --production


# Bundle app source
COPY demo /app/datacomb/demo/
COPY dist /app/dist/

EXPOSE 5050

WORKDIR /app

CMD [ "./node_modules/serve/bin/serve", "-p", "5050" ]


# build:
# docker build -t kapec/datacomb:1.2.0 .
#
# run:
# docker run -p 5050:5050/tcp -d kapec/datacomb:1.2.0
