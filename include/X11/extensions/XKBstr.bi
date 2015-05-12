''
''
'' XKBstr -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __XKBstr_bi__
#define __XKBstr_bi__

type _XkbStateRec
	group as ubyte
	locked_group as ubyte
	base_group as ushort
	latched_group as ushort
	mods as ubyte
	base_mods as ubyte
	latched_mods as ubyte
	locked_mods as ubyte
	compat_state as ubyte
	grab_mods as ubyte
	compat_grab_mods as ubyte
	lookup_mods as ubyte
	compat_lookup_mods as ubyte
	ptr_buttons as ushort
end type

type XkbStateRec as _XkbStateRec
type XkbStatePtr as _XkbStateRec ptr

type _XkbMods
	mask as ubyte
	real_mods as ubyte
	vmods as ushort
end type

type XkbModsRec as _XkbMods
type XkbModsPtr as _XkbMods ptr

type _XkbKTMapEntry
	active as Bool
	level as ubyte
	mods as XkbModsRec
end type

type XkbKTMapEntryRec as _XkbKTMapEntry
type XkbKTMapEntryPtr as _XkbKTMapEntry ptr

type _XkbKeyType
	mods as XkbModsRec
	num_levels as ubyte
	map_count as ubyte
	map as XkbKTMapEntryPtr
	preserve as XkbModsPtr
	name as Atom
	level_names as Atom ptr
end type

type XkbKeyTypeRec as _XkbKeyType
type XkbKeyTypePtr as _XkbKeyType ptr

type _XkbBehavior
	type as ubyte
	data as ubyte
end type

type XkbBehavior as _XkbBehavior

#define XkbAnyActionDataSize 7

type _XkbAnyAction
	type as ubyte
	data(0 to 7-1) as ubyte
end type

type XkbAnyAction as _XkbAnyAction

type _XkbModAction
	type as ubyte
	flags as ubyte
	mask as ubyte
	real_mods as ubyte
	vmods1 as ubyte
	vmods2 as ubyte
end type

type XkbModAction as _XkbModAction

type _XkbGroupAction
	type as ubyte
	flags as ubyte
	group_XXX as byte
end type

type XkbGroupAction as _XkbGroupAction

type _XkbISOAction
	type as ubyte
	flags as ubyte
	mask as ubyte
	real_mods as ubyte
	group_XXX as byte
	affect as ubyte
	vmods1 as ubyte
	vmods2 as ubyte
end type

type XkbISOAction as _XkbISOAction

type _XkbPtrAction
	type as ubyte
	flags as ubyte
	high_XXX as ubyte
	low_XXX as ubyte
	high_YYY as ubyte
	low_YYY as ubyte
end type

type XkbPtrAction as _XkbPtrAction

type _XkbPtrBtnAction
	type as ubyte
	flags as ubyte
	count as ubyte
	button as ubyte
end type

type XkbPtrBtnAction as _XkbPtrBtnAction

type _XkbPtrDfltAction
	type as ubyte
	flags as ubyte
	affect as ubyte
	valueXXX as byte
end type

type XkbPtrDfltAction as _XkbPtrDfltAction

type _XkbSwitchScreenAction
	type as ubyte
	flags as ubyte
	screenXXX as byte
end type

type XkbSwitchScreenAction as _XkbSwitchScreenAction

type _XkbCtrlsAction
	type as ubyte
	flags as ubyte
	ctrls3 as ubyte
	ctrls2 as ubyte
	ctrls1 as ubyte
	ctrls0 as ubyte
end type

type XkbCtrlsAction as _XkbCtrlsAction

type _XkbMessageAction
	type as ubyte
	flags as ubyte
	message(0 to 6-1) as ubyte
end type

type XkbMessageAction as _XkbMessageAction

type _XkbRedirectKeyAction
	type as ubyte
	new_key as ubyte
	mods_mask as ubyte
	mods as ubyte
	vmods_mask0 as ubyte
	vmods_mask1 as ubyte
	vmods0 as ubyte
	vmods1 as ubyte
