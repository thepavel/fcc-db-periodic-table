#!/bin/bash

echo Restoring periodic_table.sql

psql -U postgres < periodic_table.sql