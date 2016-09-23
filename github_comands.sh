### GitHub Troubleshoutings
### xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun

# for Mac OS X
xcode-select --install

From a shell go to /usr/bin
sudo ./git
Agree to the terms
Close and reopen RStudio


## github commands

get --help

git config --global user.name "Alexander Treshchev"
git config --global user.email "treshev.a.d@gmail.com"
git config --list
git exit

##----------------

ls -al
pwd
mkdir test-repo
cd test-repo/

git init

git remote add origin https://github.com/atreshchev/test-repo.git

##----------------

touch test.txt

git add -A
git commit -m "test commit"

git push --set-upstream origin master

git pull
git pull remote

#git pull test-repo.git

##----------------

git add .
git commit -m "start commit"
git push -u origin master

##----------------

rm -rf test-repo
ls
pwd
mkdir exp
cd exp/
ls

##----------------

git init

echo "# exp" >> README.md

git add README.md
git commit -m "first commit"
git remote add origin https://github.com/atreshchev/exp.git
git push -u origin master

git pull -u origin master
git pull

##----------------

git checkout -b branchname 
git checkout
git branch
git checkout branchname
git push
