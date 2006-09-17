#ifndef __VARIANT_BI__
#define __VARIANT_BI__

#include once "windows.bi"
#include once "win/ole2.bi"

#inclib "variant"

enum VARIANT_NOTHING
	NOTHING = -1
end enum

type CVariant
	as VARIANT var
 	
 	declare constructor ( )
 	declare constructor ( byref rhs as CVariant )
	declare constructor ( byref rhs as CVariant, byval deep_copy as integer )
	declare constructor ( byref rhs as VARIANT )
	declare constructor ( byref rhs as VARIANT, byval deep_copy as integer )
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
	declare operator let ( byref rhs as CVariant )
	declare operator let ( byref rhs as VARIANT )
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
	declare operator cast ( ) as VARIANT
	declare operator cast ( ) as integer
	declare operator cast ( ) as uinteger
	declare operator cast ( ) as longint
	declare operator cast ( ) as ulongint
	declare operator cast ( ) as single
	declare operator cast ( ) as double
	declare operator cast ( ) as string
	declare operator cast ( ) as wstring ptr

	declare operator += ( byref rhs as CVariant )
	declare operator += ( byref rhs as VARIANT ) 
	declare operator += ( byval rhs as integer ) 
	declare operator += ( byval rhs as uinteger ) 
	declare operator += ( byval rhs as longint ) 
	declare operator += ( byval rhs as ulongint ) 
	declare operator += ( byval rhs as single ) 
	declare operator += ( byval rhs as double ) 
	declare operator += ( byval rhs as zstring ptr ) 
	declare operator += ( byval rhs as wstring ptr ) 

	declare operator -= ( byref rhs as CVariant )
	declare operator -= ( byref rhs as VARIANT ) 
	declare operator -= ( byval rhs as integer ) 
	declare operator -= ( byval rhs as uinteger ) 
	declare operator -= ( byval rhs as longint ) 
	declare operator -= ( byval rhs as ulongint ) 
	declare operator -= ( byval rhs as single ) 
	declare operator -= ( byval rhs as double ) 

	declare operator *= ( byref rhs as CVariant )
	declare operator *= ( byref rhs as VARIANT ) 
	declare operator *= ( byval rhs as integer ) 
	declare operator *= ( byval rhs as uinteger ) 
	declare operator *= ( byval rhs as longint ) 
	declare operator *= ( byval rhs as ulongint ) 
	declare operator *= ( byval rhs as single ) 
	declare operator *= ( byval rhs as double ) 
	
	declare operator /= ( byref rhs as CVariant )
	declare operator /= ( byref rhs as VARIANT ) 
	declare operator /= ( byval rhs as integer ) 
	declare operator /= ( byval rhs as uinteger ) 
	declare operator /= ( byval rhs as longint ) 
	declare operator /= ( byval rhs as ulongint ) 
	declare operator /= ( byval rhs as single ) 
	declare operator /= ( byval rhs as double ) 
	
	declare operator \= ( byref rhs as CVariant )
	declare operator \= ( byref rhs as VARIANT ) 
	declare operator \= ( byval rhs as integer ) 
	declare operator \= ( byval rhs as uinteger ) 
	declare operator \= ( byval rhs as longint ) 
	declare operator \= ( byval rhs as ulongint ) 
	declare operator \= ( byval rhs as single ) 
	declare operator \= ( byval rhs as double ) 
	
	declare operator mod= ( byref rhs as CVariant )
	declare operator mod= ( byref rhs as VARIANT ) 
	declare operator mod= ( byval rhs as integer ) 
	declare operator mod= ( byval rhs as uinteger ) 
	declare operator mod= ( byval rhs as longint ) 
	declare operator mod= ( byval rhs as ulongint ) 
	declare operator mod= ( byval rhs as single ) 
	declare operator mod= ( byval rhs as double ) 
	
	declare operator shl= ( byref rhs as CVariant )
	declare operator shl= ( byval rhs as integer ) 

	declare operator shr= ( byref rhs as CVariant )
	declare operator shr= ( byval rhs as integer ) 

	declare operator and= ( byref rhs as CVariant )
	declare operator and= ( byref rhs as VARIANT ) 
	declare operator and= ( byval rhs as integer ) 
	declare operator and= ( byval rhs as uinteger ) 
	declare operator and= ( byval rhs as longint ) 
	declare operator and= ( byval rhs as ulongint ) 
	
	declare operator or= ( byref rhs as CVariant )
	declare operator or= ( byref rhs as VARIANT ) 
	declare operator or= ( byval rhs as integer ) 
	declare operator or= ( byval rhs as uinteger ) 
	declare operator or= ( byval rhs as longint ) 
	declare operator or= ( byval rhs as ulongint ) 
	
	declare operator xor= ( byref rhs as CVariant )
	declare operator xor= ( byref rhs as VARIANT ) 
	declare operator xor= ( byval rhs as integer ) 
	declare operator xor= ( byval rhs as uinteger ) 
	declare operator xor= ( byval rhs as longint ) 
	declare operator xor= ( byval rhs as ulongint ) 
	
	declare operator imp= ( byref rhs as CVariant )
	declare operator imp= ( byref rhs as VARIANT ) 
	declare operator imp= ( byval rhs as integer ) 
	declare operator imp= ( byval rhs as uinteger ) 
	declare operator imp= ( byval rhs as longint ) 
	declare operator imp= ( byval rhs as ulongint ) 
	
	declare operator eqv= ( byref rhs as CVariant )
	declare operator eqv= ( byref rhs as VARIANT ) 
	declare operator eqv= ( byval rhs as integer ) 
	declare operator eqv= ( byval rhs as uinteger ) 
	declare operator eqv= ( byval rhs as longint ) 
	declare operator eqv= ( byval rhs as ulongint ) 
	
	declare operator ^= ( byref rhs as CVariant )
	declare operator ^= ( byref rhs as VARIANT ) 
	declare operator ^= ( byval rhs as integer ) 
	declare operator ^= ( byval rhs as uinteger ) 
	declare operator ^= ( byval rhs as longint ) 
	declare operator ^= ( byval rhs as ulongint ) 
	declare operator ^= ( byval rhs as single ) 
	declare operator ^= ( byval rhs as double ) 
