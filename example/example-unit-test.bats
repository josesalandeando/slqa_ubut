@test "test example.sh - function addNumbers" {
    load ${BATS_TEST_DIRNAME}/example-unit-test.sh
    run testFunctionTemplate
    [ ! $status -eq 1 ]
}