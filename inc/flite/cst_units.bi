''
''
'' cst_units -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_units_bi__
#define __cst_units_bi__

declare function join_units cdecl alias "join_units" (byval utt as cst_utterance ptr) as cst_utterance ptr
declare function join_units_windowed cdecl alias "join_units_windowed" (byval utt as cst_utterance ptr) as cst_utterance ptr
declare function join_units_simple cdecl alias "join_units_simple" (byval utt as cst_utterance ptr) as cst_utterance ptr
declare function join_units_modified_lpc cdecl alias "join_units_modified_lpc" (byval utt as cst_utterance ptr) as cst_utterance ptr
declare function asis_to_pm cdecl alias "asis_to_pm" (byval utt as cst_utterance ptr) as cst_utterance ptr
declare function f0_targets_to_pm cdecl alias "f0_targets_to_pm" (byval utt as cst_utterance ptr) as cst_utterance ptr
declare function concat_units cdecl alias "concat_units" (byval utt as cst_utterance ptr) as cst_utterance ptr
declare sub add_residual cdecl alias "add_residual" (byval targ_size as integer, byval targ_residual as ubyte ptr, byval unit_size as integer, byval unit_residual as ubyte ptr)
declare sub add_residual_pulse cdecl alias "add_residual_pulse" (byval targ_size as integer, byval targ_residual as ubyte ptr, byval unit_size as integer, byval unit_residual as ubyte ptr)

#endif
