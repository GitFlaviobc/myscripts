#!/bin/bash
## class "name class file 1" "name class file 2" "name class file 3" ..............
for var in "$@"
do
	header=$(echo $var | tr 'a-z' 'A-Z')
	file_hpp=$(echo "$var.hpp")
	file_cpp=$(echo "$var.cpp")

	printf "#ifndef ${header}_HPP
#define ${header}_HPP

#include <iostream>

class $var {
\tpublic:
\t\t// -Constructors
\t\t$var(void);
\t\t$var($var const &rhs);

\t\t// -Destructor
\t\t~$var(void);

\t\t// -Operators
\t\t$var &operator=($var const &rhs);

\t\t// -Getters

\t\t// -Setters

\t\t// -Methods

\tprivate:

\tprotected:

};

// -Functions
std::ostream &operator<<(std::ostream &out, $var const &in);

#endif
" > $file_hpp

	printf "#include \"${file_hpp}\"

// -Constructors
$var::$var(void) {
\tstd::cout << \"$var default constructor called\\\n\";
\treturn ;
}

$var::$var($var const &rhs) {
\tstd::cout << \"$var copy constructor called\\\n\";
\t*this = rhs;
\treturn ;
}

// -Destructor
$var::~$var(void) {
\tstd::cout << \"$var default destructor called\\\n\";
\treturn ;
}

// -Operators
$var &$var::operator=($var const &rhs) {
\tif (this != &rhs) {
\t\tstd::cout << \"$var copy assignment operator called\\\n\";
\t}
\treturn (*this);
}

// -Getters
// -Setters
// -Methods
// -Functions
std::ostream &operator<<(std::ostream &out, $var const &in) {
	(void)in;
	return (out);
}
" > $file_cpp
done
