#pragma once

#ifndef __FB_LINUX__
	#error "Target platform not supported; this is the header for the glibc regex implementation on GNU/Linux."
#endif

#include once "crt/long.bi"
#include once "crt/sys/types.bi"

extern "C"

const _REGEX_H = 1
type active_reg_t as culong
type reg_syntax_t as culong
extern re_syntax_options as reg_syntax_t
const REG_EXTENDED = 1
#define REG_ICASE (REG_EXTENDED shl 1)
#define REG_NEWLINE (REG_ICASE shl 1)
#define REG_NOSUB (REG_NEWLINE shl 1)
const REG_NOTBOL = 1
const REG_NOTEOL = 1 shl 1
const REG_STARTEND = 1 shl 2

type reg_errcode_t as long
enum
	REG_NOERROR = 0
	REG_NOMATCH
	REG_BADPAT
	REG_ECOLLATE
	REG_ECTYPE
	REG_EESCAPE
	REG_ESUBREG
	REG_EBRACK
	REG_EPAREN
	REG_EBRACE
	REG_BADBR
	REG_ERANGE
	REG_ESPACE
	REG_BADRPT
	REG_EEND
	REG_ESIZE
	REG_ERPAREN
end enum

type re_pattern_buffer
	__buffer as ubyte ptr
	__allocated as culong
	__used as culong
	__syntax as reg_syntax_t
	__fastmap as zstring ptr
	__translate as ubyte ptr
	re_nsub as uinteger
	__can_be_null : 1 as ulong
	__regs_allocated : 2 as ulong
	__fastmap_accurate : 1 as ulong
	__no_sub : 1 as ulong
	__not_bol : 1 as ulong
	__not_eol : 1 as ulong
	__newline_anchor : 1 as ulong
end type

type regex_t as re_pattern_buffer
type regoff_t as long

type regmatch_t
	rm_so as regoff_t
	rm_eo as regoff_t
end type

declare function regcomp(byval __preg as regex_t ptr, byval __pattern as const zstring ptr, byval __cflags as long) as long
declare function regexec(byval __preg as const regex_t ptr, byval __string as const zstring ptr, byval __nmatch as uinteger, byval __pmatch as regmatch_t ptr, byval __eflags as long) as long
declare function regerror(byval __errcode as long, byval __preg as const regex_t ptr, byval __errbuf as zstring ptr, byval __errbuf_size as uinteger) as uinteger
declare sub regfree(byval __preg as regex_t ptr)

end extern
