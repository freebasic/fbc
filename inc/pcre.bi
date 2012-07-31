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

/' This is the public header file for the PCRE library, to be #included by
applications that call the PCRE functions.

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

#ifndef _PCRE_H
#define _PCRE_H

#include once "crt/stdlib.bi"
#inclib "pcre"

/' The current PCRE version information. '/

#define PCRE_MAJOR          8
#define PCRE_MINOR          31
#define PCRE_PRERELEASE     
#define PCRE_DATE           2012-07-06

/' Options. Some are compile-time only, some are run-time only, and some are
both, so we keep them all distinct. However, almost all the bits in the options
word are now used. In the long run, we may have to re-use some of the
compile-time only bits for runtime options, or vice versa. In the comments
below, "compile", "exec", and "DFA exec" mean that the option is permitted to
be set for those functions; "used in" means that an option may be set only for
compile, but is subsequently referenced in exec and/or DFA exec. Any of the
compile-time options may be inspected during studying (and therefore JIT
compiling). '/

#define PCRE_CASELESS           &h00000001  /' Compile '/
#define PCRE_MULTILINE          &h00000002  /' Compile '/
#define PCRE_DOTALL             &h00000004  /' Compile '/
#define PCRE_EXTENDED           &h00000008  /' Compile '/
#define PCRE_ANCHORED           &h00000010  /' Compile, exec, DFA exec '/
#define PCRE_DOLLAR_ENDONLY     &h00000020  /' Compile, used in exec, DFA exec '/
#define PCRE_EXTRA              &h00000040  /' Compile '/
#define PCRE_NOTBOL             &h00000080  /' Exec, DFA exec '/
#define PCRE_NOTEOL             &h00000100  /' Exec, DFA exec '/
#define PCRE_UNGREEDY           &h00000200  /' Compile '/
#define PCRE_NOTEMPTY           &h00000400  /' Exec, DFA exec '/
/' The next two are also used in exec and DFA exec '/
#define PCRE_UTF8               &h00000800  /' Compile (same as PCRE_UTF16) '/
#define PCRE_UTF16              &h00000800  /' Compile (same as PCRE_UTF8) '/
#define PCRE_NO_AUTO_CAPTURE    &h00001000  /' Compile '/
/' The next two are also used in exec and DFA exec '/
#define PCRE_NO_UTF8_CHECK      &h00002000  /' Compile (same as PCRE_NO_UTF16_CHECK) '/
#define PCRE_NO_UTF16_CHECK     &h00002000  /' Compile (same as PCRE_NO_UTF8_CHECK) '/
#define PCRE_AUTO_CALLOUT       &h00004000  /' Compile '/
#define PCRE_PARTIAL_SOFT       &h00008000  /' Exec, DFA exec '/
#define PCRE_PARTIAL            &h00008000  /' Backwards compatible synonym '/
#define PCRE_DFA_SHORTEST       &h00010000  /' DFA exec '/
#define PCRE_DFA_RESTART        &h00020000  /' DFA exec '/
#define PCRE_FIRSTLINE          &h00040000  /' Compile, used in exec, DFA exec '/
#define PCRE_DUPNAMES           &h00080000  /' Compile '/
#define PCRE_NEWLINE_CR         &h00100000  /' Compile, exec, DFA exec '/
#define PCRE_NEWLINE_LF         &h00200000  /' Compile, exec, DFA exec '/
#define PCRE_NEWLINE_CRLF       &h00300000  /' Compile, exec, DFA exec '/
#define PCRE_NEWLINE_ANY        &h00400000  /' Compile, exec, DFA exec '/
#define PCRE_NEWLINE_ANYCRLF    &h00500000  /' Compile, exec, DFA exec '/
#define PCRE_BSR_ANYCRLF        &h00800000  /' Compile, exec, DFA exec '/
#define PCRE_BSR_UNICODE        &h01000000  /' Compile, exec, DFA exec '/
#define PCRE_JAVASCRIPT_COMPAT  &h02000000  /' Compile, used in exec '/
#define PCRE_NO_START_OPTIMIZE  &h04000000  /' Compile, exec, DFA exec '/
#define PCRE_NO_START_OPTIMISE  &h04000000  /' Synonym '/
#define PCRE_PARTIAL_HARD       &h08000000  /' Exec, DFA exec '/
#define PCRE_NOTEMPTY_ATSTART   &h10000000  /' Exec, DFA exec '/
#define PCRE_UCP                &h20000000  /' Compile, used in exec, DFA exec '/

