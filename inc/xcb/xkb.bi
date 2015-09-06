'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2009 Open Text Corporation.  All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is
''   furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in all
''   copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''   AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
''   ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
''   WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the names of the authors or their
''   institutions shall not be used in advertising or otherwise to promote the
''   sale, use or other dealings in this Software without prior written
''   authorization from the authors.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "xcb.bi"
#include once "xproto.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_XKB_USE_EXTENSION => XCB_XKB_USE_EXTENSION_
''     constant XCB_XKB_SELECT_EVENTS => XCB_XKB_SELECT_EVENTS_
''     constant XCB_XKB_BELL => XCB_XKB_BELL_
''     constant XCB_XKB_GET_STATE => XCB_XKB_GET_STATE_
''     constant XCB_XKB_LATCH_LOCK_STATE => XCB_XKB_LATCH_LOCK_STATE_
''     constant XCB_XKB_GET_CONTROLS => XCB_XKB_GET_CONTROLS_
''     constant XCB_XKB_SET_CONTROLS => XCB_XKB_SET_CONTROLS_
''     constant XCB_XKB_GET_MAP => XCB_XKB_GET_MAP_
''     constant XCB_XKB_SET_MAP => XCB_XKB_SET_MAP_
''     constant XCB_XKB_GET_COMPAT_MAP => XCB_XKB_GET_COMPAT_MAP_
''     constant XCB_XKB_SET_COMPAT_MAP => XCB_XKB_SET_COMPAT_MAP_
''     constant XCB_XKB_GET_INDICATOR_STATE => XCB_XKB_GET_INDICATOR_STATE_
''     constant XCB_XKB_GET_INDICATOR_MAP => XCB_XKB_GET_INDICATOR_MAP_
''     constant XCB_XKB_SET_INDICATOR_MAP => XCB_XKB_SET_INDICATOR_MAP_
''     constant XCB_XKB_GET_NAMED_INDICATOR => XCB_XKB_GET_NAMED_INDICATOR_
''     constant XCB_XKB_SET_NAMED_INDICATOR => XCB_XKB_SET_NAMED_INDICATOR_
''     constant XCB_XKB_GET_NAMES => XCB_XKB_GET_NAMES_
''     constant XCB_XKB_SET_NAMES => XCB_XKB_SET_NAMES_
''     constant XCB_XKB_PER_CLIENT_FLAGS => XCB_XKB_PER_CLIENT_FLAGS_
''     constant XCB_XKB_LIST_COMPONENTS => XCB_XKB_LIST_COMPONENTS_
''     constant XCB_XKB_GET_KBD_BY_NAME => XCB_XKB_GET_KBD_BY_NAME_
''     constant XCB_XKB_GET_DEVICE_INFO => XCB_XKB_GET_DEVICE_INFO_
''     constant XCB_XKB_SET_DEVICE_INFO => XCB_XKB_SET_DEVICE_INFO_
''     constant XCB_XKB_SET_DEBUGGING_FLAGS => XCB_XKB_SET_DEBUGGING_FLAGS_

extern "C"

#define __XKB_H
const XCB_XKB_MAJOR_VERSION = 1
const XCB_XKB_MINOR_VERSION = 0
extern xcb_xkb_id as xcb_extension_t

type xcb_xkb_const_t as long
enum
	XCB_XKB_CONST_MAX_LEGAL_KEY_CODE = 255
	XCB_XKB_CONST_PER_KEY_BIT_ARRAY_SIZE = 32
	XCB_XKB_CONST_KEY_NAME_LENGTH = 4
end enum

type xcb_xkb_event_type_t as long
enum
	XCB_XKB_EVENT_TYPE_NEW_KEYBOARD_NOTIFY = 1
	XCB_XKB_EVENT_TYPE_MAP_NOTIFY = 2
	XCB_XKB_EVENT_TYPE_STATE_NOTIFY = 4
	XCB_XKB_EVENT_TYPE_CONTROLS_NOTIFY = 8
	XCB_XKB_EVENT_TYPE_INDICATOR_STATE_NOTIFY = 16
	XCB_XKB_EVENT_TYPE_INDICATOR_MAP_NOTIFY = 32
	XCB_XKB_EVENT_TYPE_NAMES_NOTIFY = 64
	XCB_XKB_EVENT_TYPE_COMPAT_MAP_NOTIFY = 128
	XCB_XKB_EVENT_TYPE_BELL_NOTIFY = 256
	XCB_XKB_EVENT_TYPE_ACTION_MESSAGE = 512
	XCB_XKB_EVENT_TYPE_ACCESS_X_NOTIFY = 1024
	XCB_XKB_EVENT_TYPE_EXTENSION_DEVICE_NOTIFY = 2048
end enum

type xcb_xkb_nkn_detail_t as long
enum
	XCB_XKB_NKN_DETAIL_KEYCODES = 1
	XCB_XKB_NKN_DETAIL_GEOMETRY = 2
	XCB_XKB_NKN_DETAIL_DEVICE_ID = 4
end enum

type xcb_xkb_axn_detail_t as long
enum
	XCB_XKB_AXN_DETAIL_SK_PRESS = 1
	XCB_XKB_AXN_DETAIL_SK_ACCEPT = 2
	XCB_XKB_AXN_DETAIL_SK_REJECT = 4
	XCB_XKB_AXN_DETAIL_SK_RELEASE = 8
	XCB_XKB_AXN_DETAIL_BK_ACCEPT = 16
	XCB_XKB_AXN_DETAIL_BK_REJECT = 32
	XCB_XKB_AXN_DETAIL_AXK_WARNING = 64
end enum

type xcb_xkb_map_part_t as long
enum
	XCB_XKB_MAP_PART_KEY_TYPES = 1
	XCB_XKB_MAP_PART_KEY_SYMS = 2
	XCB_XKB_MAP_PART_MODIFIER_MAP = 4
	XCB_XKB_MAP_PART_EXPLICIT_COMPONENTS = 8
	XCB_XKB_MAP_PART_KEY_ACTIONS = 16
	XCB_XKB_MAP_PART_KEY_BEHAVIORS = 32
	XCB_XKB_MAP_PART_VIRTUAL_MODS = 64
	XCB_XKB_MAP_PART_VIRTUAL_MOD_MAP = 128
end enum

type xcb_xkb_set_map_flags_t as long
enum
	XCB_XKB_SET_MAP_FLAGS_RESIZE_TYPES = 1
	XCB_XKB_SET_MAP_FLAGS_RECOMPUTE_ACTIONS = 2
end enum

type xcb_xkb_state_part_t as long
enum
	XCB_XKB_STATE_PART_MODIFIER_STATE = 1
	XCB_XKB_STATE_PART_MODIFIER_BASE = 2
	XCB_XKB_STATE_PART_MODIFIER_LATCH = 4
	XCB_XKB_STATE_PART_MODIFIER_LOCK = 8
	XCB_XKB_STATE_PART_GROUP_STATE = 16
	XCB_XKB_STATE_PART_GROUP_BASE = 32
	XCB_XKB_STATE_PART_GROUP_LATCH = 64
	XCB_XKB_STATE_PART_GROUP_LOCK = 128
	XCB_XKB_STATE_PART_COMPAT_STATE = 256
	XCB_XKB_STATE_PART_GRAB_MODS = 512
	XCB_XKB_STATE_PART_COMPAT_GRAB_MODS = 1024
	XCB_XKB_STATE_PART_LOOKUP_MODS = 2048
	XCB_XKB_STATE_PART_COMPAT_LOOKUP_MODS = 4096
	XCB_XKB_STATE_PART_POINTER_BUTTONS = 8192
end enum

type xcb_xkb_bool_ctrl_t as long
enum
	XCB_XKB_BOOL_CTRL_REPEAT_KEYS = 1
	XCB_XKB_BOOL_CTRL_SLOW_KEYS = 2
	XCB_XKB_BOOL_CTRL_BOUNCE_KEYS = 4
	XCB_XKB_BOOL_CTRL_STICKY_KEYS = 8
	XCB_XKB_BOOL_CTRL_MOUSE_KEYS = 16
	XCB_XKB_BOOL_CTRL_MOUSE_KEYS_ACCEL = 32
	XCB_XKB_BOOL_CTRL_ACCESS_X_KEYS = 64
	XCB_XKB_BOOL_CTRL_ACCESS_X_TIMEOUT_MASK = 128
	XCB_XKB_BOOL_CTRL_ACCESS_X_FEEDBACK_MASK = 256
	XCB_XKB_BOOL_CTRL_AUDIBLE_BELL_MASK = 512
	XCB_XKB_BOOL_CTRL_OVERLAY_1_MASK = 1024
	XCB_XKB_BOOL_CTRL_OVERLAY_2_MASK = 2048
	XCB_XKB_BOOL_CTRL_IGNORE_GROUP_LOCK_MASK = 4096
end enum

type xcb_xkb_control_t as long
enum
	XCB_XKB_CONTROL_GROUPS_WRAP = 134217728
	XCB_XKB_CONTROL_INTERNAL_MODS = 268435456
	XCB_XKB_CONTROL_IGNORE_LOCK_MODS = 536870912
	XCB_XKB_CONTROL_PER_KEY_REPEAT = 1073741824
	XCB_XKB_CONTROL_CONTROLS_ENABLED = 2147483648
end enum

type xcb_xkb_ax_option_t as long
enum
	XCB_XKB_AX_OPTION_SK_PRESS_FB = 1
	XCB_XKB_AX_OPTION_SK_ACCEPT_FB = 2
	XCB_XKB_AX_OPTION_FEATURE_FB = 4
	XCB_XKB_AX_OPTION_SLOW_WARN_FB = 8
	XCB_XKB_AX_OPTION_INDICATOR_FB = 16
	XCB_XKB_AX_OPTION_STICKY_KEYS_FB = 32
	XCB_XKB_AX_OPTION_TWO_KEYS = 64
	XCB_XKB_AX_OPTION_LATCH_TO_LOCK = 128
	XCB_XKB_AX_OPTION_SK_RELEASE_FB = 256
	XCB_XKB_AX_OPTION_SK_REJECT_FB = 512
	XCB_XKB_AX_OPTION_BK_REJECT_FB = 1024
	XCB_XKB_AX_OPTION_DUMB_BELL = 2048
end enum

type xcb_xkb_device_spec_t as ushort

type xcb_xkb_device_spec_iterator_t
	data as xcb_xkb_device_spec_t ptr
	as long rem
	index as long
end type

type xcb_xkb_led_class_result_t as long
enum
	XCB_XKB_LED_CLASS_RESULT_KBD_FEEDBACK_CLASS = 0
	XCB_XKB_LED_CLASS_RESULT_LED_FEEDBACK_CLASS = 4
end enum

type xcb_xkb_led_class_t as long
enum
	XCB_XKB_LED_CLASS_KBD_FEEDBACK_CLASS = 0
	XCB_XKB_LED_CLASS_LED_FEEDBACK_CLASS = 4
	XCB_XKB_LED_CLASS_DFLT_XI_CLASS = 768
	XCB_XKB_LED_CLASS_ALL_XI_CLASSES = 1280
end enum

type xcb_xkb_led_class_spec_t as ushort

type xcb_xkb_led_class_spec_iterator_t
	data as xcb_xkb_led_class_spec_t ptr
	as long rem
	index as long
end type

type xcb_xkb_bell_class_result_t as long
enum
	XCB_XKB_BELL_CLASS_RESULT_KBD_FEEDBACK_CLASS = 0
	XCB_XKB_BELL_CLASS_RESULT_BELL_FEEDBACK_CLASS = 5
end enum

type xcb_xkb_bell_class_t as long
enum
	XCB_XKB_BELL_CLASS_KBD_FEEDBACK_CLASS = 0
	XCB_XKB_BELL_CLASS_BELL_FEEDBACK_CLASS = 5
	XCB_XKB_BELL_CLASS_DFLT_XI_CLASS = 768
end enum

type xcb_xkb_bell_class_spec_t as ushort

type xcb_xkb_bell_class_spec_iterator_t
	data as xcb_xkb_bell_class_spec_t ptr
	as long rem
	index as long
end type

type xcb_xkb_id_t as long
enum
	XCB_XKB_ID_USE_CORE_KBD = 256
	XCB_XKB_ID_USE_CORE_PTR = 512
	XCB_XKB_ID_DFLT_XI_CLASS = 768
	XCB_XKB_ID_DFLT_XI_ID = 1024
	XCB_XKB_ID_ALL_XI_CLASS = 1280
	XCB_XKB_ID_ALL_XI_ID = 1536
	XCB_XKB_ID_XI_NONE = 65280
end enum

type xcb_xkb_id_spec_t as ushort

type xcb_xkb_id_spec_iterator_t
	data as xcb_xkb_id_spec_t ptr
	as long rem
	index as long
end type

type xcb_xkb_group_t as long
enum
	XCB_XKB_GROUP_1 = 0
	XCB_XKB_GROUP_2 = 1
	XCB_XKB_GROUP_3 = 2
	XCB_XKB_GROUP_4 = 3
end enum

type xcb_xkb_groups_t as long
enum
	XCB_XKB_GROUPS_ANY = 254
	XCB_XKB_GROUPS_ALL = 255
end enum

type xcb_xkb_set_of_group_t as long
enum
	XCB_XKB_SET_OF_GROUP_GROUP_1 = 1
	XCB_XKB_SET_OF_GROUP_GROUP_2 = 2
	XCB_XKB_SET_OF_GROUP_GROUP_3 = 4
	XCB_XKB_SET_OF_GROUP_GROUP_4 = 8
end enum

type xcb_xkb_set_of_groups_t as long
enum
	XCB_XKB_SET_OF_GROUPS_ANY = 128
end enum

type xcb_xkb_groups_wrap_t as long
enum
	XCB_XKB_GROUPS_WRAP_WRAP_INTO_RANGE = 0
	XCB_XKB_GROUPS_WRAP_CLAMP_INTO_RANGE = 64
	XCB_XKB_GROUPS_WRAP_REDIRECT_INTO_RANGE = 128
end enum

type xcb_xkb_v_mods_high_t as long
enum
	XCB_XKB_V_MODS_HIGH_15 = 128
	XCB_XKB_V_MODS_HIGH_14 = 64
	XCB_XKB_V_MODS_HIGH_13 = 32
	XCB_XKB_V_MODS_HIGH_12 = 16
	XCB_XKB_V_MODS_HIGH_11 = 8
	XCB_XKB_V_MODS_HIGH_10 = 4
	XCB_XKB_V_MODS_HIGH_9 = 2
	XCB_XKB_V_MODS_HIGH_8 = 1
end enum

type xcb_xkb_v_mods_low_t as long
enum
	XCB_XKB_V_MODS_LOW_7 = 128
	XCB_XKB_V_MODS_LOW_6 = 64
	XCB_XKB_V_MODS_LOW_5 = 32
	XCB_XKB_V_MODS_LOW_4 = 16
	XCB_XKB_V_MODS_LOW_3 = 8
	XCB_XKB_V_MODS_LOW_2 = 4
	XCB_XKB_V_MODS_LOW_1 = 2
	XCB_XKB_V_MODS_LOW_0 = 1
end enum

type xcb_xkb_v_mod_t as long
enum
	XCB_XKB_V_MOD_15 = 32768
	XCB_XKB_V_MOD_14 = 16384
	XCB_XKB_V_MOD_13 = 8192
	XCB_XKB_V_MOD_12 = 4096
	XCB_XKB_V_MOD_11 = 2048
	XCB_XKB_V_MOD_10 = 1024
	XCB_XKB_V_MOD_9 = 512
	XCB_XKB_V_MOD_8 = 256
	XCB_XKB_V_MOD_7 = 128
	XCB_XKB_V_MOD_6 = 64
	XCB_XKB_V_MOD_5 = 32
	XCB_XKB_V_MOD_4 = 16
	XCB_XKB_V_MOD_3 = 8
	XCB_XKB_V_MOD_2 = 4
	XCB_XKB_V_MOD_1 = 2
	XCB_XKB_V_MOD_0 = 1
end enum

type xcb_xkb_explicit_t as long
enum
	XCB_XKB_EXPLICIT_V_MOD_MAP = 128
	XCB_XKB_EXPLICIT_BEHAVIOR = 64
	XCB_XKB_EXPLICIT_AUTO_REPEAT = 32
	XCB_XKB_EXPLICIT_INTERPRET = 16
	XCB_XKB_EXPLICIT_KEY_TYPE_4 = 8
	XCB_XKB_EXPLICIT_KEY_TYPE_3 = 4
	XCB_XKB_EXPLICIT_KEY_TYPE_2 = 2
	XCB_XKB_EXPLICIT_KEY_TYPE_1 = 1
end enum

type xcb_xkb_sym_interpret_match_t as long
enum
	XCB_XKB_SYM_INTERPRET_MATCH_NONE_OF = 0
	XCB_XKB_SYM_INTERPRET_MATCH_ANY_OF_OR_NONE = 1
	XCB_XKB_SYM_INTERPRET_MATCH_ANY_OF = 2
	XCB_XKB_SYM_INTERPRET_MATCH_ALL_OF = 3
	XCB_XKB_SYM_INTERPRET_MATCH_EXACTLY = 4
end enum

