'' CONST qualifier discarded warnings

'' this test needs constness warnings turned on
#pragma constness=true

#define ENABLE_SHOW_EXPECTED_ERRORS 0

'' set to 1 to see errors, compile with -maxerr 1000 
'' to see all errors


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

'' !!! FIXME !!!: if we already get a warning on different
'' pointer types, warning on CONSTness also is probably
'' meaningless.

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
		#print none expected
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

'' ----------------

#print "---- RTLIB"

'' from sf.net #642

scope

	dim as const integer a = 256

	WARN( 1 )
	*cast( integer ptr, @a ) = 257

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

	#print ASSIGNMENT

	WARN( 0 )
	ptr_const   = @sub_const   '' safe, same type
	WARN( 2 ) 
	ptr_const   = @sub_noconst '' unsafe, because when calling through the ptr the param appears const, but the sub actually modifies it
	WARN( 0 )
	ptr_noconst = @sub_const   '' safe, ptr allows more than the sub will do
	WARN( 0 )
	ptr_noconst = @sub_noconst '' safe, same type

	#print EXPRESSION

	WARN( 0 )
	print cptr(sub(byref as const integer), @sub_const) '' safe
	WARN( 1 ) 
	print cptr(sub(byref as const integer), @sub_noconst) '' unsafe, warn
	WARN( 0 )
	print cptr(sub(byref as integer), @sub_const) '' safe
	WARN( 0 )
	print cptr(sub(byref as integer), @sub_noconst) '' safe
end scope

'' from tests/warnings/ptr-const-param.bas

declare sub byref__i__	( byval as sub( byref as       integer           ) )
declare sub byref_ci__	( byval as sub( byref as const integer           ) )
declare sub byref__i_p	( byval as sub( byref as       integer       ptr ) )
declare sub byref__icp	( byval as sub( byref as       integer const ptr ) )
declare sub byref_ci_p	( byval as sub( byref as const integer       ptr ) )
declare sub byref_cicp	( byval as sub( byref as const integer const ptr ) )

scope
	#print BYREF PARAMETER

	dim _i__ as sub( byref as       integer           )
	dim ci__ as sub( byref as const integer           )
	dim _i_p as sub( byref as       integer       ptr )
	dim _icp as sub( byref as       integer const ptr )
	dim ci_p as sub( byref as const integer       ptr )
	dim cicp as sub( byref as const integer const ptr )

	WARN( 0 )
	byref__i__( _i__ ) '' safe, same type
	WARN( 2 )
	byref_ci__( _i__ ) '' unsafe, ptr can do more than param allows
	WARN( 1 )
	byref__i_p( _i__ ) '' unsafe, different types
	WARN( 2 )
	byref__icp( _i__ ) '' unsafe, different types
	WARN( 1 )
	byref_ci_p( _i__ ) '' unsafe, different types
	WARN( 2 )
	byref_cicp( _i__ ) '' unsafe, different types

	WARN( 0 )
	byref__i__( ci__ ) '' safe, param allows more than ptr will do
	WARN( 0 )
	byref_ci__( ci__ ) '' safe, same type
	WARN( 1 )
	byref__i_p( ci__ ) '' unsafe, different types
	WARN( 1 )
	byref__icp( ci__ ) '' unsafe, different types
	WARN( 1 )
	byref_ci_p( ci__ ) '' unsafe, different types
	WARN( 1 )
	byref_cicp( ci__ ) '' unsafe, different types

	WARN( 1 )
	byref__i__( _i_p ) '' unsafe, different types
	WARN( 2 )
	byref_ci__( _i_p ) '' unsafe, different types
	WARN( 0 )
	byref__i_p( _i_p ) '' safe, same type
	WARN( 2 )
	byref__icp( _i_p ) '' unsafe, ptr can do more than param allows
	WARN( 2 )
	byref_ci_p( _i_p ) '' unsafe, ptr can do more than param allows
	WARN( 2 )
	byref_cicp( _i_p ) '' unsafe, ptr can do more than param allows

	WARN( 1 )
	byref__i__( _icp ) '' unsafe, different types
	WARN( 1 )
	byref_ci__( _icp ) '' unsafe, different types
	WARN( 0 )
	byref__i_p( _icp ) '' safe, param allows more then ptr will do
	WARN( 0 )
	byref__icp( _icp ) '' safe, same type
	WARN( 2 )
	byref_ci_p( _icp ) '' unsafe, different types
	WARN( 2 )
	byref_cicp( _icp ) '' unsafe, ptr can do more than param allows

	WARN( 1 )
	byref__i__( ci_p ) '' unsafe, different types
	WARN( 2 )
	byref_ci__( ci_p ) '' unsafe, different types
	WARN( 0 )
	byref__i_p( ci_p ) '' safe, param allows more then ptr will do
	WARN( 2 )
	byref__icp( ci_p ) '' unsafe, different types
	WARN( 0 )
	byref_ci_p( ci_p ) '' safe, same type
	WARN( 2 )
	byref_cicp( ci_p ) '' unsafe, ptr can do more than param allows

	WARN( 1 )
	byref__i__( cicp ) '' unsafe, different types
	WARN( 1 )
	byref_ci__( cicp ) '' unsafe, different types
	WARN( 0 )
	byref__i_p( cicp ) '' safe, param allows more then ptr will do
	WARN( 0 )
	byref__icp( cicp ) '' safe, param allows more then ptr will do
	WARN( 0 )
	byref_ci_p( cicp ) '' safe, param allows more then ptr will do
	WARN( 0 )
	byref_cicp( cicp ) '' safe, same type

