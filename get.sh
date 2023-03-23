#!/bin/bash
# getter "file" "vars type" "var1" "var2" ...

file_hpp=$(find . -name "$1.hpp")
file_cpp=$(find . -name "$1.cpp")

new_hpp=$(cat $file_hpp)
add_cpp=""
type=$(echo $2)

if [ $type == "string" ]; then
	type=$(echo std::string)
fi

for var in "${@:3}"
do
	upvar=$(echo ${var} | awk '{print toupper(substr($0,0,1))tolower(substr($0,2))}');
	add_cpp=$(echo $add_cpp"\nconst $type \\&$1::get$upvar(void) const {\n\treturn (this->_$var);\n}\n")
	method_hpp=$(echo $method_hpp"\n\t\tconst $type\t\&get$upvar(void) const;")
done
add_cpp="${add_cpp:2}"
new_hpp=$(printf "$new_hpp" | sed "s/-Getters/&$method_hpp/")
new_cpp=$(cat $file_cpp)
new_cpp=$(echo "$new_cpp" | sed "s/-Getters/&\n$add_cpp/")
echo "$new_cpp" > $file_cpp
printf "$new_hpp" > $file_hpp