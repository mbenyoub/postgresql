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

# Install ``python-software-properties``, ``software-properties-common`` and PostgreSQL 9.3
#  There are some warnings (in red) that show up during the build. You can hide
#  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
#
# WARNING You must explicitly provide /var/log/postgresql and /var/lib/postgresql/9.3/<clustername>
#
RUN apt-get update && apt-get -y -q install python-software-properties software-properties-common \
                                            postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 && \
                                            rm -rf /var/log/postgresql && rm -rf /var/lib/postgresql/9.3/main && \
                                            rm -rf /etc/postgresql/9.3

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-9.3`` package when it was ``apt-get installed``
USER postgres

# Expose the PostgreSQL port (this is only so you can run backups,
# not to be exposed to the outside world)
EXPOSE 5432

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]
