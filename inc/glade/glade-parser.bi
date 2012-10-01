''
''
'' glade-parser -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __glade_parser_bi__
#define __glade_parser_bi__

#include once "glib.bi"
#include once "gdk/gdk.bi"

type GladeProperty as _GladeProperty

type _GladeProperty
	name as zstring ptr
	value as zstring ptr
end type

type GladeSignalInfo as _GladeSignalInfo

type _GladeSignalInfo
	name as zstring ptr
	handler as zstring ptr
	object as zstring ptr
	after as guint
end type

type GladeAtkActionInfo as _GladeAtkActionInfo

type _GladeAtkActionInfo
	action_name as zstring ptr
	description as zstring ptr
end type

type GladeAtkRelationInfo as _GladeAtkRelationInfo

type _GladeAtkRelationInfo
	target as zstring ptr
	type as zstring ptr
end type

type GladeAccelInfo as _GladeAccelInfo

type _GladeAccelInfo
	key as guint
	modifiers as GdkModifierType
	signal as zstring ptr
end type

type GladeWidgetInfo as _GladeWidgetInfo
type GladeChildInfo as _GladeChildInfo

type _GladeWidgetInfo
	parent as GladeWidgetInfo ptr
	classname as zstring ptr
	name as zstring ptr
	properties as GladeProperty ptr
	n_properties as guint
	atk_props as GladeProperty ptr
	n_atk_props as guint
	signals as GladeSignalInfo ptr
	n_signals as guint
	atk_actions as GladeAtkActionInfo ptr
	n_atk_actions as guint
	relations as GladeAtkRelationInfo ptr
	n_relations as guint
	accels as GladeAccelInfo ptr
	n_accels as guint
	children as GladeChildInfo ptr
	n_children as guint
end type

type _GladeChildInfo
	properties as GladeProperty ptr
	n_properties as guint
	child as GladeWidgetInfo ptr
	internal_child as zstring ptr
end type

type GladeInterface as _GladeInterface

type _GladeInterface
	requires as zstring ptr ptr
	n_requires as guint
	toplevels as GladeWidgetInfo ptr ptr
	n_toplevels as guint
	names as GHashTable ptr
	strings as GHashTable ptr
end type

declare function glade_parser_parse_file (byval file as zstring ptr, byval domain as zstring ptr) as GladeInterface ptr
declare function glade_parser_parse_buffer (byval buffer as zstring ptr, byval len as gint, byval domain as zstring ptr) as GladeInterface ptr
declare sub glade_interface_destroy (byval interface as GladeInterface ptr)
declare sub glade_interface_dump (byval interface as GladeInterface ptr, byval filename as zstring ptr)

#endif