/' Exec-time and get/set-time error codes '/

#define PCRE_ERROR_NOMATCH          (-1)
#define PCRE_ERROR_NULL             (-2)
#define PCRE_ERROR_BADOPTION        (-3)
#define PCRE_ERROR_BADMAGIC         (-4)
#define PCRE_ERROR_UNKNOWN_OPCODE   (-5)
#define PCRE_ERROR_UNKNOWN_NODE     (-5)  /' For backward compatibility '/
#define PCRE_ERROR_NOMEMORY         (-6)
#define PCRE_ERROR_NOSUBSTRING      (-7)
#define PCRE_ERROR_MATCHLIMIT       (-8)
#define PCRE_ERROR_CALLOUT          (-9)  /' Never used by PCRE itself '/
#define PCRE_ERROR_BADUTF8         (-10)  /' Same for 8/16 '/
#define PCRE_ERROR_BADUTF16        (-10)  /' Same for 8/16 '/
#define PCRE_ERROR_BADUTF8_OFFSET  (-11)  /' Same for 8/16 '/
#define PCRE_ERROR_BADUTF16_OFFSET (-11)  /' Same for 8/16 '/
#define PCRE_ERROR_PARTIAL         (-12)
#define PCRE_ERROR_BADPARTIAL      (-13)
#define PCRE_ERROR_INTERNAL        (-14)
#define PCRE_ERROR_BADCOUNT        (-15)
#define PCRE_ERROR_DFA_UITEM       (-16)
#define PCRE_ERROR_DFA_UCOND       (-17)
#define PCRE_ERROR_DFA_UMLIMIT     (-18)
#define PCRE_ERROR_DFA_WSSIZE      (-19)
#define PCRE_ERROR_DFA_RECURSE     (-20)
#define PCRE_ERROR_RECURSIONLIMIT  (-21)
#define PCRE_ERROR_NULLWSLIMIT     (-22)  /' No longer actually used '/
#define PCRE_ERROR_BADNEWLINE      (-23)
#define PCRE_ERROR_BADOFFSET       (-24)
#define PCRE_ERROR_SHORTUTF8       (-25)
#define PCRE_ERROR_SHORTUTF16      (-25)  /' Same for 8/16 '/
#define PCRE_ERROR_RECURSELOOP     (-26)
#define PCRE_ERROR_JIT_STACKLIMIT  (-27)
#define PCRE_ERROR_BADMODE         (-28)
#define PCRE_ERROR_BADENDIANNESS   (-29)
#define PCRE_ERROR_DFA_BADRESTART  (-30)

/' Specific error codes for UTF-8 validity checks '/

#define PCRE_UTF8_ERR0               0
#define PCRE_UTF8_ERR1               1
#define PCRE_UTF8_ERR2               2
#define PCRE_UTF8_ERR3               3
#define PCRE_UTF8_ERR4               4
#define PCRE_UTF8_ERR5               5
#define PCRE_UTF8_ERR6               6
#define PCRE_UTF8_ERR7               7
#define PCRE_UTF8_ERR8               8
#define PCRE_UTF8_ERR9               9
#define PCRE_UTF8_ERR10             10
#define PCRE_UTF8_ERR11             11
#define PCRE_UTF8_ERR12             12
#define PCRE_UTF8_ERR13             13
#define PCRE_UTF8_ERR14             14
#define PCRE_UTF8_ERR15             15
#define PCRE_UTF8_ERR16             16
#define PCRE_UTF8_ERR17             17
#define PCRE_UTF8_ERR18             18
#define PCRE_UTF8_ERR19             19
#define PCRE_UTF8_ERR20             20
#define PCRE_UTF8_ERR21             21

/' Request types for pcre_fullinfo() '/

