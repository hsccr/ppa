#!/bin/bash

set -e
set -v

export EMAIL=ccr@emstone.com

(
    set -e
    set -v

    cd ./ubuntu/

    gpg --armor --export "${EMAIL}" > KEY.gpg

    # Packages & Packages.gz
    dpkg-scanpackages --multiversion . > Packages
    gzip -k -f Packages

    # Release, Release.gpg & InRelease
    apt-ftparchive release . > Release
    gpg --default-key "${EMAIL}" -abs -o - Release > Release.gpg
    gpg --default-key "${EMAIL}" --clearsign -o - Release > InRelease
)