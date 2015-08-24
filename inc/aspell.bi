'' FreeBASIC binding for aspell-0.60.6.1
''
'' based on the C header files:
''   This file is part of The New Aspell
''   Copyright (C) 2001-2002 by Kevin Atkinson under the GNU LGPL
''   license version 2.0 or 2.1.  You should have received a copy of the
''   LGPL license along with this library if you did not you can find it
''   at http://www.gnu.org/.                                              
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "aspell"

#if defined(__FB_WIN32__) or defined(__FB_UNIX__)
	#inclib "stdc++"
#endif

#ifdef __FB_WIN32__
	#inclib "pthread"
#elseif defined(__FB_DOS__)
	#inclib "stdcx"
#endif

extern "C"

#define ASPELL_ASPELL__H

union AspellTypeId
	num as ulong
	str as zstring * 4
end union

type AspellMutableContainer as AspellMutableContainer_
declare function aspell_mutable_container_add(byval ths as AspellMutableContainer ptr, byval to_add as const zstring ptr) as long
declare function aspell_mutable_container_remove(byval ths as AspellMutableContainer ptr, byval to_rem as const zstring ptr) as long
declare sub aspell_mutable_container_clear(byval ths as AspellMutableContainer ptr)
declare function aspell_mutable_container_to_mutable_container(byval ths as AspellMutableContainer ptr) as AspellMutableContainer ptr

type AspellKeyInfoType as long
enum
	AspellKeyInfoString
	AspellKeyInfoInt
	AspellKeyInfoBool
	AspellKeyInfoList
end enum

type AspellKeyInfo
	name as const zstring ptr
	as AspellKeyInfoType type
	def as const zstring ptr
	desc as const zstring ptr
	flags as long
	other_data as long
end type

type AspellKeyInfoEnumeration as AspellKeyInfoEnumeration_
declare function aspell_key_info_enumeration_at_end(byval ths as const AspellKeyInfoEnumeration ptr) as long
declare function aspell_key_info_enumeration_next(byval ths as AspellKeyInfoEnumeration ptr) as const AspellKeyInfo ptr
declare sub delete_aspell_key_info_enumeration(byval ths as AspellKeyInfoEnumeration ptr)
declare function aspell_key_info_enumeration_clone(byval ths as const AspellKeyInfoEnumeration ptr) as AspellKeyInfoEnumeration ptr
declare sub aspell_key_info_enumeration_assign(byval ths as AspellKeyInfoEnumeration ptr, byval other as const AspellKeyInfoEnumeration ptr)
type AspellConfig as AspellConfig_
declare function new_aspell_config() as AspellConfig ptr
declare sub delete_aspell_config(byval ths as AspellConfig ptr)
declare function aspell_config_clone(byval ths as const AspellConfig ptr) as AspellConfig ptr
declare sub aspell_config_assign(byval ths as AspellConfig ptr, byval other as const AspellConfig ptr)
declare function aspell_config_error_number(byval ths as const AspellConfig ptr) as ulong
declare function aspell_config_error_message(byval ths as const AspellConfig ptr) as const zstring ptr
type AspellError as AspellError_
declare function aspell_config_error(byval ths as const AspellConfig ptr) as const AspellError ptr
declare sub aspell_config_set_extra(byval ths as AspellConfig ptr, byval begin as const AspellKeyInfo ptr, byval end as const AspellKeyInfo ptr)
declare function aspell_config_keyinfo(byval ths as AspellConfig ptr, byval key as const zstring ptr) as const AspellKeyInfo ptr
declare function aspell_config_possible_elements(byval ths as AspellConfig ptr, byval include_extra as long) as AspellKeyInfoEnumeration ptr
declare function aspell_config_get_default(byval ths as AspellConfig ptr, byval key as const zstring ptr) as const zstring ptr
type AspellStringPairEnumeration as AspellStringPairEnumeration_
declare function aspell_config_elements(byval ths as AspellConfig ptr) as AspellStringPairEnumeration ptr
declare function aspell_config_replace(byval ths as AspellConfig ptr, byval key as const zstring ptr, byval value as const zstring ptr) as long
declare function aspell_config_remove(byval ths as AspellConfig ptr, byval key as const zstring ptr) as long
declare function aspell_config_have(byval ths as const AspellConfig ptr, byval key as const zstring ptr) as long
declare function aspell_config_retrieve(byval ths as AspellConfig ptr, byval key as const zstring ptr) as const zstring ptr
declare function aspell_config_retrieve_list(byval ths as AspellConfig ptr, byval key as const zstring ptr, byval lst as AspellMutableContainer ptr) as long
declare function aspell_config_retrieve_bool(byval ths as AspellConfig ptr, byval key as const zstring ptr) as long
declare function aspell_config_retrieve_int(byval ths as AspellConfig ptr, byval key as const zstring ptr) as long
type AspellErrorInfo as AspellErrorInfo_

