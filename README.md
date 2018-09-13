
# SLQA_UBUT_Framework (Framework for testing bash scripts)

It's a docker image of a framework built in bash that will allow you to create unit test with a good structure and run them in a dockerized enviroment.

## Introduction

The Framework is oriented to the develop of tests that wants to validate scripts or functions bash in an unitary way. For it we have created two scripts with utilities for print and checking the results of test (utils-test.sh and utils-print.sh). Furthermore, 
it is provided with a framework called Bats to print the results of the tests in a more "comfortable" way to read.  

## How to Integrate SLQA_UBUT_Framework in your project

To do this we put in a Dockerfile the image of SLQA_UBUT_Framework as shown below. With this we would have the two scripts and the framework available for your use 

```bash
FROM slqa-ubut:latest
```
The next step is to develop our unit tests as shown in the template unit-test.sh.template

If you want to print the results with Bats you also have to develop a .bats file as indicated in the template unit-test.bats.template

Once our test is finished (Remember: if we want to run in "pretty" mode we will have to have two files, one .sh and another .bats). We must copy them in our new docker image to have them available when we lift the container. So we should have in our new Dockerfile two instructions how are you:

```bash
COPY ["test-example.sh",""test-example.bats"","/"]
RUN chmod +x /test-example.sh
```

Therefore, our Dockerfile would be a file as simple as the one that follows

```bash
FROM slqa-ubut:latest

COPY ["test-example.sh",""test-example.bats"","/"]
RUN chmod +x /test-example.sh
```

With this we could already run our unit tests

## Run the tests from our Dockerfile created in the previous step

**Create docker image from Dockerfile**

Our first step will be to generate the docker image from this Dockerfile that we have created, for this:

```bash
docker build -t example-bash-unit-tests .
```

With this we would generate a docker image called example-bash-unit-tests from the Dockerfile that we have in the current route, which will be the one we have created before.

**Running tests from the docker image**


We have introduced in addition to the template, an example of use in the docker image itself (*example-unit-test.sh*, *example-unit-test.bats*). This example is available as a test of the framework and we explain how to test it in the running modes

We have two run modes available:

* Run with bats: To use this mode we have to run the docker container from the image created in the previous step, you pass it SCRIPT_TEST as environment variable with the name of the file to execute. We show an example below:

```bash
docker run -it -e SCRIPT_TEST=test-function.bats example-bash-unit-tests
```

If you want to run the example that we have mentioned above, run docker container  without variable SCRIPT_TEST

```bash
docker run -it example-bash-unit-tests
```

* Run with verbose mode: To use this mode we have to run the docker container from the image created in the previous step, you pass it SCRIPT_TEST as environment variable with the name of the file to execute and variable MODE_TESTS with value "VERBOSE". We show an example below:

```bash
docker run -it -e MODE_TESTS=VERBOSE -e SCRIPT_TEST=test-function.bats example-bash-unit-tests
```

If you want to run the example that we have mentioned above, run docker container  without variable SCRIPT_TEST

```bash
docker run -it -e MODE_TESTS=VERBOSE example-bash-unit-tests
```
