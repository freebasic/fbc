#ifndef __VARIANT_BI__
#define __VARIANT_BI__

#ifdef VARIANT_ISBUILDING
	#include once "windows.bi"
	#include once "win/ole2.bi"

	'' older fbc packages (before 2015) had this forward declaration in 
	'' inc/win/oaidl.bi - having it here allows this library to be compiled
	'' (but has not been tested for correctness / completeness)
	type VARIANT_ as VARIANT
#else
	#ifndef VARIANT_
		type VARIANT_
			reserved(0 to 16-1) as byte
		end type
	#endif
#endif

#inclib "variant"
#libpath "libvariant"

enum VARIANT_NOTHING
	NOTHING = -1
end enum

'' this is safe to do because 'VARIANT' is just an alias for 'VARIANT_'
#undef VARIANT

type VARIANT
	as VARIANT_ var_
 	
 	declare constructor ( )
 	declare constructor ( byref rhs as VARIANT )
	declare constructor ( byref rhs as VARIANT, byval deep_copy as integer )
	declare constructor ( byref rhs as VARIANT_ )
	declare constructor ( byref rhs as VARIANT_, byval deep_copy as integer )
	declare constructor ( byval rhs as integer )
	declare constructor ( byval rhs as uinteger )
	declare constructor ( byval rhs as longint )
	declare constructor ( byval rhs as ulongint )
	declare constructor ( byval rhs as single )
	declare constructor ( byval rhs as double )
	declare constructor ( byval rhs as zstring ptr )
	declare constructor ( byval rhs as wstring ptr )
 	
 	declare destructor ( )
 
 #ifndef VARIANT_NOASSIGNMENT
	declare operator let ( byval rhs as VARIANT_NOTHING )
	declare operator let ( byref rhs as VARIANT )
	declare operator let ( byref rhs as VARIANT_ )
	declare operator let ( byval rhs as integer )
	declare operator let ( byval rhs as uinteger )
	declare operator let ( byval rhs as longint )
	declare operator let ( byval rhs as ulongint )
	declare operator let ( byval rhs as single )
	declare operator let ( byval rhs as double )
	declare operator let ( byval rhs as zstring ptr )
	declare operator let ( byval rhs as wstring ptr )
 #endif

	'' cast
	declare operator cast ( ) as VARIANT_
	declare operator cast ( ) as integer
	declare operator cast ( ) as uinteger
	declare operator cast ( ) as longint
	declare operator cast ( ) as ulongint
	declare operator cast ( ) as single
	declare operator cast ( ) as double
	declare operator cast ( ) as string
	declare operator cast ( ) as wstring ptr

	declare operator += ( byref rhs as VARIANT )
	declare operator += ( byref rhs as VARIANT_ ) 
	declare operator += ( byval rhs as integer ) 
	declare operator += ( byval rhs as uinteger ) 
	declare operator += ( byval rhs as longint ) 
	declare operator += ( byval rhs as ulongint ) 
	declare operator += ( byval rhs as single ) 
	declare operator += ( byval rhs as double ) 
	declare operator += ( byval rhs as zstring ptr ) 
	declare operator += ( byval rhs as wstring ptr ) 

	declare operator -= ( byref rhs as VARIANT )
	declare operator -= ( byref rhs as VARIANT_ ) 
	declare operator -= ( byval rhs as integer ) 
	declare operator -= ( byval rhs as uinteger ) 
	declare operator -= ( byval rhs as longint ) 
	declare operator -= ( byval rhs as ulongint ) 
	declare operator -= ( byval rhs as single ) 
	declare operator -= ( byval rhs as double ) 

	declare operator *= ( byref rhs as VARIANT )
	declare operator *= ( byref rhs as VARIANT_ ) 
	declare operator *= ( byval rhs as integer ) 
	declare operator *= ( byval rhs as uinteger ) 
	declare operator *= ( byval rhs as longint ) 
	declare operator *= ( byval rhs as ulongint ) 
	declare operator *= ( byval rhs as single ) 
	declare operator *= ( byval rhs as double ) 
	
	declare operator /= ( byref rhs as VARIANT )
	declare operator /= ( byref rhs as VARIANT_ ) 
	declare operator /= ( byval rhs as integer ) 
	declare operator /= ( byval rhs as uinteger ) 
	declare operator /= ( byval rhs as longint ) 
	declare operator /= ( byval rhs as ulongint ) 
	declare operator /= ( byval rhs as single ) 
	declare operator /= ( byval rhs as double ) 
	
	declare operator \= ( byref rhs as VARIANT )
	declare operator \= ( byref rhs as VARIANT_ ) 
	declare operator \= ( byval rhs as integer ) 
	declare operator \= ( byval rhs as uinteger ) 
	declare operator \= ( byval rhs as longint ) 
	declare operator \= ( byval rhs as ulongint ) 
	declare operator \= ( byval rhs as single ) 
	declare operator \= ( byval rhs as double ) 
	
	declare operator mod= ( byref rhs as VARIANT )
	declare operator mod= ( byref rhs as VARIANT_ ) 
	declare operator mod= ( byval rhs as integer ) 
	declare operator mod= ( byval rhs as uinteger ) 
	declare operator mod= ( byval rhs as longint ) 
	declare operator mod= ( byval rhs as ulongint ) 
	declare operator mod= ( byval rhs as single ) 
	declare operator mod= ( byval rhs as double ) 
	
	declare operator shl= ( byref rhs as VARIANT )
	declare operator shl= ( byval rhs as integer ) 

	declare operator shr= ( byref rhs as VARIANT )
	declare operator shr= ( byval rhs as integer ) 

	declare operator and= ( byref rhs as VARIANT )
	declare operator and= ( byref rhs as VARIANT_ ) 
	declare operator and= ( byval rhs as integer ) 
	declare operator and= ( byval rhs as uinteger ) 
	declare operator and= ( byval rhs as longint ) 
	declare operator and= ( byval rhs as ulongint ) 
	
	declare operator or= ( byref rhs as VARIANT )
	declare operator or= ( byref rhs as VARIANT_ ) 
	declare operator or= ( byval rhs as integer ) 
	declare operator or= ( byval rhs as uinteger ) 
	declare operator or= ( byval rhs as longint ) 
	declare operator or= ( byval rhs as ulongint ) 
	
	declare operator xor= ( byref rhs as VARIANT )
	declare operator xor= ( byref rhs as VARIANT_ ) 
	declare operator xor= ( byval rhs as integer ) 
	declare operator xor= ( byval rhs as uinteger ) 
	declare operator xor= ( byval rhs as longint ) 
	declare operator xor= ( byval rhs as ulongint ) 
	
	declare operator imp= ( byref rhs as VARIANT )
	declare operator imp= ( byref rhs as VARIANT_ ) 
	declare operator imp= ( byval rhs as integer ) 
	declare operator imp= ( byval rhs as uinteger ) 
	declare operator imp= ( byval rhs as longint ) 
	declare operator imp= ( byval rhs as ulongint ) 
	
	declare operator eqv= ( byref rhs as VARIANT )
	declare operator eqv= ( byref rhs as VARIANT_ ) 
	declare operator eqv= ( byval rhs as integer ) 
	declare operator eqv= ( byval rhs as uinteger ) 
	declare operator eqv= ( byval rhs as longint ) 
	declare operator eqv= ( byval rhs as ulongint ) 
	
	declare operator ^= ( byref rhs as VARIANT )
	declare operator ^= ( byref rhs as VARIANT_ ) 
	declare operator ^= ( byval rhs as integer ) 
	declare operator ^= ( byval rhs as uinteger ) 
	declare operator ^= ( byval rhs as longint ) 
	declare operator ^= ( byval rhs as ulongint ) 
	declare operator ^= ( byval rhs as single ) 
	declare operator ^= ( byval rhs as double ) 
