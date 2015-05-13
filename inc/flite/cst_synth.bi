''
''
'' cst_synth -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_synth_bi__
#define __cst_synth_bi__

type cst_breakfunc as function cdecl(byval as cst_tokenstream ptr, byval as zstring ptr, byval as cst_relation ptr) as integer

declare function utt_synth cdecl alias "utt_synth" (byval u as cst_utterance ptr) as cst_utterance ptr
declare function utt_synth_phones cdecl alias "utt_synth_phones" (byval u as cst_utterance ptr) as cst_utterance ptr
declare function utt_synth_tokens cdecl alias "utt_synth_tokens" (byval u as cst_utterance ptr) as cst_utterance ptr

type cst_dur_stats_struct
	phone as zstring ptr
	mean as single
	stddev as single
end type

type dur_stat as cst_dur_stats_struct
type dur_stats as dur_stat ptr

declare function default_segmentanalysis cdecl alias "default_segmentanalysis" (byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_tokenization cdecl alias "default_tokenization" (byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_textanalysis cdecl alias "default_textanalysis" (byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_tokentowords cdecl alias "default_tokentowords" (byval i as cst_item ptr) as cst_val ptr
declare function default_phrasing cdecl alias "default_phrasing" (byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_pos_tagger cdecl alias "default_pos_tagger" (byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_lexical_insertion cdecl alias "default_lexical_insertion" (byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_pause_insertion cdecl alias "default_pause_insertion" (byval u as cst_utterance ptr) as cst_utterance ptr
declare function cart_intonation cdecl alias "cart_intonation" (byval u as cst_utterance ptr) as cst_utterance ptr
declare function cart_duration cdecl alias "cart_duration" (byval u as cst_utterance ptr) as cst_utterance ptr
declare function flat_prosody cdecl alias "flat_prosody" (byval u as cst_utterance ptr) as cst_utterance ptr

type cst_synth_module_struct
	hookname as zstring ptr
	defhook as cst_uttfunc
end type

type cst_synth_module as cst_synth_module_struct

declare function apply_synth_module cdecl alias "apply_synth_module" (byval u as cst_utterance ptr, byval mod as cst_synth_module ptr) as cst_utterance ptr
declare function apply_synth_method cdecl alias "apply_synth_method" (byval u as cst_utterance ptr, byval meth as cst_synth_module ptr) as cst_utterance ptr

#endif
