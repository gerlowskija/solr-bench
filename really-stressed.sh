#!/bin/bash -x

# Performance test immediately preceding my JAX-RS change
commit_hash=89adf62cf0902f351f65d12df2772d9bfa79327c
for i in 1 100 200 300 400 500
do
  cat suites/cluster-test.json.template | sed s/@@COLL_LIMIT@@/${i}/ > suites/templated-cluster-test.json
  ./cleanup.sh && ./stress.sh -c $commit_hash -s ${i}colls suites/templated-cluster-test.json 2>&1 | tee suites/results/${commit_hash}-${i}colls-stdout.txt
done

# Then get the results with the JAX-RS change
commit_hash=62e3686d196ed0bb7a95bc2b25d6f4cd42d04bdb
for i in 1 100 200 300 400 500
do
  cat suites/cluster-test.json.template | sed s/@@COLL_LIMIT@@/${i}/ > suites/templated-cluster-test.json
  ./cleanup.sh
  ./stress.sh -c $commit_hash -s ${i}colls suites/templated-cluster-test.json 2>&1 | tee suites/results/${commit_hash}-${i}colls-stdout.txt
done

# Then do a commit which fixes some of the JAX-RS slowdown
commit_hash=3e1b694a6bc9b1f010645d59cdc02f81e53813a4
for i in 1 100 200 300 400 500
do
  cat suites/cluster-test.json.template | sed s/@@COLL_LIMIT@@/${i}/ > suites/templated-cluster-test.json
  ./cleanup.sh
  ./stress.sh -c $commit_hash -s ${i}colls suites/templated-cluster-test.json 2>&1 | tee suites/results/${commit_hash}-${i}colls-stdout.txt
done

# Last of all do a commit which hacks together the AppHandler sharing
commit_hash=3e1b694a6bc9b1f010645d59cdc02f81e53813a4
for i in 1 100 200 300 400 500
do
  cat suites/cluster-test.json.template | sed s/@@COLL_LIMIT@@/${i}/ > suites/templated-cluster-test.json
  ./cleanup.sh
  ./stress.sh -c $commit_hash -s ${i}colls suites/templated-cluster-test.json 2>&1 | tee suites/results/${commit_hash}-${i}colls-stdout.txt
done