end type

'' neg
declare operator - ( byref rhs as VARIANT ) as VARIANT

'' not
declare operator not ( byref rhs as VARIANT ) as VARIANT

'' add
declare operator + ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator + ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as double ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as zstring ptr ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as wstring ptr ) as VARIANT

'' sub
declare operator - ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator - ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as double ) as VARIANT

'' mul
declare operator * ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator * ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as double ) as VARIANT

'' div
declare operator / ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator / ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as double ) as VARIANT

'' idiv
declare operator \ ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as double ) as VARIANT

'' mod
declare operator mod ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as double ) as VARIANT

'' shl
declare operator shl ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator shl ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT

'' shr
declare operator shr ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator shr ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT

'' and
declare operator and ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator and ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator and ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator and ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator and ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator and ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT

'' or
declare operator or ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator or ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator or ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator or ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator or ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator or ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT

'' xor
declare operator xor ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator xor ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator xor ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator xor ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator xor ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator xor ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT

'' imp
declare operator imp ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator imp ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator imp ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator imp ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator imp ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator imp ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT

'' eqv
declare operator eqv ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator eqv ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator eqv ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator eqv ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator eqv ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator eqv ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT

'' pow
declare operator ^ ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as double ) as VARIANT

