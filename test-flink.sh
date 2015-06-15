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


test_builtin_data $flink_dist/examples/flink-java-examples-*-ConnectedComponents.jar
test_builtin_data $flink_dist/examples/flink-java-examples-*-EnumTrianglesBasic.jar
test_builtin_data $flink_dist/examples/flink-java-examples-*-EnumTrianglesOpt.jar
test_builtin_data $flink_dist/examples/flink-java-examples-*-KMeans.jar
test_builtin_data $flink_dist/examples/flink-java-examples-*-PageRankBasic.jar
test_builtin_data $flink_dist/examples/flink-java-examples-*-TransitiveClosure.jar
test_builtin_data $flink_dist/examples/flink-java-examples-*-WebLogAnalysis.jar
test_builtin_data $flink_dist/examples/flink-java-examples-*-WordCount.jar
test_builtin_data $flink_dist/examples/flink-java-examples-*-WordCountPOJO.jar

rm -r $test_root/out/cc_out
$flink_dist/bin/flink run $flink_dist/examples/flink-java-examples-*-ConnectedComponents.jar $test_root/test-data/cc_vert $test_root/test-data/cc_edge $test_root/out/cc_out 10
check_result $test_root/out/cc_out

rm -r $test_root/out/tr_basic_out
$flink_dist/bin/flink run $flink_dist/examples/flink-java-examples-*-EnumTrianglesBasic.jar $test_root/test-data/tr_edges $test_root/out/tr_basic_out
check_result $test_root/out/tr_basic_out

rm -r $test_root/out/tr_opt_out
$flink_dist/bin/flink run $flink_dist/examples/flink-java-examples-*-EnumTrianglesOpt.jar $test_root/test-data/tr_edges $test_root/out/tr_opt_out
check_result $test_root/out/tr_opt_out

rm -r $test_root/out/pr_out
$flink_dist/bin/flink run $flink_dist/examples/flink-java-examples-*-PageRankBasic.jar $test_root/test-data/pages $test_root/test-data/links $test_root/out/pr_out 5 10
check_result $test_root/out/pr_out

rm -r $test_root/out/tc_out
$flink_dist/bin/flink run $flink_dist/examples/flink-java-examples-*-TransitiveClosure.jar $test_root/test-data/tr_edges $test_root/out/tc_out 10
check_result $test_root/out/tc_out

rm -r $test_root/out/web_out
$flink_dist/bin/flink run $flink_dist/examples/flink-java-examples-*-WebLogAnalysis.jar $test_root/test-data/web_docs $test_root/test-data/web_ranks $test_root/test-data/web_visits $test_root/out/web_out
check_result $test_root/out/web_out

rm -r $test_root/out/wc_out
$flink_dist/bin/flink run $flink_dist/examples/flink-java-examples-*-WordCount.jar $test_root/test-data/words $test_root/out/wc_out
check_result $test_root/out/wc_out

rm -r $test_root/out/wc_pojo_out
$flink_dist/bin/flink run $flink_dist/examples/flink-java-examples-*-WordCountPOJO.jar $test_root/test-data/words $test_root/out/wc_pojo_out
check_result $test_root/out/wc_pojo_out