end type

type XkbRedirectKeyAction as _XkbRedirectKeyAction

type _XkbDeviceBtnAction
	type as ubyte
	flags as ubyte
	count as ubyte
	button as ubyte
	device as ubyte
end type

type XkbDeviceBtnAction as _XkbDeviceBtnAction

type _XkbDeviceValuatorAction
	type as ubyte
	device as ubyte
	v1_what as ubyte
	v1_ndx as ubyte
	v1_value as ubyte
	v2_what as ubyte
	v2_ndx as ubyte
	v2_value as ubyte
end type

type XkbDeviceValuatorAction as _XkbDeviceValuatorAction

union _XkbAction
	any as XkbAnyAction
	mods as XkbModAction
	group as XkbGroupAction
	iso as XkbISOAction
	ptr as XkbPtrAction
	btn as XkbPtrBtnAction
	dflt as XkbPtrDfltAction
	screen as XkbSwitchScreenAction
	ctrls as XkbCtrlsAction
	msg as XkbMessageAction
	redirect as XkbRedirectKeyAction
	devbtn as XkbDeviceBtnAction
	devval as XkbDeviceValuatorAction
	type as ubyte
end union

type XkbAction as _XkbAction

type _XkbControls
	mk_dflt_btn as ubyte
	num_groups as ubyte
	groups_wrap as ubyte
	internal as XkbModsRec
	ignore_lock as XkbModsRec
	enabled_ctrls as uinteger
	repeat_delay as ushort
	repeat_interval as ushort
	slow_keys_delay as ushort
	debounce_delay as ushort
	mk_delay as ushort
	mk_interval as ushort
	mk_time_to_max as ushort
	mk_max_speed as ushort
	mk_curve as short
	ax_options as ushort
	ax_timeout as ushort
	axt_opts_mask as ushort
	axt_opts_values as ushort
	axt_ctrls_mask as uinteger
	axt_ctrls_values as uinteger
	per_key_repeat(0 to XkbPerKeyBitArraySize-1) as ubyte
end type

type XkbControlsRec as _XkbControls
type XkbControlsPtr as _XkbControls ptr

type _XkbServerMapRec
	num_acts as ushort
	size_acts as ushort
	acts as XkbAction ptr
	behaviors as XkbBehavior ptr
	key_acts as ushort ptr
	explicit as ubyte ptr
	vmods(0 to XkbNumVirtualMods-1) as ubyte
	vmodmap as ushort ptr
end type

type XkbServerMapRec as _XkbServerMapRec
type XkbServerMapPtr as _XkbServerMapRec ptr

type _XkbSymMapRec
	kt_index(0 to XkbNumKbdGroups-1) as ubyte
	group_info as ubyte
	width as ubyte
	offset as ushort
end type

type XkbSymMapRec as _XkbSymMapRec
type XkbSymMapPtr as _XkbSymMapRec ptr

type _XkbClientMapRec
	size_types as ubyte
	num_types as ubyte
	types as XkbKeyTypePtr
	size_syms as ushort
	num_syms as ushort
	syms as KeySym ptr
	key_sym_map as XkbSymMapPtr
	modmap as ubyte ptr
end type

type XkbClientMapRec as _XkbClientMapRec
type XkbClientMapPtr as _XkbClientMapRec ptr

type _XkbSymInterpretRec
	sym as KeySym
	flags as ubyte
	match as ubyte
	mods as ubyte
	virtual_mod as ubyte
	act as XkbAnyAction
end type

type XkbSymInterpretRec as _XkbSymInterpretRec
type XkbSymInterpretPtr as _XkbSymInterpretRec ptr

type _XkbCompatMapRec
	sym_interpret as XkbSymInterpretPtr
	groups(0 to XkbNumKbdGroups-1) as XkbModsRec
	num_si as ushort
	size_si as ushort
