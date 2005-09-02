''
''  regex.h - POSIX.2 compatible regexp interface and TRE extensions
''
''  Copyright (C) 2001-2004 Ville Laurikari <vl@iki.fi>.
''
''  This program is free software; you can redistribute it and/or modify
''  it under the terms of the GNU General Public License version 2 (June
''  1991) as published by the Free Software Foundation.
''
''  This program is distributed in the hope that it will be useful,
''  but WITHOUT ANY WARRANTY; without even the implied warranty of
''  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''  GNU General Public License for more details.
''
''  You should have received a copy of the GNU General Public License
''  along with this program; if not, write to the Free Software
''  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
''
''

#ifndef TRE_REGEX_H
#define TRE_REGEX_H 1

#inclib "tre"

#ifndef _SIZE_T_
#define _SIZE_T_
type size_t as integer
#endif

type regoff_t as integer

type regex_t
	re_nsub 	as integer  	'' Number of parenthesized subexpressions.
  	value		as any ptr	   	'' For internal use only.
end type

type regmatch_t
  rm_so			as regoff_t
  rm_eo			as regoff_t
end type


enum reg_errcode_t
  REG_OK = 0		'' No error. 
  REG_NOMATCH		'' No match. 
  REG_BADPAT		'' Invalid regexp. 
  REG_ECOLLATE		'' Unknown collating element. 
  REG_ECTYPE		'' Unknown character class name. 
  REG_EESCAPE		'' Trailing backslash. 
  REG_ESUBREG		'' Invalid back reference. 
  REG_EBRACK		'' "[]" imbalance 
  REG_EPAREN		'' "\(\)" or "()" imbalance 
  REG_EBRACE		'' "\{\}" or "{}" imbalance 
  REG_BADBR			'' Invalid content of {} 
  REG_ERANGE		'' Invalid use of range operator 
  REG_ESPACE		'' Out of memory.  
  REG_BADRPT
end enum

'' POSIX regcomp() flags. 
#define REG_EXTENDED	1
#define REG_ICASE	(REG_EXTENDED shl 1)
#define REG_NEWLINE	(REG_ICASE shl 1)
#define REG_NOSUB	(REG_NEWLINE shl 1)

'' Extra regcomp() flags. 
#define REG_BASIC	0
#define REG_LITERAL	(REG_NOSUB shl 1)
#define REG_RIGHT_ASSOC (REG_LITERAL shl 1)

'' POSIX regexec() flags. 
#define REG_NOTBOL 1
#define REG_NOTEOL (REG_NOTBOL shl 1)

'' Extra regexec() flags. 
#define REG_APPROX_MATCHER	 (REG_NOTEOL shl 1)
#define REG_BACKTRACKING_MATCHER (REG_APPROX_MATCHER shl 1)

'' REG_NOSPEC and REG_LITERAL mean the same thing. 
#ifdef REG_LITERAL
#define REG_NOSPEC	REG_LITERAL
#elseif defined(REG_NOSPEC)
#define REG_LITERAL	REG_NOSPEC
#endif '' defined(REG_NOSPEC) 

'' The maximum number of iterations in a bound expression. 
#define RE_DUP_MAX 255

'' The POSIX.2 regexp functions 
declare function regcomp cdecl alias "regcomp" 		(byval preg as regex_t ptr, byval regex as zstring ptr, byval cflags as integer) as integer
declare function regexec cdecl alias "regexec" 		(byval preg as regex_t ptr, byval string as zstring ptr, byval nmatch as size_t, _
	    											 byval pmatch as regmatch_t ptr, byval eflags as integer) as integer
declare function regerror cdecl alias "regerror"	(byval errcode as integer, byval preg as regex_t ptr, byval errbuf as zstring ptr, _
													 byval errbuf_size as size_t) as size_t
declare sub 	 regfree cdecl alias "regfree" 		(byval preg as regex_t ptr)
 
 
'' Versions with a maximum length argument and therefore the capability to
'' handle null characters in the middle of the strings (not in POSIX.2).
declare function regncomp cdecl alias "regncomp" 	(byval preg as regex_t ptr, byval regex as zstring ptr, byval len as size_t, byval cflags as integer) as integer
declare function regnexec cdecl alias "regnexec" 	(byval preg as regex_t ptr, byval string as zstring ptr, byval len as size_t, _
	     											 byval nmatch as size_t, byval pmatch as regmatch_t ptr, byval eflags as integer) as integer



'' Approximate matching parameter struct. 
type regaparams_t
	cost_ins	as integer       '' Default cost of an inserted character. 
  	cost_del	as integer	     '' Default cost of a deleted character. 
  	cost_subst	as integer       '' Default cost of a substituted character. 
  	max_cost	as integer	     '' Maximum allowed cost of a match. 

  	max_ins		as integer	     '' Maximum allowed number of inserts. 
  	max_del		as integer	     '' Maximum allowed number of deletes. 
  	max_subst	as integer       '' Maximum allowed number of substitutes. 
  	max_err		as integer	     '' Maximum allowed number of errors total. 
end type

'' Approximate matching result struct. 
type regamatch_t
  	nmatch		as size_t        '' Length of pmatch[] array. 
  	pmatch		as regmatch_t ptr'' Submatch data. 
  	cost	    as integer   	 '' Cost of the match. 
  	num_ins	    as integer  	 '' Number of inserts in the match. 
  	num_del     as integer  	 '' Number of deletes in the match. 
  	num_subst	as integer       '' Number of substitutes in the match. 
end type


'' Approximate matching functions. 
declare function regaexec cdecl alias "regaexec"	(byval preg as regex_t ptr, byval string as zstring ptr, _
	     											 byval match as regamatch_t ptr, byval params as regaparams_t, byval eflags as integer) as integer
declare function reganexec cdecl alias "reganexec" 	(byval preg as regex_t ptr, byval string as zstring ptr, byval len as size_t, _
	      											 byval match as regamatch_t ptr, byval params as regaparams_t, byval eflags as integer) as integer


#endif				'' TRE_REGEX_H