end scope

'' from tests/warnings/ptr-const-param.bas

declare sub byval__i__	( byval as sub( byval as       integer           ) )
declare sub byval_ci__	( byval as sub( byval as const integer           ) )
declare sub byval__i_p	( byval as sub( byval as       integer       ptr ) )
declare sub byval__icp	( byval as sub( byval as       integer const ptr ) )
declare sub byval_ci_p	( byval as sub( byval as const integer       ptr ) )
declare sub byval_cicp	( byval as sub( byval as const integer const ptr ) )

scope
	#print BYVAL PARAMETER

	dim _i__ as sub( byval as       integer           )
	dim ci__ as sub( byval as const integer           )
	dim _i_p as sub( byval as       integer       ptr )
	dim _icp as sub( byval as       integer const ptr )
	dim ci_p as sub( byval as const integer       ptr )
	dim cicp as sub( byval as const integer const ptr )

	WARN( 0 )
	byval__i__( _i__ ) '' safe, same type
	WARN( 0 )
	byval_ci__( _i__ ) '' safe, byval makes copy
	WARN( 1 )
	byval__i_p( _i__ ) '' unsafe, different types
	WARN( 1 )
	byval__icp( _i__ ) '' unsafe, different types
	WARN( 1 )
	byval_ci_p( _i__ ) '' unsafe, different types
	WARN( 1 )
	byval_cicp( _i__ ) '' unsafe, different types

	WARN( 0 )
	byval__i__( ci__ ) '' safe, param allows more than ptr will do
	WARN( 0 )
	byval_ci__( ci__ ) '' safe, same type
	WARN( 1 )
	byval__i_p( ci__ ) '' unsafe, different types
	WARN( 1 )
	byval__icp( ci__ ) '' unsafe, different types
	WARN( 1 )
	byval_ci_p( ci__ ) '' unsafe, different types
	WARN( 1 )
	byval_cicp( ci__ ) '' unsafe, different types

	WARN( 1 )
	byval__i__( _i_p ) '' unsafe, different types
	WARN( 1 )
	byval_ci__( _i_p ) '' unsafe, different types
	WARN( 0 )
	byval__i_p( _i_p ) '' safe, same type
	WARN( 0 )
	byval__icp( _i_p ) '' safe, byval makes copy
	WARN( 2 )
	byval_ci_p( _i_p ) '' unsafe, ptr can do more than param allows
	WARN( 2 )
	byval_cicp( _i_p ) '' unsafe, ptr can do more than param allows

	WARN( 1 )
	byval__i__( _icp ) '' unsafe, different types
	WARN( 1 )
	byval_ci__( _icp ) '' unsafe, different types
	WARN( 0 )
	byval__i_p( _icp ) '' safe, param allows more then ptr will do
	WARN( 0 )
	byval__icp( _icp ) '' safe, same type
	WARN( 2 )
	byval_ci_p( _icp ) '' unsafe, different types
	WARN( 2 )
	byval_cicp( _icp ) '' unsafe, ptr can do more than param allows

	WARN( 1 )
	byval__i__( ci_p ) '' unsafe, different types
	WARN( 1 )
	byval_ci__( ci_p ) '' unsafe, different types
	WARN( 0 )
	byval__i_p( ci_p ) '' safe, param allows more then ptr will do
	WARN( 0 )
	byval__icp( ci_p ) '' safe, byval makes copy
	WARN( 0 )
	byval_ci_p( ci_p ) '' safe, same type
	WARN( 0 )
	byval_cicp( ci_p ) '' safe, byval makes copy

	WARN( 1 )
	byval__i__( cicp ) '' unsafe, different types
	WARN( 1 )
	byval_ci__( cicp ) '' unsafe, different types
	WARN( 0 )
	byval__i_p( cicp ) '' safe, param allows more then ptr will do
	WARN( 0 )
	byval__icp( cicp ) '' safe, param allows more then ptr will do
	WARN( 0 )
	byval_ci_p( cicp ) '' safe, param allows more then ptr will do
	WARN( 0 )
	byval_cicp( cicp ) '' safe, same type

