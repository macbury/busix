#!/bin/bash

[ -e /app/tmp/pids/server.pid ] && rm /app/tmp/pids/server.pid
cd /app
exec bin/foreman start