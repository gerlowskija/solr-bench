#!/bin/bash -x

# First do a bunch of tests that contain my JAX-RS change
commit_hash=62e3686d196ed0bb7a95bc2b25d6f4cd42d04bdb
for i in 900 1000
#for i in 800 900 1000
do
  cat suites/cluster-test.json.template | sed s/@@COLL_LIMIT@@/${i}/ > suites/templated-cluster-test.json
  ./cleanup.sh
  ./stress.sh -c $commit_hash -s ${i}colls suites/templated-cluster-test.json 2>&1 | tee suites/results/${commit_hash}-${i}colls-stdout.txt
done

# Then do the same tests on the commit immediately preceding my JAX-RS change
commit_hash=89adf62cf0902f351f65d12df2772d9bfa79327c
for i in 1 100 200 300 400 500 600 700 800 900 1000
do
  cat suites/cluster-test.json.template | sed s/@@COLL_LIMIT@@/${i}/ > suites/templated-cluster-test.json
  ./cleanup.sh && ./stress.sh -c $commit_hash -s ${i}colls suites/templated-cluster-test.json 2>&1 | tee suites/results/${commit_hash}-${i}colls-stdout.txt
done