'' eq
declare operator = ( byref lhs as VARIANT, byref rhs as VARIANT ) as integer
declare operator = ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as integer
declare operator = ( byref lhs as VARIANT, byval rhs as integer ) as integer
declare operator = ( byref lhs as VARIANT, byval rhs as uinteger ) as integer
declare operator = ( byref lhs as VARIANT, byval rhs as longint ) as integer
declare operator = ( byref lhs as VARIANT, byval rhs as ulongint ) as integer
declare operator = ( byref lhs as VARIANT, byval rhs as single ) as integer
declare operator = ( byref lhs as VARIANT, byval rhs as double ) as integer
declare operator = ( byref lhs as VARIANT, byval rhs as zstring ptr ) as integer
declare operator = ( byref lhs as VARIANT, byval rhs as wstring ptr ) as integer

'' ne
declare operator <> ( byref lhs as VARIANT, byref rhs as VARIANT ) as integer
declare operator <> ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as integer
declare operator <> ( byref lhs as VARIANT, byval rhs as integer ) as integer
declare operator <> ( byref lhs as VARIANT, byval rhs as uinteger ) as integer
declare operator <> ( byref lhs as VARIANT, byval rhs as longint ) as integer
declare operator <> ( byref lhs as VARIANT, byval rhs as ulongint ) as integer
declare operator <> ( byref lhs as VARIANT, byval rhs as single ) as integer
declare operator <> ( byref lhs as VARIANT, byval rhs as double ) as integer
declare operator <> ( byref lhs as VARIANT, byval rhs as zstring ptr ) as integer
declare operator <> ( byref lhs as VARIANT, byval rhs as wstring ptr ) as integer

'' lt
declare operator < ( byref lhs as VARIANT, byref rhs as VARIANT ) as integer
declare operator < ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as integer
declare operator < ( byref lhs as VARIANT, byval rhs as integer ) as integer
declare operator < ( byref lhs as VARIANT, byval rhs as uinteger ) as integer
declare operator < ( byref lhs as VARIANT, byval rhs as longint ) as integer
declare operator < ( byref lhs as VARIANT, byval rhs as ulongint ) as integer
declare operator < ( byref lhs as VARIANT, byval rhs as single ) as integer
declare operator < ( byref lhs as VARIANT, byval rhs as double ) as integer
declare operator < ( byref lhs as VARIANT, byval rhs as zstring ptr ) as integer
declare operator < ( byref lhs as VARIANT, byval rhs as wstring ptr ) as integer

'' gt
declare operator > ( byref lhs as VARIANT, byref rhs as VARIANT ) as integer
declare operator > ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as integer
declare operator > ( byref lhs as VARIANT, byval rhs as integer ) as integer
declare operator > ( byref lhs as VARIANT, byval rhs as uinteger ) as integer
declare operator > ( byref lhs as VARIANT, byval rhs as longint ) as integer
declare operator > ( byref lhs as VARIANT, byval rhs as ulongint ) as integer
declare operator > ( byref lhs as VARIANT, byval rhs as single ) as integer
declare operator > ( byref lhs as VARIANT, byval rhs as double ) as integer
declare operator > ( byref lhs as VARIANT, byval rhs as zstring ptr ) as integer
declare operator > ( byref lhs as VARIANT, byval rhs as wstring ptr ) as integer

