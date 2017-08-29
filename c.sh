#!/bin/bash
# Made by kk

git init 2>/dev/null >&2
git checkout -b master 2>/dev/null >&2

commit() {
  name=$1
  if [ "x$name" == "x" ]
  then
    echo "Empty commit message" >&2
    exit 10;
  fi
  shift
  parents=
  for parent in "$@"
  do
    parents="$parents -p $parent"
  done
  echo 123 > "$name"
  git add .
  tree=`git write-tree`
  commit=`echo "$name" | git commit-tree $tree $parents`
  echo $commit | tee ./.git/refs/heads/master
}

commit 14 $( commit 13 $( commit 12 $( commit 11 $( commit 10 $(           \
  commit 9 $( commit 8 $( commit 7 $( commit 6 $( commit 5 $( commit 4 $(  \
  commit 3 $( commit 2 $( commit 1 $( commit 0 ))))))))))))))  > /dev/null

commit 'The End'                                                           \
  `git log --oneline | sed -n 's,\([^ ]*\) .*,\1,; H; ${x; s.\n. .g; p;}'` \
  > /dev/null

git log --oneline --graph
