''
''
'' cst_regex -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_regex_bi__
#define __cst_regex_bi__

#define CST_REGMAGIC 0234

type cst_regex_struct
	regstart as byte
	reganch as byte
	regmust as zstring ptr
	regmlen as integer
	regsize as integer
	program as zstring ptr
end type

type cst_regex as cst_regex_struct

#define CST_NSUBEXP 10

type cst_regstate_struct
	startp as zstring * 10
	endp as zstring * 10
	input as zstring ptr
	bol as zstring ptr
end type

type cst_regstate as cst_regstate_struct

declare function new_cst_regex cdecl alias "new_cst_regex" (byval str as zstring ptr) as cst_regex ptr
declare sub delete_cst_regex cdecl alias "delete_cst_regex" (byval r as cst_regex ptr)
declare function cst_regex_match cdecl alias "cst_regex_match" (byval r as cst_regex ptr, byval str as zstring ptr) as integer
declare function cst_regex_match_return cdecl alias "cst_regex_match_return" (byval r as cst_regex ptr, byval str as zstring ptr) as cst_regstate ptr
declare function hs_regcomp cdecl alias "hs_regcomp" (byval as zstring ptr) as cst_regex ptr
declare function hs_regexec cdecl alias "hs_regexec" (byval as cst_regex ptr, byval as zstring ptr) as cst_regstate ptr
declare sub hs_regdelete cdecl alias "hs_regdelete" (byval as cst_regex ptr)
declare function cst_regsub cdecl alias "cst_regsub" (byval r as cst_regstate ptr, byval in as zstring ptr, byval out as zstring ptr, byval max as size_t) as size_t
declare sub cst_regex_init cdecl alias "cst_regex_init" ()
extern cst_rx_white alias "cst_rx_white" as cst_regex ptr
extern cst_rx_alpha alias "cst_rx_alpha" as cst_regex ptr
extern cst_rx_uppercase alias "cst_rx_uppercase" as cst_regex ptr
extern cst_rx_lowercase alias "cst_rx_lowercase" as cst_regex ptr
extern cst_rx_alphanum alias "cst_rx_alphanum" as cst_regex ptr
extern cst_rx_identifier alias "cst_rx_identifier" as cst_regex ptr
extern cst_rx_int alias "cst_rx_int" as cst_regex ptr
extern cst_rx_double alias "cst_rx_double" as cst_regex ptr
extern cst_rx_commaint alias "cst_rx_commaint" as cst_regex ptr
extern cst_rx_digits alias "cst_rx_digits" as cst_regex ptr
extern cst_rx_dotted_abbrev alias "cst_rx_dotted_abbrev" as cst_regex ptr
extern cst_regex_table(0 to -1) alias "cst_regex_table" as cst_regex ptr

#define CST_RX_dotted_abbrev_NUM 0

#endif
