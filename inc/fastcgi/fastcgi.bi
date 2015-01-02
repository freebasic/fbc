#pragma once

#define _FASTCGI_H
#define FCGI_LISTENSOCK_FILENO 0

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

#define FCGI_MAX_LENGTH &hffff
#define FCGI_HEADER_LEN 8
#define FCGI_VERSION_1 1
#define FCGI_BEGIN_REQUEST 1
#define FCGI_ABORT_REQUEST 2
#define FCGI_END_REQUEST 3
#define FCGI_PARAMS 4
#define FCGI_STDIN 5
#define FCGI_STDOUT 6
#define FCGI_STDERR 7
#define FCGI_DATA 8
#define FCGI_GET_VALUES 9
#define FCGI_GET_VALUES_RESULT 10
#define FCGI_UNKNOWN_TYPE 11
#define FCGI_MAXTYPE FCGI_UNKNOWN_TYPE
#define FCGI_NULL_REQUEST_ID 0

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

#define FCGI_KEEP_CONN 1
#define FCGI_RESPONDER 1
#define FCGI_AUTHORIZER 2
#define FCGI_FILTER 3

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

#define FCGI_REQUEST_COMPLETE 0
#define FCGI_CANT_MPX_CONN 1
#define FCGI_OVERLOADED 2
#define FCGI_UNKNOWN_ROLE 3
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
