#!/bin/bash
for var in "$@"
do
	header=$(echo $var | tr 'a-z' 'A-Z')
	file_hpp=$(echo "$var.hpp")
	file_tpp=$(echo "$var.tpp")

	printf "#ifndef ${header}_HPP
#define ${header}_HPP

template <typename T>

#include \"${file_tpp}\"

#endif
" > $file_hpp

	printf "#ifndef ${header}_TPP
#define ${header}_TPP

#include \"${file_hpp}\"

template <typename T>

#endif
" > $file_tpp
done