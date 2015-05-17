'' FreeBASIC binding for kbproto-1.0.6
''
'' based on the C header files:
''   **********************************************************
''   Copyright (c) 1993 by Silicon Graphics Computer Systems, Inc.
''
''   Permission to use, copy, modify, and distribute this
''   software and its documentation for any purpose and without
''   fee is hereby granted, provided that the above copyright
''   notice appear in all copies and that both that copyright
''   notice and this permission notice appear in supporting
''   documentation, and that the name of Silicon Graphics not be 
''   used in advertising or publicity pertaining to distribution 
''   of the software without specific prior written permission.
''   Silicon Graphics makes no representation about the suitability 
''   of this software for any purpose. It is provided "as is"
''   without any express or implied warranty.
''
''   SILICON GRAPHICS DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
''   SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY 
''   AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL SILICON
''   GRAPHICS BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL 
''   DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, 
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE 
''   OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
''   THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/extensions/XKB.bi"

#define _XKBSTR_H_
#define XkbCharToInt(v) iif((v) and &h80, clng((v) or (not &hff)), clng((v) and &h7f))
#macro XkbIntTo2Chars(i, h, l)
	scope
		(h) = (i shr 8) and &hff
		(l) = (i) and &hff
	end scope
#endmacro
#define Xkb2CharsToInt(h, l) cshort(((h) shl 8) or (l))

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
#define XkbModLocks(s) (s)->locked_mods
#define XkbStateMods(s) (((s)->base_mods or (s)->latched_mods) or XkbModLocks(s))
#define XkbGroupLock(s) (s)->locked_group
#define XkbStateGroup(s) (((s)->base_group + (s)->latched_group) + XkbGroupLock(s))
#define XkbStateFieldFromRec(s) XkbBuildCoreState((s)->lookup_mods, (s)->group)
#define XkbGrabStateFromRec(s) XkbBuildCoreState((s)->grab_mods, (s)->group)

type _XkbMods
	mask as ubyte
	real_mods as ubyte
	vmods as ushort
end type

type XkbModsRec as _XkbMods
type XkbModsPtr as _XkbMods ptr

type _XkbKTMapEntry
	active as long
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
	name as XAtom
	level_names as XAtom ptr
end type

type XkbKeyTypeRec as _XkbKeyType
type XkbKeyTypePtr as _XkbKeyType ptr
#define XkbNumGroups(g) ((g) and &h0f)
#define XkbOutOfRangeGroupInfo(g) ((g) and &hf0)
#define XkbOutOfRangeGroupAction(g) ((g) and &hc0)
#define XkbOutOfRangeGroupNumber(g) (((g) and &h30) shr 4)
#define XkbSetGroupInfo(g, w, n) ((((w) and &hc0) or (((n) and 3) shl 4)) or ((g) and &h0f))
#define XkbSetNumGroups(g, n) (((g) and &hf0) or ((n) and &h0f))

type _XkbBehavior
	as ubyte type
	data as ubyte
end type

type XkbBehavior as _XkbBehavior
const XkbAnyActionDataSize = 7

type _XkbAnyAction
	as ubyte type
	data(0 to 6) as ubyte
end type

type XkbAnyAction as _XkbAnyAction

type _XkbModAction
	as ubyte type
	flags as ubyte
	mask as ubyte
	real_mods as ubyte
	vmods1 as ubyte
	vmods2 as ubyte
end type

type XkbModAction as _XkbModAction
#define XkbModActionVMods(a) cshort(((a)->vmods1 shl 8) or (a)->vmods2)
#macro XkbSetModActionVMods(a, v)
	scope
		(a)->vmods1 = ((v) shr 8) and &hff
		(a)->vmods2 = (v) and &hff
	end scope
#endmacro

type _XkbGroupAction
	as ubyte type
	flags as ubyte
	group_XXX as byte
end type

type XkbGroupAction as _XkbGroupAction
#define XkbSAGroup(a) XkbCharToInt((a)->group_XXX)
#define XkbSASetGroup(a, g) scope : (a)->group_XXX = (g) : end scope

type _XkbISOAction
	as ubyte type
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
	as ubyte type
	flags as ubyte
	high_XXX as ubyte
	low_XXX as ubyte
	high_YYY as ubyte
	low_YYY as ubyte
