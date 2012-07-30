''
''
'' aspell -- header translated with help of SWIG FB wrapper
''
'' This file is part of The New Aspell
'' Copyright (C) 2001-2002 by Kevin Atkinson under the GNU LGPL
'' license version 2.0 or 2.1.  You should have received a copy of the
'' LGPL license along with this library if you did not you can find it
'' at http://www.gnu.org/
''
''
''
#ifndef __aspell_bi__
#define __aspell_bi__

#ifdef __FB_WIN32__
    #inclib "aspell-15"
#else
    #inclib "aspell"
#endif

union AspellTypeId
	num as uinteger
	str as zstring * 4
end union

type AspellMutableContainer as any

enum AspellKeyInfoType
	AspellKeyInfoString
	AspellKeyInfoInt
	AspellKeyInfoBool
	AspellKeyInfoList
end enum

type AspellKeyInfo
	name as zstring ptr
	type as AspellKeyInfoType
	def as zstring ptr
	desc as zstring ptr
	otherdata as zstring * 16
end type

type AspellKeyInfoEnumeration as any

type AspellConfig as any

type AspellErrorInfo
	isa as AspellErrorInfo ptr
	mesg as zstring ptr
	num_parms as uinteger
	parms as zstring * 3
end type

type AspellError
	mesg as zstring ptr
	err as AspellErrorInfo ptr
end type

type AspellCanHaveError as any

type AspellSpeller as any

type AspellFilter as any

type AspellToken
	offset as uinteger
	len as uinteger
end type

type AspellDocumentChecker as any

type AspellWordList as any

type AspellStringEnumeration as any

type AspellStringList as any

type AspellModuleInfo
	name as zstring ptr
	order_num as double
	lib_dir as zstring ptr
	dict_dirs as AspellStringList ptr
	dict_exts as AspellStringList ptr
end type

type AspellDictInfo
	name as zstring ptr
	code as zstring ptr
	jargon as zstring ptr
	size as integer
	size_str as zstring ptr
	module as AspellModuleInfo ptr
end type

type AspellModuleInfoList as any

type AspellDictInfoList as any

type AspellModuleInfoEnumeration as any

type AspellDictInfoEnumeration as any

type AspellStringMap as any

type AspellStringPair
	first as zstring ptr
	second as zstring ptr
end type

type AspellStringPairEnumeration as any

declare function aspell_mutable_container_add cdecl alias "aspell_mutable_container_add" (byval ths as AspellMutableContainer ptr, byval to_add as zstring ptr) as integer
declare function aspell_mutable_container_remove cdecl alias "aspell_mutable_container_remove" (byval ths as AspellMutableContainer ptr, byval to_rem as zstring ptr) as integer
declare sub aspell_mutable_container_clear cdecl alias "aspell_mutable_container_clear" (byval ths as AspellMutableContainer ptr)
declare function aspell_mutable_container_to_mutable_container cdecl alias "aspell_mutable_container_to_mutable_container" (byval ths as AspellMutableContainer ptr) as AspellMutableContainer ptr

declare function aspell_key_info_enumeration_at_end cdecl alias "aspell_key_info_enumeration_at_end" (byval ths as AspellKeyInfoEnumeration ptr) as integer
declare function aspell_key_info_enumeration_next cdecl alias "aspell_key_info_enumeration_next" (byval ths as AspellKeyInfoEnumeration ptr) as AspellKeyInfo ptr
declare sub delete_aspell_key_info_enumeration cdecl alias "delete_aspell_key_info_enumeration" (byval ths as AspellKeyInfoEnumeration ptr)
declare function aspell_key_info_enumeration_clone cdecl alias "aspell_key_info_enumeration_clone" (byval ths as AspellKeyInfoEnumeration ptr) as AspellKeyInfoEnumeration ptr
declare sub aspell_key_info_enumeration_assign cdecl alias "aspell_key_info_enumeration_assign" (byval ths as AspellKeyInfoEnumeration ptr, byval other as AspellKeyInfoEnumeration ptr)

