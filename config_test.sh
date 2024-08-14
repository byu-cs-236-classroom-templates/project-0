#!/bin/sh

echo $#

if [ $# -ne 1 ]; then
    echo "usage: sh config_test.sh #"
    exit 1
fi

arg="$1"

echo $arg

mv "test/test_project0.py" "test/.test_project0.py"
mv "test/test_passoff_80.py" "test/.test_passoff_80.py"
mv "test/test_passoff_100.py" "test/.test_passoff_100.py"

if [ $arg -eq "80" ]; then
    mv "test/.test_passoff_80.py" "test/test_passoff_80.py"
elif [ $arg -eq "100" ]; then
    mv "test/.test_passoff_100.py" "test/test_passoff_100.py"
else
    exit 1
fi