end type

type XkbPtrAction as _XkbPtrAction
#define XkbPtrActionX(a) Xkb2CharsToInt((a)->high_XXX, (a)->low_XXX)
#define XkbPtrActionY(a) Xkb2CharsToInt((a)->high_YYY, (a)->low_YYY)
#define XkbSetPtrActionX(a, x) XkbIntTo2Chars(x, (a)->high_XXX, (a)->low_XXX)
#define XkbSetPtrActionY(a, y) XkbIntTo2Chars(y, (a)->high_YYY, (a)->low_YYY)

type _XkbPtrBtnAction
	as ubyte type
	flags as ubyte
	count as ubyte
	button as ubyte
end type

type XkbPtrBtnAction as _XkbPtrBtnAction

type _XkbPtrDfltAction
	as ubyte type
	flags as ubyte
	affect as ubyte
	valueXXX as byte
end type

type XkbPtrDfltAction as _XkbPtrDfltAction
#define XkbSAPtrDfltValue(a) XkbCharToInt((a)->valueXXX)
#define XkbSASetPtrDfltValue(a, c) scope : (a)->valueXXX = (c) and &hff : end scope

type _XkbSwitchScreenAction
	as ubyte type
	flags as ubyte
	screenXXX as byte
end type

type XkbSwitchScreenAction as _XkbSwitchScreenAction
#define XkbSAScreen(a) XkbCharToInt((a)->screenXXX)
#define XkbSASetScreen(a, s) scope : (a)->screenXXX = (s) and &hff : end scope

type _XkbCtrlsAction
	as ubyte type
	flags as ubyte
	ctrls3 as ubyte
	ctrls2 as ubyte
	ctrls1 as ubyte
	ctrls0 as ubyte
end type

type XkbCtrlsAction as _XkbCtrlsAction
#macro XkbActionSetCtrls(a, c)
	scope
		(a)->ctrls3 = ((c) shr 24) and &hff
		(a)->ctrls2 = ((c) shr 16) and &hff
		(a)->ctrls1 = ((c) shr 8) and &hff
		(a)->ctrls0 = (c) and &hff
	end scope
#endmacro
#define XkbActionCtrls(a) culng(culng(culng(culng(culng((a)->ctrls3) shl 24) or culng(culng((a)->ctrls2) shl 16)) or culng(culng((a)->ctrls1) shl 8)) or culng((a)->ctrls0))

type _XkbMessageAction
	as ubyte type
	flags as ubyte
	message(0 to 5) as ubyte
end type

type XkbMessageAction as _XkbMessageAction

type _XkbRedirectKeyAction
	as ubyte type
	new_key as ubyte
	mods_mask as ubyte
	mods as ubyte
	vmods_mask0 as ubyte
	vmods_mask1 as ubyte
	vmods0 as ubyte
	vmods1 as ubyte
end type

type XkbRedirectKeyAction as _XkbRedirectKeyAction
#define XkbSARedirectVMods(a) culng(culng(culng((a)->vmods1) shl 8) or culng((a)->vmods0))
#macro XkbSARedirectSetVMods(a, m)
	scope
		(a)->vmods_mask1 = ((m) shr 8) and &hff
		(a)->vmods_mask0 = (m) and &hff
	end scope
#endmacro
#define XkbSARedirectVModsMask(a) culng(culng(culng((a)->vmods_mask1) shl 8) or culng((a)->vmods_mask0))
#macro XkbSARedirectSetVModsMask(a, m)
	scope
		(a)->vmods_mask1 = ((m) shr 8) and &hff
		(a)->vmods_mask0 = (m) and &hff
	end scope
#endmacro

type _XkbDeviceBtnAction
	as ubyte type
	flags as ubyte
	count as ubyte
	button as ubyte
	device as ubyte
end type

type XkbDeviceBtnAction as _XkbDeviceBtnAction

type _XkbDeviceValuatorAction
	as ubyte type
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
	as ubyte type
end union

type XkbAction as _XkbAction

type _XkbControls
	mk_dflt_btn as ubyte
	num_groups as ubyte
	groups_wrap as ubyte
	internal as XkbModsRec
	ignore_lock as XkbModsRec
	enabled_ctrls as ulong
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
	axt_ctrls_mask as ulong
	axt_ctrls_values as ulong
	per_key_repeat(0 to ((255 + 1) / 8) - 1) as ubyte