declare function new_aspell_config cdecl alias "new_aspell_config" () as AspellConfig ptr
declare sub delete_aspell_config cdecl alias "delete_aspell_config" (byval ths as AspellConfig ptr)
declare function aspell_config_clone cdecl alias "aspell_config_clone" (byval ths as AspellConfig ptr) as AspellConfig ptr
declare sub aspell_config_assign cdecl alias "aspell_config_assign" (byval ths as AspellConfig ptr, byval other as AspellConfig ptr)
declare function aspell_config_error_number cdecl alias "aspell_config_error_number" (byval ths as AspellConfig ptr) as uinteger
declare function aspell_config_error_message cdecl alias "aspell_config_error_message" (byval ths as AspellConfig ptr) as zstring ptr
declare function aspell_config_error cdecl alias "aspell_config_error" (byval ths as AspellConfig ptr) as AspellError ptr
declare sub aspell_config_set_extra cdecl alias "aspell_config_set_extra" (byval ths as AspellConfig ptr, byval begin as AspellKeyInfo ptr, byval end as AspellKeyInfo ptr)
declare function aspell_config_keyinfo cdecl alias "aspell_config_keyinfo" (byval ths as AspellConfig ptr, byval key as zstring ptr) as AspellKeyInfo ptr
declare function aspell_config_possible_elements cdecl alias "aspell_config_possible_elements" (byval ths as AspellConfig ptr, byval include_extra as integer) as AspellKeyInfoEnumeration ptr
declare function aspell_config_get_default cdecl alias "aspell_config_get_default" (byval ths as AspellConfig ptr, byval key as zstring ptr) as zstring ptr
declare function aspell_config_elements cdecl alias "aspell_config_elements" (byval ths as AspellConfig ptr) as AspellStringPairEnumeration ptr
declare function aspell_config_replace cdecl alias "aspell_config_replace" (byval ths as AspellConfig ptr, byval key as zstring ptr, byval value as zstring ptr) as integer
declare function aspell_config_remove cdecl alias "aspell_config_remove" (byval ths as AspellConfig ptr, byval key as zstring ptr) as integer
declare function aspell_config_have cdecl alias "aspell_config_have" (byval ths as AspellConfig ptr, byval key as zstring ptr) as integer
declare function aspell_config_retrieve cdecl alias "aspell_config_retrieve" (byval ths as AspellConfig ptr, byval key as zstring ptr) as zstring ptr
declare function aspell_config_retrieve_list cdecl alias "aspell_config_retrieve_list" (byval ths as AspellConfig ptr, byval key as zstring ptr, byval lst as AspellMutableContainer ptr) as integer
declare function aspell_config_retrieve_bool cdecl alias "aspell_config_retrieve_bool" (byval ths as AspellConfig ptr, byval key as zstring ptr) as integer
declare function aspell_config_retrieve_int cdecl alias "aspell_config_retrieve_int" (byval ths as AspellConfig ptr, byval key as zstring ptr) as integer

declare function aspell_error_is_a cdecl alias "aspell_error_is_a" (byval ths as AspellError ptr, byval e as AspellErrorInfo ptr) as integer

