#!/bin/bash

# Run the container as an app with local data persistance
docker run -d -v /my/host/volumes/pg:/var/lib/postgresql --name pg95 xcgd/postgresql
