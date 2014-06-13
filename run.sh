#!/bin/bash

#docker run -d --name="pg93" --volumes-from postgresql_data xcgd/postgresql

docker run --rm --name="pg93" --volumes-from postgresql_data xcgd/postgresql