declare function aspell_error_number cdecl alias "aspell_error_number" (byval ths as AspellCanHaveError ptr) as uinteger
declare function aspell_error_message cdecl alias "aspell_error_message" (byval ths as AspellCanHaveError ptr) as zstring ptr
declare function aspell_error cdecl alias "aspell_error" (byval ths as AspellCanHaveError ptr) as AspellError ptr
declare sub delete_aspell_can_have_error cdecl alias "delete_aspell_can_have_error" (byval ths as AspellCanHaveError ptr)
extern aerror_other alias "aerror_other" as AspellErrorInfo ptr
extern aerror_operation_not_supported alias "aerror_operation_not_supported" as AspellErrorInfo ptr
extern aerror_cant_copy alias "aerror_cant_copy" as AspellErrorInfo ptr
extern aerror_file alias "aerror_file" as AspellErrorInfo ptr
extern aerror_cant_open_file alias "aerror_cant_open_file" as AspellErrorInfo ptr
extern aerror_cant_read_file alias "aerror_cant_read_file" as AspellErrorInfo ptr
extern aerror_cant_write_file alias "aerror_cant_write_file" as AspellErrorInfo ptr
extern aerror_invalid_name alias "aerror_invalid_name" as AspellErrorInfo ptr
extern aerror_bad_file_format alias "aerror_bad_file_format" as AspellErrorInfo ptr
extern aerror_dir alias "aerror_dir" as AspellErrorInfo ptr
extern aerror_cant_read_dir alias "aerror_cant_read_dir" as AspellErrorInfo ptr
extern aerror_config alias "aerror_config" as AspellErrorInfo ptr
extern aerror_unknown_key alias "aerror_unknown_key" as AspellErrorInfo ptr
extern aerror_cant_change_value alias "aerror_cant_change_value" as AspellErrorInfo ptr
extern aerror_bad_key alias "aerror_bad_key" as AspellErrorInfo ptr
extern aerror_bad_value alias "aerror_bad_value" as AspellErrorInfo ptr
extern aerror_duplicate alias "aerror_duplicate" as AspellErrorInfo ptr
extern aerror_language_related alias "aerror_language_related" as AspellErrorInfo ptr
extern aerror_unknown_language alias "aerror_unknown_language" as AspellErrorInfo ptr
extern aerror_unknown_soundslike alias "aerror_unknown_soundslike" as AspellErrorInfo ptr
extern aerror_language_not_supported alias "aerror_language_not_supported" as AspellErrorInfo ptr
extern aerror_no_wordlist_for_lang alias "aerror_no_wordlist_for_lang" as AspellErrorInfo ptr
extern aerror_mismatched_language alias "aerror_mismatched_language" as AspellErrorInfo ptr
extern aerror_encoding alias "aerror_encoding" as AspellErrorInfo ptr
extern aerror_unknown_encoding alias "aerror_unknown_encoding" as AspellErrorInfo ptr
extern aerror_encoding_not_supported alias "aerror_encoding_not_supported" as AspellErrorInfo ptr
extern aerror_conversion_not_supported alias "aerror_conversion_not_supported" as AspellErrorInfo ptr
extern aerror_pipe alias "aerror_pipe" as AspellErrorInfo ptr
extern aerror_cant_create_pipe alias "aerror_cant_create_pipe" as AspellErrorInfo ptr
extern aerror_process_died alias "aerror_process_died" as AspellErrorInfo ptr
extern aerror_bad_input alias "aerror_bad_input" as AspellErrorInfo ptr
extern aerror_invalid_word alias "aerror_invalid_word" as AspellErrorInfo ptr
extern aerror_word_list_flags alias "aerror_word_list_flags" as AspellErrorInfo ptr
extern aerror_invalid_flag alias "aerror_invalid_flag" as AspellErrorInfo ptr
extern aerror_conflicting_flags alias "aerror_conflicting_flags" as AspellErrorInfo ptr

declare function new_aspell_speller cdecl alias "new_aspell_speller" (byval config as AspellConfig ptr) as AspellCanHaveError ptr
declare function to_aspell_speller cdecl alias "to_aspell_speller" (byval obj as AspellCanHaveError ptr) as AspellSpeller ptr
declare sub delete_aspell_speller cdecl alias "delete_aspell_speller" (byval ths as AspellSpeller ptr)
declare function aspell_speller_error_number cdecl alias "aspell_speller_error_number" (byval ths as AspellSpeller ptr) as uinteger
declare function aspell_speller_error_message cdecl alias "aspell_speller_error_message" (byval ths as AspellSpeller ptr) as zstring ptr
declare function aspell_speller_error cdecl alias "aspell_speller_error" (byval ths as AspellSpeller ptr) as AspellError ptr
declare function aspell_speller_config cdecl alias "aspell_speller_config" (byval ths as AspellSpeller ptr) as AspellConfig ptr
declare function aspell_speller_check cdecl alias "aspell_speller_check" (byval ths as AspellSpeller ptr, byval word as zstring ptr, byval word_size as integer) as integer
declare function aspell_speller_add_to_personal cdecl alias "aspell_speller_add_to_personal" (byval ths as AspellSpeller ptr, byval word as zstring ptr, byval word_size as integer) as integer
declare function aspell_speller_add_to_session cdecl alias "aspell_speller_add_to_session" (byval ths as AspellSpeller ptr, byval word as zstring ptr, byval word_size as integer) as integer
declare function aspell_speller_personal_word_list cdecl alias "aspell_speller_personal_word_list" (byval ths as AspellSpeller ptr) as AspellWordList ptr
declare function aspell_speller_session_word_list cdecl alias "aspell_speller_session_word_list" (byval ths as AspellSpeller ptr) as AspellWordList ptr
declare function aspell_speller_main_word_list cdecl alias "aspell_speller_main_word_list" (byval ths as AspellSpeller ptr) as AspellWordList ptr
declare function aspell_speller_save_all_word_lists cdecl alias "aspell_speller_save_all_word_lists" (byval ths as AspellSpeller ptr) as integer
declare function aspell_speller_clear_session cdecl alias "aspell_speller_clear_session" (byval ths as AspellSpeller ptr) as integer
declare function aspell_speller_suggest cdecl alias "aspell_speller_suggest" (byval ths as AspellSpeller ptr, byval word as zstring ptr, byval word_size as integer) as AspellWordList ptr
declare function aspell_speller_store_replacement cdecl alias "aspell_speller_store_replacement" (byval ths as AspellSpeller ptr, byval mis as zstring ptr, byval mis_size as integer, byval cor as zstring ptr, byval cor_size as integer) as integer

