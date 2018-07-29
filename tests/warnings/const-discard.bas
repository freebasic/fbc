'' CONST qualifier discarded warnings

'' set to 1 to see errors, compile with -maxerr 1000 
'' to see all errors

#define ENABLE_SHOW_EXPECTED_ERRORS 0


/'
To check first time run, use this helper tool:
	$ cd ./generator
	$ fbc -w constness ../const-discard.bas -c > const-discard.log 
	$ fbc chk-warning-log.bas
	$ ./chk-warning-log const-discard.log > chk-const-discard.log

	Line numbers reported in ./chk-const-discard.log refer to line 
	numbers in const-discard.log which can then be referenced to line 
	numbers in ../const-discard.bas

	If no differences found, ./chk-const-discard.log is empty file.

'/

'' --------------------------------------------------------

#macro WARN_AND_ERROR( W, E )
	#if (W>0) and (E>0)
		#print W Warning(s), E Error(s)
	#elseif (W>0)
		#print W Warning(s)
	#elseif (E>0)
		#print E Error(s)
	#else
		#print "No Warnings"
	#endif
#endmacro

#macro WARN( W )
	#if (W=0) 
	#elseif (W=1)
		#print warning expected
	#elseif (W=2)
		#print 2 warnings expected
	#else
		#print argument must be 0 or 1 or 2
		#error
	#endif
#endmacro

'' --------------------------------------------------------

#print "---- INTERNAL CONVERSIONS"

'' internal init should not give warning

WARN( 0 )

type T_modlevel
	__ as string
end type

'' --------------------------------------------------------

'' internal init should not give warning

scope
	WARN( 0 )
	dim s as const string = ""
end scope

'' --------------------------------------------------------

'' internal init should not give warning

WARN( 0 )

type RTTI1 extends object
end type

type RTTI2 extends RTTI1
end type

'' ----------------

'' internal init should not give warning

WARN( 0 )

type OBJECT1 extends OBJECT
   static as const integer y
   static as integer z
end type

'' ----------------

'' internal casts to [const] zstring const ptr ptr
'' should not give warning

WARN( 0 )

scope
	dim i as integer
	dim k as const integer = 1
	scope
		dim s as string
		#print 5 UBYTE PTR to follow
		#print typeof( @s[0] )
		#print typeof( @s[1] )
		#print typeof( @s[i] )
		#print typeof( @s[k] )
		#print typeof( @s[k+i] )
	end scope

	scope
		dim s as const string = ""
		dim i as integer
		dim k as const integer = 1
		#print 5 CONST UBYTE PTR to follow
		#print typeof( @s[0] )
		#print typeof( @s[1] )
		#print typeof( @s[i] )
		#print typeof( @s[k] )
		#print typeof( @s[k+i] )
	end scope
end scope

'' --------------------------------------------------------

'' from sf.net #801

WARN( 0 )

scope 
	type UDT
		i as integer
	end type

	dim x as UDT

	/'
	'' !!! FIXME: move to unit tests, error expected
	type<UDT>(1) = x
	*@type<UDT>(1) = x
	'/

	type<UDT>(0).i = 1
	*@type<UDT>(0).i = 1
end scope

'' ----------------

#print "---- RTLIB"

'' from sf.net #642

scope

	dim as const integer a = 256

	WARN( 1 )
	clear a, 0, sizeof(integer)

	WARN( 1 )
	poke integer, @a, 257

end scope

'' --------------------------------------------------------

#print "---- LOCAL CONST INTEGER"

scope
	WARN( 0 )
	dim x as const integer = 1

	scope
		WARN( 0 )
		dim p as const integer ptr = @x
		p = @x
	end scope

	scope
		WARN( 1 )
		dim p as const integer ptr = cast( integer ptr, @x )
		WARN( 1 )
		p = cast( integer ptr, @x )
	end scope

	scope
		WARN( 0 )
		dim p as const integer ptr = cast( const integer ptr, @x )
		WARN( 0 )
		p = cast( const integer ptr, @x )
	end scope

	#if (ENABLE_SHOW_EXPECTED_ERRORS<>0)
	scope
		WARN_AND_ERROR( 1, 2 )
		dim p as integer ptr = @x
		p = @x
	end scope
	#endif

	scope
		WARN( 1 )
		dim p as integer ptr = cast( integer ptr, @x )
		WARN( 1 )
		p = cast( integer ptr, @x )
	end scope

	#if (ENABLE_SHOW_EXPECTED_ERRORS<>0)
	scope
		WARN_AND_ERROR( 1, 2 )
		dim p as integer ptr = cast( const integer ptr, @x )
		p = cast( const integer ptr, @x )
	end scope
	#endif

