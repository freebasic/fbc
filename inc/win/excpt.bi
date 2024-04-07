'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   FreeBASIC development team

#pragma once

#include once "crtdefs.bi"

extern "C"

#define _INC_EXCPT
'' TODO: #pragma pack(push,_CRT_PACKING)
type EXCEPTION_DISPOSITION as long
const ExceptionContinueExecution = 0
const ExceptionContinueSearch = 1
const ExceptionNestedException = 2
const ExceptionCollidedUnwind = 3
const ExceptionExecuteHandler = 4

#ifndef __FB_64BIT__
	type _EXCEPTION_RECORD as _EXCEPTION_RECORD_
	type _CONTEXT as _CONTEXT_
	declare function _except_handler(byval _ExceptionRecord as _EXCEPTION_RECORD ptr, byval _EstablisherFrame as any ptr, byval _ContextRecord as _CONTEXT ptr, byval _DispatcherContext as any ptr) as long
#endif

#define GetExceptionInformation cptr(_EXCEPTION_POINTERS ptr, _exception_info)
#define exception_info cptr(_EXCEPTION_POINTERS ptr, _exception_info)
declare function _exception_code() as ulong
declare function GetExceptionCode alias "_exception_code"() as ulong
declare function exception_code alias "_exception_code"() as ulong
declare function _exception_info() as any ptr
declare function _abnormal_termination() as long
declare function AbnormalTermination alias "_abnormal_termination"() as long
declare function abnormal_termination alias "_abnormal_termination"() as long

const EXCEPTION_EXECUTE_HANDLER = 1
const EXCEPTION_CONTINUE_SEARCH = 0
const EXCEPTION_CONTINUE_EXECUTION = -1
type _PHNDLR as sub(byval as long)

type _XCPT_ACTION
	XcptNum as ulong
	SigNum as long
	XcptAction as _PHNDLR
end type

extern _XcptActTab as _XCPT_ACTION ptr
extern _XcptActTabCount as long
extern _XcptActTabSize as long
extern _First_FPE_Indx as long
extern _Num_FPE as long
type _EXCEPTION_POINTERS as _EXCEPTION_POINTERS_
declare function __CppXcptFilter(byval _ExceptionNum as ulong, byval _ExceptionPtr as _EXCEPTION_POINTERS ptr) as long
declare function _XcptFilter(byval _ExceptionNum as ulong, byval _ExceptionPtr as _EXCEPTION_POINTERS ptr) as long

#ifdef __FB_64BIT__
	type _EXCEPTION_RECORD as _EXCEPTION_RECORD_
	type _CONTEXT as _CONTEXT_
#endif

type PEXCEPTION_HANDLER as function(byval as _EXCEPTION_RECORD ptr, byval as any ptr, byval as _CONTEXT ptr, byval as any ptr) as long

#ifdef __FB_64BIT__
	'' TODO: #define __try1(pHandler) __asm__ __volatile__ ("\t.l_startw:\n" "\t.seh_handler __C_specific_handler, @except\n" "\t.seh_handlerdata\n" "\t.long 1\n" "\t.rva .l_startw, .l_endw, " __MINGW64_STRINGIFY(__MINGW_USYMBOL(pHandler)) " ,.l_endw\n" "\t.text" );
	'' TODO: #define __except1 asm ("\tnop\n" "\t.l_endw: nop\n");
#else
	'' TODO: #define __try1(pHandler) __asm__ __volatile__ ("pushl %0;pushl %%fs:0;movl %%esp,%%fs:0;" : : "g" (pHandler));
	'' TODO: #define __except1 __asm__ __volatile__ ("movl (%%esp),%%eax;movl %%eax,%%fs:0;addl $8,%%esp;" : : : "%eax");
#endif

end extern
