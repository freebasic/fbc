'' indexed properties example

type foo
	'' get
	declare property bar(index as integer) as integer
	declare property bar(index as string) as integer
	
	'' set
	declare property bar(index as integer, value as integer)
	declare property bar(index as string, value as integer)
	declare property bar(index as integer, value as string)
	declare property bar(index as string, value as string)

private:
	dim as integer __bar(0 to 9)
end type

property foo.bar(index as integer) as integer

	return __bar(index)

end property

property foo.bar(index as string) as integer

	return __bar(cint(index))

end property

property foo.bar(index as integer, value as integer)

	__bar(index) = value

end property

property foo.bar(index as string, value as integer)

	__bar(cint(index)) = value

end property

property foo.bar(index as integer, value as string)

	__bar(index) = cint(value)

end property

property foo.bar(index as string, value as string)

	__bar(cint(index)) = cint(value)

end property

	dim f as foo
	
	f.bar(0) = 1234
	f.bar("1") = 5678
	f.bar(2) = "-1234"
	f.bar("3") = "-5678"
	
	print f.bar(0)
	print f.bar("1")
	print f.bar(2)
	print f.bar("3")
	
	sleep
