''
''
'' atkhyperlink -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkhyperlink_bi__
#define __atkhyperlink_bi__

#include once "atkaction.bi"

#define ATK_TYPE_HYPERLINK() atk_hyperlink_get_type()
#define ATK_HYPERLINK(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_HYPERLINK, AtkHyperlink)
#define ATK_HYPERLINK_CLASS(klass) G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_HYPERLINK, AtkHyperlinkClass)
#define ATK_IS_HYPERLINK(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_HYPERLINK)
#define ATK_IS_HYPERLINK_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_HYPERLINK)
#define ATK_HYPERLINK_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_HYPERLINK, AtkHyperlinkClass)

enum AtkHyperlinkStateFlags
	ATK_HYPERLINK_IS_INLINE_ = 1 shl 0
end enum

type AtkHyperlink as _AtkHyperlink
type AtkHyperlinkClass as _AtkHyperlinkClass

type _AtkHyperlink
	parent as GObject
end type

type _AtkHyperlinkClass
	parent as GObjectClass
	get_uri as function cdecl(byval as AtkHyperlink ptr, byval as gint) as gchar
	get_object as function cdecl(byval as AtkHyperlink ptr, byval as gint) as AtkObject
	get_end_index as function cdecl(byval as AtkHyperlink ptr) as gint
	get_start_index as function cdecl(byval as AtkHyperlink ptr) as gint
	is_valid as function cdecl(byval as AtkHyperlink ptr) as gboolean
	get_n_anchors as function cdecl(byval as AtkHyperlink ptr) as gint
	link_state as function cdecl(byval as AtkHyperlink ptr) as guint
	is_selected_link as function cdecl(byval as AtkHyperlink ptr) as gboolean
	link_activated as sub cdecl(byval as AtkHyperlink ptr)
	pad1 as AtkFunction
end type

declare function atk_hyperlink_get_type () as GType
declare function atk_hyperlink_get_uri (byval link_ as AtkHyperlink ptr, byval i as gint) as zstring ptr
declare function atk_hyperlink_get_object (byval link_ as AtkHyperlink ptr, byval i as gint) as AtkObject ptr
declare function atk_hyperlink_get_end_index (byval link_ as AtkHyperlink ptr) as gint
declare function atk_hyperlink_get_start_index (byval link_ as AtkHyperlink ptr) as gint
declare function atk_hyperlink_is_valid (byval link_ as AtkHyperlink ptr) as gboolean
declare function atk_hyperlink_is_inline (byval link_ as AtkHyperlink ptr) as gboolean
declare function atk_hyperlink_get_n_anchors (byval link_ as AtkHyperlink ptr) as gint
declare function atk_hyperlink_is_selected_link (byval link_ as AtkHyperlink ptr) as gboolean

#endif