end type

'' neg
declare operator - ( byref rhs as CVariant ) as CVariant

'' not
declare operator not ( byref rhs as CVariant ) as CVariant

'' add
declare operator + ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator + ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator + ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator + ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator + ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator + ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant
declare operator + ( byref lhs as CVariant, byval rhs as single ) as CVariant
declare operator + ( byref lhs as CVariant, byval rhs as double ) as CVariant
declare operator + ( byref lhs as CVariant, byval rhs as zstring ptr ) as CVariant
declare operator + ( byref lhs as CVariant, byval rhs as wstring ptr ) as CVariant

'' sub
declare operator - ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator - ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator - ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator - ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator - ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator - ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant
declare operator - ( byref lhs as CVariant, byval rhs as single ) as CVariant
declare operator - ( byref lhs as CVariant, byval rhs as double ) as CVariant

'' mul
declare operator * ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator * ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator * ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator * ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator * ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator * ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant
declare operator * ( byref lhs as CVariant, byval rhs as single ) as CVariant
declare operator * ( byref lhs as CVariant, byval rhs as double ) as CVariant

'' div
declare operator / ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator / ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator / ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator / ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator / ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator / ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant
declare operator / ( byref lhs as CVariant, byval rhs as single ) as CVariant
declare operator / ( byref lhs as CVariant, byval rhs as double ) as CVariant

'' idiv
declare operator \ ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator \ ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator \ ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator \ ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator \ ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator \ ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant
declare operator \ ( byref lhs as CVariant, byval rhs as single ) as CVariant
declare operator \ ( byref lhs as CVariant, byval rhs as double ) as CVariant

'' mod
declare operator mod ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator mod ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator mod ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator mod ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator mod ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator mod ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant
declare operator mod ( byref lhs as CVariant, byval rhs as single ) as CVariant
declare operator mod ( byref lhs as CVariant, byval rhs as double ) as CVariant

'' shl
declare operator shl ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator shl ( byref lhs as CVariant, byval rhs as integer ) as CVariant

'' shr
declare operator shr ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator shr ( byref lhs as CVariant, byval rhs as integer ) as CVariant

'' and
declare operator and ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator and ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator and ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator and ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator and ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator and ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant

'' or
declare operator or ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator or ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator or ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator or ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator or ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator or ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant

'' xor
declare operator xor ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator xor ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator xor ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator xor ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator xor ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator xor ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant

'' imp
declare operator imp ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator imp ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator imp ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator imp ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator imp ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator imp ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant

'' eqv
declare operator eqv ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator eqv ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator eqv ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator eqv ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator eqv ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator eqv ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant

'' pow
declare operator ^ ( byref lhs as CVariant, byref rhs as CVariant ) as CVariant
declare operator ^ ( byref lhs as CVariant, byref rhs as VARIANT ) as CVariant
declare operator ^ ( byref lhs as CVariant, byval rhs as integer ) as CVariant
declare operator ^ ( byref lhs as CVariant, byval rhs as uinteger ) as CVariant
declare operator ^ ( byref lhs as CVariant, byval rhs as longint ) as CVariant
declare operator ^ ( byref lhs as CVariant, byval rhs as ulongint ) as CVariant
declare operator ^ ( byref lhs as CVariant, byval rhs as single ) as CVariant
declare operator ^ ( byref lhs as CVariant, byval rhs as double ) as CVariant