declare sub delete_aspell_filter cdecl alias "delete_aspell_filter" (byval ths as AspellFilter ptr)
declare function aspell_filter_error_number cdecl alias "aspell_filter_error_number" (byval ths as AspellFilter ptr) as uinteger
declare function aspell_filter_error_message cdecl alias "aspell_filter_error_message" (byval ths as AspellFilter ptr) as zstring ptr
declare function aspell_filter_error cdecl alias "aspell_filter_error" (byval ths as AspellFilter ptr) as AspellError ptr
declare function to_aspell_filter cdecl alias "to_aspell_filter" (byval obj as AspellCanHaveError ptr) as AspellFilter ptr

declare sub delete_aspell_document_checker cdecl alias "delete_aspell_document_checker" (byval ths as AspellDocumentChecker ptr)
declare function aspell_document_checker_error_number cdecl alias "aspell_document_checker_error_number" (byval ths as AspellDocumentChecker ptr) as uinteger
declare function aspell_document_checker_error_message cdecl alias "aspell_document_checker_error_message" (byval ths as AspellDocumentChecker ptr) as zstring ptr
declare function aspell_document_checker_error cdecl alias "aspell_document_checker_error" (byval ths as AspellDocumentChecker ptr) as AspellError ptr
declare function new_aspell_document_checker cdecl alias "new_aspell_document_checker" (byval speller as AspellSpeller ptr) as AspellCanHaveError ptr
declare function to_aspell_document_checker cdecl alias "to_aspell_document_checker" (byval obj as AspellCanHaveError ptr) as AspellDocumentChecker ptr
declare sub aspell_document_checker_reset cdecl alias "aspell_document_checker_reset" (byval ths as AspellDocumentChecker ptr)
declare sub aspell_document_checker_process cdecl alias "aspell_document_checker_process" (byval ths as AspellDocumentChecker ptr, byval str as zstring ptr, byval size as integer)
declare function aspell_document_checker_next_misspelling cdecl alias "aspell_document_checker_next_misspelling" (byval ths as AspellDocumentChecker ptr) as AspellToken
declare function aspell_document_checker_filter cdecl alias "aspell_document_checker_filter" (byval ths as AspellDocumentChecker ptr) as AspellFilter ptr

declare function aspell_word_list_empty cdecl alias "aspell_word_list_empty" (byval ths as AspellWordList ptr) as integer
declare function aspell_word_list_size cdecl alias "aspell_word_list_size" (byval ths as AspellWordList ptr) as uinteger
declare function aspell_word_list_elements cdecl alias "aspell_word_list_elements" (byval ths as AspellWordList ptr) as AspellStringEnumeration ptr

