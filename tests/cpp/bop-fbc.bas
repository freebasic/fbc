' TEST_MODE : MULTI_MODULE_TEST

'' test mapping of mangling and calling convention
'' of global overloaded operators
'' between c/c++ and fbc

'' helper macro to track progress
#define DLOG( msg ) '' print #msg

extern "c++"
	'' getters to retrieve call information
	'' from the c++ side
	declare sub resetChecks()
	declare function getPtr1() as any ptr
	declare function getPtr2() as any ptr
	declare function getMsg1() as zstring ptr
	declare function getVal1() as long
	declare function getVal2() as long
	declare function getVal3() as long
end extern

'' default mangling, default calling convention
type UDT_DEFAULT
	value as long
end type

'' fbc will mangle a @N suffix by default
declare operator +( byref lhs as const UDT_DEFAULT, byref rhs as const UDT_DEFAULT ) as UDT_DEFAULT
declare operator -( byref lhs as const UDT_DEFAULT, byref rhs as const UDT_DEFAULT ) as UDT_DEFAULT
declare operator *( byref lhs as const UDT_DEFAULT, byref rhs as const UDT_DEFAULT ) as UDT_DEFAULT
declare operator /( byref lhs as const UDT_DEFAULT, byref rhs as const UDT_DEFAULT ) as UDT_DEFAULT
declare operator mod( byref lhs as const UDT_DEFAULT, byref rhs as const UDT_DEFAULT ) as UDT_DEFAULT
declare operator shl( byref lhs as const UDT_DEFAULT, byref rhs as const UDT_DEFAULT ) as UDT_DEFAULT
declare operator shr( byref lhs as const UDT_DEFAULT, byref rhs as const UDT_DEFAULT ) as UDT_DEFAULT
declare operator and( byref lhs as const UDT_DEFAULT, byref rhs as const UDT_DEFAULT ) as UDT_DEFAULT
declare operator or ( byref lhs as const UDT_DEFAULT, byref rhs as const UDT_DEFAULT ) as UDT_DEFAULT
declare operator xor( byref lhs as const UDT_DEFAULT, byref rhs as const UDT_DEFAULT ) as UDT_DEFAULT


'' extern "c", default calling convention
type UDT_C_DEFAULT
	value as long
end type

extern "c"
	declare operator +( byref lhs as const UDT_C_DEFAULT, byref rhs as const UDT_C_DEFAULT ) as UDT_C_DEFAULT
	declare operator -( byref lhs as const UDT_C_DEFAULT, byref rhs as const UDT_C_DEFAULT ) as UDT_C_DEFAULT
	declare operator *( byref lhs as const UDT_C_DEFAULT, byref rhs as const UDT_C_DEFAULT ) as UDT_C_DEFAULT
	declare operator /( byref lhs as const UDT_C_DEFAULT, byref rhs as const UDT_C_DEFAULT ) as UDT_C_DEFAULT
	declare operator mod( byref lhs as const UDT_C_DEFAULT, byref rhs as const UDT_C_DEFAULT ) as UDT_C_DEFAULT
	declare operator shl( byref lhs as const UDT_C_DEFAULT, byref rhs as const UDT_C_DEFAULT ) as UDT_C_DEFAULT
	declare operator shr( byref lhs as const UDT_C_DEFAULT, byref rhs as const UDT_C_DEFAULT ) as UDT_C_DEFAULT
	declare operator and( byref lhs as const UDT_C_DEFAULT, byref rhs as const UDT_C_DEFAULT ) as UDT_C_DEFAULT
	declare operator or ( byref lhs as const UDT_C_DEFAULT, byref rhs as const UDT_C_DEFAULT ) as UDT_C_DEFAULT
	declare operator xor( byref lhs as const UDT_C_DEFAULT, byref rhs as const UDT_C_DEFAULT ) as UDT_C_DEFAULT
end extern


'' extern "c++", default calling convention
type UDT_CPP_DEFAULT
	value as long
end type

extern "c++"
	declare operator +( byref lhs as const UDT_CPP_DEFAULT, byref rhs as const UDT_CPP_DEFAULT ) as UDT_CPP_DEFAULT
	declare operator -( byref lhs as const UDT_CPP_DEFAULT, byref rhs as const UDT_CPP_DEFAULT ) as UDT_CPP_DEFAULT
	declare operator *( byref lhs as const UDT_CPP_DEFAULT, byref rhs as const UDT_CPP_DEFAULT ) as UDT_CPP_DEFAULT
	declare operator /( byref lhs as const UDT_CPP_DEFAULT, byref rhs as const UDT_CPP_DEFAULT ) as UDT_CPP_DEFAULT
	declare operator mod( byref lhs as const UDT_CPP_DEFAULT, byref rhs as const UDT_CPP_DEFAULT ) as UDT_CPP_DEFAULT
	declare operator shl( byref lhs as const UDT_CPP_DEFAULT, byref rhs as const UDT_CPP_DEFAULT ) as UDT_CPP_DEFAULT
	declare operator shr( byref lhs as const UDT_CPP_DEFAULT, byref rhs as const UDT_CPP_DEFAULT ) as UDT_CPP_DEFAULT
	declare operator and( byref lhs as const UDT_CPP_DEFAULT, byref rhs as const UDT_CPP_DEFAULT ) as UDT_CPP_DEFAULT
	declare operator or ( byref lhs as const UDT_CPP_DEFAULT, byref rhs as const UDT_CPP_DEFAULT ) as UDT_CPP_DEFAULT
	declare operator xor( byref lhs as const UDT_CPP_DEFAULT, byref rhs as const UDT_CPP_DEFAULT ) as UDT_CPP_DEFAULT
