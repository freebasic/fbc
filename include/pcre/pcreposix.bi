''
''
'' pcreposix -- Perl-Compatible Regular Expressions, POSIX wrapper interface
''		   		(header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pcreposix_bi__
#define __pcreposix_bi__

''            Copyright (c) 1997-2008 University of Cambridge
'' 
'' -----------------------------------------------------------------------------
'' Redistribution and use in source and binary forms, with or without
'' modification, are permitted provided that the following conditions are met:
'' 
''     * Redistributions of source code must retain the above copyright notice,
''       this list of conditions and the following disclaimer.
'' 
''     * Redistributions in binary form must reproduce the above copyright
''       notice, this list of conditions and the following disclaimer in the
''       documentation and/or other materials provided with the distribution.
'' 
''     * Neither the name of the University of Cambridge nor the names of its
''       contributors may be used to endorse or promote products derived from
''       this software without specific prior written permission.
'' 
'' THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
'' IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
'' ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
'' LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
'' CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
'' SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
'' INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
'' CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
'' ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
'' POSSIBILITY OF SUCH DAMAGE.
'' -----------------------------------------------------------------------------

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
