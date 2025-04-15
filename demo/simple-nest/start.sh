#!/bin/bash

echo "Node version $(node -v)"

echo "NPM version $(npm -v)"

echo "Distribution details"
cat /etc/os-release

exec npm run start:prod