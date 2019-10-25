#!/bin/bash

echo Linting RAML...
for i in APIs/*.raml; do
    perl -pi -e 's/!include//' $i
    if ./node_modules/.bin/yamllint $i > output; then
        echo $i ok
    else
        cat output
        echo -e "\033[31m$i failed\033[0m"
        failed=y
    fi
done

echo Linting JSON...
for i in APIs/schemas/*.json examples/*.json; do
    if ./node_modules/.bin/jsonlint $i > /dev/null; then
        echo $i ok
    else
        echo -e "\033[31m$i failed\033[0m"
    failed=y
  fi
done

if [ "$failed" == "y" ]; then
    exit 1
else
    exit 0
fi
