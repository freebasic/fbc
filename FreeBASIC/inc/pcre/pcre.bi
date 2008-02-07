''
''
'' pcre -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pcre_bi__
#define __pcre_bi__

#inclib "pcre"

# include "crt/stdlib.bi"

#define PCRE_MAJOR 7
#define PCRE_MINOR 6
#define PCRE_DATE 2008-01-28

#define PCRE_CASELESS &h00000001
#define PCRE_MULTILINE &h00000002
#define PCRE_DOTALL &h00000004
#define PCRE_EXTENDED &h00000008
#define PCRE_ANCHORED &h00000010
#define PCRE_DOLLAR_ENDONLY &h00000020
#define PCRE_EXTRA &h00000040
#define PCRE_NOTBOL &h00000080
#define PCRE_NOTEOL &h00000100
#define PCRE_UNGREEDY &h00000200
#define PCRE_NOTEMPTY &h00000400
#define PCRE_UTF8 &h00000800
#define PCRE_NO_AUTO_CAPTURE &h00001000
#define PCRE_NO_UTF8_CHECK &h00002000
#define PCRE_AUTO_CALLOUT &h00004000
#define PCRE_PARTIAL &h00008000
#define PCRE_DFA_SHORTEST &h00010000
#define PCRE_DFA_RESTART &h00020000
#define PCRE_FIRSTLINE &h00040000
#define PCRE_DUPNAMES &h00080000
#define PCRE_NEWLINE_CR &h00100000
#define PCRE_NEWLINE_LF &h00200000
#define PCRE_NEWLINE_CRLF &h00300000
#define PCRE_NEWLINE_ANY &h00400000
#define PCRE_NEWLINE_ANYCRLF &h00500000
#define PCRE_BSR_ANYCRLF &h00800000
#define PCRE_BSR_UNICODE &h01000000

#define PCRE_ERROR_NOMATCH (-1)
#define PCRE_ERROR_NULL (-2)
#define PCRE_ERROR_BADOPTION (-3)
#define PCRE_ERROR_BADMAGIC (-4)
#define PCRE_ERROR_UNKNOWN_OPCODE (-5)
#define PCRE_ERROR_UNKNOWN_NODE (-5)
#define PCRE_ERROR_NOMEMORY (-6)
#define PCRE_ERROR_NOSUBSTRING (-7)
#define PCRE_ERROR_MATCHLIMIT (-8)
#define PCRE_ERROR_CALLOUT (-9)
#define PCRE_ERROR_BADUTF8 (-10)
#define PCRE_ERROR_BADUTF8_OFFSET (-11)
#define PCRE_ERROR_PARTIAL (-12)
#define PCRE_ERROR_BADPARTIAL (-13)
#define PCRE_ERROR_INTERNAL (-14)
#define PCRE_ERROR_BADCOUNT (-15)
#define PCRE_ERROR_DFA_UITEM (-16)
#define PCRE_ERROR_DFA_UCOND (-17)
#define PCRE_ERROR_DFA_UMLIMIT (-18)
#define PCRE_ERROR_DFA_WSSIZE (-19)
#define PCRE_ERROR_DFA_RECURSE (-20)
#define PCRE_ERROR_RECURSIONLIMIT (-21)
#define PCRE_ERROR_NULLWSLIMIT (-22)
#define PCRE_ERROR_BADNEWLINE (-23)

#define PCRE_INFO_OPTIONS 0
#define PCRE_INFO_SIZE 1
#define PCRE_INFO_CAPTURECOUNT 2
#define PCRE_INFO_BACKREFMAX 3
#define PCRE_INFO_FIRSTBYTE 4
#define PCRE_INFO_FIRSTCHAR 4
#define PCRE_INFO_FIRSTTABLE 5
#define PCRE_INFO_LASTLITERAL 6
#define PCRE_INFO_NAMEENTRYSIZE 7
#define PCRE_INFO_NAMECOUNT 8
#define PCRE_INFO_NAMETABLE 9
#define PCRE_INFO_STUDYSIZE 10
#define PCRE_INFO_DEFAULT_TABLES 11
#define PCRE_INFO_OKPARTIAL 12
#define PCRE_INFO_JCHANGED 13
#define PCRE_INFO_HASCRORLF 14

