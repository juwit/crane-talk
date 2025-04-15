#!/bin/bash

echo "Java version"
java -version

echo "Distribution details"
cat /etc/lsb-release

java -jar app.jar