type xcb_xkb_sym_interp_match_t as long
enum
	XCB_XKB_SYM_INTERP_MATCH_LEVEL_ONE_ONLY = 128
	XCB_XKB_SYM_INTERP_MATCH_OP_MASK = 127
end enum

type xcb_xkb_im_flag_t as long
enum
	XCB_XKB_IM_FLAG_NO_EXPLICIT = 128
	XCB_XKB_IM_FLAG_NO_AUTOMATIC = 64
	XCB_XKB_IM_FLAG_LED_DRIVES_KB = 32
end enum

type xcb_xkb_im_mods_which_t as long
enum
	XCB_XKB_IM_MODS_WHICH_USE_COMPAT = 16
	XCB_XKB_IM_MODS_WHICH_USE_EFFECTIVE = 8
	XCB_XKB_IM_MODS_WHICH_USE_LOCKED = 4
	XCB_XKB_IM_MODS_WHICH_USE_LATCHED = 2
	XCB_XKB_IM_MODS_WHICH_USE_BASE = 1
end enum

type xcb_xkb_im_groups_which_t as long
enum
	XCB_XKB_IM_GROUPS_WHICH_USE_COMPAT = 16
	XCB_XKB_IM_GROUPS_WHICH_USE_EFFECTIVE = 8
	XCB_XKB_IM_GROUPS_WHICH_USE_LOCKED = 4
	XCB_XKB_IM_GROUPS_WHICH_USE_LATCHED = 2
	XCB_XKB_IM_GROUPS_WHICH_USE_BASE = 1
end enum

type xcb_xkb_indicator_map_t
	flags as ubyte
	whichGroups as ubyte
	groups as ubyte
	whichMods as ubyte
	mods as ubyte
	realMods as ubyte
	vmods as ushort
	ctrls as ulong
end type

type xcb_xkb_indicator_map_iterator_t
	data as xcb_xkb_indicator_map_t ptr
	as long rem
	index as long
end type

type xcb_xkb_cm_detail_t as long
enum
	XCB_XKB_CM_DETAIL_SYM_INTERP = 1
	XCB_XKB_CM_DETAIL_GROUP_COMPAT = 2
end enum

type xcb_xkb_name_detail_t as long
enum
	XCB_XKB_NAME_DETAIL_KEYCODES = 1
	XCB_XKB_NAME_DETAIL_GEOMETRY = 2
	XCB_XKB_NAME_DETAIL_SYMBOLS = 4
	XCB_XKB_NAME_DETAIL_PHYS_SYMBOLS = 8
	XCB_XKB_NAME_DETAIL_TYPES = 16
	XCB_XKB_NAME_DETAIL_COMPAT = 32
	XCB_XKB_NAME_DETAIL_KEY_TYPE_NAMES = 64
	XCB_XKB_NAME_DETAIL_KT_LEVEL_NAMES = 128
	XCB_XKB_NAME_DETAIL_INDICATOR_NAMES = 256
	XCB_XKB_NAME_DETAIL_KEY_NAMES = 512
	XCB_XKB_NAME_DETAIL_KEY_ALIASES = 1024
	XCB_XKB_NAME_DETAIL_VIRTUAL_MOD_NAMES = 2048
	XCB_XKB_NAME_DETAIL_GROUP_NAMES = 4096
	XCB_XKB_NAME_DETAIL_RG_NAMES = 8192
end enum

type xcb_xkb_gbn_detail_t as long
enum
	XCB_XKB_GBN_DETAIL_TYPES = 1
	XCB_XKB_GBN_DETAIL_COMPAT_MAP = 2
	XCB_XKB_GBN_DETAIL_CLIENT_SYMBOLS = 4
	XCB_XKB_GBN_DETAIL_SERVER_SYMBOLS = 8
	XCB_XKB_GBN_DETAIL_INDICATOR_MAPS = 16
	XCB_XKB_GBN_DETAIL_KEY_NAMES = 32
	XCB_XKB_GBN_DETAIL_GEOMETRY = 64
	XCB_XKB_GBN_DETAIL_OTHER_NAMES = 128
end enum

type xcb_xkb_xi_feature_t as long
enum
	XCB_XKB_XI_FEATURE_KEYBOARDS = 1
	XCB_XKB_XI_FEATURE_BUTTON_ACTIONS = 2
	XCB_XKB_XI_FEATURE_INDICATOR_NAMES = 4
	XCB_XKB_XI_FEATURE_INDICATOR_MAPS = 8
	XCB_XKB_XI_FEATURE_INDICATOR_STATE = 16
end enum

type xcb_xkb_per_client_flag_t as long
enum
	XCB_XKB_PER_CLIENT_FLAG_DETECTABLE_AUTO_REPEAT = 1
	XCB_XKB_PER_CLIENT_FLAG_GRABS_USE_XKB_STATE = 2
	XCB_XKB_PER_CLIENT_FLAG_AUTO_RESET_CONTROLS = 4
	XCB_XKB_PER_CLIENT_FLAG_LOOKUP_STATE_WHEN_GRABBED = 8
	XCB_XKB_PER_CLIENT_FLAG_SEND_EVENT_USES_XKB_STATE = 16
end enum

type xcb_xkb_mod_def_t
	mask as ubyte
	realMods as ubyte
	vmods as ushort
end type

type xcb_xkb_mod_def_iterator_t
	data as xcb_xkb_mod_def_t ptr
	as long rem
	index as long
end type

type xcb_xkb_key_name_t
	name as zstring * 4
end type

type xcb_xkb_key_name_iterator_t
	data as xcb_xkb_key_name_t ptr
	as long rem
	index as long
end type

type xcb_xkb_key_alias_t
	real as zstring * 4
	alias as zstring * 4
end type

type xcb_xkb_key_alias_iterator_t
	data as xcb_xkb_key_alias_t ptr
	as long rem
	index as long
end type

type xcb_xkb_counted_string_16_t
	length as ushort
end type

type xcb_xkb_counted_string_16_iterator_t
	data as xcb_xkb_counted_string_16_t ptr
	as long rem
	index as long
end type

type xcb_xkb_kt_map_entry_t
	active as ubyte
	mods_mask as ubyte
	level as ubyte
	mods_mods as ubyte
	mods_vmods as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_kt_map_entry_iterator_t
	data as xcb_xkb_kt_map_entry_t ptr
	as long rem
	index as long
end type

type xcb_xkb_key_type_t
	mods_mask as ubyte
	mods_mods as ubyte
	mods_vmods as ushort
	numLevels as ubyte
	nMapEntries as ubyte
	hasPreserve as ubyte
	pad0 as ubyte
end type

type xcb_xkb_key_type_iterator_t
	data as xcb_xkb_key_type_t ptr
	as long rem
	index as long
end type

type xcb_xkb_key_sym_map_t
	kt_index(0 to 3) as ubyte
	groupInfo as ubyte
	width as ubyte
	nSyms as ushort
end type

type xcb_xkb_key_sym_map_iterator_t
	data as xcb_xkb_key_sym_map_t ptr
	as long rem
	index as long
end type

type xcb_xkb_common_behavior_t
	as ubyte type
	data as ubyte
end type

type xcb_xkb_common_behavior_iterator_t
	data as xcb_xkb_common_behavior_t ptr
	as long rem
	index as long
end type

type xcb_xkb_default_behavior_t
	as ubyte type
	pad0 as ubyte
end type

type xcb_xkb_default_behavior_iterator_t
	data as xcb_xkb_default_behavior_t ptr
	as long rem
	index as long
end type

type xcb_xkb_lock_behavior_t
	as ubyte type
	pad0 as ubyte
end type

type xcb_xkb_lock_behavior_iterator_t
	data as xcb_xkb_lock_behavior_t ptr
	as long rem
	index as long
end type

type xcb_xkb_radio_group_behavior_t
	as ubyte type
	group as ubyte
end type

type xcb_xkb_radio_group_behavior_iterator_t
	data as xcb_xkb_radio_group_behavior_t ptr
	as long rem
	index as long
end type

type xcb_xkb_overlay_behavior_t
	as ubyte type
	key as xcb_keycode_t
end type

type xcb_xkb_overlay_behavior_iterator_t
	data as xcb_xkb_overlay_behavior_t ptr
	as long rem
	index as long
end type

type xcb_xkb_permament_lock_behavior_t
	as ubyte type
	pad0 as ubyte
end type

type xcb_xkb_permament_lock_behavior_iterator_t
	data as xcb_xkb_permament_lock_behavior_t ptr
	as long rem
	index as long
end type

type xcb_xkb_permament_radio_group_behavior_t
	as ubyte type
	group as ubyte
end type

type xcb_xkb_permament_radio_group_behavior_iterator_t
	data as xcb_xkb_permament_radio_group_behavior_t ptr
	as long rem
	index as long
end type

type xcb_xkb_permament_overlay_behavior_t
	as ubyte type
	key as xcb_keycode_t
end type

type xcb_xkb_permament_overlay_behavior_iterator_t
	data as xcb_xkb_permament_overlay_behavior_t ptr
	as long rem
	index as long
end type

union xcb_xkb_behavior_t
	common as xcb_xkb_common_behavior_t
	_default as xcb_xkb_default_behavior_t
	lock as xcb_xkb_lock_behavior_t
	radioGroup as xcb_xkb_radio_group_behavior_t
	overlay1 as xcb_xkb_overlay_behavior_t
	overlay2 as xcb_xkb_overlay_behavior_t
	permamentLock as xcb_xkb_permament_lock_behavior_t
	permamentRadioGroup as xcb_xkb_permament_radio_group_behavior_t
	permamentOverlay1 as xcb_xkb_permament_overlay_behavior_t
	permamentOverlay2 as xcb_xkb_permament_overlay_behavior_t
	as ubyte type
end union

type xcb_xkb_behavior_iterator_t
	data as xcb_xkb_behavior_t ptr
	as long rem
	index as long
end type

type xcb_xkb_behavior_type_t as long
enum
	XCB_XKB_BEHAVIOR_TYPE_DEFAULT = 0
	XCB_XKB_BEHAVIOR_TYPE_LOCK = 1
	XCB_XKB_BEHAVIOR_TYPE_RADIO_GROUP = 2
	XCB_XKB_BEHAVIOR_TYPE_OVERLAY_1 = 3
	XCB_XKB_BEHAVIOR_TYPE_OVERLAY_2 = 4
	XCB_XKB_BEHAVIOR_TYPE_PERMAMENT_LOCK = 129
	XCB_XKB_BEHAVIOR_TYPE_PERMAMENT_RADIO_GROUP = 130
	XCB_XKB_BEHAVIOR_TYPE_PERMAMENT_OVERLAY_1 = 131
	XCB_XKB_BEHAVIOR_TYPE_PERMAMENT_OVERLAY_2 = 132
end enum

type xcb_xkb_set_behavior_t
	keycode as xcb_keycode_t
	behavior as xcb_xkb_behavior_t
	pad0 as ubyte
end type

type xcb_xkb_set_behavior_iterator_t
	data as xcb_xkb_set_behavior_t ptr
	as long rem
	index as long
end type

type xcb_xkb_set_explicit_t
	keycode as xcb_keycode_t
	explicit as ubyte
end type

type xcb_xkb_set_explicit_iterator_t
	data as xcb_xkb_set_explicit_t ptr
	as long rem
	index as long
end type

type xcb_xkb_key_mod_map_t
	keycode as xcb_keycode_t
	mods as ubyte
end type

type xcb_xkb_key_mod_map_iterator_t
	data as xcb_xkb_key_mod_map_t ptr
	as long rem
	index as long
end type

type xcb_xkb_key_v_mod_map_t
	keycode as xcb_keycode_t
	pad0 as ubyte
	vmods as ushort
end type

type xcb_xkb_key_v_mod_map_iterator_t
	data as xcb_xkb_key_v_mod_map_t ptr
	as long rem
	index as long
end type

type xcb_xkb_kt_set_map_entry_t
	level as ubyte
	realMods as ubyte
	virtualMods as ushort
end type

type xcb_xkb_kt_set_map_entry_iterator_t
	data as xcb_xkb_kt_set_map_entry_t ptr
	as long rem
	index as long
end type

type xcb_xkb_set_key_type_t
	mask as ubyte
	realMods as ubyte
	virtualMods as ushort
	numLevels as ubyte
	nMapEntries as ubyte
	preserve as ubyte
	pad0 as ubyte
end type

type xcb_xkb_set_key_type_iterator_t
	data as xcb_xkb_set_key_type_t ptr
	as long rem
	index as long
end type

type xcb_xkb_string8_t as zstring

type xcb_xkb_string8_iterator_t
	data as xcb_xkb_string8_t ptr
	as long rem
	index as long
end type

type xcb_xkb_outline_t
	nPoints as ubyte
	cornerRadius as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_outline_iterator_t
	data as xcb_xkb_outline_t ptr
	as long rem
	index as long
end type

type xcb_xkb_shape_t
	name as xcb_atom_t
	nOutlines as ubyte
	primaryNdx as ubyte
	approxNdx as ubyte
	pad0 as ubyte
end type

type xcb_xkb_shape_iterator_t
	data as xcb_xkb_shape_t ptr
	as long rem
	index as long
end type

type xcb_xkb_key_t
	name as zstring * 4
	gap as short
	shapeNdx as ubyte
	colorNdx as ubyte
end type

type xcb_xkb_key_iterator_t
	data as xcb_xkb_key_t ptr
	as long rem
	index as long
end type

type xcb_xkb_overlay_key_t
	over as zstring * 4
	under as zstring * 4
end type

type xcb_xkb_overlay_key_iterator_t
	data as xcb_xkb_overlay_key_t ptr
	as long rem
	index as long
end type

type xcb_xkb_overlay_row_t
	rowUnder as ubyte
	nKeys as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_overlay_row_iterator_t
	data as xcb_xkb_overlay_row_t ptr
	as long rem
	index as long
end type

type xcb_xkb_overlay_t
	name as xcb_atom_t
	nRows as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_xkb_overlay_iterator_t
	data as xcb_xkb_overlay_t ptr
	as long rem
	index as long
end type

type xcb_xkb_row_t
	top as short
	left as short
	nKeys as ubyte
	vertical as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_row_iterator_t
	data as xcb_xkb_row_t ptr
	as long rem
	index as long
end type

type xcb_xkb_doodad_type_t as long
enum
	XCB_XKB_DOODAD_TYPE_OUTLINE = 1
	XCB_XKB_DOODAD_TYPE_SOLID = 2
	XCB_XKB_DOODAD_TYPE_TEXT = 3
	XCB_XKB_DOODAD_TYPE_INDICATOR = 4
	XCB_XKB_DOODAD_TYPE_LOGO = 5
end enum

type xcb_xkb_listing_t
	flags as ushort
	length as ushort
end type

type xcb_xkb_listing_iterator_t
	data as xcb_xkb_listing_t ptr
	as long rem
	index as long
end type

type xcb_xkb_device_led_info_t
	ledClass as xcb_xkb_led_class_spec_t
	ledID as xcb_xkb_id_spec_t
	namesPresent as ulong
	mapsPresent as ulong
	physIndicators as ulong
	state as ulong
end type

type xcb_xkb_device_led_info_iterator_t
	data as xcb_xkb_device_led_info_t ptr
	as long rem
	index as long
end type

type xcb_xkb_error_t as long
enum
	XCB_XKB_ERROR_BAD_DEVICE = 255
	XCB_XKB_ERROR_BAD_CLASS = 254
	XCB_XKB_ERROR_BAD_ID = 253
end enum

const XCB_XKB_KEYBOARD = 0

type xcb_xkb_keyboard_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
	value as ulong
	minorOpcode as ushort
	majorOpcode as ubyte
	pad0(0 to 20) as ubyte
end type

type xcb_xkb_sa_t as long
enum
	XCB_XKB_SA_CLEAR_LOCKS = 1
	XCB_XKB_SA_LATCH_TO_LOCK = 2
	XCB_XKB_SA_USE_MOD_MAP_MODS = 4
	XCB_XKB_SA_GROUP_ABSOLUTE = 4
end enum

type xcb_xkb_sa_type_t as long
enum
	XCB_XKB_SA_TYPE_NO_ACTION = 0
	XCB_XKB_SA_TYPE_SET_MODS = 1
	XCB_XKB_SA_TYPE_LATCH_MODS = 2
	XCB_XKB_SA_TYPE_LOCK_MODS = 3
	XCB_XKB_SA_TYPE_SET_GROUP = 4
	XCB_XKB_SA_TYPE_LATCH_GROUP = 5
	XCB_XKB_SA_TYPE_LOCK_GROUP = 6
	XCB_XKB_SA_TYPE_MOVE_PTR = 7
	XCB_XKB_SA_TYPE_PTR_BTN = 8
	XCB_XKB_SA_TYPE_LOCK_PTR_BTN = 9
	XCB_XKB_SA_TYPE_SET_PTR_DFLT = 10
	XCB_XKB_SA_TYPE_ISO_LOCK = 11
	XCB_XKB_SA_TYPE_TERMINATE = 12
	XCB_XKB_SA_TYPE_SWITCH_SCREEN = 13
	XCB_XKB_SA_TYPE_SET_CONTROLS = 14
	XCB_XKB_SA_TYPE_LOCK_CONTROLS = 15
	XCB_XKB_SA_TYPE_ACTION_MESSAGE = 16
	XCB_XKB_SA_TYPE_REDIRECT_KEY = 17
	XCB_XKB_SA_TYPE_DEVICE_BTN = 18
	XCB_XKB_SA_TYPE_LOCK_DEVICE_BTN = 19
	XCB_XKB_SA_TYPE_DEVICE_VALUATOR = 20