#define PCRE_CONFIG_UTF8 0
#define PCRE_CONFIG_NEWLINE 1
#define PCRE_CONFIG_LINK_SIZE 2
#define PCRE_CONFIG_POSIX_MALLOC_THRESHOLD 3
#define PCRE_CONFIG_MATCH_LIMIT 4
#define PCRE_CONFIG_STACKRECURSE 5
#define PCRE_CONFIG_UNICODE_PROPERTIES 6
#define PCRE_CONFIG_MATCH_LIMIT_RECURSION 7
#define PCRE_CONFIG_BSR 8

#define PCRE_EXTRA_STUDY_DATA &h0001
#define PCRE_EXTRA_MATCH_LIMIT &h0002
#define PCRE_EXTRA_CALLOUT_DATA &h0004
#define PCRE_EXTRA_TABLES &h0008
#define PCRE_EXTRA_MATCH_LIMIT_RECURSION &h0010

#ifndef PCRE_SPTR
#define PCRE_SPTR zstring ptr
#endif

type pcre as real_pcre

type pcre_extra_
	flags as uinteger
	study_data as any ptr
	match_limit as uinteger
	callout_data as any ptr
	tables as ubyte ptr
	match_limit_recursion as uinteger
end type

type pcre_callout_block
	version as integer
	callout_number as integer
	offset_vector as integer ptr
	subject as PCRE_SPTR
	subject_length as integer
	start_match as integer
	current_position as integer
	capture_top as integer
	capture_last as integer
	callout_data as any ptr
	pattern_position as integer
	next_item_length as integer
end type

extern "c"

extern pcre_malloc as function (byval as size_t) as any ptr
extern pcre_free as sub (byval as any ptr)
extern pcre_stack_malloc as function (byval as size_t) as any ptr
extern pcre_stack_free as sub (byval as any ptr)
extern pcre_callout as function (byval as pcre_callout_block ptr) as integer

declare function pcre_compile (byval as zstring ptr, byval as integer, byval as byte ptr ptr, byval as integer ptr, byval as ubyte ptr) as pcre ptr
declare function pcre_compile2 (byval as zstring ptr, byval as integer, byval as integer ptr, byval as byte ptr ptr, byval as integer ptr, byval as ubyte ptr) as pcre ptr
declare function pcre_config (byval as integer, byval as any ptr) as integer
declare function pcre_copy_named_substring (byval as pcre ptr, byval as zstring ptr, byval as integer ptr, byval as integer, byval as zstring ptr, byval as zstring ptr, byval as integer) as integer
declare function pcre_copy_substring (byval as zstring ptr, byval as integer ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function pcre_dfa_exec (byval as pcre ptr, byval as pcre_extra_ ptr, byval as zstring ptr, byval as integer, byval as integer, byval as integer, byval as integer ptr, byval as integer, byval as integer ptr, byval as integer) as integer
declare function pcre_exec (byval as pcre ptr, byval as pcre_extra_ ptr, byval as zstring ptr, byval as integer, byval as integer, byval as integer, byval as integer ptr, byval as integer) as integer
declare sub pcre_free_substring (byval as zstring ptr)
declare sub pcre_free_substring_list (byval as byte ptr ptr)
declare function pcre_fullinfo (byval as pcre ptr, byval as pcre_extra_ ptr, byval as integer, byval as any ptr) as integer
declare function pcre_get_named_substring (byval as pcre ptr, byval as zstring ptr, byval as integer ptr, byval as integer, byval as zstring ptr, byval as byte ptr ptr) as integer
declare function pcre_get_stringnumber (byval as pcre ptr, byval as zstring ptr) as integer
declare function pcre_get_stringtable_entries (byval as pcre ptr, byval as zstring ptr, byval as byte ptr ptr, byval as byte ptr ptr) as integer
declare function pcre_get_substring (byval as zstring ptr, byval as integer ptr, byval as integer, byval as integer, byval as byte ptr ptr) as integer
declare function pcre_get_substring_list (byval as zstring ptr, byval as integer ptr, byval as integer, byval as byte ptr ptr ptr) as integer
declare function pcre_info (byval as pcre ptr, byval as integer ptr, byval as integer ptr) as integer
declare function pcre_maketables () as ubyte ptr
declare function pcre_refcount (byval as pcre ptr, byval as integer) as integer
declare function pcre_study (byval as pcre ptr, byval as integer, byval as byte ptr ptr) as pcre_extra_ ptr
declare function pcre_version () as zstring ptr

end extern

#endif
