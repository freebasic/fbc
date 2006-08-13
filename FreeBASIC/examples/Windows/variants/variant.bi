#ifndef __VARIANT_BI__
#define __VARIANT_BI__

#include once "windows.bi"
#include once "win/ole2.bi"

#inclib "variant"

enum VARIANT_NOTHING
	NOTHING = -1
end enum

#ifndef VARIANT_NOASSIGNMENT
declare operator let ( byref lhs as VARIANT, byval rhs as VARIANT_NOTHING )
declare operator let ( byref lhs as VARIANT, byref rhs as VARIANT )
declare operator let ( byref lhs as VARIANT, byval rhs as integer )
declare operator let ( byref lhs as VARIANT, byval rhs as uinteger )
declare operator let ( byref lhs as VARIANT, byval rhs as longint )
declare operator let ( byref lhs as VARIANT, byval rhs as ulongint )
declare operator let ( byref lhs as VARIANT, byval rhs as single )
declare operator let ( byref lhs as VARIANT, byval rhs as double )
declare operator let ( byref lhs as VARIANT, byval rhs as zstring ptr )
declare operator let ( byref lhs as VARIANT, byval rhs as wstring ptr )
#endif

'' cast
declare operator cast ( byref lhs as VARIANT ) as integer
declare operator cast ( byref lhs as VARIANT ) as uinteger
declare operator cast ( byref lhs as VARIANT ) as longint
declare operator cast ( byref lhs as VARIANT ) as ulongint
declare operator cast ( byref lhs as VARIANT ) as single
declare operator cast ( byref lhs as VARIANT ) as double
declare operator cast ( byref lhs as VARIANT ) as string
declare operator cast ( byref lhs as VARIANT ) as wstring ptr

'' add
declare operator + ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as double ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as zstring ptr ) as VARIANT
declare operator + ( byref lhs as VARIANT, byval rhs as wstring ptr ) as VARIANT
declare operator += ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator += ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator += ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator += ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator += ( byref lhs as VARIANT, byval rhs as ulongint ) 
declare operator += ( byref lhs as VARIANT, byval rhs as single ) 
declare operator += ( byref lhs as VARIANT, byval rhs as double ) 
declare operator += ( byref lhs as VARIANT, byval rhs as zstring ptr ) 
declare operator += ( byref lhs as VARIANT, byval rhs as wstring ptr ) 

'' sub
declare operator - ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator - ( byref lhs as VARIANT, byval rhs as double ) as VARIANT
declare operator -= ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator -= ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator -= ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator -= ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator -= ( byref lhs as VARIANT, byval rhs as ulongint ) 
declare operator -= ( byref lhs as VARIANT, byval rhs as single ) 
declare operator -= ( byref lhs as VARIANT, byval rhs as double ) 

'' mul
declare operator * ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator * ( byref lhs as VARIANT, byval rhs as double ) as VARIANT
declare operator *= ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator *= ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator *= ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator *= ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator *= ( byref lhs as VARIANT, byval rhs as ulongint ) 
declare operator *= ( byref lhs as VARIANT, byval rhs as single ) 
declare operator *= ( byref lhs as VARIANT, byval rhs as double ) 

'' div
declare operator / ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator / ( byref lhs as VARIANT, byval rhs as double ) as VARIANT
declare operator /= ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator /= ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator /= ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator /= ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator /= ( byref lhs as VARIANT, byval rhs as ulongint ) 
declare operator /= ( byref lhs as VARIANT, byval rhs as single ) 
declare operator /= ( byref lhs as VARIANT, byval rhs as double ) 

'' idiv
declare operator \ ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator \ ( byref lhs as VARIANT, byval rhs as double ) as VARIANT
declare operator \= ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator \= ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator \= ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator \= ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator \= ( byref lhs as VARIANT, byval rhs as ulongint ) 
declare operator \= ( byref lhs as VARIANT, byval rhs as single ) 
declare operator \= ( byref lhs as VARIANT, byval rhs as double ) 

'' mod
declare operator mod ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator mod ( byref lhs as VARIANT, byval rhs as double ) as VARIANT
declare operator mod= ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator mod= ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator mod= ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator mod= ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator mod= ( byref lhs as VARIANT, byval rhs as ulongint ) 
declare operator mod= ( byref lhs as VARIANT, byval rhs as single ) 
declare operator mod= ( byref lhs as VARIANT, byval rhs as double ) 

'' and
declare operator and ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator and ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator and ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator and ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator and ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator and= ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator and= ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator and= ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator and= ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator and= ( byref lhs as VARIANT, byval rhs as ulongint ) 


'' or
declare operator or ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator or ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator or ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator or ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator or ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator or= ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator or= ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator or= ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator or= ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator or= ( byref lhs as VARIANT, byval rhs as ulongint ) 

'' xor
declare operator xor ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator xor ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator xor ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator xor ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator xor ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator xor= ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator xor= ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator xor= ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator xor= ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator xor= ( byref lhs as VARIANT, byval rhs as ulongint ) 

'' imp
declare operator imp ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator imp ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator imp ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator imp ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator imp ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator imp= ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator imp= ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator imp= ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator imp= ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator imp= ( byref lhs as VARIANT, byval rhs as ulongint ) 

'' eqv
declare operator eqv ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator eqv ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator eqv ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator eqv ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator eqv ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator eqv= ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator eqv= ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator eqv= ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator eqv= ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator eqv= ( byref lhs as VARIANT, byval rhs as ulongint ) 

'' pow
declare operator ^ ( byref lhs as VARIANT, byref rhs as VARIANT ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as integer ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as uinteger ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as longint ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as ulongint ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as single ) as VARIANT
declare operator ^ ( byref lhs as VARIANT, byval rhs as double ) as VARIANT
declare operator ^= ( byref lhs as VARIANT, byref rhs as VARIANT ) 
declare operator ^= ( byref lhs as VARIANT, byval rhs as integer ) 
declare operator ^= ( byref lhs as VARIANT, byval rhs as uinteger ) 
declare operator ^= ( byref lhs as VARIANT, byval rhs as longint ) 
declare operator ^= ( byref lhs as VARIANT, byval rhs as ulongint ) 
declare operator ^= ( byref lhs as VARIANT, byval rhs as single ) 
declare operator ^= ( byref lhs as VARIANT, byval rhs as double ) 

'' eq
declare operator = ( byref lhs as VARIANT, byref rhs as VARIANT ) as integer
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
declare operator >= ( byref lhs as VARIANT, byval rhs as integer ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as uinteger ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as longint ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as ulongint ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as single ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as double ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as zstring ptr ) as integer
declare operator >= ( byref lhs as VARIANT, byval rhs as wstring ptr ) as integer

#endif