end type

type XkbCompatMapRec as _XkbCompatMapRec
type XkbCompatMapPtr as _XkbCompatMapRec ptr

type _XkbIndicatorMapRec
	flags as ubyte
	which_groups as ubyte
	groups as ubyte
	which_mods as ubyte
	mods as XkbModsRec
	ctrls as uinteger
end type

type XkbIndicatorMapRec as _XkbIndicatorMapRec
type XkbIndicatorMapPtr as _XkbIndicatorMapRec ptr

type _XkbIndicatorRec
	phys_indicators as uinteger
	maps(0 to XkbNumIndicators-1) as XkbIndicatorMapRec
end type

type XkbIndicatorRec as _XkbIndicatorRec
type XkbIndicatorPtr as _XkbIndicatorRec ptr

type _XkbKeyNameRec
	name as zstring * XkbKeyNameLength
end type

type XkbKeyNameRec as _XkbKeyNameRec
type XkbKeyNamePtr as _XkbKeyNameRec ptr

type _XkbKeyAliasRec
	real as zstring * XkbKeyNameLength
	alias as zstring * XkbKeyNameLength
end type

type XkbKeyAliasRec as _XkbKeyAliasRec
type XkbKeyAliasPtr as _XkbKeyAliasRec ptr

type _XkbNamesRec
	keycodes as Atom
	geometry as Atom
	symbols as Atom
	types as Atom
	compat as Atom
	vmods(0 to XkbNumVirtualMods-1) as Atom
	indicators(0 to XkbNumIndicators-1) as Atom
	groups(0 to XkbNumKbdGroups-1) as Atom
	keys as XkbKeyNamePtr
	key_aliases as XkbKeyAliasPtr
	radio_groups as Atom ptr
	phys_symbols as Atom
	num_keys as ubyte
	num_key_aliases as ubyte
	num_rg as ushort
end type

type XkbNamesRec as _XkbNamesRec
type XkbNamesPtr as _XkbNamesRec ptr
type XkbGeometryPtr as _XkbGeometry ptr

type _XkbDesc
	dpy as _XDisplay ptr
	flags as ushort
	device_spec as ushort
	min_key_code as KeyCode
	max_key_code as KeyCode
	ctrls as XkbControlsPtr
	server as XkbServerMapPtr
	map as XkbClientMapPtr
	indicators as XkbIndicatorPtr
	names as XkbNamesPtr
	compat as XkbCompatMapPtr
	geom as XkbGeometryPtr
end type

type XkbDescRec as _XkbDesc
type XkbDescPtr as _XkbDesc ptr

type _XkbMapChanges
	changed as ushort
	min_key_code as KeyCode
	max_key_code as KeyCode
	first_type as ubyte
	num_types as ubyte
	first_key_sym as KeyCode
	num_key_syms as ubyte
	first_key_act as KeyCode
	num_key_acts as ubyte
	first_key_behavior as KeyCode
	num_key_behaviors as ubyte
	first_key_explicit as KeyCode
	num_key_explicit as ubyte
	first_modmap_key as KeyCode
	num_modmap_keys as ubyte
	first_vmodmap_key as KeyCode
	num_vmodmap_keys as ubyte
	pad as ubyte
	vmods as ushort
end type

type XkbMapChangesRec as _XkbMapChanges
type XkbMapChangesPtr as _XkbMapChanges ptr

type _XkbControlsChanges
	changed_ctrls as uinteger
	enabled_ctrls_changes as uinteger
	num_groups_changed as Bool
end type

type XkbControlsChangesRec as _XkbControlsChanges
type XkbControlsChangesPtr as _XkbControlsChanges ptr

type _XkbIndicatorChanges
	state_changes as uinteger
	map_changes as uinteger
end type

type XkbIndicatorChangesRec as _XkbIndicatorChanges
type XkbIndicatorChangesPtr as _XkbIndicatorChanges ptr

