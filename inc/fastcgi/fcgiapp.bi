'' FreeBASIC binding for fcgi-2.4.1-SNAP-0910052249
''
'' based on the C header files:
''   Copyright (c) 1995-1996 Open Market, Inc.
''
''   This FastCGI application library source and object code (the
''   "Software") and its documentation (the "Documentation") are
''   copyrighted by Open Market, Inc ("Open Market").  The following terms
''   apply to all files associated with the Software and Documentation
''   unless explicitly disclaimed in individual files.
''
''   Open Market permits you to use, copy, modify, distribute, and license
''   this Software and the Documentation for any purpose, provided that
''   existing copyright notices are retained in all copies and that this
''   notice is included verbatim in any distributions.  No written
''   agreement, license, or royalty fee is required for any of the
''   authorized uses.  Modifications to this Software and Documentation may
''   be copyrighted by their authors and need not follow the licensing
''   terms described here.  If modifications to this Software and
''   Documentation have new licensing terms, the new terms must be clearly
''   indicated on the first page of each file where they apply.
''
''   OPEN MARKET MAKES NO EXPRESS OR IMPLIED WARRANTY WITH RESPECT TO THE
''   SOFTWARE OR THE DOCUMENTATION, INCLUDING WITHOUT LIMITATION ANY
''   WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  IN
''   NO EVENT SHALL OPEN MARKET BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY
''   DAMAGES ARISING FROM OR RELATING TO THIS SOFTWARE OR THE
''   DOCUMENTATION, INCLUDING, WITHOUT LIMITATION, ANY INDIRECT, SPECIAL OR
''   CONSEQUENTIAL DAMAGES OR SIMILAR DAMAGES, INCLUDING LOST PROFITS OR
''   LOST DATA, EVEN IF OPEN MARKET HAS BEEN ADVISED OF THE POSSIBILITY OF
''   SUCH DAMAGES.  THE SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS".
''   OPEN MARKET HAS NO LIABILITY IN CONTRACT, TORT, NEGLIGENCE OR
''   OTHERWISE ARISING OUT OF THIS SOFTWARE OR THE DOCUMENTATION.
''
'' translated to FreeBASIC by:
''   Copyright © 2021 FreeBASIC development team

#pragma once

#inclib "fcgi"

#include once "crt/stdarg.bi"

extern "C"

#define _FCGIAPP_H
const FCGX_UNSUPPORTED_VERSION = -2
const FCGX_PROTOCOL_ERROR = -3
const FCGX_PARAMS_ERROR = -4
const FCGX_CALL_SEQ_ERROR = -5

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
const FCGI_FAIL_ACCEPT_ON_INTR = 1
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
