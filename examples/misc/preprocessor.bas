''
'' pre-processor test
''

#define DWORD integer
#define foo dim 
#define bar DWORD
#define SOMEVALUE 1234
#define myFunc func1( SOMEVALUE )

declare function func1( byval arg1 as integer ) as integer

#if DWORD = integer or foo = dim
	foo a as bar

	a = SOMEVALUE

	myFunc

#else
	
	dim a as short

	a = 1234

#endif

''''''''''''''''''''''''''''''''''''''''''

#define a_ 1
#define b_ 2
#define c_ 3
#define d_ 4

#if ((a_ = b_ and b_ = c_) or (c_ = d_)) or defined( a_ ) '' comment

# ifdef a_
#  ifdef b_
#   if defined( c_ ) and not defined( e_ )
# print TRUE
#   endif
#  endif
# endif

#else '' comment

# print FALSE

#endif '' comment



function func1( byval arg1 as integer ) as integer

	print "Worked!"
	
	sleep
	
	return 0

end function