#define PCRE_INFO_OPTIONS            0
#define PCRE_INFO_SIZE               1
#define PCRE_INFO_CAPTURECOUNT       2
#define PCRE_INFO_BACKREFMAX         3
#define PCRE_INFO_FIRSTBYTE          4
#define PCRE_INFO_FIRSTCHAR          4  /' For backwards compatibility '/
#define PCRE_INFO_FIRSTTABLE         5
#define PCRE_INFO_LASTLITERAL        6
#define PCRE_INFO_NAMEENTRYSIZE      7
#define PCRE_INFO_NAMECOUNT          8
#define PCRE_INFO_NAMETABLE          9
#define PCRE_INFO_STUDYSIZE         10
#define PCRE_INFO_DEFAULT_TABLES    11
#define PCRE_INFO_OKPARTIAL         12
#define PCRE_INFO_JCHANGED          13
#define PCRE_INFO_HASCRORLF         14
#define PCRE_INFO_MINLENGTH         15
#define PCRE_INFO_JIT               16
#define PCRE_INFO_JITSIZE           17
#define PCRE_INFO_MAXLOOKBEHIND     18

/' Request types for pcre_config(). Do not re-arrange, in order to remain
compatible. '/

#define PCRE_CONFIG_UTF8                    0
#define PCRE_CONFIG_NEWLINE                 1
#define PCRE_CONFIG_LINK_SIZE               2
#define PCRE_CONFIG_POSIX_MALLOC_THRESHOLD  3
#define PCRE_CONFIG_MATCH_LIMIT             4
#define PCRE_CONFIG_STACKRECURSE            5
#define PCRE_CONFIG_UNICODE_PROPERTIES      6
#define PCRE_CONFIG_MATCH_LIMIT_RECURSION   7
#define PCRE_CONFIG_BSR                     8
#define PCRE_CONFIG_JIT                     9
#define PCRE_CONFIG_UTF16                  10
#define PCRE_CONFIG_JITTARGET              11

/' Request types for pcre_study(). Do not re-arrange, in order to remain
compatible. '/

#define PCRE_STUDY_JIT_COMPILE                &h0001
#define PCRE_STUDY_JIT_PARTIAL_SOFT_COMPILE   &h0002
#define PCRE_STUDY_JIT_PARTIAL_HARD_COMPILE   &h0004

/' Bit flags for the pcre[16]_extra structure. Do not re-arrange or redefine
these bits, just add new ones on the end, in order to remain compatible. '/

#define PCRE_EXTRA_STUDY_DATA             &h0001
#define PCRE_EXTRA_MATCH_LIMIT            &h0002
#define PCRE_EXTRA_CALLOUT_DATA           &h0004
#define PCRE_EXTRA_TABLES                 &h0008
#define PCRE_EXTRA_MATCH_LIMIT_RECURSION  &h0010
#define PCRE_EXTRA_MARK                   &h0020
#define PCRE_EXTRA_EXECUTABLE_JIT         &h0040

/' Types '/

type pcre as real_pcre                 /' declaration; the definition is private  '/

type pcre_jit_stack as real_pcre_jit_stack /' declaration; the definition is private  '/


/' When PCRE is compiled as a C++ library, the subject pointer type can be
replaced with a custom type. For conventional use, the public interface is a
const char *. '/

#ifndef PCRE_SPTR
#define PCRE_SPTR const zstring ptr
#endif



/' The structure for passing additional data to pcre_exec(). This is defined in
such as way as to be extensible. Always add new fields at the end, in order to
remain compatible. '/

type pcre_extra_
  as ulong flags                     /' Bits for which fields are set '/
  as any ptr study_data              /' Opaque data from pcre_study() '/
  as ulong match_limit               /' Maximum number of calls to match() '/
  as any ptr callout_data            /' Data passed back in callouts '/
  as const ubyte ptr tables          /' Pointer to character tables '/
  as ulong match_limit_recursion     /' Max recursive calls to match() '/
  as ubyte ptr ptr mark              /' For passing back a mark pointer '/
  as any ptr executable_jit          /' Contains a pointer to a compiled jit code '/
end type

/' The structure for passing out data via the pcre_callout_function. We use a
structure so that new fields can be added on the end in future versions,
without changing the API of the function, thereby allowing old clients to work
without modification. '/