type AspellError_
	mesg as const zstring ptr
	err as const AspellErrorInfo ptr
end type

declare function aspell_error_is_a(byval ths as const AspellError ptr, byval e as const AspellErrorInfo ptr) as long

type AspellErrorInfo_
	isa as const AspellErrorInfo ptr
	mesg as const zstring ptr
	num_parms as ulong
	parms(0 to 2) as const zstring ptr
end type

type AspellCanHaveError as AspellCanHaveError_
declare function aspell_error_number(byval ths as const AspellCanHaveError ptr) as ulong
declare function aspell_error_message(byval ths as const AspellCanHaveError ptr) as const zstring ptr
declare function aspell_error(byval ths as const AspellCanHaveError ptr) as const AspellError ptr
declare sub delete_aspell_can_have_error(byval ths as AspellCanHaveError ptr)

extern aerror_other as const AspellErrorInfo const ptr
extern aerror_operation_not_supported as const AspellErrorInfo const ptr
extern aerror_cant_copy as const AspellErrorInfo const ptr
extern aerror_unimplemented_method as const AspellErrorInfo const ptr
extern aerror_file as const AspellErrorInfo const ptr
extern aerror_cant_open_file as const AspellErrorInfo const ptr
extern aerror_cant_read_file as const AspellErrorInfo const ptr
extern aerror_cant_write_file as const AspellErrorInfo const ptr
extern aerror_invalid_name as const AspellErrorInfo const ptr
extern aerror_bad_file_format as const AspellErrorInfo const ptr
extern aerror_dir as const AspellErrorInfo const ptr
extern aerror_cant_read_dir as const AspellErrorInfo const ptr
extern aerror_config as const AspellErrorInfo const ptr
extern aerror_unknown_key as const AspellErrorInfo const ptr
extern aerror_cant_change_value as const AspellErrorInfo const ptr
extern aerror_bad_key as const AspellErrorInfo const ptr
extern aerror_bad_value as const AspellErrorInfo const ptr
extern aerror_duplicate as const AspellErrorInfo const ptr
extern aerror_key_not_string as const AspellErrorInfo const ptr
extern aerror_key_not_int as const AspellErrorInfo const ptr
extern aerror_key_not_bool as const AspellErrorInfo const ptr
extern aerror_key_not_list as const AspellErrorInfo const ptr
extern aerror_no_value_reset as const AspellErrorInfo const ptr
extern aerror_no_value_enable as const AspellErrorInfo const ptr
extern aerror_no_value_disable as const AspellErrorInfo const ptr
extern aerror_no_value_clear as const AspellErrorInfo const ptr
extern aerror_language_related as const AspellErrorInfo const ptr
extern aerror_unknown_language as const AspellErrorInfo const ptr
extern aerror_unknown_soundslike as const AspellErrorInfo const ptr
extern aerror_language_not_supported as const AspellErrorInfo const ptr
extern aerror_no_wordlist_for_lang as const AspellErrorInfo const ptr
extern aerror_mismatched_language as const AspellErrorInfo const ptr
extern aerror_affix as const AspellErrorInfo const ptr
extern aerror_corrupt_affix as const AspellErrorInfo const ptr
extern aerror_invalid_cond as const AspellErrorInfo const ptr
extern aerror_invalid_cond_strip as const AspellErrorInfo const ptr
extern aerror_incorrect_encoding as const AspellErrorInfo const ptr
extern aerror_encoding as const AspellErrorInfo const ptr
extern aerror_unknown_encoding as const AspellErrorInfo const ptr
extern aerror_encoding_not_supported as const AspellErrorInfo const ptr
extern aerror_conversion_not_supported as const AspellErrorInfo const ptr
extern aerror_pipe as const AspellErrorInfo const ptr
extern aerror_cant_create_pipe as const AspellErrorInfo const ptr
extern aerror_process_died as const AspellErrorInfo const ptr
extern aerror_bad_input as const AspellErrorInfo const ptr
extern aerror_invalid_string as const AspellErrorInfo const ptr
extern aerror_invalid_word as const AspellErrorInfo const ptr
extern aerror_invalid_affix as const AspellErrorInfo const ptr
extern aerror_inapplicable_affix as const AspellErrorInfo const ptr
extern aerror_unknown_unichar as const AspellErrorInfo const ptr
extern aerror_word_list_flags as const AspellErrorInfo const ptr
extern aerror_invalid_flag as const AspellErrorInfo const ptr
extern aerror_conflicting_flags as const AspellErrorInfo const ptr
extern aerror_version_control as const AspellErrorInfo const ptr
extern aerror_bad_version_string as const AspellErrorInfo const ptr
extern aerror_filter as const AspellErrorInfo const ptr
extern aerror_cant_dlopen_file as const AspellErrorInfo const ptr
extern aerror_empty_filter as const AspellErrorInfo const ptr
extern aerror_no_such_filter as const AspellErrorInfo const ptr
extern aerror_confusing_version as const AspellErrorInfo const ptr
extern aerror_bad_version as const AspellErrorInfo const ptr
extern aerror_identical_option as const AspellErrorInfo const ptr
extern aerror_options_only as const AspellErrorInfo const ptr
extern aerror_invalid_option_modifier as const AspellErrorInfo const ptr
extern aerror_cant_describe_filter as const AspellErrorInfo const ptr
extern aerror_filter_mode_file as const AspellErrorInfo const ptr
extern aerror_mode_option_name as const AspellErrorInfo const ptr
extern aerror_no_filter_to_option as const AspellErrorInfo const ptr
extern aerror_bad_mode_key as const AspellErrorInfo const ptr
extern aerror_expect_mode_key as const AspellErrorInfo const ptr
extern aerror_mode_version_requirement as const AspellErrorInfo const ptr
extern aerror_confusing_mode_version as const AspellErrorInfo const ptr
extern aerror_bad_mode_version as const AspellErrorInfo const ptr
extern aerror_missing_magic_expression as const AspellErrorInfo const ptr
extern aerror_empty_file_ext as const AspellErrorInfo const ptr
extern aerror_filter_mode_expand as const AspellErrorInfo const ptr
extern aerror_unknown_mode as const AspellErrorInfo const ptr
extern aerror_mode_extend_expand as const AspellErrorInfo const ptr
extern aerror_filter_mode_magic as const AspellErrorInfo const ptr
extern aerror_file_magic_pos as const AspellErrorInfo const ptr
extern aerror_file_magic_range as const AspellErrorInfo const ptr
extern aerror_missing_magic as const AspellErrorInfo const ptr
extern aerror_bad_magic as const AspellErrorInfo const ptr
extern aerror_expression as const AspellErrorInfo const ptr
extern aerror_invalid_expression as const AspellErrorInfo const ptr
declare function new_aspell_speller(byval config as AspellConfig ptr) as AspellCanHaveError ptr
type AspellSpeller as AspellSpeller_

