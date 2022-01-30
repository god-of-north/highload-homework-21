# Dockerfile

# Postgres
FROM postgres:9.5
ENV POSTGRES_USER dbadmin	 
ENV POSTGRES_DB db
ENV POSTGRES_PASSWORD passw0rd

# Custom config
RUN mkdir -p /archive
RUN mkdir -p /var/lib/postgresql/config/
COPY pg_hba.conf /var/lib/postgresql/config/
RUN chown -R postgres: /var/lib/postgresql/config/

COPY db-config.sh /docker-entrypoint-initdb.d/

# Custom entrypoint
COPY custom-docker-entrypoint.sh /
RUN chmod +x /custom-docker-entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/custom-docker-entrypoint.sh"]
CMD ["postgres"]

