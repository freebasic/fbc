''
''
'' PCRE -- Perl-Compatible Regular Expressions
''		   (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pcre_bi__
#define __pcre_bi__

''            Copyright (c) 1997-2004 University of Cambridge
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

#inclib "pcre"

#define PCRE_MAJOR 5
#define PCRE_MINOR 0
#define PCRE_DATE "13-Sep-2004"

#define PCRE_CASELESS &h0001
#define PCRE_MULTILINE &h0002
#define PCRE_DOTALL &h0004
#define PCRE_EXTENDED &h0008
#define PCRE_ANCHORED &h0010
#define PCRE_DOLLAR_ENDONLY &h0020
#define PCRE_EXTRA_ &h0040
#define PCRE_NOTBOL &h0080
#define PCRE_NOTEOL &h0100
#define PCRE_UNGREEDY &h0200
#define PCRE_NOTEMPTY &h0400
#define PCRE_UTF8 &h0800
#define PCRE_NO_AUTO_CAPTURE &h1000
#define PCRE_NO_UTF8_CHECK &h2000
#define PCRE_AUTO_CALLOUT &h4000
#define PCRE_PARTIAL &h8000
#define PCRE_ERROR_NOMATCH (-1)
#define PCRE_ERROR_NULL (-2)
#define PCRE_ERROR_BADOPTION (-3)
#define PCRE_ERROR_BADMAGIC (-4)
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
#define PCRE_CONFIG_UTF8 0
#define PCRE_CONFIG_NEWLINE 1
#define PCRE_CONFIG_LINK_SIZE 2
#define PCRE_CONFIG_POSIX_MALLOC_THRESHOLD 3
#define PCRE_CONFIG_MATCH_LIMIT 4
#define PCRE_CONFIG_STACKRECURSE 5
#define PCRE_CONFIG_UNICODE_PROPERTIES 6
#define PCRE_EXTRA_STUDY_DATA &h0001
#define PCRE_EXTRA_MATCH_LIMIT &h0002
#define PCRE_EXTRA_CALLOUT_DATA &h0004
#define PCRE_EXTRA_TABLES &h0008

type pcre as any

type pcre_extra
	flags as uinteger
	study_data as any ptr
	match_limit as uinteger
	callout_data as any ptr
	tables as ubyte ptr
end type

type pcre_callout_block
	version as integer
	callout_number as integer
	offset_vector as integer ptr
	subject as zstring ptr
	subject_length as integer
	start_match as integer
	current_position as integer
	capture_top as integer
	capture_last as integer
	callout_data as any ptr
	pattern_position as integer
	next_item_length as integer
end type

#ifndef VPCOMPAT
extern import pcre_malloc alias "pcre_malloc" as function (byval as integer) as any ptr
extern import pcre_free alias "pcre_free" as sub (byval as any ptr)
extern import pcre_stack_malloc alias "pcre_stack_malloc" as function (byval as integer) as any ptr
extern import pcre_stack_free alias "pcre_stack_free" as sub (byval as any ptr)
extern import pcre_callout alias "pcre_callout" as function (byval as pcre_callout_block ptr) as integer
#else
declare function pcre_malloc stdcall alias "pcre_malloc" (byval as integer) as any ptr
declare sub pcre_free stdcall alias "pcre_free" (byval as any ptr)
declare function pcre_stack_malloc stdcall alias "pcre_stack_malloc" (byval as integer) as any ptr
declare sub pcre_stack_free stdcall alias "pcre_stack_free" (byval as any ptr)
declare function pcre_callout stdcall alias "pcre_callout" (byval as pcre_callout_block ptr) as integer
#endif

declare function pcre_compile alias "pcre_compile" (byval as string, byval as integer, byval as zstring ptr ptr, byval as integer ptr, byval as ubyte ptr) as pcre ptr
declare function pcre_config alias "pcre_config" (byval as integer, byval as any ptr) as integer
declare function pcre_copy_named_substring alias "pcre_copy_named_substring" (byval as pcre ptr, byval as string, byval as integer ptr, byval as integer, byval as string, byval as string, byval as integer) as integer
declare function pcre_copy_substring alias "pcre_copy_substring" (byval as string, byval as integer ptr, byval as integer, byval as integer, byval as string, byval as integer) as integer
declare function pcre_exec alias "pcre_exec" (byval as pcre ptr, byval as pcre_extra ptr, byval as string, byval as integer, byval as integer, byval as integer, byval as integer ptr, byval as integer) as integer
declare sub pcre_free_substring alias "pcre_free_substring" (byval as string)
declare sub pcre_free_substring_list alias "pcre_free_substring_list" (byval as zstring ptr ptr)
declare function pcre_fullinfo alias "pcre_fullinfo" (byval as pcre ptr, byval as pcre_extra ptr, byval as integer, byval as any ptr) as integer
declare function pcre_get_named_substring alias "pcre_get_named_substring" (byval as pcre ptr, byval as string, byval as integer ptr, byval as integer, byval as string, byval as zstring ptr ptr) as integer
declare function pcre_get_stringnumber alias "pcre_get_stringnumber" (byval as pcre ptr, byval as string) as integer
declare function pcre_get_substring alias "pcre_get_substring" (byval as string, byval as integer ptr, byval as integer, byval as integer, byval as zstring ptr ptr) as integer
declare function pcre_get_substring_list alias "pcre_get_substring_list" (byval as string, byval as integer ptr, byval as integer, byval as zstring ptr ptr ptr) as integer
declare function pcre_info alias "pcre_info" (byval as pcre ptr, byval as integer ptr, byval as integer ptr) as integer
declare function pcre_maketables alias "pcre_maketables" () as ubyte ptr
declare function pcre_study alias "pcre_study" (byval as pcre ptr, byval as integer, byval as zstring ptr ptr) as pcre_extra ptr
declare function pcre_version alias "pcre_version" () as zstring ptr

#endif
