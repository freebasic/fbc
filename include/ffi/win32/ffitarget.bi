''
''
'' ffitarget -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ffitarget_bi__
#define __ffitarget_bi__

' ---- System specific configurations ----------------------------------- 

' For code common to all platforms on x86 and x86_64. 
#define X86_ANY

#ifdef __FB_WIN64__
#define FFI_SIZEOF_ARG 8
#define USE_BUILTIN_FFS 0
#endif

type ffi_arg as uinteger
type ffi_sarg as integer

enum ffi_abi
	FFI_FIRST_ABI = 0
	FFI_SYSV
	FFI_STDCALL
	FFI_LAST_ABI
	FFI_DEFAULT_ABI = FFI_SYSV
end enum

#define FFI_CLOSURES 1
#define FFI_TYPE_SMALL_STRUCT_1B (FFI_TYPE_LAST+1)
#define FFI_TYPE_SMALL_STRUCT_2B (FFI_TYPE_LAST+2)
#define FFI_TYPE_SMALL_STRUCT_4B (FFI_TYPE_LAST+3)
#define FFI_TRAMPOLINE_SIZE 13
#define FFI_NATIVE_RAW_API 1

#endif
