' TEST_MODE : MULTI_MODULE_TEST

extern "c++"

namespace cpp_mangle
	
	declare function cpp_byval_bool( byval a as boolean ) as boolean
	declare function cpp_byref_bool( byref a as boolean ) as boolean

	declare function cpp_byval_float( byval a as single ) as single
	declare function cpp_byref_float( byref a as single ) as single

	declare function cpp_byval_double( byval a as double ) as double
	declare function cpp_byref_double( byref a as double ) as double
	
	declare function cpp_byval_u8( byval a as unsigned byte ) as unsigned byte
	declare function cpp_byval_s8( byval a as byte ) as byte
	declare function cpp_byref_u8( byref a as unsigned byte ) as unsigned byte
	declare function cpp_byref_s8( byref a as byte ) as byte

   	declare function cpp_byval_u16( byval a as unsigned short ) as unsigned short
	declare function cpp_byval_s16( byval a as short ) as short
	declare function cpp_byref_u16( byref a as unsigned short ) as unsigned short
	declare function cpp_byref_s16( byref a as short ) as short

   	declare function cpp_byval_u32( byval a as unsigned long ) as unsigned long
	declare function cpp_byval_s32( byval a as long ) as long
	declare function cpp_byref_u32( byref a as unsigned long ) as unsigned long
	declare function cpp_byref_s32( byref a as long ) as long

   	declare function cpp_byval_u64( byval a as unsigned longint ) as unsigned longint
	declare function cpp_byval_s64( byval a as longint ) as longint
	declare function cpp_byref_u64( byref a as unsigned longint ) as unsigned longint 
	declare function cpp_byref_s64( byref a as longint ) as longint

end namespace

end extern

using cpp_mangle

'' boolean
dim b as boolean
ASSERT( cpp_byval_bool(false) = 0 )
ASSERT( cpp_byval_bool(true) = true )
b = false: ASSERT( cpp_byref_bool(b) = false )
b = true : ASSERT( cpp_byref_bool(b) = true )

'' single
dim s as single
ASSERT( cpp_byval_float(s) = 0 )
ASSERT( cpp_byval_float(s) = 0 )
s = 0: ASSERT( cpp_byref_float(s) = 0 )
s = 10 : ASSERT( cpp_byref_float(s) = 10 )

'' double
dim d as double
ASSERT( cpp_byval_double(d) = 0 )
ASSERT( cpp_byval_double(d) = 0 )
d = 0: ASSERT( cpp_byref_double(d) = 0 )
d = 10 : ASSERT( cpp_byref_double(d) = 10 )
			 
'' signed|unsigned byte
ASSERT( cpp_byval_u8(0) = 0 )
ASSERT( cpp_byval_s8(0) = 0 )
ASSERT( cpp_byval_u8(&h7f) = &h7f )
ASSERT( cpp_byval_s8(&h7f) = &h7f )
dim ub as unsigned byte = 0
dim sb as byte = 0
ASSERT( cpp_byval_u8(ub) = 0 )
ASSERT( cpp_byval_s8(sb) = 0 )
ub = &h7f
sb = &h7f
ASSERT( cpp_byval_u8(ub) = &h7f )
ASSERT( cpp_byval_s8(sb) = &h7f )

'' signed|unsigned short
ASSERT( cpp_byval_u16(0) = 0 )
ASSERT( cpp_byval_s16(0) = 0 )
ASSERT( cpp_byval_u16(&h7fff) = &h7fff )
ASSERT( cpp_byval_s16(&h7fff) = &h7fff )
dim us as unsigned short = 0
dim ss as short = 0
ASSERT( cpp_byval_u16(us) = 0 )
ASSERT( cpp_byval_s16(ss) = 0 )
us = &h7fff
ss = &h7fff
ASSERT( cpp_byval_u16(us) = &h7fff )
ASSERT( cpp_byval_s16(ss) = &h7fff )

'' signed|unsigned long
ASSERT( cpp_byval_u32(0) = 0 )
ASSERT( cpp_byval_s32(0) = 0 )
ASSERT( cpp_byval_u32(&h7fffffff) = &h7fffffff )
ASSERT( cpp_byval_s32(&h7fffffff) = &h7fffffff )
dim ul as unsigned long = 0
dim sl as long = 0
ASSERT( cpp_byval_u32(ul) = 0 )
ASSERT( cpp_byval_s32(sl) = 0 )
ul = &h7fffffff
sl = &h7fffffff
ASSERT( cpp_byval_u32(ul) = &h7fffffff )
ASSERT( cpp_byval_s32(sl) = &h7fffffff )

'' signed|unsigned longint
ASSERT( cpp_byval_u64(0) = 0 )
ASSERT( cpp_byval_s64(0) = 0 )
ASSERT( cpp_byval_u64(&h7fffffffffffffff) = &h7fffffffffffffff )
ASSERT( cpp_byval_s64(&h7fffffffffffffff) = &h7fffffffffffffff )
dim ull as unsigned longint = 0
dim sll as longint = 0
ASSERT( cpp_byval_u64(ull) = 0 )
ASSERT( cpp_byval_s64(sll) = 0 )
ull = &h7fffffffffffffff
sll = &h7fffffffffffffff
ASSERT( cpp_byval_u64(ull) = &h7fffffffffffffff )
ASSERT( cpp_byval_s64(sll) = &h7fffffffffffffff )