'' le
declare operator <= ( byref lhs as VARIANT, byref rhs as VARIANT ) as integer
declare operator <= ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as integer
declare operator <= ( byref lhs as VARIANT, byval rhs as integer ) as integer
declare operator <= ( byref lhs as VARIANT, byval rhs as uinteger ) as integer
declare operator <= ( byref lhs as VARIANT, byval rhs as longint ) as integer
declare operator <= ( byref lhs as VARIANT, byval rhs as ulongint ) as integer
declare operator <= ( byref lhs as VARIANT, byval rhs as single ) as integer
declare operator <= ( byref lhs as VARIANT, byval rhs as double ) as integer
declare operator <= ( byref lhs as VARIANT, byval rhs as zstring ptr ) as integer
declare operator <= ( byref lhs as VARIANT, byval rhs as wstring ptr ) as integer

'' ge
declare operator >= ( byref lhs as VARIANT, byref rhs as VARIANT ) as integer
declare operator >= ( byref lhs as VARIANT, byref rhs as VARIANT_ ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as integer ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as uinteger ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as longint ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as ulongint ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as single ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as double ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as zstring ptr ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as wstring ptr ) as integer

'' inverse

'' add
declare operator + ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator + ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator + ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator + ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator + ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT
declare operator + ( byval lhs as single, byref rhs as VARIANT ) as VARIANT
declare operator + ( byval lhs as double, byref rhs as VARIANT ) as VARIANT
declare operator + ( byval lhs as zstring ptr, byref rhs as VARIANT ) as VARIANT
declare operator + ( byval lhs as wstring ptr, byref rhs as VARIANT ) as VARIANT

'' sub
declare operator - ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator - ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator - ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator - ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator - ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT
declare operator - ( byval lhs as single, byref rhs as VARIANT ) as VARIANT
declare operator - ( byval lhs as double, byref rhs as VARIANT ) as VARIANT

'' mul
declare operator * ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator * ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator * ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator * ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator * ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT
declare operator * ( byval lhs as single, byref rhs as VARIANT ) as VARIANT
declare operator * ( byval lhs as double, byref rhs as VARIANT ) as VARIANT

'' div
declare operator / ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator / ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator / ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator / ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator / ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT
declare operator / ( byval lhs as single, byref rhs as VARIANT ) as VARIANT
declare operator / ( byval lhs as double, byref rhs as VARIANT ) as VARIANT

'' idiv
declare operator \ ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator \ ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator \ ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator \ ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator \ ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT
declare operator \ ( byval lhs as single, byref rhs as VARIANT ) as VARIANT
declare operator \ ( byval lhs as double, byref rhs as VARIANT ) as VARIANT

'' mod
declare operator mod ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator mod ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator mod ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator mod ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator mod ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT
declare operator mod ( byval lhs as single, byref rhs as VARIANT ) as VARIANT
declare operator mod ( byval lhs as double, byref rhs as VARIANT ) as VARIANT

'' and
declare operator and ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator and ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator and ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator and ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator and ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT

'' or
declare operator or ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator or ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator or ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator or ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator or ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT

'' xor
declare operator xor ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator xor ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator xor ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator xor ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator xor ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT

'' imp
declare operator imp ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator imp ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator imp ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator imp ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator imp ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT

'' eqv
declare operator eqv ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator eqv ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator eqv ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator eqv ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator eqv ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT

'' pow
declare operator ^ ( byref lhs as VARIANT_, byref rhs as VARIANT ) as VARIANT
declare operator ^ ( byval lhs as integer, byref rhs as VARIANT ) as VARIANT
declare operator ^ ( byval lhs as uinteger, byref rhs as VARIANT ) as VARIANT
declare operator ^ ( byval lhs as longint, byref rhs as VARIANT ) as VARIANT
declare operator ^ ( byval lhs as ulongint, byref rhs as VARIANT ) as VARIANT
declare operator ^ ( byval lhs as single, byref rhs as VARIANT ) as VARIANT
declare operator ^ ( byval lhs as double, byref rhs as VARIANT ) as VARIANT

'' eq
declare operator = ( byref lhs as VARIANT_, byref rhs as VARIANT ) as integer
declare operator = ( byval lhs as integer, byref rhs as VARIANT ) as integer
declare operator = ( byval lhs as uinteger, byref rhs as VARIANT ) as integer
declare operator = ( byval lhs as longint, byref rhs as VARIANT ) as integer
declare operator = ( byval lhs as ulongint, byref rhs as VARIANT ) as integer
declare operator = ( byval lhs as single, byref rhs as VARIANT ) as integer
declare operator = ( byval lhs as double, byref rhs as VARIANT ) as integer
declare operator = ( byval lhs as zstring ptr, byref rhs as VARIANT ) as integer
declare operator = ( byval lhs as wstring ptr, byref rhs as VARIANT ) as integer

