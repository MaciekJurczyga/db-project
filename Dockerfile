FROM postgres:16-alpine

# Set environment variables
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin123
ENV POSTGRES_DB=medical_clinic

COPY migrations /docker-entrypoint-initdb.d/

EXPOSE 5432