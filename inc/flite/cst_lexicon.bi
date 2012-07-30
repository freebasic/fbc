''
''
'' cst_lexicon -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_lexicon_bi__
#define __cst_lexicon_bi__

type lexicon_struct
	name as zstring ptr
	num_entries as integer
	data as ubyte ptr
	num_bytes as integer
	phone_table as byte ptr ptr
	lts_rule_set as cst_lts_rules ptr
	syl_boundary as function cdecl(byval as cst_item ptr, byval as cst_val ptr) as integer
	lts_function as function cdecl(byval as lexicon_struct ptr, byval as zstring ptr, byval as zstring ptr) as cst_val ptr
	addenda as byte ptr ptr ptr
	phone_hufftable as byte ptr ptr
	entry_hufftable as byte ptr ptr
	postlex as function cdecl(byval as cst_utterance ptr) as cst_utterance ptr
	lex_addenda as cst_val ptr
end type

type cst_lexicon as lexicon_struct

declare function new_lexicon cdecl alias "new_lexicon" () as cst_lexicon ptr
declare sub delete_lexicon cdecl alias "delete_lexicon" (byval lex as cst_lexicon ptr)
declare function cst_lex_make_entry cdecl alias "cst_lex_make_entry" (byval lex as cst_lexicon ptr, byval entry as cst_string ptr) as cst_val ptr
declare function cst_lex_load_addenda cdecl alias "cst_lex_load_addenda" (byval lex as cst_lexicon ptr, byval lexfile as zstring ptr) as cst_val ptr
declare function lex_lookup cdecl alias "lex_lookup" (byval l as cst_lexicon ptr, byval word as zstring ptr, byval pos as zstring ptr) as cst_val ptr
declare function in_lex cdecl alias "in_lex" (byval l as cst_lexicon ptr, byval word as zstring ptr, byval pos as zstring ptr) as integer

#endif