end enum

type xcb_xkb_sa_no_action_t
	as ubyte type
	pad0(0 to 6) as ubyte
end type

type xcb_xkb_sa_no_action_iterator_t
	data as xcb_xkb_sa_no_action_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_set_mods_t
	as ubyte type
	flags as ubyte
	mask as ubyte
	realMods as ubyte
	vmodsHigh as ubyte
	vmodsLow as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_sa_set_mods_iterator_t
	data as xcb_xkb_sa_set_mods_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_latch_mods_t
	as ubyte type
	flags as ubyte
	mask as ubyte
	realMods as ubyte
	vmodsHigh as ubyte
	vmodsLow as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_sa_latch_mods_iterator_t
	data as xcb_xkb_sa_latch_mods_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_lock_mods_t
	as ubyte type
	flags as ubyte
	mask as ubyte
	realMods as ubyte
	vmodsHigh as ubyte
	vmodsLow as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_sa_lock_mods_iterator_t
	data as xcb_xkb_sa_lock_mods_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_set_group_t
	as ubyte type
	flags as ubyte
	group as byte
	pad0(0 to 4) as ubyte
end type

type xcb_xkb_sa_set_group_iterator_t
	data as xcb_xkb_sa_set_group_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_latch_group_t
	as ubyte type
	flags as ubyte
	group as byte
	pad0(0 to 4) as ubyte
end type

type xcb_xkb_sa_latch_group_iterator_t
	data as xcb_xkb_sa_latch_group_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_lock_group_t
	as ubyte type
	flags as ubyte
	group as byte
	pad0(0 to 4) as ubyte
end type

type xcb_xkb_sa_lock_group_iterator_t
	data as xcb_xkb_sa_lock_group_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_move_ptr_flag_t as long
enum
	XCB_XKB_SA_MOVE_PTR_FLAG_NO_ACCELERATION = 1
	XCB_XKB_SA_MOVE_PTR_FLAG_MOVE_ABSOLUTE_X = 2
	XCB_XKB_SA_MOVE_PTR_FLAG_MOVE_ABSOLUTE_Y = 4
end enum

type xcb_xkb_sa_move_ptr_t
	as ubyte type
	flags as ubyte
	xHigh as byte
	xLow as ubyte
	yHigh as byte
	yLow as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_sa_move_ptr_iterator_t
	data as xcb_xkb_sa_move_ptr_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_ptr_btn_t
	as ubyte type
	flags as ubyte
	count as ubyte
	button as ubyte
	pad0(0 to 3) as ubyte
end type

type xcb_xkb_sa_ptr_btn_iterator_t
	data as xcb_xkb_sa_ptr_btn_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_lock_ptr_btn_t
	as ubyte type
	flags as ubyte
	pad0 as ubyte
	button as ubyte
	pad1(0 to 3) as ubyte
end type

type xcb_xkb_sa_lock_ptr_btn_iterator_t
	data as xcb_xkb_sa_lock_ptr_btn_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_set_ptr_dflt_flag_t as long
enum
	XCB_XKB_SA_SET_PTR_DFLT_FLAG_DFLT_BTN_ABSOLUTE = 4
	XCB_XKB_SA_SET_PTR_DFLT_FLAG_AFFECT_DFLT_BUTTON = 1
end enum

type xcb_xkb_sa_set_ptr_dflt_t
	as ubyte type
	flags as ubyte
	affect as ubyte
	value as byte
	pad0(0 to 3) as ubyte
end type

type xcb_xkb_sa_set_ptr_dflt_iterator_t
	data as xcb_xkb_sa_set_ptr_dflt_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_iso_lock_flag_t as long
enum
	XCB_XKB_SA_ISO_LOCK_FLAG_NO_LOCK = 1
	XCB_XKB_SA_ISO_LOCK_FLAG_NO_UNLOCK = 2
	XCB_XKB_SA_ISO_LOCK_FLAG_USE_MOD_MAP_MODS = 4
	XCB_XKB_SA_ISO_LOCK_FLAG_GROUP_ABSOLUTE = 4
	XCB_XKB_SA_ISO_LOCK_FLAG_ISO_DFLT_IS_GROUP = 8
end enum

type xcb_xkb_sa_iso_lock_no_affect_t as long
enum
	XCB_XKB_SA_ISO_LOCK_NO_AFFECT_CTRLS = 8
	XCB_XKB_SA_ISO_LOCK_NO_AFFECT_PTR = 16
	XCB_XKB_SA_ISO_LOCK_NO_AFFECT_GROUP = 32
	XCB_XKB_SA_ISO_LOCK_NO_AFFECT_MODS = 64
end enum

type xcb_xkb_sa_iso_lock_t
	as ubyte type
	flags as ubyte
	mask as ubyte
	realMods as ubyte
	group as byte
	affect as ubyte
	vmodsHigh as ubyte
	vmodsLow as ubyte
end type

type xcb_xkb_sa_iso_lock_iterator_t
	data as xcb_xkb_sa_iso_lock_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_terminate_t
	as ubyte type
	pad0(0 to 6) as ubyte
end type

type xcb_xkb_sa_terminate_iterator_t
	data as xcb_xkb_sa_terminate_t ptr
	as long rem
	index as long
end type

type xcb_xkb_switch_screen_flag_t as long
enum
	XCB_XKB_SWITCH_SCREEN_FLAG_APPLICATION = 1
	XCB_XKB_SWITCH_SCREEN_FLAG_ABSOLUTE = 4
end enum

type xcb_xkb_sa_switch_screen_t
	as ubyte type
	flags as ubyte
	newScreen as byte
	pad0(0 to 4) as ubyte
end type

type xcb_xkb_sa_switch_screen_iterator_t
	data as xcb_xkb_sa_switch_screen_t ptr
	as long rem
	index as long
end type

type xcb_xkb_bool_ctrls_high_t as long
enum
	XCB_XKB_BOOL_CTRLS_HIGH_ACCESS_X_FEEDBACK = 1
	XCB_XKB_BOOL_CTRLS_HIGH_AUDIBLE_BELL = 2
	XCB_XKB_BOOL_CTRLS_HIGH_OVERLAY_1 = 4
	XCB_XKB_BOOL_CTRLS_HIGH_OVERLAY_2 = 8
	XCB_XKB_BOOL_CTRLS_HIGH_IGNORE_GROUP_LOCK = 16
end enum

type xcb_xkb_bool_ctrls_low_t as long
enum
	XCB_XKB_BOOL_CTRLS_LOW_REPEAT_KEYS = 1
	XCB_XKB_BOOL_CTRLS_LOW_SLOW_KEYS = 2
	XCB_XKB_BOOL_CTRLS_LOW_BOUNCE_KEYS = 4
	XCB_XKB_BOOL_CTRLS_LOW_STICKY_KEYS = 8
	XCB_XKB_BOOL_CTRLS_LOW_MOUSE_KEYS = 16
	XCB_XKB_BOOL_CTRLS_LOW_MOUSE_KEYS_ACCEL = 32
	XCB_XKB_BOOL_CTRLS_LOW_ACCESS_X_KEYS = 64
	XCB_XKB_BOOL_CTRLS_LOW_ACCESS_X_TIMEOUT = 128
end enum

type xcb_xkb_sa_set_controls_t
	as ubyte type
	pad0(0 to 2) as ubyte
	boolCtrlsHigh as ubyte
	boolCtrlsLow as ubyte
	pad1(0 to 1) as ubyte
end type

type xcb_xkb_sa_set_controls_iterator_t
	data as xcb_xkb_sa_set_controls_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_lock_controls_t
	as ubyte type
	pad0(0 to 2) as ubyte
	boolCtrlsHigh as ubyte
	boolCtrlsLow as ubyte
	pad1(0 to 1) as ubyte
end type

type xcb_xkb_sa_lock_controls_iterator_t
	data as xcb_xkb_sa_lock_controls_t ptr
	as long rem
	index as long
end type

type xcb_xkb_action_message_flag_t as long
enum
	XCB_XKB_ACTION_MESSAGE_FLAG_ON_PRESS = 1
	XCB_XKB_ACTION_MESSAGE_FLAG_ON_RELEASE = 2
	XCB_XKB_ACTION_MESSAGE_FLAG_GEN_KEY_EVENT = 4
end enum

type xcb_xkb_sa_action_message_t
	as ubyte type
	flags as ubyte
	message(0 to 5) as ubyte
end type

type xcb_xkb_sa_action_message_iterator_t
	data as xcb_xkb_sa_action_message_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_redirect_key_t
	as ubyte type
	newkey as xcb_keycode_t
	mask as ubyte
	realModifiers as ubyte
	vmodsMaskHigh as ubyte
	vmodsMaskLow as ubyte
	vmodsHigh as ubyte
	vmodsLow as ubyte
end type

type xcb_xkb_sa_redirect_key_iterator_t
	data as xcb_xkb_sa_redirect_key_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_device_btn_t
	as ubyte type
	flags as ubyte
	count as ubyte
	button as ubyte
	device as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_xkb_sa_device_btn_iterator_t
	data as xcb_xkb_sa_device_btn_t ptr
	as long rem
	index as long
end type

type xcb_xkb_lock_device_flags_t as long
enum
	XCB_XKB_LOCK_DEVICE_FLAGS_NO_LOCK = 1
	XCB_XKB_LOCK_DEVICE_FLAGS_NO_UNLOCK = 2
end enum

type xcb_xkb_sa_lock_device_btn_t
	as ubyte type
	flags as ubyte
	pad0 as ubyte
	button as ubyte
	device as ubyte
	pad1(0 to 2) as ubyte
end type

type xcb_xkb_sa_lock_device_btn_iterator_t
	data as xcb_xkb_sa_lock_device_btn_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sa_val_what_t as long
enum
	XCB_XKB_SA_VAL_WHAT_IGNORE_VAL = 0
	XCB_XKB_SA_VAL_WHAT_SET_VAL_MIN = 1
	XCB_XKB_SA_VAL_WHAT_SET_VAL_CENTER = 2
	XCB_XKB_SA_VAL_WHAT_SET_VAL_MAX = 3
	XCB_XKB_SA_VAL_WHAT_SET_VAL_RELATIVE = 4
	XCB_XKB_SA_VAL_WHAT_SET_VAL_ABSOLUTE = 5
end enum

type xcb_xkb_sa_device_valuator_t
	as ubyte type
	device as ubyte
	val1what as ubyte
	val1index as ubyte
	val1value as ubyte
	val2what as ubyte
	val2index as ubyte
	val2value as ubyte
end type

type xcb_xkb_sa_device_valuator_iterator_t
	data as xcb_xkb_sa_device_valuator_t ptr
	as long rem
	index as long
end type

type xcb_xkb_si_action_t
	as ubyte type
	data(0 to 6) as ubyte
end type

type xcb_xkb_si_action_iterator_t
	data as xcb_xkb_si_action_t ptr
	as long rem
	index as long
end type

type xcb_xkb_sym_interpret_t
	sym as xcb_keysym_t
	mods as ubyte
	match as ubyte
	virtualMod as ubyte
	flags as ubyte
	action as xcb_xkb_si_action_t
end type

type xcb_xkb_sym_interpret_iterator_t
	data as xcb_xkb_sym_interpret_t ptr
	as long rem
	index as long
end type

union xcb_xkb_action_t
	noaction as xcb_xkb_sa_no_action_t
	setmods as xcb_xkb_sa_set_mods_t
	latchmods as xcb_xkb_sa_latch_mods_t
	lockmods as xcb_xkb_sa_lock_mods_t
	setgroup as xcb_xkb_sa_set_group_t
	latchgroup as xcb_xkb_sa_latch_group_t
	lockgroup as xcb_xkb_sa_lock_group_t
	moveptr as xcb_xkb_sa_move_ptr_t
	ptrbtn as xcb_xkb_sa_ptr_btn_t
	lockptrbtn as xcb_xkb_sa_lock_ptr_btn_t
	setptrdflt as xcb_xkb_sa_set_ptr_dflt_t
	isolock as xcb_xkb_sa_iso_lock_t
	terminate as xcb_xkb_sa_terminate_t
	switchscreen as xcb_xkb_sa_switch_screen_t
	setcontrols as xcb_xkb_sa_set_controls_t
	lockcontrols as xcb_xkb_sa_lock_controls_t
	message as xcb_xkb_sa_action_message_t
	redirect as xcb_xkb_sa_redirect_key_t
	devbtn as xcb_xkb_sa_device_btn_t
	lockdevbtn as xcb_xkb_sa_lock_device_btn_t
	devval as xcb_xkb_sa_device_valuator_t
	as ubyte type
end union

type xcb_xkb_action_iterator_t
	data as xcb_xkb_action_t ptr
	as long rem
	index as long
end type

type xcb_xkb_use_extension_cookie_t
	sequence as ulong
end type

const XCB_XKB_USE_EXTENSION_ = 0

type xcb_xkb_use_extension_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	wantedMajor as ushort
	wantedMinor as ushort
end type

type xcb_xkb_use_extension_reply_t
	response_type as ubyte
	supported as ubyte
	sequence as ushort
	length as ulong
	serverMajor as ushort
	serverMinor as ushort
	pad0(0 to 19) as ubyte
end type

type xcb_xkb_select_events_details_t
	affectNewKeyboard as ushort
	newKeyboardDetails as ushort
	affectState as ushort
	stateDetails as ushort
	affectCtrls as ulong
	ctrlDetails as ulong
	affectIndicatorState as ulong
	indicatorStateDetails as ulong
	affectIndicatorMap as ulong
	indicatorMapDetails as ulong
	affectNames as ushort
	namesDetails as ushort
	affectCompat as ubyte
	compatDetails as ubyte
	affectBell as ubyte
	bellDetails as ubyte
	affectMsgDetails as ubyte
	msgDetails as ubyte
	affectAccessX as ushort
	accessXDetails as ushort
	affectExtDev as ushort
	extdevDetails as ushort
end type

const XCB_XKB_SELECT_EVENTS_ = 1

type xcb_xkb_select_events_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	affectWhich as ushort
	clear as ushort
	selectAll as ushort
	affectMap as ushort
	map as ushort
end type

const XCB_XKB_BELL_ = 3

type xcb_xkb_bell_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	bellClass as xcb_xkb_bell_class_spec_t
	bellID as xcb_xkb_id_spec_t
	percent as byte
	forceSound as ubyte
	eventOnly as ubyte
	pad0 as ubyte
	pitch as short
	duration as short
	pad1(0 to 1) as ubyte
	name as xcb_atom_t
	window as xcb_window_t
end type

type xcb_xkb_get_state_cookie_t
	sequence as ulong
end type

const XCB_XKB_GET_STATE_ = 4

type xcb_xkb_get_state_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_get_state_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	mods as ubyte
	baseMods as ubyte
	latchedMods as ubyte
	lockedMods as ubyte
	group as ubyte
	lockedGroup as ubyte
	baseGroup as short
	latchedGroup as short
	compatState as ubyte
	grabMods as ubyte
	compatGrabMods as ubyte
	lookupMods as ubyte
	compatLookupMods as ubyte
	pad0 as ubyte
	ptrBtnState as ushort
	pad1(0 to 5) as ubyte
end type

const XCB_XKB_LATCH_LOCK_STATE_ = 5

type xcb_xkb_latch_lock_state_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	affectModLocks as ubyte
	modLocks as ubyte
	lockGroup as ubyte
	groupLock as ubyte
	affectModLatches as ubyte
	pad0 as ubyte
	pad1 as ubyte
	latchGroup as ubyte
	groupLatch as ushort
end type

type xcb_xkb_get_controls_cookie_t
	sequence as ulong
end type

const XCB_XKB_GET_CONTROLS_ = 6

type xcb_xkb_get_controls_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_get_controls_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	mouseKeysDfltBtn as ubyte
	numGroups as ubyte
	groupsWrap as ubyte
	internalModsMask as ubyte
	ignoreLockModsMask as ubyte
	internalModsRealMods as ubyte
	ignoreLockModsRealMods as ubyte
	pad0 as ubyte
	internalModsVmods as ushort
	ignoreLockModsVmods as ushort
	repeatDelay as ushort
	repeatInterval as ushort
	slowKeysDelay as ushort
	debounceDelay as ushort
	mouseKeysDelay as ushort
	mouseKeysInterval as ushort
	mouseKeysTimeToMax as ushort
	mouseKeysMaxSpeed as ushort
	mouseKeysCurve as short
	accessXOption as ushort
	accessXTimeout as ushort
	accessXTimeoutOptionsMask as ushort
	accessXTimeoutOptionsValues as ushort
	pad1(0 to 1) as ubyte
	accessXTimeoutMask as ulong
	accessXTimeoutValues as ulong
	enabledControls as ulong
	perKeyRepeat(0 to 31) as ubyte
end type

const XCB_XKB_SET_CONTROLS_ = 7