end extern

#macro chkbop( op, t, m1, arg1, arg2, result )
	DLOG( n )
	resetChecks()
	scope
		dim a as t = ( arg1 )
		dim b as t = ( arg2 )
		dim r as t
		r = a op b
		assert( m1 = *getMsg1() )
		assert( @a = getPtr1() )
		assert( @b = getPtr2() )
		assert( r.value = result )
		assert( r.value = getVal3() )
	end scope
#endmacro

chkbop( +, UDT_DEFAULT, "UDT_DEFAULT operator+", 5, 7, 12 )
chkbop( -, UDT_DEFAULT, "UDT_DEFAULT operator-", 5, 7, -2 )
chkbop( *, UDT_DEFAULT, "UDT_DEFAULT operator*", 5, 7, 35 )
chkbop( /, UDT_DEFAULT, "UDT_DEFAULT operator/", 35, 7, 5 )
chkbop( mod, UDT_DEFAULT, "UDT_DEFAULT operator%", 16, 5, 1 )
chkbop( shl, UDT_DEFAULT, "UDT_DEFAULT operator<<", 16, 2, 64 )
chkbop( shr, UDT_DEFAULT, "UDT_DEFAULT operator>>", 16, 2, 4 )
chkbop( and, UDT_DEFAULT, "UDT_DEFAULT operator&", &b1100, &b1010, &b1000 )
chkbop( or , UDT_DEFAULT, "UDT_DEFAULT operator|", &b1100, &b1010, &b1110 )
chkbop( xor, UDT_DEFAULT, "UDT_DEFAULT operator^", &b1100, &b1010, &b0110 )

chkbop( +, UDT_C_DEFAULT, "UDT_C_DEFAULT operator+", 5, 7, 12  )
chkbop( -, UDT_C_DEFAULT, "UDT_C_DEFAULT operator-", 5, 7, -2  )
chkbop( *, UDT_C_DEFAULT, "UDT_C_DEFAULT operator*", 5, 7, 35  )
chkbop( /, UDT_C_DEFAULT, "UDT_C_DEFAULT operator/", 35, 7, 5  )
chkbop( mod, UDT_C_DEFAULT, "UDT_C_DEFAULT operator%", 16, 5, 1  )
chkbop( shl, UDT_C_DEFAULT, "UDT_C_DEFAULT operator<<", 16, 2, 64  )
chkbop( shr, UDT_C_DEFAULT, "UDT_C_DEFAULT operator>>", 16, 2, 4  )
chkbop( and, UDT_C_DEFAULT, "UDT_C_DEFAULT operator&", &b1100, &b1010, &b1000 )
chkbop( or , UDT_C_DEFAULT, "UDT_C_DEFAULT operator|", &b1100, &b1010, &b1110 )
chkbop( xor, UDT_C_DEFAULT, "UDT_C_DEFAULT operator^", &b1100, &b1010, &b0110 )

chkbop( +, UDT_CPP_DEFAULT, "UDT_CPP_DEFAULT operator+", 5, 7, 12  )
chkbop( -, UDT_CPP_DEFAULT, "UDT_CPP_DEFAULT operator-", 5, 7, -2  )
chkbop( *, UDT_CPP_DEFAULT, "UDT_CPP_DEFAULT operator*", 5, 7, 35  )
chkbop( /, UDT_CPP_DEFAULT, "UDT_CPP_DEFAULT operator/", 35, 7, 5  )
chkbop( mod, UDT_CPP_DEFAULT, "UDT_CPP_DEFAULT operator%", 16, 5, 1  )
chkbop( shl, UDT_CPP_DEFAULT, "UDT_CPP_DEFAULT operator<<", 16, 2, 64  )
chkbop( shr, UDT_CPP_DEFAULT, "UDT_CPP_DEFAULT operator>>", 16, 2, 4  )
chkbop( and, UDT_CPP_DEFAULT, "UDT_CPP_DEFAULT operator&", &b1100, &b1010, &b1000 )
chkbop( or , UDT_CPP_DEFAULT, "UDT_CPP_DEFAULT operator|", &b1100, &b1010, &b1110 )
chkbop( xor, UDT_CPP_DEFAULT, "UDT_CPP_DEFAULT operator^", &b1100, &b1010, &b0110 )