end scope

'' --------------------------------------------------------

#print "---- LOCAL INTEGER"

scope
	WARN( 0 )
	dim x as integer = 1

	scope
		WARN( 0 )
		dim p as const integer ptr = @x
		p = @x
	end scope

	scope
		WARN( 0 )
		dim p as const integer ptr = cast( integer ptr, @x )
		p = cast( integer ptr, @x )
	end scope

	scope
		WARN( 1 )
		dim p as const integer ptr = cast( const integer ptr, @x )
		WARN( 1 )
		p = cast( const integer ptr, @x )
	end scope

	scope
		WARN( 0 )
		dim p as integer ptr = @x
		p = @x
	end scope

	scope
		WARN( 0 )
		dim p as integer ptr = cast( integer ptr, @x )
		p = cast( integer ptr, @x )
	end scope

	#if (ENABLE_SHOW_EXPECTED_ERRORS<>0)
	scope
		WARN_AND_ERROR( 2, 3 )
		dim p as integer ptr = cast( const integer ptr, @x )
		p = cast( const integer ptr, @x )
	end scope
	#endif

end scope

'' --------------------------------------------------------

'' internal array expressions should not give warning
'' only access to the data type represented

#print "---- LOCAL CONST INTEGER ARRAY"

scope
	WARN( 0 )
	dim x(0 to 2) as const integer = { 1, 2, 3 }
	dim i as const integer = 1

	scope
		WARN( 0 )
		dim p0 as const integer ptr = @x(0)
		dim p1 as const integer ptr = @x(1)
		dim p2 as const integer ptr = @x(i)
		dim p3 as const integer ptr = @x(1+i)
		p0 = @x(0)
		p1 = @x(1)
		p2 = @x(i)
		p3 = @x(1+i)
	end scope

	scope
		WARN( 1 )
		dim p0 as const integer ptr = cast( integer ptr, @x(0) )
		WARN( 1 )
		dim p1 as const integer ptr = cast( integer ptr, @x(1) )
		WARN( 1 )
		dim p2 as const integer ptr = cast( integer ptr, @x(i) )
		WARN( 1 )
		dim p3 as const integer ptr = cast( integer ptr, @x(1+i) )
		WARN( 1 )
		p0 = cast( integer ptr, @x(0) )
		WARN( 1 )
		p1 = cast( integer ptr, @x(1) )
		WARN( 1 )
		p2 = cast( integer ptr, @x(i) )
		WARN( 1 )
		p3 = cast( integer ptr, @x(1+i) )
	end scope

	scope
		WARN( 0 )
		dim p0 as const integer ptr = cast( const integer ptr, @x(0) )
		dim p1 as const integer ptr = cast( const integer ptr, @x(1) )
		dim p3 as const integer ptr = cast( const integer ptr, @x(i) )
		dim p2 as const integer ptr = cast( const integer ptr, @x(1+i) )
		p0 = cast( const integer ptr, @x(0) )
		p1 = cast( const integer ptr, @x(1) )
		p2 = cast( const integer ptr, @x(i) )
		p3 = cast( const integer ptr, @x(1+i) )
	end scope

	#if (ENABLE_SHOW_EXPECTED_ERRORS<>0)
	scope
		WARN_AND_ERROR( 3, 6 )
		dim p0 as integer ptr = @x(0)
		dim p1 as integer ptr = @x(1)
		dim p2 as integer ptr = @x(i)
		dim p3 as integer ptr = @x(1+i)
		p0 = @x(0)
		p1 = @x(1)
		p2 = @x(i)
		p3 = @x(1+i)
	end scope
	#endif

	scope
		WARN( 1 )
		dim p0 as integer ptr = cast( integer ptr, @x(0) )
		WARN( 1 )
		dim p1 as integer ptr = cast( integer ptr, @x(1) )
		WARN( 1 )
		dim p2 as integer ptr = cast( integer ptr, @x(i) )
		WARN( 1 )
		dim p3 as integer ptr = cast( integer ptr, @x(1+i) )
		WARN( 1 )
		p0 = cast( integer ptr, @x(0) )
		WARN( 1 )
		p1 = cast( integer ptr, @x(1) )
		WARN( 1 )
		p2 = cast( integer ptr, @x(i) )
		WARN( 1 )
		p2 = cast( integer ptr, @x(1+i) )
	end scope

	#if (ENABLE_SHOW_EXPECTED_ERRORS<>0)
	scope
		WARN_AND_ERROR( 3, 6 )
		dim p0 as integer ptr = cast( const integer ptr, @x(0) )
		dim p1 as integer ptr = cast( const integer ptr, @x(1) )
		dim p2 as integer ptr = cast( const integer ptr, @x(i) )
		dim p3 as integer ptr = cast( const integer ptr, @x(1+i) )
		p0 = cast( const integer ptr, @x(0) )
		p1 = cast( const integer ptr, @x(1) )
		p2 = cast( const integer ptr, @x(i) )
		p3 = cast( const integer ptr, @x(1+i) )
	end scope
	#endif

