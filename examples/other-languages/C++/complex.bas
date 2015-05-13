'' A bigger examle using a complex number object and overloaded operators,
'' all implemented in C++ in the libcomplex.a created from complex.cxx.

#inclib "complex"

extern "c++"
	namespace cpp
		type complex
			as double re
			as double im

			declare constructor( )
			declare constructor( byval re as double, byval im as double = 0.0 )
			declare function abs2( ) as double
		end type

		declare operator + ( byref as complex, byref as complex ) as complex
		declare operator - ( byref as complex, byref as complex ) as complex
		declare operator * ( byref as complex, byref as complex ) as complex
		declare operator / ( byref as complex, byref as complex ) as complex
	end namespace
end extern

using cpp

dim a as complex = complex(1,2)
dim b as complex = complex(3,4)

dim c as complex
c = a * b

print "c = " & c.re & " + i" & c.im

print "|c|^2 = "; c.abs2()
