#!/bin/bash
git config user.name "BellMeng"
git config user.email "2459721102@qq.com"
git checkout -b gitbook
git status
git add .
git commit -m "[Travis] Update SUMMARY.md"
git push -f "https://${GH_TOKEN}@${GH_REF}" gitbook:gitbook
gitbook install
gitbook build .
if [ $? -ne 0 ];then
    exit 1
fi
cd _book
sed -i '/a href.*\.md/s#\.md#.html#g;/a href.*README\.html/s#README\.html##g' SUMMARY.html
git init
git checkout --orphan gh-pages
git status
sleep 5
git add .
git commit -m "Update gh-pages"
git remote add origin git@github.com:用户名/仓库.git
git push -f "https://${GH_TOKEN}@${GH_REF}" gh-pages:gh-pages
