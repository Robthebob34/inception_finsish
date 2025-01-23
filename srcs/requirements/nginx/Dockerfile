FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	nginx \
	openssl && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/sites-available/default

RUN openssl req -x509 -days 365 -nodes -newkey rsa:4096 \
	-keyout /etc/ssl/private/nginx.key \
	-out /etc/ssl/certs/nginx.crt -sha256 \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/CN=rheck.42.fr"

CMD ["nginx", "-g", "daemon off;"]