type pcre_callout_block
  as integer          version           /' Identifies version of block '/
  /' ------------------------ Version 0 ------------------------------- '/
  as integer          callout_number    /' Number compiled into pattern '/
  as integer ptr      offset_vector     /' The offset vector '/
  as PCRE_SPTR        subject           /' The subject being matched '/
  as integer          subject_length    /' The length of the subject '/
  as integer          start_match       /' Offset to start of this match attempt '/
  as integer          current_position  /' Where we currently are in the subject '/
  as integer          capture_top       /' Max current capture '/
  as integer          capture_last      /' Most recently closed capture '/
  as any ptr          callout_data      /' Data passed in with the call '/
  /' ------------------- Added for Version 1 -------------------------- '/
  as integer          pattern_position  /' Offset to next item in the pattern '/
  as integer          next_item_length  /' Length of next item in the pattern '/
  /' ------------------- Added for Version 2 -------------------------- '/
  as const ubyte ptr  mark               /' Pointer to current mark or NULL    '/
  /' ------------------------------------------------------------------ '/
end type


extern "C"

/' Indirection for store get and free functions. These can be set to
alternative malloc/free functions if required. Special ones are used in the
non-recursive case for "frames". There is also an optional callout function
that is triggered by the (?) regex item. For Virtual Pascal, these definitions
have to take another form. '/

#ifndef VPCOMPAT
  extern import pcre_malloc alias "pcre_malloc" as function cdecl (byval as size_t) as any ptr
  extern import pcre_free alias "pcre_free" as sub cdecl (byval as any ptr)
  extern import pcre_stack_malloc alias "pcre_stack_malloc" as function cdecl (byval as size_t) as any ptr
  extern import pcre_stack_free alias "pcre_stack_free" as sub cdecl (byval as any ptr)
  extern import pcre_callout alias "pcre_callout" as function cdecl (byval as pcre_callout_block ptr) as integer
#else
	declare function pcre_malloc (byval as size_t) as any ptr
	declare sub pcre_free (byval as any ptr)
	declare function pcre_stack_malloc (byval as size_t) as any ptr
	declare sub pcre_stack_free (byval as any ptr)
	declare function pcre_callout (byval as pcre_callout_block ptr) as integer
#endif


/' User defined callback which provides a stack just before the match starts. '/

type pcre_jit_callback as function cdecl (byval as any ptr) as pcre_jit_stack ptr




/'************************************************
*        Compile a Regular Expression            *
************************************************'/

/' This function takes a string and returns a pointer to a block of store
holding a compiled version of the expression. The original API for this
function had no error code return variable; it is retained for backwards
compatibility. The new function is given a new name.

Arguments:
  pattern       the regular expression
  options       various option bits
  errorcodeptr  pointer to error code variable (pcre_compile2() only)
                  can be NULL if you don't want a code value
  errorptr      pointer to pointer to error text
  erroroffset   ptr offset in pattern where error was detected
  tables        pointer to character tables or NULL

Returns:        pointer to compiled data block, or NULL on error,
                with errorptr and erroroffset set
'/



declare function pcre_compile(byval pattern as const zstring ptr, _
                              byval options as integer,_
                              byval errorptr as zstring ptr ptr,_
                              byval erroroffset as integer ptr,_
                              byval tables as ubyte ptr) as pcre ptr

declare function pcre_compile2(byval pattern as const zstring ptr, _
                               byval options as integer,_
                               byval errorptr as zstring ptr ptr,_
                               byval erroroffset as integer ptr,_
                               byval tables as ubyte ptr) as pcre ptr

/'************************************************
*          Study a compiled expression           *
************************************************'/

/' This function is handed a compiled expression that it must study to produce
information that will speed up the matching. It returns a pcre[16]_extra block
which then gets handed back to pcre_exec().

Arguments:
  re        points to the compiled expression
  options   contains option bits
  errorptr  points to where to place error messages;
            set NULL unless error

Returns:    pointer to a pcre[16]_extra block, with study_data filled in and
              the appropriate flags set;
            NULL on error or if no optimization possible
'/

declare function pcre_study(byval external_re as const pcre ptr,_ 
                            byval options as integer,_
                            byval errorptr as const zstring ptr ptr) as pcre_extra_ ptr

