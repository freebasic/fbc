''
''
'' gpattern -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gpattern_bi__
#define __gpattern_bi__

#include once "gtypes.bi"

type GPatternSpec as _GPatternSpec

declare function g_pattern_spec_new (byval pattern as zstring ptr) as GPatternSpec ptr
declare sub g_pattern_spec_free (byval pspec as GPatternSpec ptr)
declare function g_pattern_spec_equal (byval pspec1 as GPatternSpec ptr, byval pspec2 as GPatternSpec ptr) as gboolean
declare function g_pattern_match (byval pspec as GPatternSpec ptr, byval string_length as guint, byval string as zstring ptr, byval string_reversed as zstring ptr) as gboolean
declare function g_pattern_match_string (byval pspec as GPatternSpec ptr, byval string as zstring ptr) as gboolean
declare function g_pattern_match_simple (byval pattern as zstring ptr, byval string as zstring ptr) as gboolean

#endif