end type

type XkbControlsRec as _XkbControls
type XkbControlsPtr as _XkbControls ptr
#define XkbAX_AnyFeedback(c) ((c)->enabled_ctrls and XkbAccessXFeedbackMask)
#define XkbAX_NeedOption(c, w) ((c)->ax_options and (w))
#define XkbAX_NeedFeedback(c, w) (XkbAX_AnyFeedback(c) andalso XkbAX_NeedOption(c, w))

type _XkbServerMapRec
	num_acts as ushort
	size_acts as ushort
	acts as XkbAction ptr
	behaviors as XkbBehavior ptr
	key_acts as ushort ptr
	explicit as ubyte ptr
	vmods(0 to 15) as ubyte
	vmodmap as ushort ptr
end type

type XkbServerMapRec as _XkbServerMapRec
type XkbServerMapPtr as _XkbServerMapRec ptr
#define XkbSMKeyActionsPtr(m, k) (@(m)->acts[(m)->key_acts[k]])

type _XkbSymMapRec
	kt_index(0 to 3) as ubyte
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
#define XkbCMKeyGroupInfo(m, k) (m)->key_sym_map[k].group_info
#define XkbCMKeyNumGroups(m, k) XkbNumGroups((m)->key_sym_map[k].group_info)
#define XkbCMKeyGroupWidth(m, k, g) XkbCMKeyType(m, k, g)->num_levels
#define XkbCMKeyGroupsWidth(m, k) (m)->key_sym_map[k].width
#define XkbCMKeyTypeIndex(m, k, g) (m)->key_sym_map[k].kt_index[(g and &h3)]
#define XkbCMKeyType(m, k, g) (@(m)->types[XkbCMKeyTypeIndex(m, k, g)])
#define XkbCMKeyNumSyms(m, k) (XkbCMKeyGroupsWidth(m, k) * XkbCMKeyNumGroups(m, k))
#define XkbCMKeySymsOffset(m, k) (m)->key_sym_map[k].offset
#define XkbCMKeySymsPtr(m, k) (@(m)->syms[XkbCMKeySymsOffset(m, k)])

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
	groups(0 to 3) as XkbModsRec
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
	ctrls as ulong
end type

type XkbIndicatorMapRec as _XkbIndicatorMapRec
type XkbIndicatorMapPtr as _XkbIndicatorMapRec ptr
#define XkbIM_IsAuto(i) ((((i)->flags and XkbIM_NoAutomatic) = 0) andalso ((((i)->which_groups andalso (i)->groups) orelse ((i)->which_mods andalso (i)->mods.mask)) orelse (i)->ctrls))
#define XkbIM_InUse(i) ((((i)->flags orelse (i)->which_groups) orelse (i)->which_mods) orelse (i)->ctrls)

type _XkbIndicatorRec
	phys_indicators as culong
	maps(0 to 31) as XkbIndicatorMapRec
end type

type XkbIndicatorRec as _XkbIndicatorRec
type XkbIndicatorPtr as _XkbIndicatorRec ptr

type _XkbKeyNameRec
	name as zstring * 4
end type

type XkbKeyNameRec as _XkbKeyNameRec
type XkbKeyNamePtr as _XkbKeyNameRec ptr

type _XkbKeyAliasRec
	real as zstring * 4
	alias as zstring * 4
end type

type XkbKeyAliasRec as _XkbKeyAliasRec
type XkbKeyAliasPtr as _XkbKeyAliasRec ptr