end scope

'' --------------------------------------------------------

'' internal array expressions should not give warning
'' only access to the data type represented

#print "---- LOCAL INTEGER ARRAY"

scope
	WARN( 0 )
	dim x(0 to 2) as integer = { 1, 2, 3 }
	dim i as const integer = 1

	scope
		WARN( 0 )
		dim p0 as const integer ptr = @x(0)
		dim p1 as const integer ptr = @x(1)
		dim p2 as const integer ptr = @x(i)
		dim p3 as const integer ptr = @x(1+i)
		p0 = @x(0)
		p1 = @x(1)
		p2 = @x(i)
		p3 = @x(1+i)
	end scope

	scope
		#print TODO: assigning non-const-ptr to const-ptr is safe, warn only if -w constness given
		WARN( 0 )
		dim p0 as const integer ptr = cast( integer ptr, @x(0) )
		WARN( 0 )
		dim p1 as const integer ptr = cast( integer ptr, @x(1) )
		WARN( 0 )
		dim p2 as const integer ptr = cast( integer ptr, @x(i) )
		WARN( 0 )
		dim p3 as const integer ptr = cast( integer ptr, @x(1+i) )
		WARN( 0 )
		p0 = cast( integer ptr, @x(0) )
		WARN( 0 )
		p1 = cast( integer ptr, @x(1) )
		WARN( 0 )
		p2 = cast( integer ptr, @x(i) )
		WARN( 0 )
		p3 = cast( integer ptr, @x(1+i) )
	end scope

	scope
		WARN( 1 )
		dim p0 as const integer ptr = cast( const integer ptr, @x(0) )
		WARN( 1 )
		dim p1 as const integer ptr = cast( const integer ptr, @x(1) )
		WARN( 1 )
		dim p2 as const integer ptr = cast( const integer ptr, @x(i) )
		WARN( 1 )
		dim p3 as const integer ptr = cast( const integer ptr, @x(1+i) )
		WARN( 1 )
		p0 = cast( const integer ptr, @x(0) )
		WARN( 1 )
		p1 = cast( const integer ptr, @x(i) )
		WARN( 1 )
		p2 = cast( const integer ptr, @x(1+i) )
	end scope

	scope
		WARN( 0 )
		dim p0 as integer ptr = @x(0)
		dim p1 as integer ptr = @x(1)
		dim p2 as integer ptr = @x(i)
		dim p3 as integer ptr = @x(1+i)
		p0 = @x(0)
		p1 = @x(1)
		p2 = @x(i)
		p3 = @x(1+i)
	end scope

	scope
		WARN( 0 )
		dim p0 as integer ptr = cast( integer ptr, @x(0) )
		dim p1 as integer ptr = cast( integer ptr, @x(1) )
		dim p2 as integer ptr = cast( integer ptr, @x(i) )
		dim p3 as integer ptr = cast( integer ptr, @x(1+i) )
		p0 = cast( integer ptr, @x(0) )
		p1 = cast( integer ptr, @x(1) )
		p2 = cast( integer ptr, @x(i) )
		p3 = cast( integer ptr, @x(1+i) )
	end scope

	#if (ENABLE_SHOW_EXPECTED_ERRORS<>0)
	scope
		WARN_AND_ERROR( 9, 6 )
		dim p0 as integer ptr = cast( const integer ptr, @x(0) )
		dim p1 as integer ptr = cast( const integer ptr, @x(1) )
		dim p2 as integer ptr = cast( const integer ptr, @x(i) )
		dim p3 as integer ptr = cast( const integer ptr, @x(1+i) )
		p0 = cast( const integer ptr, @x(0) )
		p1 = cast( const integer ptr, @x(1) )
		p2 = cast( const integer ptr, @x(i) )
		p3 = cast( const integer ptr, @x(1+i) )
	end scope
	#endif

