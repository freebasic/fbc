''
''
'' regex -- POSIX.2 compatible regexp interface and TRE extensions
''			(header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __regex_bi__
#define __regex_bi__

#inclib "tre"

type regoff_t as integer

type regex_t
	re_nsub as integer
	value as any ptr
end type

type regmatch_t
	rm_so as regoff_t
	rm_eo as regoff_t
end type

enum reg_errcode_t
	REG_OK = 0
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
end enum

#define REG_EXTENDED	1
#define REG_ICASE	(REG_EXTENDED shl 1)
#define REG_NEWLINE	(REG_ICASE shl 1)
#define REG_NOSUB	(REG_NEWLINE shl 1)
#define REG_BASIC	0
#define REG_LITERAL	(REG_NOSUB shl 1)
#define REG_RIGHT_ASSOC (REG_LITERAL shl 1)
#define REG_NOTBOL 1
#define REG_NOTEOL (REG_NOTBOL shl 1)
#define REG_APPROX_MATCHER	 (REG_NOTEOL shl 1)
#define REG_BACKTRACKING_MATCHER (REG_APPROX_MATCHER shl 1)
#ifdef REG_LITERAL
# define REG_NOSPEC	REG_LITERAL
#elseif defined(REG_NOSPEC)
# define REG_LITERAL	REG_NOSPEC
#endif
#define RE_DUP_MAX 255

declare function regcomp cdecl alias "regcomp" (byval preg as regex_t ptr, byval regex as zstring ptr, byval cflags as integer) as integer
declare function regexec cdecl alias "regexec" (byval preg as regex_t ptr, byval string as zstring ptr, byval nmatch as integer, byval pmatch as regmatch_t ptr, byval eflags as integer) as integer
declare function regerror cdecl alias "regerror" (byval errcode as integer, byval preg as regex_t ptr, byval errbuf as zstring ptr, byval errbuf_size as integer) as integer
declare sub regfree cdecl alias "regfree" (byval preg as regex_t ptr)
declare function regncomp cdecl alias "regncomp" (byval preg as regex_t ptr, byval regex as zstring ptr, byval len as integer, byval cflags as integer) as integer
declare function regnexec cdecl alias "regnexec" (byval preg as regex_t ptr, byval string as zstring ptr, byval len as integer, byval nmatch as integer, byval pmatch as regmatch_t ptr, byval eflags as integer) as integer

type regaparams_t
	cost_ins as integer
	cost_del as integer
	cost_subst as integer
	max_cost as integer
	max_ins as integer
	max_del as integer
	max_subst as integer
	max_err as integer
end type

type regamatch_t
	nmatch as integer
	pmatch as regmatch_t ptr
	cost as integer
	num_ins as integer
	num_del as integer
	num_subst as integer
end type

declare function regaexec cdecl alias "regaexec" (byval preg as regex_t ptr, byval string as zstring ptr, byval match as regamatch_t ptr, byval params as regaparams_t, byval eflags as integer) as integer
declare function reganexec cdecl alias "reganexec" (byval preg as regex_t ptr, byval string as zstring ptr, byval len as integer, byval match as regamatch_t ptr, byval params as regaparams_t, byval eflags as integer) as integer
declare sub regaparams_default cdecl alias "regaparams_default" (byval params as regaparams_t ptr)

type tre_char_t as ubyte

type tre_str_source
	get_next_char as function cdecl(byval as tre_char_t ptr, byval as uinteger ptr, byval as any ptr) as integer
	rewind as sub cdecl(byval as integer, byval as any ptr)
	compare as function cdecl(byval as integer, byval as integer, byval as integer, byval as any ptr) as integer
	context as any ptr
end type

declare function reguexec cdecl alias "reguexec" (byval preg as regex_t ptr, byval string as tre_str_source ptr, byval nmatch as integer, byval pmatch as regmatch_t ptr, byval eflags as integer) as integer
declare function tre_version cdecl alias "tre_version" () as zstring ptr
declare function tre_config cdecl alias "tre_config" (byval query as integer, byval result as any ptr) as integer

enum 
	TRE_CONFIG_APPROX
	TRE_CONFIG_WCHAR
	TRE_CONFIG_MULTIBYTE
	TRE_CONFIG_SYSTEM_ABI
	TRE_CONFIG_VERSION
end enum

declare function tre_have_backrefs cdecl alias "tre_have_backrefs" (byval preg as regex_t ptr) as integer
declare function tre_have_approx cdecl alias "tre_have_approx" (byval preg as regex_t ptr) as integer

#endif
