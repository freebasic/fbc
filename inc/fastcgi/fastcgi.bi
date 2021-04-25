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

#define _FASTCGI_H
const FCGI_LISTENSOCK_FILENO = 0

type FCGI_Header
	version as ubyte
	as ubyte type
	requestIdB1 as ubyte
	requestIdB0 as ubyte
	contentLengthB1 as ubyte
	contentLengthB0 as ubyte
	paddingLength as ubyte
	reserved as ubyte
end type

const FCGI_MAX_LENGTH = &hffff
const FCGI_HEADER_LEN = 8
const FCGI_VERSION_1 = 1
const FCGI_BEGIN_REQUEST = 1
const FCGI_ABORT_REQUEST = 2
const FCGI_END_REQUEST = 3
const FCGI_PARAMS = 4
const FCGI_STDIN = 5
const FCGI_STDOUT = 6
const FCGI_STDERR = 7
const FCGI_DATA = 8
const FCGI_GET_VALUES = 9
const FCGI_GET_VALUES_RESULT = 10
const FCGI_UNKNOWN_TYPE = 11
const FCGI_MAXTYPE = FCGI_UNKNOWN_TYPE
const FCGI_NULL_REQUEST_ID = 0

type FCGI_BeginRequestBody
	roleB1 as ubyte
	roleB0 as ubyte
	flags as ubyte
	reserved(0 to 4) as ubyte
end type

type FCGI_BeginRequestRecord
	header as FCGI_Header
	body as FCGI_BeginRequestBody
end type

const FCGI_KEEP_CONN = 1
const FCGI_RESPONDER = 1
const FCGI_AUTHORIZER = 2
const FCGI_FILTER = 3

type FCGI_EndRequestBody
	appStatusB3 as ubyte
	appStatusB2 as ubyte
	appStatusB1 as ubyte
	appStatusB0 as ubyte
	protocolStatus as ubyte
	reserved(0 to 2) as ubyte
end type

type FCGI_EndRequestRecord
	header as FCGI_Header
	body as FCGI_EndRequestBody
end type

const FCGI_REQUEST_COMPLETE = 0
const FCGI_CANT_MPX_CONN = 1
const FCGI_OVERLOADED = 2
const FCGI_UNKNOWN_ROLE = 3
#define FCGI_MAX_CONNS "FCGI_MAX_CONNS"
#define FCGI_MAX_REQS "FCGI_MAX_REQS"
#define FCGI_MPXS_CONNS "FCGI_MPXS_CONNS"

type FCGI_UnknownTypeBody
	as ubyte type
	reserved(0 to 6) as ubyte
end type

type FCGI_UnknownTypeRecord
	header as FCGI_Header
	body as FCGI_UnknownTypeBody
end type