type xcb_xkb_set_controls_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	affectInternalRealMods as ubyte
	internalRealMods as ubyte
	affectIgnoreLockRealMods as ubyte
	ignoreLockRealMods as ubyte
	affectInternalVirtualMods as ushort
	internalVirtualMods as ushort
	affectIgnoreLockVirtualMods as ushort
	ignoreLockVirtualMods as ushort
	mouseKeysDfltBtn as ubyte
	groupsWrap as ubyte
	accessXOptions as ushort
	pad0(0 to 1) as ubyte
	affectEnabledControls as ulong
	enabledControls as ulong
	changeControls as ulong
	repeatDelay as ushort
	repeatInterval as ushort
	slowKeysDelay as ushort
	debounceDelay as ushort
	mouseKeysDelay as ushort
	mouseKeysInterval as ushort
	mouseKeysTimeToMax as ushort
	mouseKeysMaxSpeed as ushort
	mouseKeysCurve as short
	accessXTimeout as ushort
	accessXTimeoutMask as ulong
	accessXTimeoutValues as ulong
	accessXTimeoutOptionsMask as ushort
	accessXTimeoutOptionsValues as ushort
	perKeyRepeat(0 to 31) as ubyte
end type

type xcb_xkb_get_map_cookie_t
	sequence as ulong
end type

const XCB_XKB_GET_MAP_ = 8

type xcb_xkb_get_map_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	full as ushort
	partial as ushort
	firstType as ubyte
	nTypes as ubyte
	firstKeySym as xcb_keycode_t
	nKeySyms as ubyte
	firstKeyAction as xcb_keycode_t
	nKeyActions as ubyte
	firstKeyBehavior as xcb_keycode_t
	nKeyBehaviors as ubyte
	virtualMods as ushort
	firstKeyExplicit as xcb_keycode_t
	nKeyExplicit as ubyte
	firstModMapKey as xcb_keycode_t
	nModMapKeys as ubyte
	firstVModMapKey as xcb_keycode_t
	nVModMapKeys as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_get_map_map_t
	types_rtrn as xcb_xkb_key_type_t ptr
	syms_rtrn as xcb_xkb_key_sym_map_t ptr
	acts_rtrn_count as ubyte ptr
	pad2 as ubyte ptr
	acts_rtrn_acts as xcb_xkb_action_t ptr
	behaviors_rtrn as xcb_xkb_set_behavior_t ptr
	vmods_rtrn as ubyte ptr
	pad3 as ubyte ptr
	explicit_rtrn as xcb_xkb_set_explicit_t ptr
	pad4 as ubyte ptr
	modmap_rtrn as xcb_xkb_key_mod_map_t ptr
	pad5 as ubyte ptr
	vmodmap_rtrn as xcb_xkb_key_v_mod_map_t ptr
end type

type xcb_xkb_get_map_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	pad0(0 to 1) as ubyte
	minKeyCode as xcb_keycode_t
	maxKeyCode as xcb_keycode_t
	present as ushort
	firstType as ubyte
	nTypes as ubyte
	totalTypes as ubyte
	firstKeySym as xcb_keycode_t
	totalSyms as ushort
	nKeySyms as ubyte
	firstKeyAction as xcb_keycode_t
	totalActions as ushort
	nKeyActions as ubyte
	firstKeyBehavior as xcb_keycode_t
	nKeyBehaviors as ubyte
	totalKeyBehaviors as ubyte
	firstKeyExplicit as xcb_keycode_t
	nKeyExplicit as ubyte
	totalKeyExplicit as ubyte
	firstModMapKey as xcb_keycode_t
	nModMapKeys as ubyte
	totalModMapKeys as ubyte
	firstVModMapKey as xcb_keycode_t
	nVModMapKeys as ubyte
	totalVModMapKeys as ubyte
	pad1 as ubyte
	virtualMods as ushort
end type

type xcb_xkb_set_map_values_t
	types as xcb_xkb_set_key_type_t ptr
	syms as xcb_xkb_key_sym_map_t ptr
	actionsCount as ubyte ptr
	actions as xcb_xkb_action_t ptr
	behaviors as xcb_xkb_set_behavior_t ptr
	vmods as ubyte ptr
	explicit as xcb_xkb_set_explicit_t ptr
	modmap as xcb_xkb_key_mod_map_t ptr
	vmodmap as xcb_xkb_key_v_mod_map_t ptr
end type

const XCB_XKB_SET_MAP_ = 9

type xcb_xkb_set_map_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	present as ushort
	flags as ushort
	minKeyCode as xcb_keycode_t
	maxKeyCode as xcb_keycode_t
	firstType as ubyte
	nTypes as ubyte
	firstKeySym as xcb_keycode_t
	nKeySyms as ubyte
	totalSyms as ushort
	firstKeyAction as xcb_keycode_t
	nKeyActions as ubyte
	totalActions as ushort
	firstKeyBehavior as xcb_keycode_t
	nKeyBehaviors as ubyte
	totalKeyBehaviors as ubyte
	firstKeyExplicit as xcb_keycode_t
	nKeyExplicit as ubyte
	totalKeyExplicit as ubyte
	firstModMapKey as xcb_keycode_t
	nModMapKeys as ubyte
	totalModMapKeys as ubyte
	firstVModMapKey as xcb_keycode_t
	nVModMapKeys as ubyte
	totalVModMapKeys as ubyte
	virtualMods as ushort
end type

type xcb_xkb_get_compat_map_cookie_t
	sequence as ulong
end type

const XCB_XKB_GET_COMPAT_MAP_ = 10

type xcb_xkb_get_compat_map_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	groups as ubyte
	getAllSI as ubyte
	firstSI as ushort
	nSI as ushort
end type

type xcb_xkb_get_compat_map_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	groupsRtrn as ubyte
	pad0 as ubyte
	firstSIRtrn as ushort
	nSIRtrn as ushort
	nTotalSI as ushort
	pad1(0 to 15) as ubyte
end type

const XCB_XKB_SET_COMPAT_MAP_ = 11

type xcb_xkb_set_compat_map_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	pad0 as ubyte
	recomputeActions as ubyte
	truncateSI as ubyte
	groups as ubyte
	firstSI as ushort
	nSI as ushort
	pad1(0 to 1) as ubyte
end type

type xcb_xkb_get_indicator_state_cookie_t
	sequence as ulong
end type

const XCB_XKB_GET_INDICATOR_STATE_ = 12

type xcb_xkb_get_indicator_state_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	pad0(0 to 1) as ubyte
end type

type xcb_xkb_get_indicator_state_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	state as ulong
	pad0(0 to 19) as ubyte
end type

type xcb_xkb_get_indicator_map_cookie_t
	sequence as ulong
end type

const XCB_XKB_GET_INDICATOR_MAP_ = 13

type xcb_xkb_get_indicator_map_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	pad0(0 to 1) as ubyte
	which as ulong
end type

type xcb_xkb_get_indicator_map_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	which as ulong
	realIndicators as ulong
	nIndicators as ubyte
	pad0(0 to 14) as ubyte
end type

const XCB_XKB_SET_INDICATOR_MAP_ = 14

type xcb_xkb_set_indicator_map_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	pad0(0 to 1) as ubyte
	which as ulong
end type

type xcb_xkb_get_named_indicator_cookie_t
	sequence as ulong
end type

const XCB_XKB_GET_NAMED_INDICATOR_ = 15

type xcb_xkb_get_named_indicator_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	ledClass as xcb_xkb_led_class_spec_t
	ledID as xcb_xkb_id_spec_t
	pad0(0 to 1) as ubyte
	indicator as xcb_atom_t
end type

type xcb_xkb_get_named_indicator_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	indicator as xcb_atom_t
	found as ubyte
	on as ubyte
	realIndicator as ubyte
	ndx as ubyte
	map_flags as ubyte
	map_whichGroups as ubyte
	map_groups as ubyte
	map_whichMods as ubyte
	map_mods as ubyte
	map_realMods as ubyte
	map_vmod as ushort
	map_ctrls as ulong
	supported as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_XKB_SET_NAMED_INDICATOR_ = 16

type xcb_xkb_set_named_indicator_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	ledClass as xcb_xkb_led_class_spec_t
	ledID as xcb_xkb_id_spec_t
	pad0(0 to 1) as ubyte
	indicator as xcb_atom_t
	setState as ubyte
	on as ubyte
	setMap as ubyte
	createMap as ubyte
	pad1 as ubyte
	map_flags as ubyte
	map_whichGroups as ubyte
	map_groups as ubyte
	map_whichMods as ubyte
	map_realMods as ubyte
	map_vmods as ushort
	map_ctrls as ulong
end type

type xcb_xkb_get_names_cookie_t
	sequence as ulong
end type

const XCB_XKB_GET_NAMES_ = 17

type xcb_xkb_get_names_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	pad0(0 to 1) as ubyte
	which as ulong
end type

type xcb_xkb_get_names_value_list_t
	keycodesName as xcb_atom_t
	geometryName as xcb_atom_t
	symbolsName as xcb_atom_t
	physSymbolsName as xcb_atom_t
	typesName as xcb_atom_t
	compatName as xcb_atom_t
	typeNames as xcb_atom_t ptr
	nLevelsPerType as ubyte ptr
	alignment_pad as ubyte ptr
	ktLevelNames as xcb_atom_t ptr
	indicatorNames as xcb_atom_t ptr
	virtualModNames as xcb_atom_t ptr
	groups as xcb_atom_t ptr
	keyNames as xcb_xkb_key_name_t ptr
	keyAliases as xcb_xkb_key_alias_t ptr
	radioGroupNames as xcb_atom_t ptr
end type

type xcb_xkb_get_names_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	which as ulong
	minKeyCode as xcb_keycode_t
	maxKeyCode as xcb_keycode_t
	nTypes as ubyte
	groupNames as ubyte
	virtualMods as ushort
	firstKey as xcb_keycode_t
	nKeys as ubyte
	indicators as ulong
	nRadioGroups as ubyte
	nKeyAliases as ubyte
	nKTLevels as ushort
	pad0(0 to 3) as ubyte
end type

type xcb_xkb_set_names_values_t
	keycodesName as xcb_atom_t
	geometryName as xcb_atom_t
	symbolsName as xcb_atom_t
	physSymbolsName as xcb_atom_t
	typesName as xcb_atom_t
	compatName as xcb_atom_t
	typeNames as xcb_atom_t ptr
	nLevelsPerType as ubyte ptr
	ktLevelNames as xcb_atom_t ptr
	indicatorNames as xcb_atom_t ptr
	virtualModNames as xcb_atom_t ptr
	groups as xcb_atom_t ptr
	keyNames as xcb_xkb_key_name_t ptr
	keyAliases as xcb_xkb_key_alias_t ptr
	radioGroupNames as xcb_atom_t ptr
end type

const XCB_XKB_SET_NAMES_ = 18

type xcb_xkb_set_names_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	virtualMods as ushort
	which as ulong
	firstType as ubyte
	nTypes as ubyte
	firstKTLevelt as ubyte
	nKTLevels as ubyte
	indicators as ulong
	groupNames as ubyte
	nRadioGroups as ubyte
	firstKey as xcb_keycode_t
	nKeys as ubyte
	nKeyAliases as ubyte
	pad0 as ubyte
	totalKTLevelNames as ushort
end type

type xcb_xkb_per_client_flags_cookie_t
	sequence as ulong
end type

const XCB_XKB_PER_CLIENT_FLAGS_ = 21

type xcb_xkb_per_client_flags_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	pad0(0 to 1) as ubyte
	change as ulong
	value as ulong
	ctrlsToChange as ulong
	autoCtrls as ulong
	autoCtrlsValues as ulong
end type

type xcb_xkb_per_client_flags_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	supported as ulong
	value as ulong
	autoCtrls as ulong
	autoCtrlsValues as ulong
	pad0(0 to 7) as ubyte
end type

type xcb_xkb_list_components_cookie_t
	sequence as ulong
end type

const XCB_XKB_LIST_COMPONENTS_ = 22

type xcb_xkb_list_components_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	maxNames as ushort
end type

type xcb_xkb_list_components_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	nKeymaps as ushort
	nKeycodes as ushort
	nTypes as ushort
	nCompatMaps as ushort
	nSymbols as ushort
	nGeometries as ushort
	extra as ushort
	pad0(0 to 9) as ubyte
end type

type xcb_xkb_get_kbd_by_name_cookie_t
	sequence as ulong
end type

const XCB_XKB_GET_KBD_BY_NAME_ = 23

type xcb_xkb_get_kbd_by_name_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	need as ushort
	want as ushort
	load as ubyte
	pad0 as ubyte
end type

type xcb_xkb_get_kbd_by_name_replies_types_map_t
	types_rtrn as xcb_xkb_key_type_t ptr
	syms_rtrn as xcb_xkb_key_sym_map_t ptr
	acts_rtrn_count as ubyte ptr
	acts_rtrn_acts as xcb_xkb_action_t ptr
	behaviors_rtrn as xcb_xkb_set_behavior_t ptr
	vmods_rtrn as ubyte ptr
	explicit_rtrn as xcb_xkb_set_explicit_t ptr
	modmap_rtrn as xcb_xkb_key_mod_map_t ptr
	vmodmap_rtrn as xcb_xkb_key_v_mod_map_t ptr
end type

type xcb_xkb_get_kbd_by_name_replies_key_names_value_list_t
	keycodesName as xcb_atom_t
	geometryName as xcb_atom_t
	symbolsName as xcb_atom_t
	physSymbolsName as xcb_atom_t
	typesName as xcb_atom_t
	compatName as xcb_atom_t
	typeNames as xcb_atom_t ptr
	nLevelsPerType as ubyte ptr
	ktLevelNames as xcb_atom_t ptr
	indicatorNames as xcb_atom_t ptr
	virtualModNames as xcb_atom_t ptr
	groups as xcb_atom_t ptr
	keyNames as xcb_xkb_key_name_t ptr
	keyAliases as xcb_xkb_key_alias_t ptr
	radioGroupNames as xcb_atom_t ptr
end type

type _types
	getmap_type as ubyte
	typeDeviceID as ubyte
	getmap_sequence as ushort
	getmap_length as ulong
	pad1(0 to 1) as ubyte
	typeMinKeyCode as xcb_keycode_t
	typeMaxKeyCode as xcb_keycode_t
	present as ushort
	firstType as ubyte
	nTypes as ubyte
	totalTypes as ubyte
	firstKeySym as xcb_keycode_t
	totalSyms as ushort
	nKeySyms as ubyte
	firstKeyAction as xcb_keycode_t
	totalActions as ushort
	nKeyActions as ubyte
	firstKeyBehavior as xcb_keycode_t
	nKeyBehaviors as ubyte
	totalKeyBehaviors as ubyte
	firstKeyExplicit as xcb_keycode_t
	nKeyExplicit as ubyte
	totalKeyExplicit as ubyte
	firstModMapKey as xcb_keycode_t
	nModMapKeys as ubyte
	totalModMapKeys as ubyte
	firstVModMapKey as xcb_keycode_t
	nVModMapKeys as ubyte
	totalVModMapKeys as ubyte
	pad2 as ubyte
	virtualMods as ushort
	map as xcb_xkb_get_kbd_by_name_replies_types_map_t
end type

type _compat_map
	compatmap_type as ubyte
	compatDeviceID as ubyte
	compatmap_sequence as ushort
	compatmap_length as ulong
	groupsRtrn as ubyte
	pad3 as ubyte
	firstSIRtrn as ushort
	nSIRtrn as ushort
	nTotalSI as ushort
	pad4(0 to 15) as ubyte
	si_rtrn as xcb_xkb_sym_interpret_t ptr
	group_rtrn as xcb_xkb_mod_def_t ptr
end type

type _indicator_maps
	indicatormap_type as ubyte
	indicatorDeviceID as ubyte
	indicatormap_sequence as ushort
	indicatormap_length as ulong
	which as ulong
	realIndicators as ulong
	nIndicators as ubyte
	pad5(0 to 14) as ubyte
	maps as xcb_xkb_indicator_map_t ptr
end type

type _key_names
	keyname_type as ubyte
	keyDeviceID as ubyte
	keyname_sequence as ushort
	keyname_length as ulong
	which as ulong
	keyMinKeyCode as xcb_keycode_t
	keyMaxKeyCode as xcb_keycode_t
	nTypes as ubyte
	groupNames as ubyte
	virtualMods as ushort
	firstKey as xcb_keycode_t
	nKeys as ubyte
	indicators as ulong
	nRadioGroups as ubyte
	nKeyAliases as ubyte
	nKTLevels as ushort
	pad6(0 to 3) as ubyte
	valueList as xcb_xkb_get_kbd_by_name_replies_key_names_value_list_t
end type

type _geometry
	geometry_type as ubyte
	geometryDeviceID as ubyte
	geometry_sequence as ushort
	geometry_length as ulong
	name as xcb_atom_t
	geometryFound as ubyte
	pad7 as ubyte
	widthMM as ushort
	heightMM as ushort
	nProperties as ushort
	nColors as ushort
	nShapes as ushort
	nSections as ushort
	nDoodads as ushort
	nKeyAliases as ushort
	baseColorNdx as ubyte
	labelColorNdx as ubyte
	labelFont as xcb_xkb_counted_string_16_t ptr
end type

