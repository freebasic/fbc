'' FreeBASIC binding for aspell-0.60.6.1
''
'' based on the C header files:
''   This file is part of The New Aspell
''   Copyright (C) 2001 by Kevin Atkinson under the GNU LGPL
''   license version 2.0 or 2.1.  You should have received a copy of the
''   LGPL license along with this library if you did not you can find it
''   at http://www.gnu.org/.                                              
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "aspell.bi"

extern "C"

#define ASPELL_PSPELL__H
type PspellCanHaveError as AspellCanHaveError
#define PspellErrorExtraInfo AspellErrorExtraInfo
declare function pspell_error_number alias "aspell_error_number"(byval ths as const AspellCanHaveError ptr) as ulong
declare function pspell_error_message alias "aspell_error_message"(byval ths as const AspellCanHaveError ptr) as const zstring ptr
declare sub delete_pspell_can_have_error alias "delete_aspell_can_have_error"(byval ths as AspellCanHaveError ptr)
type PspellStringEmulation as AspellStringEnumeration
declare function pspell_string_emulation_clone alias "aspell_string_enumeration_clone"(byval ths as const AspellStringEnumeration ptr) as AspellStringEnumeration ptr
declare sub pspell_string_emulation_assign alias "aspell_string_enumeration_assign"(byval ths as AspellStringEnumeration ptr, byval other as const AspellStringEnumeration ptr)
declare function pspell_string_emulation_at_end alias "aspell_string_enumeration_at_end"(byval ths as const AspellStringEnumeration ptr) as long
declare function pspell_string_emulation_next alias "aspell_string_enumeration_next"(byval ths as AspellStringEnumeration ptr) as const zstring ptr
declare sub delete_pspell_string_emulation alias "delete_aspell_string_enumeration"(byval ths as AspellStringEnumeration ptr)
type PspellStringPair as AspellStringPair
type PspellStringPairEmulation as AspellStringPairEnumeration
declare function pspell_string_pair_emulation_clone alias "aspell_string_pair_enumeration_clone"(byval ths as const AspellStringPairEnumeration ptr) as AspellStringPairEnumeration ptr
declare sub pspell_string_pair_emulation_assign alias "aspell_string_pair_enumeration_assign"(byval ths as AspellStringPairEnumeration ptr, byval other as const AspellStringPairEnumeration ptr)
declare function pspell_string_pair_emulation_at_end alias "aspell_string_pair_enumeration_at_end"(byval ths as const AspellStringPairEnumeration ptr) as long
declare sub delete_pspell_string_pair_emulation alias "delete_aspell_string_pair_enumeration"(byval ths as AspellStringPairEnumeration ptr)
type PspellKeyInfoType as AspellKeyInfoType

const PspellKeyInfoString = AspellKeyInfoString
const PspellKeyInfoInt = AspellKeyInfoInt
const PspellKeyInfoBool = AspellKeyInfoBool
const PspellKeyInfoList = AspellKeyInfoList

type PspellKeyInfo as AspellKeyInfo
type PspellKeyInfoEmulation as AspellKeyInfoEnumeration
type PspellConfig as AspellConfig