declare sub delete_aspell_string_enumeration cdecl alias "delete_aspell_string_enumeration" (byval ths as AspellStringEnumeration ptr)
declare function aspell_string_enumeration_clone cdecl alias "aspell_string_enumeration_clone" (byval ths as AspellStringEnumeration ptr) as AspellStringEnumeration ptr
declare sub aspell_string_enumeration_assign cdecl alias "aspell_string_enumeration_assign" (byval ths as AspellStringEnumeration ptr, byval other as AspellStringEnumeration ptr)
declare function aspell_string_enumeration_at_end cdecl alias "aspell_string_enumeration_at_end" (byval ths as AspellStringEnumeration ptr) as integer
declare function aspell_string_enumeration_next cdecl alias "aspell_string_enumeration_next" (byval ths as AspellStringEnumeration ptr) as zstring ptr

declare function get_aspell_module_info_list cdecl alias "get_aspell_module_info_list" (byval config as AspellConfig ptr) as AspellModuleInfoList ptr
declare function aspell_module_info_list_empty cdecl alias "aspell_module_info_list_empty" (byval ths as AspellModuleInfoList ptr) as integer
declare function aspell_module_info_list_size cdecl alias "aspell_module_info_list_size" (byval ths as AspellModuleInfoList ptr) as uinteger
declare function aspell_module_info_list_elements cdecl alias "aspell_module_info_list_elements" (byval ths as AspellModuleInfoList ptr) as AspellModuleInfoEnumeration ptr

declare function get_aspell_dict_info_list cdecl alias "get_aspell_dict_info_list" (byval config as AspellConfig ptr) as AspellDictInfoList ptr
declare function aspell_dict_info_list_empty cdecl alias "aspell_dict_info_list_empty" (byval ths as AspellDictInfoList ptr) as integer
declare function aspell_dict_info_list_size cdecl alias "aspell_dict_info_list_size" (byval ths as AspellDictInfoList ptr) as uinteger
declare function aspell_dict_info_list_elements cdecl alias "aspell_dict_info_list_elements" (byval ths as AspellDictInfoList ptr) as AspellDictInfoEnumeration ptr

declare function aspell_module_info_enumeration_at_end cdecl alias "aspell_module_info_enumeration_at_end" (byval ths as AspellModuleInfoEnumeration ptr) as integer
declare function aspell_module_info_enumeration_next cdecl alias "aspell_module_info_enumeration_next" (byval ths as AspellModuleInfoEnumeration ptr) as AspellModuleInfo ptr
declare sub delete_aspell_module_info_enumeration cdecl alias "delete_aspell_module_info_enumeration" (byval ths as AspellModuleInfoEnumeration ptr)
declare function aspell_module_info_enumeration_clone cdecl alias "aspell_module_info_enumeration_clone" (byval ths as AspellModuleInfoEnumeration ptr) as AspellModuleInfoEnumeration ptr
declare sub aspell_module_info_enumeration_assign cdecl alias "aspell_module_info_enumeration_assign" (byval ths as AspellModuleInfoEnumeration ptr, byval other as AspellModuleInfoEnumeration ptr)

declare function aspell_dict_info_enumeration_at_end cdecl alias "aspell_dict_info_enumeration_at_end" (byval ths as AspellDictInfoEnumeration ptr) as integer
declare function aspell_dict_info_enumeration_next cdecl alias "aspell_dict_info_enumeration_next" (byval ths as AspellDictInfoEnumeration ptr) as AspellDictInfo ptr
declare sub delete_aspell_dict_info_enumeration cdecl alias "delete_aspell_dict_info_enumeration" (byval ths as AspellDictInfoEnumeration ptr)
declare function aspell_dict_info_enumeration_clone cdecl alias "aspell_dict_info_enumeration_clone" (byval ths as AspellDictInfoEnumeration ptr) as AspellDictInfoEnumeration ptr
declare sub aspell_dict_info_enumeration_assign cdecl alias "aspell_dict_info_enumeration_assign" (byval ths as AspellDictInfoEnumeration ptr, byval other as AspellDictInfoEnumeration ptr)

