''
''
'' cst_tokenstream -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_tokenstream_bi__
#define __cst_tokenstream_bi__

type cst_tokenstream_struct
	fd as cst_file
	file_pos as integer
	line_number as integer
	string_buffer as cst_string ptr
	current_char as integer
	token_pos as integer
	ws_max as integer
	whitespace as cst_string ptr
	prep_max as integer
	prepunctuation as cst_string ptr
	token_max as integer
	token as cst_string ptr
	postp_max as integer
	postpunctuation as cst_string ptr
	p_whitespacesymbols as cst_string ptr
	p_singlecharsymbols as cst_string ptr
	p_prepunctuationsymbols as cst_string ptr
	p_postpunctuationsymbols as cst_string ptr
	charclass(0 to 256-1) as cst_string
end type

type cst_tokenstream as cst_tokenstream_struct

#define TS_CHARCLASS_NONE 0
#define TS_CHARCLASS_WHITESPACE 2
#define TS_CHARCLASS_SINGLECHAR 4
#define TS_CHARCLASS_PREPUNCT 8
#define TS_CHARCLASS_POSTPUNCT 16
#define TS_CHARCLASS_QUOTE 32
extern cst_ts_default_whitespacesymbols alias "cst_ts_default_whitespacesymbols" as cst_string ptr
extern cst_ts_default_prepunctuationsymbols alias "cst_ts_default_prepunctuationsymbols" as cst_string ptr
extern cst_ts_default_postpunctuationsymbols alias "cst_ts_default_postpunctuationsymbols" as cst_string ptr
extern cst_ts_default_singlecharsymbols alias "cst_ts_default_singlecharsymbols" as cst_string ptr

declare function ts_open cdecl alias "ts_open" (byval filename as zstring ptr, byval whitespacesymbols as cst_string ptr, byval singlecharsymbols as cst_string ptr, byval prepunctsymbols as cst_string ptr, byval postpunctsymbols as cst_string ptr) as cst_tokenstream ptr
declare function ts_open_string cdecl alias "ts_open_string" (byval string as cst_string ptr, byval whitespacesymbols as cst_string ptr, byval singlecharsymbols as cst_string ptr, byval prepunctsymbols as cst_string ptr, byval postpunctsymbols as cst_string ptr) as cst_tokenstream ptr
declare sub ts_close cdecl alias "ts_close" (byval ts as cst_tokenstream ptr)
declare function ts_eof cdecl alias "ts_eof" (byval ts as cst_tokenstream ptr) as integer
declare function ts_get cdecl alias "ts_get" (byval ts as cst_tokenstream ptr) as cst_string ptr
declare function ts_get_quoted_token cdecl alias "ts_get_quoted_token" (byval ts as cst_tokenstream ptr, byval quote as byte, byval escape as byte) as cst_string ptr
declare sub set_charclasses cdecl alias "set_charclasses" (byval ts as cst_tokenstream ptr, byval whitespace as cst_string ptr, byval singlecharsymbols as cst_string ptr, byval prepunctuation as cst_string ptr, byval postpunctuation as cst_string ptr)
declare function ts_read cdecl alias "ts_read" (byval buff as any ptr, byval size as integer, byval num as integer, byval ts as cst_tokenstream ptr) as integer
declare function ts_set_stream_pos cdecl alias "ts_set_stream_pos" (byval ts as cst_tokenstream ptr, byval pos as integer) as integer
declare function ts_get_stream_pos cdecl alias "ts_get_stream_pos" (byval ts as cst_tokenstream ptr) as integer

#endif
