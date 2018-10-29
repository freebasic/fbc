#pragma once

'' gas emitter helper for cva_* macros
''
'' cva_* macros are defined only for gcc backend
'' these macros allow the cva_* tests to succeed on gas 32-bit


#if __FB_BACKEND__ = "gas"

	type cva_list as any ptr

	function cva_arg_gas_helper cdecl( byref ap as any ptr, length as integer ) as any ptr
		function = ap
		ap = cptr(byte ptr, ap) + (length+sizeof(any ptr)-1 and -sizeof(any ptr))
	end function

	#define cva_start(ap,arg)	 ap = cptr(byte ptr, @arg) + (sizeof(arg)+sizeof(any ptr)-1 and -sizeof(any ptr))
	#define cva_arg(ap, dtype)   *cptr( dtype ptr, cva_arg_gas_helper( cptr(any ptr, ap), sizeof(dtype) ) )
	#define cva_end(ap)          /' no-op '/
	#define cva_copy(dst,src)    dst = src

#endif
