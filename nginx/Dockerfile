FROM nginx:alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash

RUN adduser -D -H -u 1000 www-data

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]