'' ne
declare operator <> ( byref lhs as VARIANT_, byref rhs as VARIANT ) as integer
declare operator <> ( byval lhs as integer, byref rhs as VARIANT ) as integer
declare operator <> ( byval lhs as uinteger, byref rhs as VARIANT ) as integer
declare operator <> ( byval lhs as longint, byref rhs as VARIANT ) as integer
declare operator <> ( byval lhs as ulongint, byref rhs as VARIANT ) as integer
declare operator <> ( byval lhs as single, byref rhs as VARIANT ) as integer
declare operator <> ( byval lhs as double, byref rhs as VARIANT ) as integer
declare operator <> ( byval lhs as zstring ptr, byref rhs as VARIANT ) as integer
declare operator <> ( byval lhs as wstring ptr, byref rhs as VARIANT ) as integer

'' lt
declare operator < ( byref lhs as VARIANT_, byref rhs as VARIANT ) as integer
declare operator < ( byval lhs as integer, byref rhs as VARIANT ) as integer
declare operator < ( byval lhs as uinteger, byref rhs as VARIANT ) as integer
declare operator < ( byval lhs as longint, byref rhs as VARIANT ) as integer
declare operator < ( byval lhs as ulongint, byref rhs as VARIANT ) as integer
declare operator < ( byval lhs as single, byref rhs as VARIANT ) as integer
declare operator < ( byval lhs as double, byref rhs as VARIANT ) as integer
declare operator < ( byval lhs as zstring ptr, byref rhs as VARIANT ) as integer
declare operator < ( byval lhs as wstring ptr, byref rhs as VARIANT ) as integer

'' gt
declare operator > ( byref lhs as VARIANT_, byref rhs as VARIANT ) as integer
declare operator > ( byval lhs as integer, byref rhs as VARIANT ) as integer
declare operator > ( byval lhs as uinteger, byref rhs as VARIANT ) as integer
declare operator > ( byval lhs as longint, byref rhs as VARIANT ) as integer
declare operator > ( byval lhs as ulongint, byref rhs as VARIANT ) as integer
declare operator > ( byval lhs as single, byref rhs as VARIANT ) as integer
declare operator > ( byval lhs as double, byref rhs as VARIANT ) as integer
declare operator > ( byval lhs as zstring ptr, byref rhs as VARIANT ) as integer
declare operator > ( byval lhs as wstring ptr, byref rhs as VARIANT ) as integer

'' le
declare operator <= ( byref lhs as VARIANT_, byref rhs as VARIANT ) as integer
declare operator <= ( byval lhs as integer, byref rhs as VARIANT ) as integer
declare operator <= ( byval lhs as uinteger, byref rhs as VARIANT ) as integer
declare operator <= ( byval lhs as longint, byref rhs as VARIANT ) as integer
declare operator <= ( byval lhs as ulongint, byref rhs as VARIANT ) as integer
declare operator <= ( byval lhs as single, byref rhs as VARIANT ) as integer
declare operator <= ( byval lhs as double, byref rhs as VARIANT ) as integer
declare operator <= ( byval lhs as zstring ptr, byref rhs as VARIANT ) as integer
declare operator <= ( byval lhs as wstring ptr, byref rhs as VARIANT ) as integer

'' ge
declare operator >= ( byref lhs as VARIANT_, byref rhs as VARIANT ) as integer
declare operator >= ( byval lhs as integer, byref rhs as VARIANT ) as integer
declare operator >= ( byval lhs as uinteger, byref rhs as VARIANT ) as integer
declare operator >= ( byval lhs as longint, byref rhs as VARIANT ) as integer
declare operator >= ( byval lhs as ulongint, byref rhs as VARIANT ) as integer
declare operator >= ( byval lhs as single, byref rhs as VARIANT ) as integer
declare operator >= ( byval lhs as double, byref rhs as VARIANT ) as integer
declare operator >= ( byval lhs as zstring ptr, byref rhs as VARIANT ) as integer
declare operator >= ( byval lhs as wstring ptr, byref rhs as VARIANT ) as integer


#endif