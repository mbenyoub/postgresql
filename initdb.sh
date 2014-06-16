#!/bin/bash

# INITIALIZE the cluster

echo "Testing if cluster main exists in docker volumes"
docker run --rm --volumes-from postgresql_data -u root xcgd/postgresql grep -q main /var/log/postgresql/cluster_installed
if [ $? -eq 1 ]; then
    echo "Creating a cluster 'main', since it was not managed"
    docker run --rm --name="pg93" --volumes-from postgresql_data -u root xcgd/postgresql /bin/bash /srv/initdb.sh
fi
