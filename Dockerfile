FROM ubuntu:14.04
MAINTAINER florent.aide@xcg-consulting.fr 

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc 
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release
#     of PostgreSQL, ``9.3``.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Update the Ubuntu and PostgreSQL repository indexes
RUN locale-gen en_US.UTF-8 && update-locale
RUN echo 'LANG="en_US.UTF-8"' > /etc/default/locale

RUN apt-get update && apt-get -y -q install postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3

ADD source/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
ADD source/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-9.3`` package when it was ``apt-get installed``
USER postgres

# add an openerp role, with create database
RUN /etc/init.d/postgresql start && \
    createuser -d openerp && \
    psql -c 'CREATE EXTENSION "unaccent";'

# Expose the PostgreSQL port (this is only so you can run backups,
# not to be exposed to the outside world)
EXPOSE 5432

VOLUME ["/var/log/postgresql", "/var/lib/postgresql", "/etc/postgresql"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]
