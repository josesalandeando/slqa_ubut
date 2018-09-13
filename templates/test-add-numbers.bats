@test "test addNumbersTest.sh - function addNumbers " {
    load ${BATS_TEST_DIRNAME}/test-add-numbers.sh
    run testAddNumbers
    [ ! $status -eq 1 ]
}