#pragma once
#inclib "fcgi"

#include once "crt/stdarg.bi"

extern "C"

#define _FCGIAPP_H
#define FCGX_UNSUPPORTED_VERSION (-2)
#define FCGX_PROTOCOL_ERROR (-3)
#define FCGX_PARAMS_ERROR (-4)
#define FCGX_CALL_SEQ_ERROR (-5)

type FCGX_Stream
	rdNext as ubyte ptr
	wrNext as ubyte ptr
	stop as ubyte ptr
	stopUnget as ubyte ptr
	isReader as long
	isClosed as long
	wasFCloseCalled as long
	FCGI_errno as long
	fillBuffProc as sub(byval stream as FCGX_Stream ptr)
	emptyBuffProc as sub(byval stream as FCGX_Stream ptr, byval doClose as long)
	data as any ptr
end type

type FCGX_ParamArray as zstring ptr ptr

#define FCGI_FAIL_ACCEPT_ON_INTR 1

type Params as Params_

type FCGX_Request
	requestId as long
	role as long
	in as FCGX_Stream ptr
	out as FCGX_Stream ptr
	err as FCGX_Stream ptr
	envp as zstring ptr ptr
	paramsPtr as Params ptr
	ipcFd as long
	isBeginProcessed as long
	keepConnection as long
	appStatus as long
	nWriters as long
	flags as long
	listen_sock as long
	detached as long
end type

declare function FCGX_IsCGI() as long
declare function FCGX_Init() as long
declare function FCGX_OpenSocket(byval path as const zstring ptr, byval backlog as long) as long
declare function FCGX_InitRequest(byval request as FCGX_Request ptr, byval sock as long, byval flags as long) as long
declare function FCGX_Accept_r(byval request as FCGX_Request ptr) as long
declare sub FCGX_Finish_r(byval request as FCGX_Request ptr)
declare sub FCGX_Free(byval request as FCGX_Request ptr, byval close as long)
declare function FCGX_Accept(byval in as FCGX_Stream ptr ptr, byval out as FCGX_Stream ptr ptr, byval err as FCGX_Stream ptr ptr, byval envp as FCGX_ParamArray ptr) as long
declare sub FCGX_Finish()
declare function FCGX_StartFilterData(byval stream as FCGX_Stream ptr) as long
declare sub FCGX_SetExitStatus(byval status as long, byval stream as FCGX_Stream ptr)
declare function FCGX_GetParam(byval name as const zstring ptr, byval envp as FCGX_ParamArray) as zstring ptr
declare function FCGX_GetChar(byval stream as FCGX_Stream ptr) as long
declare function FCGX_UnGetChar(byval c as long, byval stream as FCGX_Stream ptr) as long
declare function FCGX_GetStr(byval str as zstring ptr, byval n as long, byval stream as FCGX_Stream ptr) as long
declare function FCGX_GetLine(byval str as zstring ptr, byval n as long, byval stream as FCGX_Stream ptr) as zstring ptr
declare function FCGX_HasSeenEOF(byval stream as FCGX_Stream ptr) as long
declare function FCGX_PutChar(byval c as long, byval stream as FCGX_Stream ptr) as long
declare function FCGX_PutStr(byval str as const zstring ptr, byval n as long, byval stream as FCGX_Stream ptr) as long
declare function FCGX_PutS(byval str as const zstring ptr, byval stream as FCGX_Stream ptr) as long
declare function FCGX_FPrintF(byval stream as FCGX_Stream ptr, byval format as const zstring ptr, ...) as long
declare function FCGX_VFPrintF(byval stream as FCGX_Stream ptr, byval format as const zstring ptr, byval arg as va_list) as long
declare function FCGX_FFlush(byval stream as FCGX_Stream ptr) as long
declare function FCGX_FClose(byval stream as FCGX_Stream ptr) as long
declare function FCGX_GetError(byval stream as FCGX_Stream ptr) as long
declare sub FCGX_ClearError(byval stream as FCGX_Stream ptr)
declare function FCGX_CreateWriter(byval socket as long, byval requestId as long, byval bufflen as long, byval streamType as long) as FCGX_Stream ptr
declare sub FCGX_FreeStream(byval stream as FCGX_Stream ptr ptr)
declare sub FCGX_ShutdownPending()
declare function FCGX_Attach(byval r as FCGX_Request ptr) as long
declare function FCGX_Detach(byval r as FCGX_Request ptr) as long

end extern