declare function new_aspell_string_list cdecl alias "new_aspell_string_list" () as AspellStringList ptr
declare function aspell_string_list_empty cdecl alias "aspell_string_list_empty" (byval ths as AspellStringList ptr) as integer
declare function aspell_string_list_size cdecl alias "aspell_string_list_size" (byval ths as AspellStringList ptr) as uinteger
declare function aspell_string_list_elements cdecl alias "aspell_string_list_elements" (byval ths as AspellStringList ptr) as AspellStringEnumeration ptr
declare function aspell_string_list_add cdecl alias "aspell_string_list_add" (byval ths as AspellStringList ptr, byval to_add as zstring ptr) as integer
declare function aspell_string_list_remove cdecl alias "aspell_string_list_remove" (byval ths as AspellStringList ptr, byval to_rem as zstring ptr) as integer
declare sub aspell_string_list_clear cdecl alias "aspell_string_list_clear" (byval ths as AspellStringList ptr)
declare function aspell_string_list_to_mutable_container cdecl alias "aspell_string_list_to_mutable_container" (byval ths as AspellStringList ptr) as AspellMutableContainer ptr
declare sub delete_aspell_string_list cdecl alias "delete_aspell_string_list" (byval ths as AspellStringList ptr)
declare function aspell_string_list_clone cdecl alias "aspell_string_list_clone" (byval ths as AspellStringList ptr) as AspellStringList ptr
declare sub aspell_string_list_assign cdecl alias "aspell_string_list_assign" (byval ths as AspellStringList ptr, byval other as AspellStringList ptr)

declare function new_aspell_string_map cdecl alias "new_aspell_string_map" () as AspellStringMap ptr
declare function aspell_string_map_add cdecl alias "aspell_string_map_add" (byval ths as AspellStringMap ptr, byval to_add as zstring ptr) as integer
declare function aspell_string_map_remove cdecl alias "aspell_string_map_remove" (byval ths as AspellStringMap ptr, byval to_rem as zstring ptr) as integer
declare sub aspell_string_map_clear cdecl alias "aspell_string_map_clear" (byval ths as AspellStringMap ptr)
declare function aspell_string_map_to_mutable_container cdecl alias "aspell_string_map_to_mutable_container" (byval ths as AspellStringMap ptr) as AspellMutableContainer ptr
declare sub delete_aspell_string_map cdecl alias "delete_aspell_string_map" (byval ths as AspellStringMap ptr)
declare function aspell_string_map_clone cdecl alias "aspell_string_map_clone" (byval ths as AspellStringMap ptr) as AspellStringMap ptr
declare sub aspell_string_map_assign cdecl alias "aspell_string_map_assign" (byval ths as AspellStringMap ptr, byval other as AspellStringMap ptr)
declare function aspell_string_map_empty cdecl alias "aspell_string_map_empty" (byval ths as AspellStringMap ptr) as integer
declare function aspell_string_map_size cdecl alias "aspell_string_map_size" (byval ths as AspellStringMap ptr) as uinteger
declare function aspell_string_map_elements cdecl alias "aspell_string_map_elements" (byval ths as AspellStringMap ptr) as AspellStringPairEnumeration ptr
declare function aspell_string_map_insert cdecl alias "aspell_string_map_insert" (byval ths as AspellStringMap ptr, byval key as zstring ptr, byval value as zstring ptr) as integer
declare function aspell_string_map_replace cdecl alias "aspell_string_map_replace" (byval ths as AspellStringMap ptr, byval key as zstring ptr, byval value as zstring ptr) as integer
declare function aspell_string_map_lookup cdecl alias "aspell_string_map_lookup" (byval ths as AspellStringMap ptr, byval key as zstring ptr) as zstring ptr

declare function aspell_string_pair_enumeration_at_end cdecl alias "aspell_string_pair_enumeration_at_end" (byval ths as AspellStringPairEnumeration ptr) as integer
declare function aspell_string_pair_enumeration_next cdecl alias "aspell_string_pair_enumeration_next" (byval ths as AspellStringPairEnumeration ptr) as AspellStringPair
declare sub delete_aspell_string_pair_enumeration cdecl alias "delete_aspell_string_pair_enumeration" (byval ths as AspellStringPairEnumeration ptr)
declare function aspell_string_pair_enumeration_clone cdecl alias "aspell_string_pair_enumeration_clone" (byval ths as AspellStringPairEnumeration ptr) as AspellStringPairEnumeration ptr
declare sub aspell_string_pair_enumeration_assign cdecl alias "aspell_string_pair_enumeration_assign" (byval ths as AspellStringPairEnumeration ptr, byval other as AspellStringPairEnumeration ptr)

#endif
