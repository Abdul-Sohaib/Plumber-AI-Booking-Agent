FROM nginx:alpine

RUN apk add --no-cache gettext

COPY . /usr/share/nginx/html
COPY start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 80

ENTRYPOINT ["/start.sh"]
