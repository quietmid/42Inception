FROM alpine:3.20.6

RUN apk update && \
	apk add --no-cache nginx openssl \
	pcre \
	zlib \
	make

# Copy custom NGINX configuration
# COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/http.d/default.conf
RUN chmod 644 /etc/nginx/http.d/default.conf

# Copy and prepare the script
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose HTTPS ports
EXPOSE 443

# Set the entrypoint
ENTRYPOINT ["/bin/sh", "/usr/local/bin/entrypoint.sh"]