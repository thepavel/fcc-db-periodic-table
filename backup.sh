#!/bin/bash

echo Dumping periodic_table database to periodic_table.sql
pg_dump -cC --inserts -U freecodecamp periodic_table > periodic_table.sql