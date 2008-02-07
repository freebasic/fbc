''
''
'' pcreposix -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pcreposix_bi__
#define __pcreposix_bi__

#inclib "pcreposix"

#define REG_ICASE &h0001
#define REG_NEWLINE &h0002
#define REG_NOTBOL &h0004
#define REG_NOTEOL &h0008
#define REG_DOTALL &h0010
#define REG_NOSUB &h0020
#define REG_UTF8 &h0040
#define REG_EXTENDED 0

enum 
	REG_ASSERT = 1
	REG_BADBR
	REG_BADPAT
	REG_BADRPT
	REG_EBRACE
	REG_EBRACK
	REG_ECOLLATE
	REG_ECTYPE
	REG_EESCAPE
	REG_EMPTY
	REG_EPAREN
	REG_ERANGE
	REG_ESIZE
	REG_ESPACE
	REG_ESUBREG
	REG_INVARG
	REG_NOMATCH
end enum

type regex_t
	re_pcre as any ptr
	re_nsub as size_t
	re_erroffset as size_t
end type

type regoff_t as integer

type regmatch_t
	rm_so as regoff_t
	rm_eo as regoff_t
end type

declare function regcomp cdecl alias "regcomp" (byval as regex_t ptr, byval as zstring ptr, byval as integer) as integer
declare function regexec cdecl alias "regexec" (byval as regex_t ptr, byval as zstring ptr, byval as size_t, byval as regmatch_t ptr, byval as integer) as integer
declare function regerror cdecl alias "regerror" (byval as integer, byval as regex_t ptr, byval as zstring ptr, byval as size_t) as size_t
declare sub regfree cdecl alias "regfree" (byval as regex_t ptr)

#endif