type _XkbNamesRec
	keycodes as XAtom
	geometry as XAtom
	symbols as XAtom
	types as XAtom
	compat as XAtom
	vmods(0 to 15) as XAtom
	indicators(0 to 31) as XAtom
	groups(0 to 3) as XAtom
	keys as XkbKeyNamePtr
	key_aliases as XkbKeyAliasPtr
	radio_groups as XAtom ptr
	phys_symbols as XAtom
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
#define XkbKeyKeyTypeIndex(d, k, g) XkbCMKeyTypeIndex((d)->map, k, g)
#define XkbKeyKeyType(d, k, g) XkbCMKeyType((d)->map, k, g)
#define XkbKeyGroupWidth(d, k, g) XkbCMKeyGroupWidth((d)->map, k, g)
#define XkbKeyGroupsWidth(d, k) XkbCMKeyGroupsWidth((d)->map, k)
#define XkbKeyGroupInfo(d, k) XkbCMKeyGroupInfo((d)->map, (k))
#define XkbKeyNumGroups(d, k) XkbCMKeyNumGroups((d)->map, (k))
#define XkbKeyNumSyms(d, k) XkbCMKeyNumSyms((d)->map, (k))
#define XkbKeySymsPtr(d, k) XkbCMKeySymsPtr((d)->map, (k))
#define XkbKeySym(d, k, n) XkbKeySymsPtr(d, k)[n]
#define XkbKeySymEntry(d, k, sl, g) XkbKeySym(d, k, (XkbKeyGroupsWidth(d, k) * (g)) + (sl))
#define XkbKeyAction(d, k, n) iif(XkbKeyHasActions(d, k), @XkbKeyActionsPtr(d, k)[n], NULL)
#define XkbKeyActionEntry(d, k, sl, g) iif(XkbKeyHasActions(d, k), XkbKeyAction(d, k, (XkbKeyGroupsWidth(d, k) * (g)) + (sl)), NULL)
#define XkbKeyHasActions(d, k) ((d)->server->key_acts[k] <> 0)
#define XkbKeyNumActions(d, k) iif(XkbKeyHasActions(d, k), XkbKeyNumSyms(d, k), 1)
#define XkbKeyActionsPtr(d, k) XkbSMKeyActionsPtr((d)->server, k)
#define XkbKeycodeInRange(d, k) (((k) >= (d)->min_key_code) andalso ((k) <= (d)->max_key_code))
#define XkbNumKeys(d) (((d)->max_key_code - (d)->min_key_code) + 1)

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
	changed_ctrls as ulong
	enabled_ctrls_changes as ulong
	num_groups_changed as long
end type

type XkbControlsChangesRec as _XkbControlsChanges
type XkbControlsChangesPtr as _XkbControlsChanges ptr

type _XkbIndicatorChanges
	state_changes as ulong
	map_changes as ulong
end type

type XkbIndicatorChangesRec as _XkbIndicatorChanges
type XkbIndicatorChangesPtr as _XkbIndicatorChanges ptr

type _XkbNameChanges
	changed as ulong
	first_type as ubyte
	num_types as ubyte
	first_lvl as ubyte
	num_lvls as ubyte
	num_aliases as ubyte
	num_rg as ubyte
	first_key as ubyte
	num_keys as ubyte
	changed_vmods as ushort
	changed_indicators as culong
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
	num_keymaps as long
	num_keycodes as long
	num_types as long
	num_compat as long
	num_symbols as long
	num_geometry as long
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
	phys_indicators as ulong
	maps_present as ulong
	names_present as ulong
	state as ulong
	names(0 to 31) as XAtom
	maps(0 to 31) as XkbIndicatorMapRec
end type

type XkbDeviceLedInfoRec as _XkbDeviceLedInfo
type XkbDeviceLedInfoPtr as _XkbDeviceLedInfo ptr

type _XkbDeviceInfo
	name as zstring ptr
	as XAtom type
	device_spec as ushort
	has_own_state as long
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
#define XkbXI_DevHasBtnActs(d) (((d)->num_btns > 0) andalso ((d)->btn_acts <> NULL))
#define XkbXI_LegalDevBtn(d, b) (XkbXI_DevHasBtnActs(d) andalso ((b) < (d)->num_btns))
#define XkbXI_DevHasLeds(d) (((d)->num_leds > 0) andalso ((d)->leds <> NULL))

type _XkbDeviceLedChanges
	led_class as ushort
	led_id as ushort
	defined as ulong
	next as _XkbDeviceLedChanges ptr
end type

type XkbDeviceLedChangesRec as _XkbDeviceLedChanges
type XkbDeviceLedChangesPtr as _XkbDeviceLedChanges ptr

type _XkbDeviceChanges
	changed as ulong
	first_btn as ushort
	num_btns as ushort
	leds as XkbDeviceLedChangesRec
end type

type XkbDeviceChangesRec as _XkbDeviceChanges
type XkbDeviceChangesPtr as _XkbDeviceChanges ptr