end scope

'' from tests/warnings/ptr-const-param.bas

declare sub sub_byref__i__	( byref as       integer           )
declare sub sub_byref_ci__	( byref as const integer           )
declare sub sub_byref__i_p	( byref as       integer       ptr )
declare sub sub_byref__icp	( byref as       integer const ptr )
declare sub sub_byref_ci_p	( byref as const integer       ptr )
declare sub sub_byref_cicp	( byref as const integer const ptr )

scope
	#print BYREF ASSIGNMENT

	dim _i__ as sub( byref as       integer           )
	dim ci__ as sub( byref as const integer           )
	dim _i_p as sub( byref as       integer       ptr )
	dim _icp as sub( byref as       integer const ptr )
	dim ci_p as sub( byref as const integer       ptr )
	dim cicp as sub( byref as const integer const ptr )

	WARN( 0 )
	_i__ = @sub_byref__i__ '' safe, same type
	WARN( 2 )
	ci__ = @sub_byref__i__ '' unsafe, ptr can do more than param allows
	WARN( 1 )
	_i_p = @sub_byref__i__ '' unsafe, different types
	WARN( 2 )
	_icp = @sub_byref__i__ '' unsafe, different types
	WARN( 1 )
	ci_p = @sub_byref__i__ '' unsafe, different types
	WARN( 2 )
	cicp = @sub_byref__i__ '' unsafe, different types

	WARN( 0 )
	_i__ = @sub_byref_ci__ '' safe, param allows more than ptr will do
	WARN( 0 )
	ci__ = @sub_byref_ci__ '' safe, same type
	WARN( 1 )
	_i_p = @sub_byref_ci__ '' unsafe, different types
	WARN( 1 )
	_icp = @sub_byref_ci__ '' unsafe, different types
	WARN( 1 )
	ci_p = @sub_byref_ci__ '' unsafe, different types
	WARN( 1 )
	cicp = @sub_byref_ci__ '' unsafe, different types

	WARN( 1 )
	_i__ = @sub_byref__i_p '' unsafe, different types
	WARN( 2 )
	ci__ = @sub_byref__i_p '' unsafe, different types
	WARN( 0 )
	_i_p = @sub_byref__i_p '' safe, same type
	WARN( 2 )
	_icp = @sub_byref__i_p '' unsafe, ptr can do more than param allows
	WARN( 2 )
	ci_p = @sub_byref__i_p '' unsafe, ptr can do more than param allows
	WARN( 2 )
	cicp = @sub_byref__i_p '' unsafe, ptr can do more than param allows

	WARN( 1 )
	_i__ = @sub_byref__icp '' unsafe, different types
	WARN( 1 )
	ci__ = @sub_byref__icp '' unsafe, different types
	WARN( 0 )
	_i_p = @sub_byref__icp '' safe, param allows more then ptr will do
	WARN( 0 )
	_icp = @sub_byref__icp '' safe, same type
	WARN( 2 )
	ci_p = @sub_byref__icp '' unsafe, different types
	WARN( 2 )
	cicp = @sub_byref__icp '' unsafe, ptr can do more than param allows

	WARN( 1 )
	_i__ = @sub_byref_ci_p '' unsafe, different types
	WARN( 2 )
	ci__ = @sub_byref_ci_p '' unsafe, different types
	WARN( 0 )
	_i_p = @sub_byref_ci_p '' safe, param allows more then ptr will do
	WARN( 2 )
	_icp = @sub_byref_ci_p '' unsafe, different types
	WARN( 0 )
	ci_p = @sub_byref_ci_p '' safe, same type
	WARN( 2 )
	cicp = @sub_byref_ci_p '' unsafe, ptr can do more than param allows

	WARN( 1 )
	_i__ = @sub_byref_cicp '' unsafe, different types
	WARN( 1 )
	ci__ = @sub_byref_cicp '' unsafe, different types
	WARN( 0 )
	_i_p = @sub_byref_cicp '' safe, param allows more then ptr will do
	WARN( 0 )
	_icp = @sub_byref_cicp '' safe, param allows more then ptr will do
	WARN( 0 )
	ci_p = @sub_byref_cicp '' safe, param allows more then ptr will do
	WARN( 0 )
	cicp = @sub_byref_cicp '' safe, same type