declare sub pcre_free_study(byval extra as pcre_extra_ ptr)


/'************************************************
*         Execute a Regular Expression           *
************************************************'/

/' This function applies a compiled re to a subject string and picks out
portions of the string if it matches. Two elements in the vector are set for
each substring: the offsets to the start and end of the substring.

Arguments:
  argument_re     points to the compiled expression
  extra_data      points to extra data or is NULL
  subject         points to the subject string
  length          length of subject string (may contain binary zeros)
  start_offset    where to start in the subject string
  options         option bits
  offsets         points to a vector of ints to be filled in with offsets
  offsetcount     the number of elements in the vector

Returns:          > 0 => success; value is the number of elements filled in
                  = 0 => success, but offsets is not big enough
                   -1 => failed to match
                 < -1 => some kind of unexpected problem
'/


declare function pcre_exec(byval argument_re as const pcre ptr,_
                           byval extra as const pcre_extra_ ptr,_
                           byval subject as PCRE_SPTR,_
                           byval length as integer,_
                           byval start_offset as integer,_
                           byval options as integer,_
                           byval offsets as integer ptr,_
                           byval offsetcount as integer) as integer

/'************************************************
*    Execute a Regular Expression - DFA engine   *
************************************************'/

/' This external function applies a compiled re to a subject string using a DFA
engine. This function calls the internal function multiple times if the pattern
is not anchored.

Arguments:
  argument_re     points to the compiled expression
  extra_data      points to extra data or is NULL
  subject         points to the subject string
  length          length of subject string (may contain binary zeros)
  start_offset    where to start in the subject string
  options         option bits
  offsets         vector of match offsets
  offsetcount     size of same
  workspace       workspace vector
  wscount         size of same

Returns:          > 0 => number of match offset pairs placed in offsets
                  = 0 => offsets overflowed; longest matches are present
                   -1 => failed to match
                 < -1 => some kind of unexpected problem
'/

declare function pcre_dfa_exec(byval argument_re as const pcre ptr,_
                               byval extra_data as const pcre_extra_ ptr,_
                               byval subject as const zstring ptr,_
                               byval lengt as integer,_
                               byval start_offset as integer,_
                               byval options as integer,_
                               byval offsets as integer ptr,_
                               byval offsetcount as integer,_
                               byval workspace as integer ptr,_
                               byval wscount as integer) as integer

/'************************************************
*   Copy named captured string to given buffer   *
************************************************'/

/' This function copies a single captured substring into a given buffer,
identifying it by name. If the regex permits duplicate names, the first
substring that is set is chosen.

Arguments:
  code           the compiled regex
  subject        the subject string that was matched
  ovector        pointer to the offsets table
  stringcount    the number of substrings that were captured
                   (i.e. the yield of the pcre_exec call, unless
                   that was zero, in which case it should be 1/3
                   of the offset table size)
  stringname     the name of the required substring
  buffer         where to put the substring
  size           the size of the buffer

Returns:         if successful:
                   the length of the copied string, not including the zero
                   that is put on the end; can be zero
                 if not successful:
                   PCRE_ERROR_NOMEMORY (-6) buffer too small
                   PCRE_ERROR_NOSUBSTRING (-7) no such captured substring
'/


declare function pcre_copy_named_substring(byval code as const pcre ptr,_
                                           byval subject as const zstring ptr,_
                                           byval ovector as integer ptr,_
                                           byval stringcount as integer,_
                                           byval stringname as const zstring ptr,_
                                           byval buffer as zstring ptr,_
                                           byval size as integer) as integer

/'************************************************
*      Copy captured string to given buffer      *
************************************************'/

/' This function copies a single captured substring into a given buffer.
Note that we use memcpy() rather than strncpy() in case there are binary zeros
in the string.

Arguments:
  subject        the subject string that was matched
  ovector        pointer to the offsets table
  stringcount    the number of substrings that were captured
                   (i.e. the yield of the pcre_exec call, unless
                   that was zero, in which case it should be 1/3
                   of the offset table size)
  stringnumber   the number of the required substring
  buffer         where to put the substring
  size           the size of the buffer

