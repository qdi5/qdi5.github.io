#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd src/.vuepress/dist

# if you are deploying to a custom domain
# echo 'ahafe.tech' > CNAME

git init
git add -A
git commit -m '根路径加上/blog/'

# if you are deploying to https://<USERNAME>.github.io
git push -f git@github.com:qdi5/qdi5.github.io.git master

# if you are deploying to https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:qdi5/blog.git master:gh-pages

cd -