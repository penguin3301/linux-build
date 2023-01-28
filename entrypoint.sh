#!/bin/sh

set -e

repo="$(printenv REPO)"

cd "/data"
sudo mkdir "build"
sudo chown -R "$USER:$USER" "build"
sudo chmod 700 build
ls -l
cd "build"

gpg --keyserver keys.openpgp.org --recv-keys 19802F8B0D70FC30
gpg --keyserver keys.openpgp.org --recv-keys 3B94A80E50A477C7

cp /PKGBUILD ./PKGBUILD
cp /config ./config

makepkg -s

printenv GITHUB_KEY | gh auth login --with-token
gh release create "latest" ./*.pkg.tar.zst --repo "$repo"
gh auth logout -h github.com