declare function to_aspell_speller(byval obj as AspellCanHaveError ptr) as AspellSpeller ptr
declare sub delete_aspell_speller(byval ths as AspellSpeller ptr)
declare function aspell_speller_error_number(byval ths as const AspellSpeller ptr) as ulong
declare function aspell_speller_error_message(byval ths as const AspellSpeller ptr) as const zstring ptr
declare function aspell_speller_error(byval ths as const AspellSpeller ptr) as const AspellError ptr
declare function aspell_speller_config(byval ths as AspellSpeller ptr) as AspellConfig ptr
declare function aspell_speller_check(byval ths as AspellSpeller ptr, byval word as const zstring ptr, byval word_size as long) as long
declare function aspell_speller_add_to_personal(byval ths as AspellSpeller ptr, byval word as const zstring ptr, byval word_size as long) as long
declare function aspell_speller_add_to_session(byval ths as AspellSpeller ptr, byval word as const zstring ptr, byval word_size as long) as long
type AspellWordList as AspellWordList_
declare function aspell_speller_personal_word_list(byval ths as AspellSpeller ptr) as const AspellWordList ptr
declare function aspell_speller_session_word_list(byval ths as AspellSpeller ptr) as const AspellWordList ptr
declare function aspell_speller_main_word_list(byval ths as AspellSpeller ptr) as const AspellWordList ptr
declare function aspell_speller_save_all_word_lists(byval ths as AspellSpeller ptr) as long
declare function aspell_speller_clear_session(byval ths as AspellSpeller ptr) as long
declare function aspell_speller_suggest(byval ths as AspellSpeller ptr, byval word as const zstring ptr, byval word_size as long) as const AspellWordList ptr
declare function aspell_speller_store_replacement(byval ths as AspellSpeller ptr, byval mis as const zstring ptr, byval mis_size as long, byval cor as const zstring ptr, byval cor_size as long) as long
type AspellFilter as AspellFilter_
declare sub delete_aspell_filter(byval ths as AspellFilter ptr)
declare function aspell_filter_error_number(byval ths as const AspellFilter ptr) as ulong
declare function aspell_filter_error_message(byval ths as const AspellFilter ptr) as const zstring ptr
declare function aspell_filter_error(byval ths as const AspellFilter ptr) as const AspellError ptr
declare function to_aspell_filter(byval obj as AspellCanHaveError ptr) as AspellFilter ptr

