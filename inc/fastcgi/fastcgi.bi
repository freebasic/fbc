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
#define FCGI_MAXTYPE FCGI_UNKNOWN_TYPE
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
