''
''
'' PCRE -- Perl-Compatible Regular Expressions
''		   (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
/'************************************************
*       Perl-Compatible Regular Expressions      *
************************************************'/

#ifndef _PCREPOSIX_H
#define _PCREPOSIX_H

/' This is the header for the POSIX wrapper interface to the PCRE Perl-
Compatible Regular Expression library. It defines the things POSIX says should
be there. I hope.

            Copyright (c) 1997-2012 University of Cambridge

-----------------------------------------------------------------------------
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.

    * Neither the name of the University of Cambridge nor the names of its
      contributors may be used to endorse or promote products derived from
      this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
-----------------------------------------------------------------------------
'/

/' Have to include stdlib.h in order to ensure that size_t is defined. '/

#include once "crt/stdlib.bi"
#inclib "pcreposix"

/' Options, mostly defined by POSIX, but with some extras. '/

#define REG_ICASE     &h0001   /' Maps to PCRE_CASELESS '/
#define REG_NEWLINE   &h0002   /' Maps to PCRE_MULTILINE '/
#define REG_NOTBOL    &h0004   /' Maps to PCRE_NOTBOL '/
#define REG_NOTEOL    &h0008   /' Maps to PCRE_NOTEOL '/
#define REG_DOTALL    &h0010   /' NOT defined by POSIX; maps to PCRE_DOTALL '/
#define REG_NOSUB     &h0020   /' Maps to PCRE_NO_AUTO_CAPTURE '/
#define REG_UTF8      &h0040   /' NOT defined by POSIX; maps to PCRE_UTF8 '/
#define REG_STARTEND  &h0080   /' BSD feature: pass subject string by so,eo '/
#define REG_NOTEMPTY  &h0100   /' NOT defined by POSIX; maps to PCRE_NOTEMPTY '/
#define REG_UNGREEDY  &h0200   /' NOT defined by POSIX; maps to PCRE_UNGREEDY '/
#define REG_UCP       &h0400   /' NOT defined by POSIX; maps to PCRE_UCP '/

/' This is not used by PCRE, but by defining it we make it easier
to slot PCRE into existing programs that make POSIX calls. '/

#define REG_EXTENDED  0

/' Error values. Not all these are relevant or used by the wrapper. '/

enum
  REG_ASSERT = 1  /' internal error ? '/
  REG_BADBR       /' invalid repeat counts in {} '/
  REG_BADPAT      /' pattern error '/
  REG_BADRPT      /' ? * + invalid '/
  REG_EBRACE      /' unbalanced {} '/
  REG_EBRACK      /' unbalanced [] '/
  REG_ECOLLATE    /' collation error - not relevant '/
  REG_ECTYPE      /' bad class '/
  REG_EESCAPE     /' bad escape sequence '/
  REG_EMPTY       /' empty expression '/
  REG_EPAREN      /' unbalanced () '/
  REG_ERANGE      /' bad range inside [] '/
  REG_ESIZE       /' expression too big '/
  REG_ESPACE      /' failed to get memory '/
  REG_ESUBREG     /' bad back reference '/
  REG_INVARG      /' bad argument '/
  REG_NOMATCH      /' match failed '/
end enum


/' The structure representing a compiled regular expression. '/

type regex_t
  as any ptr re_pcre
  as size_t re_nsub
  as size_t re_erroffset
end type

/' The structure in which a captured offset is returned. '/

type regoff_t as integer

type regmatch_t
  as regoff_t rm_so
  as regoff_t rm_eo
end type

/' When an application links to a PCRE DLL in Windows, the symbols that are
imported have to be identified as such. When building PCRE, the appropriate
export settings are needed, and are set in pcreposix.c before including this
file. '/

/' Allow for C++ users '/

extern "C"

/' The functions '/

/' 
Arguments:
  preg        points to a structure for recording the compiled expression
  pattern     the pattern to compile
  cflags      compilation flags

Returns:      0 on success
              various non-zero codes on failure
'/

declare function regcomp(_
                         byval preg as regex_t ptr,_
                         byval pattern as const zstring ptr,_
                         byval cflags as integer) as integer


/'************************************************
*              Match a regular expression        *
************************************************'/

/' Unfortunately, PCRE requires 3 ints of working space for each captured
substring, so we have to get and release working store instead of just using
the POSIX structures as was done in earlier releases when PCRE needed only 2
ints. However, if the number of possible capturing brackets is small, use a
block of store on the stack, to reduce the use of malloc/free. The threshold is
in a macro that can be changed at configure time.

If REG_NOSUB was specified at compile time, the PCRE_NO_AUTO_CAPTURE flag will
be set. When this is the case, the nmatch and pmatch arguments are ignored, and
the only result is yes/no/error. '/

declare function regexec(_
                         byval preg as const regex_t ptr,_
                         byval string as const zstring ptr,_
                         byval nmatch as size_t,_
                         byval pmatch as regmatch_t ptr,_
                         byval eflags as integer) as integer


/'************************************************
*          Translate error code to string        *
************************************************'/

declare function regerror(_
                          byval errcode as integer,_
                          byval preg as const regex_t ptr,_
                          byval errbuf as zstring ptr,_
                          byval errbuf_size as size_t) as size_t


/'************************************************
*           Free store held by a regex           *
************************************************'/

declare sub regfree(byval preg as regex_t ptr)

end extern

#endif /' End of pcreposix.h '/