type AspellToken
	offset as ulong
	len as ulong
end type

type AspellDocumentChecker as AspellDocumentChecker_
declare sub delete_aspell_document_checker(byval ths as AspellDocumentChecker ptr)
declare function aspell_document_checker_error_number(byval ths as const AspellDocumentChecker ptr) as ulong
declare function aspell_document_checker_error_message(byval ths as const AspellDocumentChecker ptr) as const zstring ptr
declare function aspell_document_checker_error(byval ths as const AspellDocumentChecker ptr) as const AspellError ptr
declare function new_aspell_document_checker(byval speller as AspellSpeller ptr) as AspellCanHaveError ptr
declare function to_aspell_document_checker(byval obj as AspellCanHaveError ptr) as AspellDocumentChecker ptr
declare sub aspell_document_checker_reset(byval ths as AspellDocumentChecker ptr)
declare sub aspell_document_checker_process(byval ths as AspellDocumentChecker ptr, byval str as const zstring ptr, byval size as long)
declare function aspell_document_checker_next_misspelling(byval ths as AspellDocumentChecker ptr) as AspellToken
declare function aspell_document_checker_filter(byval ths as AspellDocumentChecker ptr) as AspellFilter ptr
declare function aspell_word_list_empty(byval ths as const AspellWordList ptr) as long
declare function aspell_word_list_size(byval ths as const AspellWordList ptr) as ulong
type AspellStringEnumeration as AspellStringEnumeration_
declare function aspell_word_list_elements(byval ths as const AspellWordList ptr) as AspellStringEnumeration ptr
declare sub delete_aspell_string_enumeration(byval ths as AspellStringEnumeration ptr)
declare function aspell_string_enumeration_clone(byval ths as const AspellStringEnumeration ptr) as AspellStringEnumeration ptr
declare sub aspell_string_enumeration_assign(byval ths as AspellStringEnumeration ptr, byval other as const AspellStringEnumeration ptr)
declare function aspell_string_enumeration_at_end(byval ths as const AspellStringEnumeration ptr) as long
declare function aspell_string_enumeration_next(byval ths as AspellStringEnumeration ptr) as const zstring ptr
type AspellStringList as AspellStringList_

type AspellModuleInfo
	name as const zstring ptr
	order_num as double
	lib_dir as const zstring ptr
	dict_dirs as AspellStringList ptr
	dict_exts as AspellStringList ptr
end type

type AspellDictInfo
	name as const zstring ptr
	code as const zstring ptr
	jargon as const zstring ptr
	size as long
	size_str as const zstring ptr
	module as AspellModuleInfo ptr
end type