Returns:         if successful:
                   the length of the copied string, not including the zero
                   that is put on the end; can be zero
                 if not successful:
                   PCRE_ERROR_NOMEMORY (-6) buffer too small
                   PCRE_ERROR_NOSUBSTRING (-7) no such captured substring
'/

declare function pcre_copy_substring(byval subject as const zstring ptr,_
                                     byval ovector as integer ptr,_
                                     byval stringcount as integer,_
                                     byval stringnumber as integer,_
                                     byval buffer as zstring ptr,_
                                     byval size as integer) as integer

/'************************************************
*   Copy named captured string to new store      *
************************************************'/

/' This function copies a single captured substring, identified by name, into
new store. If the regex permits duplicate names, the first substring that is
set is chosen.

Arguments:
  code           the compiled regex
  subject        the subject string that was matched
  ovector        pointer to the offsets table
  stringcount    the number of substrings that were captured
                   (i.e. the yield of the pcre_exec call, unless
                   that was zero, in which case it should be 1/3
                   of the offset table size)
  stringname     the name of the required substring
  stringptr      where to put the pointer

Returns:         if successful:
                   the length of the copied string, not including the zero
                   that is put on the end; can be zero
                 if not successful:
                   PCRE_ERROR_NOMEMORY (-6) couldn't get memory
                   PCRE_ERROR_NOSUBSTRING (-7) no such captured substring
'/

declare function pcre_get_named_substring(byval code as const pcre ptr,_
                                          byval subject as const zstring ptr,_
                                          byval ovector as integer ptr,_
                                          byval stringcount as integer,_
                                          byval stringname as const zstring ptr,_
                                          byval stringptr as const zstring ptr ptr) as integer

/'************************************************
*           Find number for named string         *
************************************************'/

/' This function is used by the get_first_set() function below, as well
as being generally available. It assumes that names are unique.

Arguments:
  code        the compiled regex
  stringname  the name whose number is required

Returns:      the number of the named parentheses, or a negative number
                (PCRE_ERROR_NOSUBSTRING) if not found
'/

declare function pcre_get_stringnumber(byval code as const pcre ptr,_
                                       byval stringname as const zstring ptr) as integer

/'************************************************
*     Find (multiple) entries for named string   *
************************************************'/

/' This is used by the get_first_set() function below, as well as being
generally available. It is used when duplicated names are permitted.

Arguments:
  code        the compiled regex
  stringname  the name whose entries required
  firstptr    where to put the pointer to the first entry
  lastptr     where to put the pointer to the last entry

Returns:      the length of each entry, or a negative number
                (PCRE_ERROR_NOSUBSTRING) if not found
'/

declare function pcre_get_stringtable_entries(byval code as pcre ptr,_
                                              byval stringname as const zstring ptr,_
                                              byval firstptr as zstring ptr ptr,_
                                              byval lastptr as zstring ptr ptr) as integer

/'************************************************
*      Copy captured string to new store         *
************************************************'/

/' This function copies a single captured substring into a piece of new
store

Arguments:
  subject        the subject string that was matched
  ovector        pointer to the offsets table
  stringcount    the number of substrings that were captured
                   (i.e. the yield of the pcre_exec call, unless
                   that was zero, in which case it should be 1/3
                   of the offset table size)
  stringnumber   the number of the required substring
  stringptr      where to put a pointer to the substring

Returns:         if successful:
                   the length of the string, not including the zero that
                   is put on the end; can be zero
                 if not successful:
                   PCRE_ERROR_NOMEMORY (-6) failed to get store
                   PCRE_ERROR_NOSUBSTRING (-7) substring not present
'/

declare function pcre_get_substring(byval subject as const zstring ptr,_
                                    byval ovector as integer ptr,_
                                    byval stringcount as integer,_
                                    byval stringnumber as integer,_
                                    byval stringptr as const zstring ptr ptr) as integer

/'************************************************
*      Copy all captured strings to new store    *
************************************************'/

/' This function gets one chunk of store and builds a list of pointers and all
of the captured substrings in it. A NULL pointer is put on the end of the list.

Arguments:
  subject        the subject string that was matched
  ovector        pointer to the offsets table
  stringcount    the number of substrings that were captured
                   (i.e. the yield of the pcre_exec call, unless
                   that was zero, in which case it should be 1/3
                   of the offset table size)
  listptr        set to point to the list of pointers