type xcb_xkb_get_kbd_by_name_replies_t
	types as _types
	compat_map as _compat_map
	indicator_maps as _indicator_maps
	key_names as _key_names
	geometry as _geometry
end type

declare function xcb_xkb_get_kbd_by_name_replies_types_map(byval R as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_get_kbd_by_name_replies_types_map_t ptr

type xcb_xkb_get_kbd_by_name_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	minKeyCode as xcb_keycode_t
	maxKeyCode as xcb_keycode_t
	loaded as ubyte
	newKeyboard as ubyte
	found as ushort
	reported as ushort
	pad0(0 to 15) as ubyte
end type

type xcb_xkb_get_device_info_cookie_t
	sequence as ulong
end type

const XCB_XKB_GET_DEVICE_INFO_ = 24

type xcb_xkb_get_device_info_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	wanted as ushort
	allButtons as ubyte
	firstButton as ubyte
	nButtons as ubyte
	pad0 as ubyte
	ledClass as xcb_xkb_led_class_spec_t
	ledID as xcb_xkb_id_spec_t
end type

type xcb_xkb_get_device_info_reply_t
	response_type as ubyte
	deviceID as ubyte
	sequence as ushort
	length as ulong
	present as ushort
	supported as ushort
	unsupported as ushort
	nDeviceLedFBs as ushort
	firstBtnWanted as ubyte
	nBtnsWanted as ubyte
	firstBtnRtrn as ubyte
	nBtnsRtrn as ubyte
	totalBtns as ubyte
	hasOwnState as ubyte
	dfltKbdFB as ushort
	dfltLedFB as ushort
	pad0(0 to 1) as ubyte
	devType as xcb_atom_t
	nameLen as ushort
end type

const XCB_XKB_SET_DEVICE_INFO_ = 25

type xcb_xkb_set_device_info_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	deviceSpec as xcb_xkb_device_spec_t
	firstBtn as ubyte
	nBtns as ubyte
	change as ushort
	nDeviceLedFBs as ushort
end type

type xcb_xkb_set_debugging_flags_cookie_t
	sequence as ulong
end type

const XCB_XKB_SET_DEBUGGING_FLAGS_ = 101

type xcb_xkb_set_debugging_flags_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	msgLength as ushort
	pad0(0 to 1) as ubyte
	affectFlags as ulong
	flags as ulong
	affectCtrls as ulong
	ctrls as ulong
end type

type xcb_xkb_set_debugging_flags_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	currentFlags as ulong
	currentCtrls as ulong
	supportedFlags as ulong
	supportedCtrls as ulong
	pad1(0 to 7) as ubyte
end type

const XCB_XKB_NEW_KEYBOARD_NOTIFY = 0

type xcb_xkb_new_keyboard_notify_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	oldDeviceID as ubyte
	minKeyCode as xcb_keycode_t
	maxKeyCode as xcb_keycode_t
	oldMinKeyCode as xcb_keycode_t
	oldMaxKeyCode as xcb_keycode_t
	requestMajor as ubyte
	requestMinor as ubyte
	changed as ushort
	pad0(0 to 13) as ubyte
end type

const XCB_XKB_MAP_NOTIFY = 1

type xcb_xkb_map_notify_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	ptrBtnActions as ubyte
	changed as ushort
	minKeyCode as xcb_keycode_t
	maxKeyCode as xcb_keycode_t
	firstType as ubyte
	nTypes as ubyte
	firstKeySym as xcb_keycode_t
	nKeySyms as ubyte
	firstKeyAct as xcb_keycode_t
	nKeyActs as ubyte
	firstKeyBehavior as xcb_keycode_t
	nKeyBehavior as ubyte
	firstKeyExplicit as xcb_keycode_t
	nKeyExplicit as ubyte
	firstModMapKey as xcb_keycode_t
	nModMapKeys as ubyte
	firstVModMapKey as xcb_keycode_t
	nVModMapKeys as ubyte
	virtualMods as ushort
	pad0(0 to 1) as ubyte
end type

const XCB_XKB_STATE_NOTIFY = 2

type xcb_xkb_state_notify_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	mods as ubyte
	baseMods as ubyte
	latchedMods as ubyte
	lockedMods as ubyte
	group as ubyte
	baseGroup as short
	latchedGroup as short
	lockedGroup as ubyte
	compatState as ubyte
	grabMods as ubyte
	compatGrabMods as ubyte
	lookupMods as ubyte
	compatLoockupMods as ubyte
	ptrBtnState as ushort
	changed as ushort
	keycode as xcb_keycode_t
	eventType as ubyte
	requestMajor as ubyte
	requestMinor as ubyte
end type

const XCB_XKB_CONTROLS_NOTIFY = 3

type xcb_xkb_controls_notify_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	numGroups as ubyte
	pad0(0 to 1) as ubyte
	changedControls as ulong
	enabledControls as ulong
	enabledControlChanges as ulong
	keycode as xcb_keycode_t
	eventType as ubyte
	requestMajor as ubyte
	requestMinor as ubyte
	pad1(0 to 3) as ubyte
end type

const XCB_XKB_INDICATOR_STATE_NOTIFY = 4

type xcb_xkb_indicator_state_notify_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	pad0(0 to 2) as ubyte
	state as ulong
	stateChanged as ulong
	pad1(0 to 11) as ubyte
end type

const XCB_XKB_INDICATOR_MAP_NOTIFY = 5

type xcb_xkb_indicator_map_notify_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	pad0(0 to 2) as ubyte
	state as ulong
	mapChanged as ulong
	pad1(0 to 11) as ubyte
end type

const XCB_XKB_NAMES_NOTIFY = 6

type xcb_xkb_names_notify_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	pad0 as ubyte
	changed as ushort
	firstType as ubyte
	nTypes as ubyte
	firstLevelName as ubyte
	nLevelNames as ubyte
	pad1 as ubyte
	nRadioGroups as ubyte
	nKeyAliases as ubyte
	changedGroupNames as ubyte
	changedVirtualMods as ushort
	firstKey as xcb_keycode_t
	nKeys as ubyte
	changedIndicators as ulong
	pad2(0 to 3) as ubyte
end type

const XCB_XKB_COMPAT_MAP_NOTIFY = 7

type xcb_xkb_compat_map_notify_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	changedGroups as ubyte
	firstSI as ushort
	nSI as ushort
	nTotalSI as ushort
	pad0(0 to 15) as ubyte
end type

const XCB_XKB_BELL_NOTIFY = 8

type xcb_xkb_bell_notify_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	bellClass as ubyte
	bellID as ubyte
	percent as ubyte
	pitch as ushort
	duration as ushort
	name as xcb_atom_t
	window as xcb_window_t
	eventOnly as ubyte
	pad0(0 to 6) as ubyte
end type

const XCB_XKB_ACTION_MESSAGE = 9

type xcb_xkb_action_message_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	keycode as xcb_keycode_t
	press as ubyte
	keyEventFollows as ubyte
	mods as ubyte
	group as ubyte
	message as zstring * 8
	pad0(0 to 9) as ubyte
end type

const XCB_XKB_ACCESS_X_NOTIFY = 10

type xcb_xkb_access_x_notify_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	keycode as xcb_keycode_t
	detailt as ushort
	slowKeysDelay as ushort
	debounceDelay as ushort
	pad0(0 to 15) as ubyte
end type

const XCB_XKB_EXTENSION_DEVICE_NOTIFY = 11

type xcb_xkb_extension_device_notify_event_t
	response_type as ubyte
	xkbType as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	deviceID as ubyte
	pad0 as ubyte
	reason as ushort
	ledClass as ushort
	ledID as ushort
	ledsDefined as ulong
	ledState as ulong
	firstButton as ubyte
	nButtons as ubyte
	supported as ushort
	unsupported as ushort
	pad1(0 to 1) as ubyte
end type

declare sub xcb_xkb_device_spec_next(byval i as xcb_xkb_device_spec_iterator_t ptr)
declare function xcb_xkb_device_spec_end(byval i as xcb_xkb_device_spec_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_led_class_spec_next(byval i as xcb_xkb_led_class_spec_iterator_t ptr)
declare function xcb_xkb_led_class_spec_end(byval i as xcb_xkb_led_class_spec_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_bell_class_spec_next(byval i as xcb_xkb_bell_class_spec_iterator_t ptr)
declare function xcb_xkb_bell_class_spec_end(byval i as xcb_xkb_bell_class_spec_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_id_spec_next(byval i as xcb_xkb_id_spec_iterator_t ptr)
declare function xcb_xkb_id_spec_end(byval i as xcb_xkb_id_spec_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_indicator_map_next(byval i as xcb_xkb_indicator_map_iterator_t ptr)
declare function xcb_xkb_indicator_map_end(byval i as xcb_xkb_indicator_map_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_mod_def_next(byval i as xcb_xkb_mod_def_iterator_t ptr)
declare function xcb_xkb_mod_def_end(byval i as xcb_xkb_mod_def_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_key_name_next(byval i as xcb_xkb_key_name_iterator_t ptr)
declare function xcb_xkb_key_name_end(byval i as xcb_xkb_key_name_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_key_alias_next(byval i as xcb_xkb_key_alias_iterator_t ptr)
declare function xcb_xkb_key_alias_end(byval i as xcb_xkb_key_alias_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_counted_string_16_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_counted_string_16_string(byval R as const xcb_xkb_counted_string_16_t ptr) as zstring ptr
declare function xcb_xkb_counted_string_16_string_length(byval R as const xcb_xkb_counted_string_16_t ptr) as long
declare function xcb_xkb_counted_string_16_string_end(byval R as const xcb_xkb_counted_string_16_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_counted_string_16_alignment_pad(byval R as const xcb_xkb_counted_string_16_t ptr) as any ptr
declare function xcb_xkb_counted_string_16_alignment_pad_length(byval R as const xcb_xkb_counted_string_16_t ptr) as long
declare function xcb_xkb_counted_string_16_alignment_pad_end(byval R as const xcb_xkb_counted_string_16_t ptr) as xcb_generic_iterator_t
declare sub xcb_xkb_counted_string_16_next(byval i as xcb_xkb_counted_string_16_iterator_t ptr)
declare function xcb_xkb_counted_string_16_end(byval i as xcb_xkb_counted_string_16_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_kt_map_entry_next(byval i as xcb_xkb_kt_map_entry_iterator_t ptr)
declare function xcb_xkb_kt_map_entry_end(byval i as xcb_xkb_kt_map_entry_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_key_type_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_key_type_map(byval R as const xcb_xkb_key_type_t ptr) as xcb_xkb_kt_map_entry_t ptr
declare function xcb_xkb_key_type_map_length(byval R as const xcb_xkb_key_type_t ptr) as long
declare function xcb_xkb_key_type_map_iterator(byval R as const xcb_xkb_key_type_t ptr) as xcb_xkb_kt_map_entry_iterator_t
declare function xcb_xkb_key_type_preserve(byval R as const xcb_xkb_key_type_t ptr) as xcb_xkb_mod_def_t ptr
declare function xcb_xkb_key_type_preserve_length(byval R as const xcb_xkb_key_type_t ptr) as long
declare function xcb_xkb_key_type_preserve_iterator(byval R as const xcb_xkb_key_type_t ptr) as xcb_xkb_mod_def_iterator_t
declare sub xcb_xkb_key_type_next(byval i as xcb_xkb_key_type_iterator_t ptr)
declare function xcb_xkb_key_type_end(byval i as xcb_xkb_key_type_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_key_sym_map_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_key_sym_map_syms(byval R as const xcb_xkb_key_sym_map_t ptr) as xcb_keysym_t ptr
declare function xcb_xkb_key_sym_map_syms_length(byval R as const xcb_xkb_key_sym_map_t ptr) as long
declare function xcb_xkb_key_sym_map_syms_end(byval R as const xcb_xkb_key_sym_map_t ptr) as xcb_generic_iterator_t
declare sub xcb_xkb_key_sym_map_next(byval i as xcb_xkb_key_sym_map_iterator_t ptr)
declare function xcb_xkb_key_sym_map_end(byval i as xcb_xkb_key_sym_map_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_common_behavior_next(byval i as xcb_xkb_common_behavior_iterator_t ptr)
declare function xcb_xkb_common_behavior_end(byval i as xcb_xkb_common_behavior_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_default_behavior_next(byval i as xcb_xkb_default_behavior_iterator_t ptr)
declare function xcb_xkb_default_behavior_end(byval i as xcb_xkb_default_behavior_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_lock_behavior_next(byval i as xcb_xkb_lock_behavior_iterator_t ptr)
declare function xcb_xkb_lock_behavior_end(byval i as xcb_xkb_lock_behavior_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_radio_group_behavior_next(byval i as xcb_xkb_radio_group_behavior_iterator_t ptr)
declare function xcb_xkb_radio_group_behavior_end(byval i as xcb_xkb_radio_group_behavior_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_overlay_behavior_next(byval i as xcb_xkb_overlay_behavior_iterator_t ptr)
declare function xcb_xkb_overlay_behavior_end(byval i as xcb_xkb_overlay_behavior_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_permament_lock_behavior_next(byval i as xcb_xkb_permament_lock_behavior_iterator_t ptr)
declare function xcb_xkb_permament_lock_behavior_end(byval i as xcb_xkb_permament_lock_behavior_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_permament_radio_group_behavior_next(byval i as xcb_xkb_permament_radio_group_behavior_iterator_t ptr)
declare function xcb_xkb_permament_radio_group_behavior_end(byval i as xcb_xkb_permament_radio_group_behavior_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_permament_overlay_behavior_next(byval i as xcb_xkb_permament_overlay_behavior_iterator_t ptr)
declare function xcb_xkb_permament_overlay_behavior_end(byval i as xcb_xkb_permament_overlay_behavior_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_behavior_next(byval i as xcb_xkb_behavior_iterator_t ptr)
declare function xcb_xkb_behavior_end(byval i as xcb_xkb_behavior_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_set_behavior_next(byval i as xcb_xkb_set_behavior_iterator_t ptr)
declare function xcb_xkb_set_behavior_end(byval i as xcb_xkb_set_behavior_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_set_explicit_next(byval i as xcb_xkb_set_explicit_iterator_t ptr)
declare function xcb_xkb_set_explicit_end(byval i as xcb_xkb_set_explicit_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_key_mod_map_next(byval i as xcb_xkb_key_mod_map_iterator_t ptr)
declare function xcb_xkb_key_mod_map_end(byval i as xcb_xkb_key_mod_map_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_key_v_mod_map_next(byval i as xcb_xkb_key_v_mod_map_iterator_t ptr)
declare function xcb_xkb_key_v_mod_map_end(byval i as xcb_xkb_key_v_mod_map_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_kt_set_map_entry_next(byval i as xcb_xkb_kt_set_map_entry_iterator_t ptr)
declare function xcb_xkb_kt_set_map_entry_end(byval i as xcb_xkb_kt_set_map_entry_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_set_key_type_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_set_key_type_entries(byval R as const xcb_xkb_set_key_type_t ptr) as xcb_xkb_kt_set_map_entry_t ptr
declare function xcb_xkb_set_key_type_entries_length(byval R as const xcb_xkb_set_key_type_t ptr) as long
declare function xcb_xkb_set_key_type_entries_iterator(byval R as const xcb_xkb_set_key_type_t ptr) as xcb_xkb_kt_set_map_entry_iterator_t
declare function xcb_xkb_set_key_type_preserve_entries(byval R as const xcb_xkb_set_key_type_t ptr) as xcb_xkb_kt_set_map_entry_t ptr
declare function xcb_xkb_set_key_type_preserve_entries_length(byval R as const xcb_xkb_set_key_type_t ptr) as long
declare function xcb_xkb_set_key_type_preserve_entries_iterator(byval R as const xcb_xkb_set_key_type_t ptr) as xcb_xkb_kt_set_map_entry_iterator_t
declare sub xcb_xkb_set_key_type_next(byval i as xcb_xkb_set_key_type_iterator_t ptr)
declare function xcb_xkb_set_key_type_end(byval i as xcb_xkb_set_key_type_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_string8_next(byval i as xcb_xkb_string8_iterator_t ptr)
declare function xcb_xkb_string8_end(byval i as xcb_xkb_string8_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_outline_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_outline_points(byval R as const xcb_xkb_outline_t ptr) as xcb_point_t ptr
declare function xcb_xkb_outline_points_length(byval R as const xcb_xkb_outline_t ptr) as long
declare function xcb_xkb_outline_points_iterator(byval R as const xcb_xkb_outline_t ptr) as xcb_point_iterator_t
declare sub xcb_xkb_outline_next(byval i as xcb_xkb_outline_iterator_t ptr)
declare function xcb_xkb_outline_end(byval i as xcb_xkb_outline_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_shape_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_shape_outlines_length(byval R as const xcb_xkb_shape_t ptr) as long
declare function xcb_xkb_shape_outlines_iterator(byval R as const xcb_xkb_shape_t ptr) as xcb_xkb_outline_iterator_t
declare sub xcb_xkb_shape_next(byval i as xcb_xkb_shape_iterator_t ptr)
declare function xcb_xkb_shape_end(byval i as xcb_xkb_shape_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_key_next(byval i as xcb_xkb_key_iterator_t ptr)
declare function xcb_xkb_key_end(byval i as xcb_xkb_key_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_overlay_key_next(byval i as xcb_xkb_overlay_key_iterator_t ptr)
declare function xcb_xkb_overlay_key_end(byval i as xcb_xkb_overlay_key_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_overlay_row_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_overlay_row_keys(byval R as const xcb_xkb_overlay_row_t ptr) as xcb_xkb_overlay_key_t ptr
declare function xcb_xkb_overlay_row_keys_length(byval R as const xcb_xkb_overlay_row_t ptr) as long
declare function xcb_xkb_overlay_row_keys_iterator(byval R as const xcb_xkb_overlay_row_t ptr) as xcb_xkb_overlay_key_iterator_t
declare sub xcb_xkb_overlay_row_next(byval i as xcb_xkb_overlay_row_iterator_t ptr)
declare function xcb_xkb_overlay_row_end(byval i as xcb_xkb_overlay_row_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_overlay_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_overlay_rows_length(byval R as const xcb_xkb_overlay_t ptr) as long
declare function xcb_xkb_overlay_rows_iterator(byval R as const xcb_xkb_overlay_t ptr) as xcb_xkb_overlay_row_iterator_t
declare sub xcb_xkb_overlay_next(byval i as xcb_xkb_overlay_iterator_t ptr)
declare function xcb_xkb_overlay_end(byval i as xcb_xkb_overlay_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_row_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_row_keys(byval R as const xcb_xkb_row_t ptr) as xcb_xkb_key_t ptr
declare function xcb_xkb_row_keys_length(byval R as const xcb_xkb_row_t ptr) as long
declare function xcb_xkb_row_keys_iterator(byval R as const xcb_xkb_row_t ptr) as xcb_xkb_key_iterator_t
declare sub xcb_xkb_row_next(byval i as xcb_xkb_row_iterator_t ptr)
declare function xcb_xkb_row_end(byval i as xcb_xkb_row_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_listing_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_listing_string(byval R as const xcb_xkb_listing_t ptr) as xcb_xkb_string8_t ptr
declare function xcb_xkb_listing_string_length(byval R as const xcb_xkb_listing_t ptr) as long
declare function xcb_xkb_listing_string_end(byval R as const xcb_xkb_listing_t ptr) as xcb_generic_iterator_t
declare sub xcb_xkb_listing_next(byval i as xcb_xkb_listing_iterator_t ptr)
declare function xcb_xkb_listing_end(byval i as xcb_xkb_listing_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_device_led_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_device_led_info_names(byval R as const xcb_xkb_device_led_info_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_device_led_info_names_length(byval R as const xcb_xkb_device_led_info_t ptr) as long
declare function xcb_xkb_device_led_info_names_end(byval R as const xcb_xkb_device_led_info_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_device_led_info_maps(byval R as const xcb_xkb_device_led_info_t ptr) as xcb_xkb_indicator_map_t ptr
declare function xcb_xkb_device_led_info_maps_length(byval R as const xcb_xkb_device_led_info_t ptr) as long
declare function xcb_xkb_device_led_info_maps_iterator(byval R as const xcb_xkb_device_led_info_t ptr) as xcb_xkb_indicator_map_iterator_t
declare sub xcb_xkb_device_led_info_next(byval i as xcb_xkb_device_led_info_iterator_t ptr)
declare function xcb_xkb_device_led_info_end(byval i as xcb_xkb_device_led_info_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_no_action_next(byval i as xcb_xkb_sa_no_action_iterator_t ptr)
declare function xcb_xkb_sa_no_action_end(byval i as xcb_xkb_sa_no_action_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_set_mods_next(byval i as xcb_xkb_sa_set_mods_iterator_t ptr)
declare function xcb_xkb_sa_set_mods_end(byval i as xcb_xkb_sa_set_mods_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_latch_mods_next(byval i as xcb_xkb_sa_latch_mods_iterator_t ptr)
declare function xcb_xkb_sa_latch_mods_end(byval i as xcb_xkb_sa_latch_mods_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_lock_mods_next(byval i as xcb_xkb_sa_lock_mods_iterator_t ptr)
declare function xcb_xkb_sa_lock_mods_end(byval i as xcb_xkb_sa_lock_mods_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_set_group_next(byval i as xcb_xkb_sa_set_group_iterator_t ptr)
declare function xcb_xkb_sa_set_group_end(byval i as xcb_xkb_sa_set_group_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_latch_group_next(byval i as xcb_xkb_sa_latch_group_iterator_t ptr)
declare function xcb_xkb_sa_latch_group_end(byval i as xcb_xkb_sa_latch_group_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_lock_group_next(byval i as xcb_xkb_sa_lock_group_iterator_t ptr)
declare function xcb_xkb_sa_lock_group_end(byval i as xcb_xkb_sa_lock_group_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_move_ptr_next(byval i as xcb_xkb_sa_move_ptr_iterator_t ptr)
declare function xcb_xkb_sa_move_ptr_end(byval i as xcb_xkb_sa_move_ptr_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_ptr_btn_next(byval i as xcb_xkb_sa_ptr_btn_iterator_t ptr)
declare function xcb_xkb_sa_ptr_btn_end(byval i as xcb_xkb_sa_ptr_btn_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_lock_ptr_btn_next(byval i as xcb_xkb_sa_lock_ptr_btn_iterator_t ptr)
declare function xcb_xkb_sa_lock_ptr_btn_end(byval i as xcb_xkb_sa_lock_ptr_btn_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_set_ptr_dflt_next(byval i as xcb_xkb_sa_set_ptr_dflt_iterator_t ptr)
declare function xcb_xkb_sa_set_ptr_dflt_end(byval i as xcb_xkb_sa_set_ptr_dflt_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_iso_lock_next(byval i as xcb_xkb_sa_iso_lock_iterator_t ptr)
declare function xcb_xkb_sa_iso_lock_end(byval i as xcb_xkb_sa_iso_lock_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_terminate_next(byval i as xcb_xkb_sa_terminate_iterator_t ptr)
declare function xcb_xkb_sa_terminate_end(byval i as xcb_xkb_sa_terminate_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_switch_screen_next(byval i as xcb_xkb_sa_switch_screen_iterator_t ptr)
declare function xcb_xkb_sa_switch_screen_end(byval i as xcb_xkb_sa_switch_screen_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_set_controls_next(byval i as xcb_xkb_sa_set_controls_iterator_t ptr)
declare function xcb_xkb_sa_set_controls_end(byval i as xcb_xkb_sa_set_controls_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_lock_controls_next(byval i as xcb_xkb_sa_lock_controls_iterator_t ptr)
declare function xcb_xkb_sa_lock_controls_end(byval i as xcb_xkb_sa_lock_controls_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_action_message_next(byval i as xcb_xkb_sa_action_message_iterator_t ptr)
declare function xcb_xkb_sa_action_message_end(byval i as xcb_xkb_sa_action_message_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_redirect_key_next(byval i as xcb_xkb_sa_redirect_key_iterator_t ptr)
declare function xcb_xkb_sa_redirect_key_end(byval i as xcb_xkb_sa_redirect_key_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_device_btn_next(byval i as xcb_xkb_sa_device_btn_iterator_t ptr)
declare function xcb_xkb_sa_device_btn_end(byval i as xcb_xkb_sa_device_btn_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_lock_device_btn_next(byval i as xcb_xkb_sa_lock_device_btn_iterator_t ptr)
declare function xcb_xkb_sa_lock_device_btn_end(byval i as xcb_xkb_sa_lock_device_btn_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sa_device_valuator_next(byval i as xcb_xkb_sa_device_valuator_iterator_t ptr)
declare function xcb_xkb_sa_device_valuator_end(byval i as xcb_xkb_sa_device_valuator_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_si_action_next(byval i as xcb_xkb_si_action_iterator_t ptr)
declare function xcb_xkb_si_action_end(byval i as xcb_xkb_si_action_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_sym_interpret_next(byval i as xcb_xkb_sym_interpret_iterator_t ptr)
declare function xcb_xkb_sym_interpret_end(byval i as xcb_xkb_sym_interpret_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xkb_action_next(byval i as xcb_xkb_action_iterator_t ptr)
declare function xcb_xkb_action_end(byval i as xcb_xkb_action_iterator_t) as xcb_generic_iterator_t
declare function xcb_xkb_use_extension(byval c as xcb_connection_t ptr, byval wantedMajor as ushort, byval wantedMinor as ushort) as xcb_xkb_use_extension_cookie_t
declare function xcb_xkb_use_extension_unchecked(byval c as xcb_connection_t ptr, byval wantedMajor as ushort, byval wantedMinor as ushort) as xcb_xkb_use_extension_cookie_t
declare function xcb_xkb_use_extension_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_use_extension_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_use_extension_reply_t ptr
declare function xcb_xkb_select_events_details_serialize(byval _buffer as any ptr ptr, byval affectWhich as ushort, byval clear as ushort, byval selectAll as ushort, byval _aux as const xcb_xkb_select_events_details_t ptr) as long
declare function xcb_xkb_select_events_details_unpack(byval _buffer as const any ptr, byval affectWhich as ushort, byval clear as ushort, byval selectAll as ushort, byval _aux as xcb_xkb_select_events_details_t ptr) as long
declare function xcb_xkb_select_events_details_sizeof(byval _buffer as const any ptr, byval affectWhich as ushort, byval clear as ushort, byval selectAll as ushort) as long
declare function xcb_xkb_select_events_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval affectWhich as ushort, byval clear as ushort, byval selectAll as ushort, byval affectMap as ushort, byval map as ushort, byval details as const any ptr) as xcb_void_cookie_t
declare function xcb_xkb_select_events(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval affectWhich as ushort, byval clear as ushort, byval selectAll as ushort, byval affectMap as ushort, byval map as ushort, byval details as const any ptr) as xcb_void_cookie_t
declare function xcb_xkb_select_events_aux_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval affectWhich as ushort, byval clear as ushort, byval selectAll as ushort, byval affectMap as ushort, byval map as ushort, byval details as const xcb_xkb_select_events_details_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_select_events_aux(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval affectWhich as ushort, byval clear as ushort, byval selectAll as ushort, byval affectMap as ushort, byval map as ushort, byval details as const xcb_xkb_select_events_details_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_bell_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval bellClass as xcb_xkb_bell_class_spec_t, byval bellID as xcb_xkb_id_spec_t, byval percent as byte, byval forceSound as ubyte, byval eventOnly as ubyte, byval pitch as short, byval duration as short, byval name as xcb_atom_t, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_xkb_bell(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval bellClass as xcb_xkb_bell_class_spec_t, byval bellID as xcb_xkb_id_spec_t, byval percent as byte, byval forceSound as ubyte, byval eventOnly as ubyte, byval pitch as short, byval duration as short, byval name as xcb_atom_t, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_xkb_get_state(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t) as xcb_xkb_get_state_cookie_t
declare function xcb_xkb_get_state_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t) as xcb_xkb_get_state_cookie_t
declare function xcb_xkb_get_state_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_get_state_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_get_state_reply_t ptr
declare function xcb_xkb_latch_lock_state_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval affectModLocks as ubyte, byval modLocks as ubyte, byval lockGroup as ubyte, byval groupLock as ubyte, byval affectModLatches as ubyte, byval latchGroup as ubyte, byval groupLatch as ushort) as xcb_void_cookie_t
declare function xcb_xkb_latch_lock_state(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval affectModLocks as ubyte, byval modLocks as ubyte, byval lockGroup as ubyte, byval groupLock as ubyte, byval affectModLatches as ubyte, byval latchGroup as ubyte, byval groupLatch as ushort) as xcb_void_cookie_t
declare function xcb_xkb_get_controls(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t) as xcb_xkb_get_controls_cookie_t
declare function xcb_xkb_get_controls_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t) as xcb_xkb_get_controls_cookie_t
declare function xcb_xkb_get_controls_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_get_controls_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_get_controls_reply_t ptr
declare function xcb_xkb_set_controls_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval affectInternalRealMods as ubyte, byval internalRealMods as ubyte, byval affectIgnoreLockRealMods as ubyte, byval ignoreLockRealMods as ubyte, byval affectInternalVirtualMods as ushort, byval internalVirtualMods as ushort, byval affectIgnoreLockVirtualMods as ushort, byval ignoreLockVirtualMods as ushort, byval mouseKeysDfltBtn as ubyte, byval groupsWrap as ubyte, byval accessXOptions as ushort, byval affectEnabledControls as ulong, byval enabledControls as ulong, byval changeControls as ulong, byval repeatDelay as ushort, byval repeatInterval as ushort, byval slowKeysDelay as ushort, byval debounceDelay as ushort, byval mouseKeysDelay as ushort, byval mouseKeysInterval as ushort, byval mouseKeysTimeToMax as ushort, byval mouseKeysMaxSpeed as ushort, byval mouseKeysCurve as short, byval accessXTimeout as ushort, byval accessXTimeoutMask as ulong, byval accessXTimeoutValues as ulong, byval accessXTimeoutOptionsMask as ushort, byval accessXTimeoutOptionsValues as ushort, byval perKeyRepeat as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_xkb_set_controls(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval affectInternalRealMods as ubyte, byval internalRealMods as ubyte, byval affectIgnoreLockRealMods as ubyte, byval ignoreLockRealMods as ubyte, byval affectInternalVirtualMods as ushort, byval internalVirtualMods as ushort, byval affectIgnoreLockVirtualMods as ushort, byval ignoreLockVirtualMods as ushort, byval mouseKeysDfltBtn as ubyte, byval groupsWrap as ubyte, byval accessXOptions as ushort, byval affectEnabledControls as ulong, byval enabledControls as ulong, byval changeControls as ulong, byval repeatDelay as ushort, byval repeatInterval as ushort, byval slowKeysDelay as ushort, byval debounceDelay as ushort, byval mouseKeysDelay as ushort, byval mouseKeysInterval as ushort, byval mouseKeysTimeToMax as ushort, byval mouseKeysMaxSpeed as ushort, byval mouseKeysCurve as short, byval accessXTimeout as ushort, byval accessXTimeoutMask as ulong, byval accessXTimeoutValues as ulong, byval accessXTimeoutOptionsMask as ushort, byval accessXTimeoutOptionsValues as ushort, byval perKeyRepeat as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_xkb_get_map_map_types_rtrn_length(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as long
declare function xcb_xkb_get_map_map_types_rtrn_iterator(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_key_type_iterator_t
declare function xcb_xkb_get_map_map_syms_rtrn_length(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as long
declare function xcb_xkb_get_map_map_syms_rtrn_iterator(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_key_sym_map_iterator_t
declare function xcb_xkb_get_map_map_acts_rtrn_count(byval S as const xcb_xkb_get_map_map_t ptr) as ubyte ptr
declare function xcb_xkb_get_map_map_acts_rtrn_count_length(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as long
declare function xcb_xkb_get_map_map_acts_rtrn_count_end(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_map_map_acts_rtrn_acts(byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_action_t ptr
declare function xcb_xkb_get_map_map_acts_rtrn_acts_length(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as long
declare function xcb_xkb_get_map_map_acts_rtrn_acts_iterator(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_action_iterator_t
declare function xcb_xkb_get_map_map_behaviors_rtrn(byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_set_behavior_t ptr
declare function xcb_xkb_get_map_map_behaviors_rtrn_length(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as long
declare function xcb_xkb_get_map_map_behaviors_rtrn_iterator(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_set_behavior_iterator_t
declare function xcb_xkb_get_map_map_vmods_rtrn(byval S as const xcb_xkb_get_map_map_t ptr) as ubyte ptr
declare function xcb_xkb_get_map_map_vmods_rtrn_length(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as long
declare function xcb_xkb_get_map_map_vmods_rtrn_end(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_map_map_explicit_rtrn(byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_set_explicit_t ptr
declare function xcb_xkb_get_map_map_explicit_rtrn_length(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as long
declare function xcb_xkb_get_map_map_explicit_rtrn_iterator(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_set_explicit_iterator_t
declare function xcb_xkb_get_map_map_modmap_rtrn(byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_key_mod_map_t ptr
declare function xcb_xkb_get_map_map_modmap_rtrn_length(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as long
declare function xcb_xkb_get_map_map_modmap_rtrn_iterator(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_key_mod_map_iterator_t
declare function xcb_xkb_get_map_map_vmodmap_rtrn(byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_key_v_mod_map_t ptr
declare function xcb_xkb_get_map_map_vmodmap_rtrn_length(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as long
declare function xcb_xkb_get_map_map_vmodmap_rtrn_iterator(byval R as const xcb_xkb_get_map_reply_t ptr, byval S as const xcb_xkb_get_map_map_t ptr) as xcb_xkb_key_v_mod_map_iterator_t
declare function xcb_xkb_get_map_map_serialize(byval _buffer as any ptr ptr, byval nTypes as ubyte, byval nKeySyms as ubyte, byval nKeyActions as ubyte, byval totalActions as ushort, byval totalKeyBehaviors as ubyte, byval virtualMods as ushort, byval totalKeyExplicit as ubyte, byval totalModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval present as ushort, byval _aux as const xcb_xkb_get_map_map_t ptr) as long
declare function xcb_xkb_get_map_map_unpack(byval _buffer as const any ptr, byval nTypes as ubyte, byval nKeySyms as ubyte, byval nKeyActions as ubyte, byval totalActions as ushort, byval totalKeyBehaviors as ubyte, byval virtualMods as ushort, byval totalKeyExplicit as ubyte, byval totalModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval present as ushort, byval _aux as xcb_xkb_get_map_map_t ptr) as long
declare function xcb_xkb_get_map_map_sizeof(byval _buffer as const any ptr, byval nTypes as ubyte, byval nKeySyms as ubyte, byval nKeyActions as ubyte, byval totalActions as ushort, byval totalKeyBehaviors as ubyte, byval virtualMods as ushort, byval totalKeyExplicit as ubyte, byval totalModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval present as ushort) as long
declare function xcb_xkb_get_map(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval full as ushort, byval partial as ushort, byval firstType as ubyte, byval nTypes as ubyte, byval firstKeySym as xcb_keycode_t, byval nKeySyms as ubyte, byval firstKeyAction as xcb_keycode_t, byval nKeyActions as ubyte, byval firstKeyBehavior as xcb_keycode_t, byval nKeyBehaviors as ubyte, byval virtualMods as ushort, byval firstKeyExplicit as xcb_keycode_t, byval nKeyExplicit as ubyte, byval firstModMapKey as xcb_keycode_t, byval nModMapKeys as ubyte, byval firstVModMapKey as xcb_keycode_t, byval nVModMapKeys as ubyte) as xcb_xkb_get_map_cookie_t
declare function xcb_xkb_get_map_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval full as ushort, byval partial as ushort, byval firstType as ubyte, byval nTypes as ubyte, byval firstKeySym as xcb_keycode_t, byval nKeySyms as ubyte, byval firstKeyAction as xcb_keycode_t, byval nKeyActions as ubyte, byval firstKeyBehavior as xcb_keycode_t, byval nKeyBehaviors as ubyte, byval virtualMods as ushort, byval firstKeyExplicit as xcb_keycode_t, byval nKeyExplicit as ubyte, byval firstModMapKey as xcb_keycode_t, byval nModMapKeys as ubyte, byval firstVModMapKey as xcb_keycode_t, byval nVModMapKeys as ubyte) as xcb_xkb_get_map_cookie_t
declare function xcb_xkb_get_map_map(byval R as const xcb_xkb_get_map_reply_t ptr) as any ptr
declare function xcb_xkb_get_map_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_get_map_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_get_map_reply_t ptr
declare function xcb_xkb_set_map_values_types_length(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as long
declare function xcb_xkb_set_map_values_types_iterator(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_set_key_type_iterator_t
declare function xcb_xkb_set_map_values_syms_length(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as long
declare function xcb_xkb_set_map_values_syms_iterator(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_key_sym_map_iterator_t
declare function xcb_xkb_set_map_values_actions_count(byval S as const xcb_xkb_set_map_values_t ptr) as ubyte ptr
declare function xcb_xkb_set_map_values_actions_count_length(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as long
declare function xcb_xkb_set_map_values_actions_count_end(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_set_map_values_actions(byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_action_t ptr
declare function xcb_xkb_set_map_values_actions_length(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as long
declare function xcb_xkb_set_map_values_actions_iterator(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_action_iterator_t
declare function xcb_xkb_set_map_values_behaviors(byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_set_behavior_t ptr
declare function xcb_xkb_set_map_values_behaviors_length(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as long
declare function xcb_xkb_set_map_values_behaviors_iterator(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_set_behavior_iterator_t
declare function xcb_xkb_set_map_values_vmods(byval S as const xcb_xkb_set_map_values_t ptr) as ubyte ptr
declare function xcb_xkb_set_map_values_vmods_length(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as long
declare function xcb_xkb_set_map_values_vmods_end(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_set_map_values_explicit(byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_set_explicit_t ptr
declare function xcb_xkb_set_map_values_explicit_length(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as long
declare function xcb_xkb_set_map_values_explicit_iterator(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_set_explicit_iterator_t
declare function xcb_xkb_set_map_values_modmap(byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_key_mod_map_t ptr
declare function xcb_xkb_set_map_values_modmap_length(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as long
declare function xcb_xkb_set_map_values_modmap_iterator(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_key_mod_map_iterator_t
declare function xcb_xkb_set_map_values_vmodmap(byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_key_v_mod_map_t ptr
declare function xcb_xkb_set_map_values_vmodmap_length(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as long
declare function xcb_xkb_set_map_values_vmodmap_iterator(byval R as const xcb_xkb_set_map_request_t ptr, byval S as const xcb_xkb_set_map_values_t ptr) as xcb_xkb_key_v_mod_map_iterator_t
declare function xcb_xkb_set_map_values_serialize(byval _buffer as any ptr ptr, byval nTypes as ubyte, byval nKeySyms as ubyte, byval nKeyActions as ubyte, byval totalActions as ushort, byval totalKeyBehaviors as ubyte, byval virtualMods as ushort, byval totalKeyExplicit as ubyte, byval totalModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval present as ushort, byval _aux as const xcb_xkb_set_map_values_t ptr) as long
declare function xcb_xkb_set_map_values_unpack(byval _buffer as const any ptr, byval nTypes as ubyte, byval nKeySyms as ubyte, byval nKeyActions as ubyte, byval totalActions as ushort, byval totalKeyBehaviors as ubyte, byval virtualMods as ushort, byval totalKeyExplicit as ubyte, byval totalModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval present as ushort, byval _aux as xcb_xkb_set_map_values_t ptr) as long
declare function xcb_xkb_set_map_values_sizeof(byval _buffer as const any ptr, byval nTypes as ubyte, byval nKeySyms as ubyte, byval nKeyActions as ubyte, byval totalActions as ushort, byval totalKeyBehaviors as ubyte, byval virtualMods as ushort, byval totalKeyExplicit as ubyte, byval totalModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval present as ushort) as long
declare function xcb_xkb_set_map_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval present as ushort, byval flags as ushort, byval minKeyCode as xcb_keycode_t, byval maxKeyCode as xcb_keycode_t, byval firstType as ubyte, byval nTypes as ubyte, byval firstKeySym as xcb_keycode_t, byval nKeySyms as ubyte, byval totalSyms as ushort, byval firstKeyAction as xcb_keycode_t, byval nKeyActions as ubyte, byval totalActions as ushort, byval firstKeyBehavior as xcb_keycode_t, byval nKeyBehaviors as ubyte, byval totalKeyBehaviors as ubyte, byval firstKeyExplicit as xcb_keycode_t, byval nKeyExplicit as ubyte, byval totalKeyExplicit as ubyte, byval firstModMapKey as xcb_keycode_t, byval nModMapKeys as ubyte, byval totalModMapKeys as ubyte, byval firstVModMapKey as xcb_keycode_t, byval nVModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval virtualMods as ushort, byval values as const any ptr) as xcb_void_cookie_t
declare function xcb_xkb_set_map(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval present as ushort, byval flags as ushort, byval minKeyCode as xcb_keycode_t, byval maxKeyCode as xcb_keycode_t, byval firstType as ubyte, byval nTypes as ubyte, byval firstKeySym as xcb_keycode_t, byval nKeySyms as ubyte, byval totalSyms as ushort, byval firstKeyAction as xcb_keycode_t, byval nKeyActions as ubyte, byval totalActions as ushort, byval firstKeyBehavior as xcb_keycode_t, byval nKeyBehaviors as ubyte, byval totalKeyBehaviors as ubyte, byval firstKeyExplicit as xcb_keycode_t, byval nKeyExplicit as ubyte, byval totalKeyExplicit as ubyte, byval firstModMapKey as xcb_keycode_t, byval nModMapKeys as ubyte, byval totalModMapKeys as ubyte, byval firstVModMapKey as xcb_keycode_t, byval nVModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval virtualMods as ushort, byval values as const any ptr) as xcb_void_cookie_t
declare function xcb_xkb_set_map_aux_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval present as ushort, byval flags as ushort, byval minKeyCode as xcb_keycode_t, byval maxKeyCode as xcb_keycode_t, byval firstType as ubyte, byval nTypes as ubyte, byval firstKeySym as xcb_keycode_t, byval nKeySyms as ubyte, byval totalSyms as ushort, byval firstKeyAction as xcb_keycode_t, byval nKeyActions as ubyte, byval totalActions as ushort, byval firstKeyBehavior as xcb_keycode_t, byval nKeyBehaviors as ubyte, byval totalKeyBehaviors as ubyte, byval firstKeyExplicit as xcb_keycode_t, byval nKeyExplicit as ubyte, byval totalKeyExplicit as ubyte, byval firstModMapKey as xcb_keycode_t, byval nModMapKeys as ubyte, byval totalModMapKeys as ubyte, byval firstVModMapKey as xcb_keycode_t, byval nVModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval virtualMods as ushort, byval values as const xcb_xkb_set_map_values_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_set_map_aux(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval present as ushort, byval flags as ushort, byval minKeyCode as xcb_keycode_t, byval maxKeyCode as xcb_keycode_t, byval firstType as ubyte, byval nTypes as ubyte, byval firstKeySym as xcb_keycode_t, byval nKeySyms as ubyte, byval totalSyms as ushort, byval firstKeyAction as xcb_keycode_t, byval nKeyActions as ubyte, byval totalActions as ushort, byval firstKeyBehavior as xcb_keycode_t, byval nKeyBehaviors as ubyte, byval totalKeyBehaviors as ubyte, byval firstKeyExplicit as xcb_keycode_t, byval nKeyExplicit as ubyte, byval totalKeyExplicit as ubyte, byval firstModMapKey as xcb_keycode_t, byval nModMapKeys as ubyte, byval totalModMapKeys as ubyte, byval firstVModMapKey as xcb_keycode_t, byval nVModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval virtualMods as ushort, byval values as const xcb_xkb_set_map_values_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_get_compat_map_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_get_compat_map(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval groups as ubyte, byval getAllSI as ubyte, byval firstSI as ushort, byval nSI as ushort) as xcb_xkb_get_compat_map_cookie_t
declare function xcb_xkb_get_compat_map_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval groups as ubyte, byval getAllSI as ubyte, byval firstSI as ushort, byval nSI as ushort) as xcb_xkb_get_compat_map_cookie_t
declare function xcb_xkb_get_compat_map_si_rtrn(byval R as const xcb_xkb_get_compat_map_reply_t ptr) as xcb_xkb_sym_interpret_t ptr
declare function xcb_xkb_get_compat_map_si_rtrn_length(byval R as const xcb_xkb_get_compat_map_reply_t ptr) as long
declare function xcb_xkb_get_compat_map_si_rtrn_iterator(byval R as const xcb_xkb_get_compat_map_reply_t ptr) as xcb_xkb_sym_interpret_iterator_t
declare function xcb_xkb_get_compat_map_group_rtrn(byval R as const xcb_xkb_get_compat_map_reply_t ptr) as xcb_xkb_mod_def_t ptr
declare function xcb_xkb_get_compat_map_group_rtrn_length(byval R as const xcb_xkb_get_compat_map_reply_t ptr) as long
declare function xcb_xkb_get_compat_map_group_rtrn_iterator(byval R as const xcb_xkb_get_compat_map_reply_t ptr) as xcb_xkb_mod_def_iterator_t
declare function xcb_xkb_get_compat_map_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_get_compat_map_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_get_compat_map_reply_t ptr
declare function xcb_xkb_set_compat_map_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_set_compat_map_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval recomputeActions as ubyte, byval truncateSI as ubyte, byval groups as ubyte, byval firstSI as ushort, byval nSI as ushort, byval si as const xcb_xkb_sym_interpret_t ptr, byval groupMaps as const xcb_xkb_mod_def_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_set_compat_map(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval recomputeActions as ubyte, byval truncateSI as ubyte, byval groups as ubyte, byval firstSI as ushort, byval nSI as ushort, byval si as const xcb_xkb_sym_interpret_t ptr, byval groupMaps as const xcb_xkb_mod_def_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_get_indicator_state(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t) as xcb_xkb_get_indicator_state_cookie_t
declare function xcb_xkb_get_indicator_state_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t) as xcb_xkb_get_indicator_state_cookie_t
declare function xcb_xkb_get_indicator_state_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_get_indicator_state_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_get_indicator_state_reply_t ptr
declare function xcb_xkb_get_indicator_map_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_get_indicator_map(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval which as ulong) as xcb_xkb_get_indicator_map_cookie_t
declare function xcb_xkb_get_indicator_map_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval which as ulong) as xcb_xkb_get_indicator_map_cookie_t
declare function xcb_xkb_get_indicator_map_maps(byval R as const xcb_xkb_get_indicator_map_reply_t ptr) as xcb_xkb_indicator_map_t ptr
declare function xcb_xkb_get_indicator_map_maps_length(byval R as const xcb_xkb_get_indicator_map_reply_t ptr) as long
declare function xcb_xkb_get_indicator_map_maps_iterator(byval R as const xcb_xkb_get_indicator_map_reply_t ptr) as xcb_xkb_indicator_map_iterator_t
declare function xcb_xkb_get_indicator_map_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_get_indicator_map_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_get_indicator_map_reply_t ptr
declare function xcb_xkb_set_indicator_map_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_set_indicator_map_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval which as ulong, byval maps as const xcb_xkb_indicator_map_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_set_indicator_map(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval which as ulong, byval maps as const xcb_xkb_indicator_map_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_get_named_indicator(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval ledClass as xcb_xkb_led_class_spec_t, byval ledID as xcb_xkb_id_spec_t, byval indicator as xcb_atom_t) as xcb_xkb_get_named_indicator_cookie_t
declare function xcb_xkb_get_named_indicator_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval ledClass as xcb_xkb_led_class_spec_t, byval ledID as xcb_xkb_id_spec_t, byval indicator as xcb_atom_t) as xcb_xkb_get_named_indicator_cookie_t
declare function xcb_xkb_get_named_indicator_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_get_named_indicator_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_get_named_indicator_reply_t ptr
declare function xcb_xkb_set_named_indicator_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval ledClass as xcb_xkb_led_class_spec_t, byval ledID as xcb_xkb_id_spec_t, byval indicator as xcb_atom_t, byval setState as ubyte, byval on as ubyte, byval setMap as ubyte, byval createMap as ubyte, byval map_flags as ubyte, byval map_whichGroups as ubyte, byval map_groups as ubyte, byval map_whichMods as ubyte, byval map_realMods as ubyte, byval map_vmods as ushort, byval map_ctrls as ulong) as xcb_void_cookie_t
declare function xcb_xkb_set_named_indicator(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval ledClass as xcb_xkb_led_class_spec_t, byval ledID as xcb_xkb_id_spec_t, byval indicator as xcb_atom_t, byval setState as ubyte, byval on as ubyte, byval setMap as ubyte, byval createMap as ubyte, byval map_flags as ubyte, byval map_whichGroups as ubyte, byval map_groups as ubyte, byval map_whichMods as ubyte, byval map_realMods as ubyte, byval map_vmods as ushort, byval map_ctrls as ulong) as xcb_void_cookie_t
declare function xcb_xkb_get_names_value_list_type_names(byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_names_value_list_type_names_length(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_type_names_end(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_names_value_list_n_levels_per_type(byval S as const xcb_xkb_get_names_value_list_t ptr) as ubyte ptr
declare function xcb_xkb_get_names_value_list_n_levels_per_type_length(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_n_levels_per_type_end(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_names_value_list_alignment_pad(byval S as const xcb_xkb_get_names_value_list_t ptr) as ubyte ptr
declare function xcb_xkb_get_names_value_list_alignment_pad_length(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_alignment_pad_end(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_names_value_list_kt_level_names(byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_names_value_list_kt_level_names_length(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_kt_level_names_end(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_names_value_list_indicator_names(byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_names_value_list_indicator_names_length(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_indicator_names_end(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_names_value_list_virtual_mod_names(byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_names_value_list_virtual_mod_names_length(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_virtual_mod_names_end(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_names_value_list_groups(byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_names_value_list_groups_length(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_groups_end(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_names_value_list_key_names(byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_xkb_key_name_t ptr
declare function xcb_xkb_get_names_value_list_key_names_length(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_key_names_iterator(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_xkb_key_name_iterator_t
declare function xcb_xkb_get_names_value_list_key_aliases(byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_xkb_key_alias_t ptr
declare function xcb_xkb_get_names_value_list_key_aliases_length(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_key_aliases_iterator(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_xkb_key_alias_iterator_t
declare function xcb_xkb_get_names_value_list_radio_group_names(byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_names_value_list_radio_group_names_length(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_radio_group_names_end(byval R as const xcb_xkb_get_names_reply_t ptr, byval S as const xcb_xkb_get_names_value_list_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_names_value_list_serialize(byval _buffer as any ptr ptr, byval nTypes as ubyte, byval indicators as ulong, byval virtualMods as ushort, byval groupNames as ubyte, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval nRadioGroups as ubyte, byval which as ulong, byval _aux as const xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_unpack(byval _buffer as const any ptr, byval nTypes as ubyte, byval indicators as ulong, byval virtualMods as ushort, byval groupNames as ubyte, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval nRadioGroups as ubyte, byval which as ulong, byval _aux as xcb_xkb_get_names_value_list_t ptr) as long
declare function xcb_xkb_get_names_value_list_sizeof(byval _buffer as const any ptr, byval nTypes as ubyte, byval indicators as ulong, byval virtualMods as ushort, byval groupNames as ubyte, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval nRadioGroups as ubyte, byval which as ulong) as long
declare function xcb_xkb_get_names(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval which as ulong) as xcb_xkb_get_names_cookie_t
declare function xcb_xkb_get_names_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval which as ulong) as xcb_xkb_get_names_cookie_t
declare function xcb_xkb_get_names_value_list(byval R as const xcb_xkb_get_names_reply_t ptr) as any ptr
declare function xcb_xkb_get_names_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_get_names_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_get_names_reply_t ptr
declare function xcb_xkb_set_names_values_type_names(byval S as const xcb_xkb_set_names_values_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_set_names_values_type_names_length(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as long
declare function xcb_xkb_set_names_values_type_names_end(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_set_names_values_n_levels_per_type(byval S as const xcb_xkb_set_names_values_t ptr) as ubyte ptr
declare function xcb_xkb_set_names_values_n_levels_per_type_length(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as long
declare function xcb_xkb_set_names_values_n_levels_per_type_end(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_set_names_values_kt_level_names(byval S as const xcb_xkb_set_names_values_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_set_names_values_kt_level_names_length(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as long
declare function xcb_xkb_set_names_values_kt_level_names_end(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_set_names_values_indicator_names(byval S as const xcb_xkb_set_names_values_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_set_names_values_indicator_names_length(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as long
declare function xcb_xkb_set_names_values_indicator_names_end(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_set_names_values_virtual_mod_names(byval S as const xcb_xkb_set_names_values_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_set_names_values_virtual_mod_names_length(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as long
declare function xcb_xkb_set_names_values_virtual_mod_names_end(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_set_names_values_groups(byval S as const xcb_xkb_set_names_values_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_set_names_values_groups_length(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as long
declare function xcb_xkb_set_names_values_groups_end(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_set_names_values_key_names(byval S as const xcb_xkb_set_names_values_t ptr) as xcb_xkb_key_name_t ptr
declare function xcb_xkb_set_names_values_key_names_length(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as long
declare function xcb_xkb_set_names_values_key_names_iterator(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as xcb_xkb_key_name_iterator_t
declare function xcb_xkb_set_names_values_key_aliases(byval S as const xcb_xkb_set_names_values_t ptr) as xcb_xkb_key_alias_t ptr
declare function xcb_xkb_set_names_values_key_aliases_length(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as long
declare function xcb_xkb_set_names_values_key_aliases_iterator(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as xcb_xkb_key_alias_iterator_t
declare function xcb_xkb_set_names_values_radio_group_names(byval S as const xcb_xkb_set_names_values_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_set_names_values_radio_group_names_length(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as long
declare function xcb_xkb_set_names_values_radio_group_names_end(byval R as const xcb_xkb_set_names_request_t ptr, byval S as const xcb_xkb_set_names_values_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_set_names_values_serialize(byval _buffer as any ptr ptr, byval nTypes as ubyte, byval indicators as ulong, byval virtualMods as ushort, byval groupNames as ubyte, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval nRadioGroups as ubyte, byval which as ulong, byval _aux as const xcb_xkb_set_names_values_t ptr) as long
declare function xcb_xkb_set_names_values_unpack(byval _buffer as const any ptr, byval nTypes as ubyte, byval indicators as ulong, byval virtualMods as ushort, byval groupNames as ubyte, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval nRadioGroups as ubyte, byval which as ulong, byval _aux as xcb_xkb_set_names_values_t ptr) as long
declare function xcb_xkb_set_names_values_sizeof(byval _buffer as const any ptr, byval nTypes as ubyte, byval indicators as ulong, byval virtualMods as ushort, byval groupNames as ubyte, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval nRadioGroups as ubyte, byval which as ulong) as long
declare function xcb_xkb_set_names_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval virtualMods as ushort, byval which as ulong, byval firstType as ubyte, byval nTypes as ubyte, byval firstKTLevelt as ubyte, byval nKTLevels as ubyte, byval indicators as ulong, byval groupNames as ubyte, byval nRadioGroups as ubyte, byval firstKey as xcb_keycode_t, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval totalKTLevelNames as ushort, byval values as const any ptr) as xcb_void_cookie_t
declare function xcb_xkb_set_names(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval virtualMods as ushort, byval which as ulong, byval firstType as ubyte, byval nTypes as ubyte, byval firstKTLevelt as ubyte, byval nKTLevels as ubyte, byval indicators as ulong, byval groupNames as ubyte, byval nRadioGroups as ubyte, byval firstKey as xcb_keycode_t, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval totalKTLevelNames as ushort, byval values as const any ptr) as xcb_void_cookie_t
declare function xcb_xkb_set_names_aux_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval virtualMods as ushort, byval which as ulong, byval firstType as ubyte, byval nTypes as ubyte, byval firstKTLevelt as ubyte, byval nKTLevels as ubyte, byval indicators as ulong, byval groupNames as ubyte, byval nRadioGroups as ubyte, byval firstKey as xcb_keycode_t, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval totalKTLevelNames as ushort, byval values as const xcb_xkb_set_names_values_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_set_names_aux(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval virtualMods as ushort, byval which as ulong, byval firstType as ubyte, byval nTypes as ubyte, byval firstKTLevelt as ubyte, byval nKTLevels as ubyte, byval indicators as ulong, byval groupNames as ubyte, byval nRadioGroups as ubyte, byval firstKey as xcb_keycode_t, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval totalKTLevelNames as ushort, byval values as const xcb_xkb_set_names_values_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_per_client_flags(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval change as ulong, byval value as ulong, byval ctrlsToChange as ulong, byval autoCtrls as ulong, byval autoCtrlsValues as ulong) as xcb_xkb_per_client_flags_cookie_t
declare function xcb_xkb_per_client_flags_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval change as ulong, byval value as ulong, byval ctrlsToChange as ulong, byval autoCtrls as ulong, byval autoCtrlsValues as ulong) as xcb_xkb_per_client_flags_cookie_t
declare function xcb_xkb_per_client_flags_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_per_client_flags_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_per_client_flags_reply_t ptr
declare function xcb_xkb_list_components_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_list_components(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval maxNames as ushort) as xcb_xkb_list_components_cookie_t
declare function xcb_xkb_list_components_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval maxNames as ushort) as xcb_xkb_list_components_cookie_t
declare function xcb_xkb_list_components_keymaps_length(byval R as const xcb_xkb_list_components_reply_t ptr) as long
declare function xcb_xkb_list_components_keymaps_iterator(byval R as const xcb_xkb_list_components_reply_t ptr) as xcb_xkb_listing_iterator_t
declare function xcb_xkb_list_components_keycodes_length(byval R as const xcb_xkb_list_components_reply_t ptr) as long
declare function xcb_xkb_list_components_keycodes_iterator(byval R as const xcb_xkb_list_components_reply_t ptr) as xcb_xkb_listing_iterator_t
declare function xcb_xkb_list_components_types_length(byval R as const xcb_xkb_list_components_reply_t ptr) as long
declare function xcb_xkb_list_components_types_iterator(byval R as const xcb_xkb_list_components_reply_t ptr) as xcb_xkb_listing_iterator_t
declare function xcb_xkb_list_components_compat_maps_length(byval R as const xcb_xkb_list_components_reply_t ptr) as long
declare function xcb_xkb_list_components_compat_maps_iterator(byval R as const xcb_xkb_list_components_reply_t ptr) as xcb_xkb_listing_iterator_t
declare function xcb_xkb_list_components_symbols_length(byval R as const xcb_xkb_list_components_reply_t ptr) as long
declare function xcb_xkb_list_components_symbols_iterator(byval R as const xcb_xkb_list_components_reply_t ptr) as xcb_xkb_listing_iterator_t
declare function xcb_xkb_list_components_geometries_length(byval R as const xcb_xkb_list_components_reply_t ptr) as long
declare function xcb_xkb_list_components_geometries_iterator(byval R as const xcb_xkb_list_components_reply_t ptr) as xcb_xkb_listing_iterator_t
declare function xcb_xkb_list_components_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_list_components_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_list_components_reply_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_types_map_types_rtrn_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_types_map_types_rtrn_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_key_type_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_types_map_syms_rtrn_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_types_map_syms_rtrn_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_key_sym_map_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_count(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as ubyte ptr
declare function xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_count_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_count_end(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_acts(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_action_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_acts_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_acts_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_action_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_types_map_behaviors_rtrn(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_set_behavior_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_types_map_behaviors_rtrn_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_types_map_behaviors_rtrn_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_set_behavior_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_types_map_vmods_rtrn(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as ubyte ptr
declare function xcb_xkb_get_kbd_by_name_replies_types_map_vmods_rtrn_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_types_map_vmods_rtrn_end(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_types_map_explicit_rtrn(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_set_explicit_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_types_map_explicit_rtrn_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_types_map_explicit_rtrn_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_set_explicit_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_types_map_modmap_rtrn(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_key_mod_map_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_types_map_modmap_rtrn_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_types_map_modmap_rtrn_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_key_mod_map_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_types_map_vmodmap_rtrn(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_key_v_mod_map_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_types_map_vmodmap_rtrn_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_types_map_vmodmap_rtrn_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_key_v_mod_map_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_types_map_serialize(byval _buffer as any ptr ptr, byval nTypes as ubyte, byval nKeySyms as ubyte, byval nKeyActions as ubyte, byval totalActions as ushort, byval totalKeyBehaviors as ubyte, byval virtualMods as ushort, byval totalKeyExplicit as ubyte, byval totalModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval present as ushort, byval _aux as const xcb_xkb_get_kbd_by_name_replies_types_map_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_types_map_unpack(byval _buffer as const any ptr, byval nTypes as ubyte, byval nKeySyms as ubyte, byval nKeyActions as ubyte, byval totalActions as ushort, byval totalKeyBehaviors as ubyte, byval virtualMods as ushort, byval totalKeyExplicit as ubyte, byval totalModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval present as ushort, byval _aux as xcb_xkb_get_kbd_by_name_replies_types_map_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_types_map_sizeof(byval _buffer as const any ptr, byval nTypes as ubyte, byval nKeySyms as ubyte, byval nKeyActions as ubyte, byval totalActions as ushort, byval totalKeyBehaviors as ubyte, byval virtualMods as ushort, byval totalKeyExplicit as ubyte, byval totalModMapKeys as ubyte, byval totalVModMapKeys as ubyte, byval present as ushort) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_type_names(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_type_names_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_type_names_end(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_n_levels_per_type(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as ubyte ptr
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_n_levels_per_type_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_n_levels_per_type_end(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_kt_level_names(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_kt_level_names_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_kt_level_names_end(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_indicator_names(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_indicator_names_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_indicator_names_end(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_virtual_mod_names(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_virtual_mod_names_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_virtual_mod_names_end(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_groups(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_groups_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_groups_end(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_names(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_key_name_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_names_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_names_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_key_name_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_aliases(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_key_alias_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_aliases_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_aliases_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_key_alias_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_radio_group_names(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_atom_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_radio_group_names_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_radio_group_names_end(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_serialize(byval _buffer as any ptr ptr, byval nTypes as ubyte, byval indicators as ulong, byval virtualMods as ushort, byval groupNames as ubyte, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval nRadioGroups as ubyte, byval which as ulong, byval _aux as const xcb_xkb_get_kbd_by_name_replies_key_names_value_list_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_unpack(byval _buffer as const any ptr, byval nTypes as ubyte, byval indicators as ulong, byval virtualMods as ushort, byval groupNames as ubyte, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval nRadioGroups as ubyte, byval which as ulong, byval _aux as xcb_xkb_get_kbd_by_name_replies_key_names_value_list_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list_sizeof(byval _buffer as const any ptr, byval nTypes as ubyte, byval indicators as ulong, byval virtualMods as ushort, byval groupNames as ubyte, byval nKeys as ubyte, byval nKeyAliases as ubyte, byval nRadioGroups as ubyte, byval which as ulong) as long
declare function xcb_xkb_get_kbd_by_name_replies_compat_map_si_rtrn(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_sym_interpret_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_compat_map_si_rtrn_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_compat_map_si_rtrn_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_sym_interpret_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_compat_map_group_rtrn(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_mod_def_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_compat_map_group_rtrn_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_compat_map_group_rtrn_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_mod_def_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_indicator_maps_maps(byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_indicator_map_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_indicator_maps_maps_length(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_indicator_maps_maps_iterator(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr, byval S as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_indicator_map_iterator_t
declare function xcb_xkb_get_kbd_by_name_replies_key_names_value_list(byval R as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_get_kbd_by_name_replies_key_names_value_list_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_geometry_label_font(byval R as const xcb_xkb_get_kbd_by_name_replies_t ptr) as xcb_xkb_counted_string_16_t ptr
declare function xcb_xkb_get_kbd_by_name_replies_serialize(byval _buffer as any ptr ptr, byval reported as ushort, byval _aux as const xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_unpack(byval _buffer as const any ptr, byval reported as ushort, byval _aux as xcb_xkb_get_kbd_by_name_replies_t ptr) as long
declare function xcb_xkb_get_kbd_by_name_replies_sizeof(byval _buffer as const any ptr, byval reported as ushort) as long
declare function xcb_xkb_get_kbd_by_name(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval need as ushort, byval want as ushort, byval load as ubyte) as xcb_xkb_get_kbd_by_name_cookie_t
declare function xcb_xkb_get_kbd_by_name_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval need as ushort, byval want as ushort, byval load as ubyte) as xcb_xkb_get_kbd_by_name_cookie_t
declare function xcb_xkb_get_kbd_by_name_replies(byval R as const xcb_xkb_get_kbd_by_name_reply_t ptr) as any ptr
declare function xcb_xkb_get_kbd_by_name_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_get_kbd_by_name_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_get_kbd_by_name_reply_t ptr
declare function xcb_xkb_get_device_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_get_device_info(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval wanted as ushort, byval allButtons as ubyte, byval firstButton as ubyte, byval nButtons as ubyte, byval ledClass as xcb_xkb_led_class_spec_t, byval ledID as xcb_xkb_id_spec_t) as xcb_xkb_get_device_info_cookie_t
declare function xcb_xkb_get_device_info_unchecked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval wanted as ushort, byval allButtons as ubyte, byval firstButton as ubyte, byval nButtons as ubyte, byval ledClass as xcb_xkb_led_class_spec_t, byval ledID as xcb_xkb_id_spec_t) as xcb_xkb_get_device_info_cookie_t
declare function xcb_xkb_get_device_info_name(byval R as const xcb_xkb_get_device_info_reply_t ptr) as xcb_xkb_string8_t ptr
declare function xcb_xkb_get_device_info_name_length(byval R as const xcb_xkb_get_device_info_reply_t ptr) as long
declare function xcb_xkb_get_device_info_name_end(byval R as const xcb_xkb_get_device_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xkb_get_device_info_btn_actions(byval R as const xcb_xkb_get_device_info_reply_t ptr) as xcb_xkb_action_t ptr
declare function xcb_xkb_get_device_info_btn_actions_length(byval R as const xcb_xkb_get_device_info_reply_t ptr) as long
declare function xcb_xkb_get_device_info_btn_actions_iterator(byval R as const xcb_xkb_get_device_info_reply_t ptr) as xcb_xkb_action_iterator_t
declare function xcb_xkb_get_device_info_leds_length(byval R as const xcb_xkb_get_device_info_reply_t ptr) as long
declare function xcb_xkb_get_device_info_leds_iterator(byval R as const xcb_xkb_get_device_info_reply_t ptr) as xcb_xkb_device_led_info_iterator_t
declare function xcb_xkb_get_device_info_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_get_device_info_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_get_device_info_reply_t ptr
declare function xcb_xkb_set_device_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_set_device_info_checked(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval firstBtn as ubyte, byval nBtns as ubyte, byval change as ushort, byval nDeviceLedFBs as ushort, byval btnActions as const xcb_xkb_action_t ptr, byval leds as const xcb_xkb_device_led_info_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_set_device_info(byval c as xcb_connection_t ptr, byval deviceSpec as xcb_xkb_device_spec_t, byval firstBtn as ubyte, byval nBtns as ubyte, byval change as ushort, byval nDeviceLedFBs as ushort, byval btnActions as const xcb_xkb_action_t ptr, byval leds as const xcb_xkb_device_led_info_t ptr) as xcb_void_cookie_t
declare function xcb_xkb_set_debugging_flags_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xkb_set_debugging_flags(byval c as xcb_connection_t ptr, byval msgLength as ushort, byval affectFlags as ulong, byval flags as ulong, byval affectCtrls as ulong, byval ctrls as ulong, byval message as const xcb_xkb_string8_t ptr) as xcb_xkb_set_debugging_flags_cookie_t
declare function xcb_xkb_set_debugging_flags_unchecked(byval c as xcb_connection_t ptr, byval msgLength as ushort, byval affectFlags as ulong, byval flags as ulong, byval affectCtrls as ulong, byval ctrls as ulong, byval message as const xcb_xkb_string8_t ptr) as xcb_xkb_set_debugging_flags_cookie_t
declare function xcb_xkb_set_debugging_flags_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xkb_set_debugging_flags_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xkb_set_debugging_flags_reply_t ptr

end extern