type AspellModuleInfoList as AspellModuleInfoList_
declare function get_aspell_module_info_list(byval config as AspellConfig ptr) as AspellModuleInfoList ptr
declare function aspell_module_info_list_empty(byval ths as const AspellModuleInfoList ptr) as long
declare function aspell_module_info_list_size(byval ths as const AspellModuleInfoList ptr) as ulong
type AspellModuleInfoEnumeration as AspellModuleInfoEnumeration_
declare function aspell_module_info_list_elements(byval ths as const AspellModuleInfoList ptr) as AspellModuleInfoEnumeration ptr
type AspellDictInfoList as AspellDictInfoList_
declare function get_aspell_dict_info_list(byval config as AspellConfig ptr) as AspellDictInfoList ptr
declare function aspell_dict_info_list_empty(byval ths as const AspellDictInfoList ptr) as long
declare function aspell_dict_info_list_size(byval ths as const AspellDictInfoList ptr) as ulong
type AspellDictInfoEnumeration as AspellDictInfoEnumeration_
declare function aspell_dict_info_list_elements(byval ths as const AspellDictInfoList ptr) as AspellDictInfoEnumeration ptr
declare function aspell_module_info_enumeration_at_end(byval ths as const AspellModuleInfoEnumeration ptr) as long
declare function aspell_module_info_enumeration_next(byval ths as AspellModuleInfoEnumeration ptr) as const AspellModuleInfo ptr
declare sub delete_aspell_module_info_enumeration(byval ths as AspellModuleInfoEnumeration ptr)
declare function aspell_module_info_enumeration_clone(byval ths as const AspellModuleInfoEnumeration ptr) as AspellModuleInfoEnumeration ptr
declare sub aspell_module_info_enumeration_assign(byval ths as AspellModuleInfoEnumeration ptr, byval other as const AspellModuleInfoEnumeration ptr)
declare function aspell_dict_info_enumeration_at_end(byval ths as const AspellDictInfoEnumeration ptr) as long
declare function aspell_dict_info_enumeration_next(byval ths as AspellDictInfoEnumeration ptr) as const AspellDictInfo ptr
declare sub delete_aspell_dict_info_enumeration(byval ths as AspellDictInfoEnumeration ptr)
declare function aspell_dict_info_enumeration_clone(byval ths as const AspellDictInfoEnumeration ptr) as AspellDictInfoEnumeration ptr
declare sub aspell_dict_info_enumeration_assign(byval ths as AspellDictInfoEnumeration ptr, byval other as const AspellDictInfoEnumeration ptr)
declare function new_aspell_string_list() as AspellStringList ptr
declare function aspell_string_list_empty(byval ths as const AspellStringList ptr) as long
declare function aspell_string_list_size(byval ths as const AspellStringList ptr) as ulong
declare function aspell_string_list_elements(byval ths as const AspellStringList ptr) as AspellStringEnumeration ptr
declare function aspell_string_list_add(byval ths as AspellStringList ptr, byval to_add as const zstring ptr) as long
declare function aspell_string_list_remove(byval ths as AspellStringList ptr, byval to_rem as const zstring ptr) as long
declare sub aspell_string_list_clear(byval ths as AspellStringList ptr)
declare function aspell_string_list_to_mutable_container(byval ths as AspellStringList ptr) as AspellMutableContainer ptr
declare sub delete_aspell_string_list(byval ths as AspellStringList ptr)
declare function aspell_string_list_clone(byval ths as const AspellStringList ptr) as AspellStringList ptr
declare sub aspell_string_list_assign(byval ths as AspellStringList ptr, byval other as const AspellStringList ptr)
type AspellStringMap as AspellStringMap_
declare function new_aspell_string_map() as AspellStringMap ptr
declare function aspell_string_map_add(byval ths as AspellStringMap ptr, byval to_add as const zstring ptr) as long
declare function aspell_string_map_remove(byval ths as AspellStringMap ptr, byval to_rem as const zstring ptr) as long
declare sub aspell_string_map_clear(byval ths as AspellStringMap ptr)
declare function aspell_string_map_to_mutable_container(byval ths as AspellStringMap ptr) as AspellMutableContainer ptr
declare sub delete_aspell_string_map(byval ths as AspellStringMap ptr)
declare function aspell_string_map_clone(byval ths as const AspellStringMap ptr) as AspellStringMap ptr
declare sub aspell_string_map_assign(byval ths as AspellStringMap ptr, byval other as const AspellStringMap ptr)
declare function aspell_string_map_empty(byval ths as const AspellStringMap ptr) as long
declare function aspell_string_map_size(byval ths as const AspellStringMap ptr) as ulong
declare function aspell_string_map_elements(byval ths as const AspellStringMap ptr) as AspellStringPairEnumeration ptr
declare function aspell_string_map_insert(byval ths as AspellStringMap ptr, byval key as const zstring ptr, byval value as const zstring ptr) as long
declare function aspell_string_map_replace(byval ths as AspellStringMap ptr, byval key as const zstring ptr, byval value as const zstring ptr) as long
declare function aspell_string_map_lookup(byval ths as const AspellStringMap ptr, byval key as const zstring ptr) as const zstring ptr

type AspellStringPair
	first as const zstring ptr
	second as const zstring ptr
end type

declare function aspell_string_pair_enumeration_at_end(byval ths as const AspellStringPairEnumeration ptr) as long
declare function aspell_string_pair_enumeration_next(byval ths as AspellStringPairEnumeration ptr) as AspellStringPair
declare sub delete_aspell_string_pair_enumeration(byval ths as AspellStringPairEnumeration ptr)
declare function aspell_string_pair_enumeration_clone(byval ths as const AspellStringPairEnumeration ptr) as AspellStringPairEnumeration ptr
declare sub aspell_string_pair_enumeration_assign(byval ths as AspellStringPairEnumeration ptr, byval other as const AspellStringPairEnumeration ptr)
declare function aspell_reset_cache(byval which as const zstring ptr) as long

end extern
