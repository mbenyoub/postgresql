# Supported tags

-       `9.5`, `latest`
-       `9.4` 
-       `9.3` 

# About this image

This docker uses a custom ubuntu:trusty image as a base.

# How to use this image

## Start PostgreSQL

Run your docker, assuming you named your postgresql docker pg93 as we did above:

    $ docker run --rm --name="pg" xcgd/postgresql

To run a specific version:

    $ docker run --rm --name="pg94" xcgd/postgresql:9.4

## Persistence

This image ships data volumes for persistence. By default, they will be bound to docker vfs and thus removed along with the container.

You'd rather want to bind volumes to your local file system. This image comes with a facility where initdb is executed only if an empty data volume is found. Otherwise it is just mounted and used.

Let's pretend your persistent data is located under `/opt/instance1/dbdata/` on your host machine, you can use it with:

    $ docker run --name="pg" -v /opt/instance1/dbdata:/var/lib/postgresql -d xcgd/postgresql

## Security Notes

You'll note that we did not open ports to the outside world on the PostgreSQL container. This is for security reasons, NEVER RUN your PostgreSQL container with ports open to the outside world... Just link other containers (single host) or use an ambassador pattern (cluster).

This is really important to understand. PostgreSQL is configured to trust everyone so better keep it firewalled. And before yelling madness please consider this: If someone gains access to your host and is able to launch a container and open a port for himself he's got your data anyway... he’s on your machine. So keep that port closed and secure your host. Your database is as safe as your host is, no more.