end scope

'' from tests/warnings/ptr-const-param.bas

declare sub sub_byval__i__	( byval as       integer           )
declare sub sub_byval_ci__	( byval as const integer           )
declare sub sub_byval__i_p	( byval as       integer       ptr )
declare sub sub_byval__icp	( byval as       integer const ptr )
declare sub sub_byval_ci_p	( byval as const integer       ptr )
declare sub sub_byval_cicp	( byval as const integer const ptr )

scope
	#print BYVAL ASSIGNMENT

	dim _i__ as sub( byval as       integer           )
	dim ci__ as sub( byval as const integer           )
	dim _i_p as sub( byval as       integer       ptr )
	dim _icp as sub( byval as       integer const ptr )
	dim ci_p as sub( byval as const integer       ptr )
	dim cicp as sub( byval as const integer const ptr )

	WARN( 0 )
	_i__ = @sub_byval__i__ '' safe, same type
	WARN( 0 )
	ci__ = @sub_byval__i__ '' safe, byval makes copy
	WARN( 1 )
	_i_p = @sub_byval__i__ '' unsafe, different types
	WARN( 1 )
	_icp = @sub_byval__i__ '' unsafe, different types
	WARN( 1 )
	ci_p = @sub_byval__i__ '' unsafe, different types
	WARN( 1 )
	cicp = @sub_byval__i__ '' unsafe, different types

	WARN( 0 )
	_i__ = @sub_byval_ci__ '' safe, param allows more than ptr will do
	WARN( 0 )
	ci__ = @sub_byval_ci__ '' safe, same type
	WARN( 1 )
	_i_p = @sub_byval_ci__ '' unsafe, different types
	WARN( 1 )
	_icp = @sub_byval_ci__ '' unsafe, different types
	WARN( 1 )
	ci_p = @sub_byval_ci__ '' unsafe, different types
	WARN( 1 )
	cicp = @sub_byval_ci__ '' unsafe, different types

	WARN( 1 )
	_i__ = @sub_byval__i_p '' unsafe, different types
	WARN( 1 )
	ci__ = @sub_byval__i_p '' unsafe, different types
	WARN( 0 )
	_i_p = @sub_byval__i_p '' safe, same type
	WARN( 0 )
	_icp = @sub_byval__i_p '' safe, byval makes copy
	WARN( 2 )
	ci_p = @sub_byval__i_p '' unsafe, ptr can do more than param allows
	WARN( 2 )
	cicp = @sub_byval__i_p '' unsafe, ptr can do more than param allows

	WARN( 1 )
	_i__ = @sub_byval__icp '' unsafe, different types
	WARN( 1 )
	ci__ = @sub_byval__icp '' unsafe, different types
	WARN( 0 )
	_i_p = @sub_byval__icp '' safe, param allows more then ptr will do
	WARN( 0 )
	_icp = @sub_byval__icp '' safe, same type
	WARN( 2 )
	ci_p = @sub_byval__icp '' unsafe, different types
	WARN( 2 )
	cicp = @sub_byval__icp '' unsafe, ptr can do more than param allows

	WARN( 1 )
	_i__ = @sub_byval_ci_p '' unsafe, different types
	WARN( 1 )
	ci__ = @sub_byval_ci_p '' unsafe, different types
	WARN( 0 )
	_i_p = @sub_byval_ci_p '' safe, param allows more then ptr will do
	WARN( 0 )
	_icp = @sub_byval_ci_p '' safe, byval makes copy
	WARN( 0 )
	ci_p = @sub_byval_ci_p '' safe, same type
	WARN( 0 )
	cicp = @sub_byval_ci_p '' safe, byval makes copy

	WARN( 1 )
	_i__ = @sub_byval_cicp '' unsafe, different types
	WARN( 1 )
	ci__ = @sub_byval_cicp '' unsafe, different types
	WARN( 0 )
	_i_p = @sub_byval_cicp '' safe, param allows more then ptr will do
	WARN( 0 )
	_icp = @sub_byval_cicp '' safe, param allows more then ptr will do
	WARN( 0 )
	ci_p = @sub_byval_cicp '' safe, param allows more then ptr will do
	WARN( 0 )
	cicp = @sub_byval_cicp '' safe, same type

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

