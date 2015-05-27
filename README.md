A dockerfile for PostgreSQL
====================================

PostgreSQL version
============

This docker builds with version 9.3.5 over a custom ubuntu-debootstrap:trusty image.

!!!NEW!!! version 9.4.2 is available in tag `xcgd/postgresql:9.4`

Instructions
=============

Start PostgreSQL
----------------

Run your docker, assuming you named your postgresql docker pg93 as we did above:

    $ docker run --rm --name="pg93" xcgd/postgresql

To run version 9.4
    $ docker run --rm --name="pg94" xcgd/postgresql:9.4

Persistance
-----------

This image ships data volumes for persistance. By default, they will be bound to docker vfs and thus removed along with the container.

You'd rather want to bind volumes to your local file system. This image comes with a facility where initdb is executed only if an empty data volume is found. Otherwise it is just mounted and used.

    # let's pretend your persistant data is located under /opt/instance1/dbdata/ on your host machine, you can use it with:

    $ docker run --name="pg" -v /opt/instance1/dbdata:/var/lib/postgresql -d xcgd/postgresql


Security Notes
==============

You'll note that we did not open ports to the outside world on the PostgreSQL container. This is for security reasons, NEVER RUN your PostgreSQL container with ports open to the outside world... Just link other containers (single host) or use an ambassador pattern (cluster).

This is really important to understand. PostgreSQL is configured to trust everyone so better keep it firewalled. And before yelling madness please consider this: If someone gains access to your host and is able to launch a container and open a port for himself he's got your data anyways... he's on your machine. So keep that port closed and secure your host. Your database is as safe as your host is, no more.

