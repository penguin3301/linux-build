#!/bin/sh

set -e

repo="$(printenv REPO)"

cd "/data"
sudo mkdir "build"
sudo chown -vR "builder:builder" "build"
sudo chmod -v 700 build
cd "build"

gpg --keyserver keys.openpgp.org --recv-keys 19802F8B0D70FC30
gpg --keyserver keys.openpgp.org --recv-keys 3B94A80E50A477C7

cp /PKGBUILD ./PKGBUILD
cp /config ./config

makepkg -s

printenv GITHUB_KEY | gh auth login --with-token
gh release create "latest" ./*.pkg.tar.zst --repo "$repo"
gh auth logout -h github.com