end scope

'' --------------------------------------------------------

'' from sf.net #642

#print "---- LOCAL INTEGER and BYTE PTR"

scope
	scope
		dim x as const integer = 1
		dim p as const integer ptr = @x
		WARN( 1 )
		*cast(byte ptr, p) = 1
	end scope

	scope
		dim x as const integer = 1
		WARN( 1 )
		dim p as const integer ptr = cast( const byte ptr, @x )
	end scope

	scope
		dim x as const integer = 1
		WARN( 0 )
		dim p as const byte ptr = cast( const byte ptr, @x )
	end scope

	scope
		dim x as const integer = 1
		WARN( 1 )
		dim p as byte ptr = cast( byte ptr, @x )
	end scope

	scope
		dim x as const integer = 1
		WARN( 0 )
		dim p as const integer ptr = @x
		WARN( 2 )
		p = cast( byte ptr, @x )
	end scope
end scope

'' --------------------------------------------------------

#print "---- MULTIPLE CAST"

	scope
		dim i as const integer = 123
		dim p as integer ptr
		WARN( 2 )
		p = cast( integer ptr, cast( const integer ptr, cast( integer, cast( integer ptr, @i ) ) ) )
	end scope

'' --------------------------------------------------------

'' from PR#90 discussion

#print "---- PROCEDURE POINTERS"

sub sub_const(byref i as const integer)
	print i
end sub

sub sub_noconst(byref i as integer)
	i = 123
	print i
end sub

scope
	type type_const as sub(byref as const integer)
	type type_noconst as sub(byref as integer)

	dim ptr_const as type_const
	dim ptr_noconst as type_noconst

	ptr_const   = @sub_const   '' safe, same type

	WARN( 1 ) 
	ptr_const   = @sub_noconst '' unsafe, because when calling through the ptr the param appears const, but the sub actually modifies it

	ptr_noconst = @sub_const   '' safe, ptr allows more than the sub will do

	ptr_noconst = @sub_noconst '' safe, same type

	print cptr(sub(byref as const integer), @sub_const) '' safe

	WARN( 1 ) 
	print cptr(sub(byref as const integer), @sub_noconst) '' unsafe, currently no warning even with -w constness

	print cptr(sub(byref as integer), @sub_const) '' safe

	print cptr(sub(byref as integer), @sub_noconst) '' safe

end scope

'' --------------------------------------------------------

#print "---- RTLIB DEALLOCATE"

scope
	type T
		zc as const zstring ptr
		z as zstring ptr
		ic as const integer ptr
		i as integer ptr
	end type

	dim x as T

	'' should not get warnings when allocating/deallocating
	'' a const {datatype} ptr.  We only need to guarantee
	'' that the data is not modified when accessed though
	'' the const type.  We make no guarantees about the pointer
	'' itself; which includes deallocation.

	'' no warnings expected

	WARN( 0 )
	x.zc = callocate( 10 )
	deallocate( x.zc )

	WARN( 0 )
	x.z = callocate( 10 )
	deallocate( x.z )

	WARN( 0 )
	x.ic = callocate( 10 )
	deallocate( x.ic )

	WARN( 0 )
	x.i = callocate( 10 )
	deallocate( x.i )

end scope

'' --------------------------------------------------------

#print "---- CRT memcpy"

declare function memcpy (byval as any ptr, byval as const any ptr, byval as integer ) as any ptr

scope
	dim x as byte ptr
	
	dim xc as const byte ptr = allocate(10)
	dim i as integer

	'' safe, should not warn
	WARN(0)
	memcpy( x, x, 5 )

	WARN(0)
	memcpy( x, xc, 5 )

	WARN(0)
	memcpy( x + i, x, 5 )

	WARN(0)
	memcpy( x + i, xc, 5 )
end scope
