#!/usr/bin/env bash

source ./common.sh

echo "${MAGENTA}GET KITSU"
git clone --single-branch --depth 1 https://github.com/eaxum/kitsu-docker.git ./kitsu || git -C ./kitsu pull

echo "${MAGENTA}GET ZOU"
git clone --single-branch --depth 1 https://github.com/eaxum/eaxum_zou-docker.git ./zou || git -C ./zou pull

echo "${MAGENTA}GET GENESYS"
git clone --single-branch --depth 1 https://github.com/eaxum/genesys-docker.git ./genesys || git -C ./genesys pull