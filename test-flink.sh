#!/usr/bin/env bash

test_root=`pwd`
flink_dist=`cd $1; pwd`

echo "Testing root: $test_root"
echo "Flink root: $flink_dist"

test_builtin_data() {
    $flink_dist/bin/flink run $1
    echo "Check results! Press any key to continue..."
    read -n 1 -s
}

check_result() {
    if [ -d "$1" ]; then
        cat $1/*
    else 
        cat $1
    fi

    echo "Check results! Press any key to continue..."
    read -n 1 -s
}


test_builtin_data $flink_dist/examples/batch/ConnectedComponents.jar
test_builtin_data $flink_dist/examples/batch/EnumTriangles.jar
test_builtin_data $flink_dist/examples/batch/KMeans.jar
test_builtin_data $flink_dist/examples/batch/PageRank.jar
test_builtin_data $flink_dist/examples/batch/TransitiveClosure.jar
test_builtin_data $flink_dist/examples/batch/WebLogAnalysis.jar
test_builtin_data $flink_dist/examples/batch/WordCount.jar

rm -r $test_root/out/cc_out
$flink_dist/bin/flink run $flink_dist/examples/batch/ConnectedComponents.jar --vertices $test_root/test-data/cc_vert --edges $test_root/test-data/cc_edge --output $test_root/out/cc_out --iterations 10
check_result $test_root/out/cc_out

rm -r $test_root/out/tr_basic_out
$flink_dist/bin/flink run $flink_dist/examples/batch/EnumTriangles.jar --edges $test_root/test-data/tr_edges --output $test_root/out/tr_basic_out
check_result $test_root/out/tr_basic_out

rm -r $test_root/out/pr_out
$flink_dist/bin/flink run $flink_dist/examples/batch/PageRank.jar --pages $test_root/test-data/pages --links $test_root/test-data/links --output $test_root/out/pr_out --numPages 5 --iterations 10
check_result $test_root/out/pr_out

rm -r $test_root/out/tc_out
$flink_dist/bin/flink run $flink_dist/examples/batch/TransitiveClosure.jar --edges $test_root/test-data/tr_edges --output $test_root/out/tc_out --iterations 10
check_result $test_root/out/tc_out

rm -r $test_root/out/web_out
$flink_dist/bin/flink run $flink_dist/examples/batch/WebLogAnalysis.jar --documents $test_root/test-data/web_docs --ranks $test_root/test-data/web_ranks --visits $test_root/test-data/web_visits --output $test_root/out/web_out
check_result $test_root/out/web_out

rm -r $test_root/out/wc_out
$flink_dist/bin/flink run $flink_dist/examples/batch/WordCount.jar --input $test_root/test-data/words --output $test_root/out/wc_out
check_result $test_root/out/wc_out