'' eq
declare operator = ( byref lhs as CVariant, byref rhs as CVariant ) as integer
declare operator = ( byref lhs as CVariant, byref rhs as VARIANT ) as integer
declare operator = ( byref lhs as CVariant, byval rhs as integer ) as integer
declare operator = ( byref lhs as CVariant, byval rhs as uinteger ) as integer
declare operator = ( byref lhs as CVariant, byval rhs as longint ) as integer
declare operator = ( byref lhs as CVariant, byval rhs as ulongint ) as integer
declare operator = ( byref lhs as CVariant, byval rhs as single ) as integer
declare operator = ( byref lhs as CVariant, byval rhs as double ) as integer
declare operator = ( byref lhs as CVariant, byval rhs as zstring ptr ) as integer
declare operator = ( byref lhs as CVariant, byval rhs as wstring ptr ) as integer

'' ne
declare operator <> ( byref lhs as CVariant, byref rhs as CVariant ) as integer
declare operator <> ( byref lhs as CVariant, byref rhs as VARIANT ) as integer
declare operator <> ( byref lhs as CVariant, byval rhs as integer ) as integer
declare operator <> ( byref lhs as CVariant, byval rhs as uinteger ) as integer
declare operator <> ( byref lhs as CVariant, byval rhs as longint ) as integer
declare operator <> ( byref lhs as CVariant, byval rhs as ulongint ) as integer
declare operator <> ( byref lhs as CVariant, byval rhs as single ) as integer
declare operator <> ( byref lhs as CVariant, byval rhs as double ) as integer
declare operator <> ( byref lhs as CVariant, byval rhs as zstring ptr ) as integer
declare operator <> ( byref lhs as CVariant, byval rhs as wstring ptr ) as integer

'' lt
declare operator < ( byref lhs as CVariant, byref rhs as CVariant ) as integer
declare operator < ( byref lhs as CVariant, byref rhs as VARIANT ) as integer
declare operator < ( byref lhs as CVariant, byval rhs as integer ) as integer
declare operator < ( byref lhs as CVariant, byval rhs as uinteger ) as integer
declare operator < ( byref lhs as CVariant, byval rhs as longint ) as integer
declare operator < ( byref lhs as CVariant, byval rhs as ulongint ) as integer
declare operator < ( byref lhs as CVariant, byval rhs as single ) as integer
declare operator < ( byref lhs as CVariant, byval rhs as double ) as integer
declare operator < ( byref lhs as CVariant, byval rhs as zstring ptr ) as integer
declare operator < ( byref lhs as CVariant, byval rhs as wstring ptr ) as integer

'' gt
declare operator > ( byref lhs as CVariant, byref rhs as CVariant ) as integer
declare operator > ( byref lhs as CVariant, byref rhs as VARIANT ) as integer
declare operator > ( byref lhs as CVariant, byval rhs as integer ) as integer
declare operator > ( byref lhs as CVariant, byval rhs as uinteger ) as integer
declare operator > ( byref lhs as CVariant, byval rhs as longint ) as integer
declare operator > ( byref lhs as CVariant, byval rhs as ulongint ) as integer
declare operator > ( byref lhs as CVariant, byval rhs as single ) as integer
declare operator > ( byref lhs as CVariant, byval rhs as double ) as integer
declare operator > ( byref lhs as CVariant, byval rhs as zstring ptr ) as integer
declare operator > ( byref lhs as CVariant, byval rhs as wstring ptr ) as integer

'' le
declare operator <= ( byref lhs as CVariant, byref rhs as CVariant ) as integer
declare operator <= ( byref lhs as CVariant, byref rhs as VARIANT ) as integer
declare operator <= ( byref lhs as CVariant, byval rhs as integer ) as integer
declare operator <= ( byref lhs as CVariant, byval rhs as uinteger ) as integer
declare operator <= ( byref lhs as CVariant, byval rhs as longint ) as integer
declare operator <= ( byref lhs as CVariant, byval rhs as ulongint ) as integer
declare operator <= ( byref lhs as CVariant, byval rhs as single ) as integer
declare operator <= ( byref lhs as CVariant, byval rhs as double ) as integer
declare operator <= ( byref lhs as CVariant, byval rhs as zstring ptr ) as integer
declare operator <= ( byref lhs as CVariant, byval rhs as wstring ptr ) as integer

'' ge
declare operator >= ( byref lhs as CVariant, byref rhs as CVariant ) as integer
declare operator >= ( byref lhs as CVariant, byref rhs as VARIANT ) as integer
declare operator >= ( byref lhs as CVariant, byval rhs as integer ) as integer
declare operator >= ( byref lhs as CVariant, byval rhs as uinteger ) as integer
declare operator >= ( byref lhs as CVariant, byval rhs as longint ) as integer
declare operator >= ( byref lhs as CVariant, byval rhs as ulongint ) as integer
declare operator >= ( byref lhs as CVariant, byval rhs as single ) as integer
declare operator >= ( byref lhs as CVariant, byval rhs as double ) as integer
declare operator >= ( byref lhs as CVariant, byval rhs as zstring ptr ) as integer
declare operator >= ( byref lhs as CVariant, byval rhs as wstring ptr ) as integer

#endif