Returns:         if successful: 0
                 if not successful:
                   PCRE_ERROR_NOMEMORY (-6) failed to get store
'/

declare function pcre_get_substring_list(byval subject as const zstring ptr,_
                                         byval ovector as integer ptr,_
                                         byval stringcount as integer,_
                                         byval listptr as const zstring ptr ptr ptr) as integer
/'************************************************
*       Free store obtained by get_substring     *
************************************************'/

/' This function exists for the benefit of people calling PCRE from non-C
programs that can call its functions, but not free() or (PUBL(free))()
directly.

Argument:   the result of a previous pcre_get_substring()
Returns:    nothing
'/

declare sub pcre_free_substring(byval pointer_ as const zstring ptr)

/'************************************************
*   Free store obtained by get_substring_list    *
************************************************'/

/' This function exists for the benefit of people calling PCRE from non-C
programs that can call its functions, but not free() or (PUBL(free))()
directly.

Argument:   the result of a previous pcre_get_substring_list()
Returns:    nothing
'/

declare sub pcre_free_substring_list(byval pointer_ as const zstring ptr ptr)

declare function pcre_jit_stack_alloc(byval startsize as integer,_
                                      byval maxsize as integer) as pcre_jit_stack ptr

declare sub pcre_jit_stack_free(byval stack as pcre_jit_stack ptr)

declare sub pcre_assign_jit_stack(byval extra as pcre_extra_ ptr,_
                                  byval callback as pcre_jit_callback,_
                                  byval userdata as any ptr)

/'************************************************
*           Create PCRE character tables         *
************************************************'/

/' This function builds a set of character tables for use by PCRE and returns
a pointer to them. They are build using the ctype functions, and consequently
their contents will depend upon the current locale setting. When compiled as
part of the library, the store is obtained via PUBL(malloc)(), but when
compiled inside dftables, use malloc().

Arguments:   none
Returns:     pointer to the contiguous block of data
'/

declare function pcre_maketables() as const ubyte ptr

/'************************************************
*        Return info about compiled pattern      *
************************************************'/

/' This is a newer "info" function which has an extensible interface so
that additional items can be added compatibly.

Arguments:
  argument_re      points to compiled code
  extra_data       points extra data, or NULL
  what             what information is required
  where            where to put the information

Returns:           0 if data returned, negative on error
'/


declare function pcre_fullinfo(_
                               byval argument_re as const pcre ptr,_
                               byval extra_data as const pcre_extra_ ptr,_
                               byval what as integer,_
                               byval where as any ptr) as integer

/'************************************************
*           Maintain reference count             *
************************************************'/

/' The reference count is a 16-bit field, initialized to zero. It is not
possible to transfer a non-zero count from one host to a different host that
has a different byte order - though I can't see why anyone in their right mind
would ever want to do that!

Arguments:
  argument_re   points to compiled code
  adjust        value to add to the count

Returns:        the (possibly updated) count value (a non-negative number), or
                a negative error number
'/

declare function pcre_refcount(_
                               byval argument_re as pcre ptr,_
                               byval adjust as integer) as integer

/'************************************************
* Return info about what features are configured *
************************************************'/

/' This function has an extensible interface so that additional items can be
added compatibly.

Arguments:
  what             what information is required
  where            where to put the information

Returns:           0 if data returned, negative on error
'/

declare function pcre_config(_
                             byval what as integer,_
                             byval where as any ptr) as integer


declare function pcre_version() as const zstring ptr

/'************************************************
*       Test for a byte-flipped compiled regex   *
************************************************'/

/' This function swaps the bytes of a compiled pattern usually
loaded form the disk. It also sets the tables pointer, which
is likely an invalid pointer after reload.

Arguments:
  argument_re     points to the compiled expression
  extra_data      points to extra data or is NULL
  tables          points to the character tables or NULL

Returns:          0 if the swap is successful, negative on error
'/

declare function pcre_pattern_to_host_byte_order(_
                                                 byval argument_re as pcre ptr,_
                                                 byval extra_data as pcre_extra_ ptr,_
                                                 byval tables as const ubyte ptr) as integer
end extern
#endif