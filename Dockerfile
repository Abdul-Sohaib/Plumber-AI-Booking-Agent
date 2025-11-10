# Dockerfile - nginx static site + envsubst
FROM nginx:alpine

# Install envsubst (gettext) for env variable substitution
RUN apk add --no-cache gettext

# Copy site files into nginx html directory
COPY . /usr/share/nginx/html

# Ensure start script is executable
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80

ENTRYPOINT ["/start.sh"]
CMD ["nginx", "-g", "daemon off;"]