#!/bin/bash

DATABASE="database.txt"

./get_post_pattern.sh

./get_pre_pattern.sh

echo "==================================="
echo "            DATABASE"
echo "==================================="
cat ${DATABASE}
