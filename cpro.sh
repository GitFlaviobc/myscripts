#!/bin/bash

## cpro "file" "vars type" "var1" "var2" ...

file_hpp=$(find . -name "$1.hpp")

type=$(echo $2)
var_hpp=""

if [ $type == "string" ]; then
	type=$(echo std::string)
fi

for var in "${@:3}"
do
	var_hpp=$(echo $var_hpp"\n\t\t$type\t_$var;")
done

new_hpp=$(cat "$file_hpp" | sed "s/protected:/&$var_hpp/g")
printf "$new_hpp" > $file_hpp