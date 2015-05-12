''
''
'' jit-defs -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_defs_bi__
#define __jit_defs_bi__

type jit_sbyte as byte
type jit_ubyte as ubyte
type jit_short as short
type jit_ushort as ushort
type jit_int as integer
type jit_uint as uinteger
type jit_nint as integer
type jit_nuint as uinteger
type jit_long as longint
type jit_ulong as ulongint
type jit_float32 as single
type jit_float64 as double
type jit_nfloat as double
type jit_ptr as any ptr

#define JIT_NATIVE_INT32 1
#define JIT_NFLOAT_IS_DOUBLE 1
#define	JIT_NOTHROW

#define	jit_min_int		((Cast(jit_int, 1)) Shl (sizeof(jit_int) * 8 - 1))
#define	jit_max_int		(Cast(jit_int, (Not jit_min_int)))
#define	jit_max_uint	(Cast(jit_uint, (Not Cast(jit_uint, 0))))
#define	jit_min_long	((Cast(jit_long, 1)) << (sizeof(jit_long) * 8 - 1))
#define	jit_max_long	(Cast(jit_long, (Not jit_min_long)))
#define	jit_max_ulong	(Cast(jit_ulong, (Not (Cast(jit_ulong, 0)))))

#endif
