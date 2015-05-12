''
''
'' cst_utt_utils -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_utt_utils_bi__
#define __cst_utt_utils_bi__

declare function utt_set_wave cdecl alias "utt_set_wave" (byval u as cst_utterance ptr, byval w as cst_wave ptr) as integer
declare function utt_wave cdecl alias "utt_wave" (byval u as cst_utterance ptr) as cst_wave ptr
declare function utt_input_text cdecl alias "utt_input_text" (byval u as cst_utterance ptr) as zstring ptr
declare function utt_set_input_text cdecl alias "utt_set_input_text" (byval u as cst_utterance ptr, byval text as zstring ptr) as integer

#endif
