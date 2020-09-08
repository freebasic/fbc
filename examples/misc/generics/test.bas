#include once "list.bi"

	type foo
		bar as integer
	end type

	imp_list_of integer
	imp_list_of string
	imp_list_of foo

	var li = new list of integer(10) '' ok
	li->add(123): li->add(456): li->add(789)
	print (*li)[2]
	delete li

	'' NOTE: we'd like to use 
	'' dim li2 as list of integer = list of integer(10)
	'' -- but this won't work because macros called w/o parentheses will read all chars until the newline 
	'' 

	dim li2 as list_of(integer) = list of integer(10)
	li2.add(123): li2.add(456): li2.add(789)
	print li2[1]
	
	dim lf as list of foo
	lf.add(type<foo>(1337))
	print lf[0].bar
	
	dim ls as list of string		 '' ok
	ls.add("aaa"): ls.add("bbb"): ls.add("ccc")
	print ls[1]