'' --------------------------------------------------------

'' from https://www.freebasic.net/forum/viewtopic.php?p=254288#p254288

#print "---- Array in Const UDT"

type point
	x as single
	y as single
end type

type shape
	points(any) as point
end type

sub const_udt_array( byref s as const shape )
	WARN(0)
	print lbound(s.points)
	WARN(0)
	print ubound(s.points)
	WARN(0)
	print @s.points(0)
	WARN(0)
	print s.points(0).x
end sub

'' --------------------------------------------------------

'' from https://www.freebasic.net/forum/viewtopic.php?f=17&t=27692
'' and  https://sourceforge.net/p/fbc/bugs/910/

#print "---- Regression Checks"

sub const_cast_string1( byval s as string )
end sub 
sub const_cast_string2( byref s as const string )
	WARN(1)
    const_cast_string1( cast(string, s) )
end sub

scope
	dim x as const string = "test"
	dim y as string
	WARN(1)
	y = cast(string, x )
	WARN(0)
	y = cast(const string, x )
end scope

type T_integer
	__ as integer
end type

sub const_cast_proc1i( byval i as integer ptr )
end sub 
sub const_cast_proc2i( byval i as const integer ptr )
end sub

sub const_cast_proc1t( byval x as T_integer ptr )
end sub 
sub const_cast_proc2t( byval x as const T_integer ptr )
end sub 

scope
	dim i as const integer = 1
	WARN(1)
	const_cast_proc1i( @cast(integer, i) )
	WARN(0)
	const_cast_proc2i( @cast(const integer, i) )
end scope

scope
	dim i as integer = 1
	WARN(1)
	const_cast_proc2i( @cast(const integer, i) )
	WARN(0)
	const_cast_proc2i( @cast(integer, i) )
end scope

scope
	dim x as const T_integer = ( 1 )
	WARN(1)
	const_cast_proc1t( @cast(T_integer, x) )
	WARN(0)
	const_cast_proc2t( @cast(const T_integer, x) )
end scope

scope
	dim x as T_integer = ( 1 )
	WARN(1)
	const_cast_proc2t( @cast(const T_integer,x) )
	WARN(0)
	const_cast_proc2t( @cast(T_integer,x) )
end scope