type _XkbNameChanges
	changed as uinteger
	first_type as ubyte
	num_types as ubyte
	first_lvl as ubyte
	num_lvls as ubyte
	num_aliases as ubyte
	num_rg as ubyte
	first_key as ubyte
	num_keys as ubyte
	changed_vmods as ushort
	changed_indicators as uinteger
	changed_groups as ubyte
end type

type XkbNameChangesRec as _XkbNameChanges
type XkbNameChangesPtr as _XkbNameChanges ptr

type _XkbCompatChanges
	changed_groups as ubyte
	first_si as ushort
	num_si as ushort
end type

type XkbCompatChangesRec as _XkbCompatChanges
type XkbCompatChangesPtr as _XkbCompatChanges ptr

type _XkbChanges
	device_spec as ushort
	state_changes as ushort
	map as XkbMapChangesRec
	ctrls as XkbControlsChangesRec
	indicators as XkbIndicatorChangesRec
	names as XkbNameChangesRec
	compat as XkbCompatChangesRec
end type

type XkbChangesRec as _XkbChanges
type XkbChangesPtr as _XkbChanges ptr

type _XkbComponentNames
	keymap as zstring ptr
	keycodes as zstring ptr
	types as zstring ptr
	compat as zstring ptr
	symbols as zstring ptr
	geometry as zstring ptr
end type

type XkbComponentNamesRec as _XkbComponentNames
type XkbComponentNamesPtr as _XkbComponentNames ptr

type _XkbComponentName
	flags as ushort
	name as zstring ptr
end type

type XkbComponentNameRec as _XkbComponentName
type XkbComponentNamePtr as _XkbComponentName ptr

type _XkbComponentList
	num_keymaps as integer
	num_keycodes as integer
	num_types as integer
	num_compat as integer
	num_symbols as integer
	num_geometry as integer
	keymaps as XkbComponentNamePtr
	keycodes as XkbComponentNamePtr
	types as XkbComponentNamePtr
	compat as XkbComponentNamePtr
	symbols as XkbComponentNamePtr
	geometry as XkbComponentNamePtr
end type

type XkbComponentListRec as _XkbComponentList
type XkbComponentListPtr as _XkbComponentList ptr

type _XkbDeviceLedInfo
	led_class as ushort
	led_id as ushort
	phys_indicators as uinteger
	maps_present as uinteger
	names_present as uinteger
	state as uinteger
	names(0 to XkbNumIndicators-1) as Atom
	maps(0 to XkbNumIndicators-1) as XkbIndicatorMapRec
end type

type XkbDeviceLedInfoRec as _XkbDeviceLedInfo
type XkbDeviceLedInfoPtr as _XkbDeviceLedInfo ptr

type _XkbDeviceInfo
	name as zstring ptr
	type as Atom
	device_spec as ushort
	has_own_state as Bool
	supported as ushort
	unsupported as ushort
	num_btns as ushort
	btn_acts as XkbAction ptr
	sz_leds as ushort
	num_leds as ushort
	dflt_kbd_fb as ushort
	dflt_led_fb as ushort
	leds as XkbDeviceLedInfoPtr
end type

type XkbDeviceInfoRec as _XkbDeviceInfo
type XkbDeviceInfoPtr as _XkbDeviceInfo ptr

type _XkbDeviceLedChanges
	led_class as ushort
	led_id as ushort
	defined as uinteger
	next as _XkbDeviceLedChanges ptr
end type

type XkbDeviceLedChangesRec as _XkbDeviceLedChanges
type XkbDeviceLedChangesPtr as _XkbDeviceLedChanges ptr

type _XkbDeviceChanges
	changed as uinteger
	first_btn as ushort
	num_btns as ushort
	leds as XkbDeviceLedChangesRec
end type

type XkbDeviceChangesRec as _XkbDeviceChanges
type XkbDeviceChangesPtr as _XkbDeviceChanges ptr

#endif
