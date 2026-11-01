v="#!/bin/bashplus/bin"
systemlib="#!/bin/bashlib"
# Custom libraries can be loaded directly from the /bin/bashlib folder.
userlibraries=".bashplus"
# Command for building the project
# bash - bashpl build
# bashplus - bashpl build -userlibraries
build="bashpl build -userlibraries"

echo "bash plus"
echo "### RUN ###"
read -p "File: " filename

if [ -f "$filename" ]; then
    "$filename"
else
    echo "bash error"
fi