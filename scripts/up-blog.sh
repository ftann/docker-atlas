#!/usr/bin/env bash

cd /root/atlas/configs
curl -OL https://github.com/ftann/ctor-blog/releases/latest/download/release.zip
rm -rf ./blog
unzip release.zip
mv public blog
chown 2000.2000 -R blog
docker restart swag