declare function new_pspell_config alias "new_aspell_config"() as AspellConfig ptr
declare sub delete_pspell_config alias "delete_aspell_config"(byval ths as AspellConfig ptr)
declare function pspell_config_error_number alias "aspell_config_error_number"(byval ths as const AspellConfig ptr) as ulong
declare function pspell_config_error_message alias "aspell_config_error_message"(byval ths as const AspellConfig ptr) as const zstring ptr
declare function pspell_config_clone alias "aspell_config_clone"(byval ths as const AspellConfig ptr) as AspellConfig ptr
declare sub pspell_config_assign alias "aspell_config_assign"(byval ths as AspellConfig ptr, byval other as const AspellConfig ptr)
declare sub pspell_config_set_extra alias "aspell_config_set_extra"(byval ths as AspellConfig ptr, byval begin as const AspellKeyInfo ptr, byval end as const AspellKeyInfo ptr)
declare function pspell_config_keyinfo alias "aspell_config_keyinfo"(byval ths as AspellConfig ptr, byval key as const zstring ptr) as const AspellKeyInfo ptr
declare function pspell_config_possible_elements alias "aspell_config_possible_elements"(byval ths as AspellConfig ptr, byval include_extra as long) as AspellKeyInfoEnumeration ptr
declare function pspell_config_get_default alias "aspell_config_get_default"(byval ths as AspellConfig ptr, byval key as const zstring ptr) as const zstring ptr
declare function pspell_config_elements alias "aspell_config_elements"(byval ths as AspellConfig ptr) as AspellStringPairEnumeration ptr
declare function pspell_config_replace alias "aspell_config_replace"(byval ths as AspellConfig ptr, byval key as const zstring ptr, byval value as const zstring ptr) as long
declare function pspell_config_remove alias "aspell_config_remove"(byval ths as AspellConfig ptr, byval key as const zstring ptr) as long
declare function pspell_config_have alias "aspell_config_have"(byval ths as const AspellConfig ptr, byval key as const zstring ptr) as long
declare function pspell_config_retrieve alias "aspell_config_retrieve"(byval ths as AspellConfig ptr, byval key as const zstring ptr) as const zstring ptr
declare function pspell_config_retrieve_list alias "aspell_config_retrieve_list"(byval ths as AspellConfig ptr, byval key as const zstring ptr, byval lst as AspellMutableContainer ptr) as long
declare function pspell_config_retrieve_bool alias "aspell_config_retrieve_bool"(byval ths as AspellConfig ptr, byval key as const zstring ptr) as long
declare function pspell_config_retrieve_int alias "aspell_config_retrieve_int"(byval ths as AspellConfig ptr, byval key as const zstring ptr) as long
type PspellStringMap as AspellStringMap
declare function new_pspell_string_map alias "new_aspell_string_map"() as AspellStringMap ptr
declare sub delete_pspell_string_map alias "delete_aspell_string_map"(byval ths as AspellStringMap ptr)
declare function pspell_string_map_clone alias "aspell_string_map_clone"(byval ths as const AspellStringMap ptr) as AspellStringMap ptr
declare sub pspell_string_map_assign alias "aspell_string_map_assign"(byval ths as AspellStringMap ptr, byval other as const AspellStringMap ptr)
declare function pspell_string_map_elements alias "aspell_string_map_elements"(byval ths as const AspellStringMap ptr) as AspellStringPairEnumeration ptr
declare function pspell_string_map_insert alias "aspell_string_map_insert"(byval ths as AspellStringMap ptr, byval key as const zstring ptr, byval value as const zstring ptr) as long
declare function pspell_string_map_replace alias "aspell_string_map_replace"(byval ths as AspellStringMap ptr, byval key as const zstring ptr, byval value as const zstring ptr) as long
declare function pspell_string_map_remove alias "aspell_string_map_remove"(byval ths as AspellStringMap ptr, byval to_rem as const zstring ptr) as long
declare sub pspell_string_map_clear alias "aspell_string_map_clear"(byval ths as AspellStringMap ptr)
declare function pspell_string_map_lookup alias "aspell_string_map_lookup"(byval ths as const AspellStringMap ptr, byval key as const zstring ptr) as const zstring ptr
declare function pspell_string_map_size alias "aspell_string_map_size"(byval ths as const AspellStringMap ptr) as ulong
declare function pspell_string_map_empty alias "aspell_string_map_empty"(byval ths as const AspellStringMap ptr) as long
type PspellWordList as AspellWordList
#define pspell_word_list_encoding aspell_word_list_encoding
declare function pspell_word_list_empty alias "aspell_word_list_empty"(byval ths as const AspellWordList ptr) as long
declare function pspell_word_list_size alias "aspell_word_list_size"(byval ths as const AspellWordList ptr) as ulong
declare function pspell_word_list_elements alias "aspell_word_list_elements"(byval ths as const AspellWordList ptr) as AspellStringEnumeration ptr
type PspellManager as AspellSpeller
declare function new_pspell_manager alias "new_aspell_speller"(byval config as AspellConfig ptr) as AspellCanHaveError ptr
declare function to_pspell_manager alias "to_aspell_speller"(byval obj as AspellCanHaveError ptr) as AspellSpeller ptr
declare sub delete_pspell_manager alias "delete_aspell_speller"(byval ths as AspellSpeller ptr)
declare function pspell_manager_error_number alias "aspell_speller_error_number"(byval ths as const AspellSpeller ptr) as ulong
declare function pspell_manager_error_message alias "aspell_speller_error_message"(byval ths as const AspellSpeller ptr) as const zstring ptr
declare function pspell_manager_config alias "aspell_speller_config"(byval ths as AspellSpeller ptr) as AspellConfig ptr
declare function pspell_manager_master_word_list alias "aspell_speller_main_word_list"(byval ths as AspellSpeller ptr) as const AspellWordList ptr
declare function pspell_manager_personal_word_list alias "aspell_speller_personal_word_list"(byval ths as AspellSpeller ptr) as const AspellWordList ptr
declare function pspell_manager_session_word_list alias "aspell_speller_session_word_list"(byval ths as AspellSpeller ptr) as const AspellWordList ptr
declare function pspell_manager_save_all_word_lists alias "aspell_speller_save_all_word_lists"(byval ths as AspellSpeller ptr) as long
declare function pspell_manager_clear_session alias "aspell_speller_clear_session"(byval ths as AspellSpeller ptr) as long
declare function pspell_manager_check alias "aspell_speller_check"(byval ths as AspellSpeller ptr, byval word as const zstring ptr, byval word_size as long) as long
declare function pspell_manager_add_to_personal alias "aspell_speller_add_to_personal"(byval ths as AspellSpeller ptr, byval word as const zstring ptr, byval word_size as long) as long
declare function pspell_manager_add_to_session alias "aspell_speller_add_to_session"(byval ths as AspellSpeller ptr, byval word as const zstring ptr, byval word_size as long) as long
declare function pspell_manager_suggest alias "aspell_speller_suggest"(byval ths as AspellSpeller ptr, byval word as const zstring ptr, byval word_size as long) as const AspellWordList ptr
declare function pspell_manager_store_replacement alias "aspell_speller_store_replacement"(byval ths as AspellSpeller ptr, byval mis as const zstring ptr, byval mis_size as long, byval cor as const zstring ptr, byval cor_size as long) as long

end extern
