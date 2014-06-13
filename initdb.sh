#!/bin/bash

# INITIALIZE the cluster
docker run --rm --name="pg93" --volumes-from postgresql_data -u root xcgd/postgresql /bin/bash /srv/initdb.sh
