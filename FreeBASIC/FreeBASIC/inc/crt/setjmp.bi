''
''
'' setjmp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_setjmp_bi__
#define __crt_setjmp_bi__

#ifdef __FB_WIN32__
#define _JBLEN 16
type jmp_buf
	as integer __opaque(0 to _JBLEN-1)
end type

#elseif defined(__FB_DOS__)
type jmp_buf
  as uinteger __eax, __ebx, __ecx, __edx, __esi
  as uinteger __edi, __ebp, __esp, __eip, __eflags
  as ushort __cs, __ds, __es, __fs, __gs, __ss
  as uinteger __sigmask
  as uinteger __signum
  as uinteger __exception_ptr
  as ubyte __fpu_state(0 to 108-1)
end type

#else
type __jmp_buf
	as integer __opaque(0 to 6-1)
end type

#ifndef __sigset_t
const _SIGSET_NWORDS =1024 \ (8 * len(uinteger))
type __sigset_t
    as uinteger __val(0 to _SIGSET_NWORDS-1)
end type
#endif

type jmp_buf
    as __jmp_buf __jmpbuf
    as integer __mask_was_saved
    as __sigset_t __saved_mask
end type
#endif

#ifdef __FB_WIN32__
declare function setjmp cdecl alias "_setjmp" (byval as jmp_buf ptr) as integer
#else
declare function setjmp cdecl alias "setjmp" (byval as jmp_buf ptr) as integer
#endif

declare sub longjmp cdecl alias "longjmp" (byval as jmp_buf ptr, byval as integer)

#endif
