'' Namespaces:

namespace Foo
	dim as integer i = 1
	sub sayHi( )
		print "hi"
	end sub
end namespace

namespace Bar
	dim as integer i = 2
	sub sayHi( )
		print "hello"
	end sub
end namespace

print Foo.i, Bar.i
Foo.sayHi( )
Bar.sayHi( )


'' Namespaces can be imported into current scope or into other name spaces
'' via the Using statement:
using Bar
print i
sayHi( )


'' Namespaces can be nested
namespace A
	namespace B
		namespace C.D.E
			dim as integer i = 123
		end namespace
	end namespace
end namespace

print A.B.C.D.E.i
