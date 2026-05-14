FROM ubuntu:latest

WORKDIR /usr/src/app
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl sudo
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

COPY . .

RUN npm install

ENV REACT_APP_BACKEND_URL=http://localhost:8080 
RUN npm run build

RUN npm install -g serve

# EXPOSE 5001

# CMD [ "serve", "-s",  "-l", "5001", "build" ]
CMD ["sh", "-c", "serve -s -l ${PORT:-5001} build"]