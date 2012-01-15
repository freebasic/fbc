''
''
'' atkeditabletext -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkeditabletext_bi__
#define __atkeditabletext_bi__

#include once "atkobject.bi"
#include once "atktext.bi"

#define ATK_TYPE_EDITABLE_TEXT() atk_editable_text_get_type()
#define ATK_IS_EDITABLE_TEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_EDITABLE_TEXT)
#define ATK_EDITABLE_TEXT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_EDITABLE_TEXT, AtkEditableText)
#define ATK_EDITABLE_TEXT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_EDITABLE_TEXT, AtkEditableTextIface)

type AtkEditableText as _AtkEditableText
type AtkEditableTextIface as _AtkEditableTextIface

type _AtkEditableTextIface
	parent_interface as GTypeInterface
	set_run_attributes as function cdecl(byval as AtkEditableText ptr, byval as AtkAttributeSet ptr, byval as gint, byval as gint) as gboolean
	set_text_contents as sub cdecl(byval as AtkEditableText ptr, byval as zstring ptr)
	insert_text as sub cdecl(byval as AtkEditableText ptr, byval as zstring ptr, byval as gint, byval as gint ptr)
	copy_text as sub cdecl(byval as AtkEditableText ptr, byval as gint, byval as gint)
	cut_text as sub cdecl(byval as AtkEditableText ptr, byval as gint, byval as gint)
	delete_text as sub cdecl(byval as AtkEditableText ptr, byval as gint, byval as gint)
	paste_text as sub cdecl(byval as AtkEditableText ptr, byval as gint)
	pad1 as AtkFunction
	pad2 as AtkFunction
end type

declare function atk_editable_text_get_type () as GType
declare function atk_editable_text_set_run_attributes (byval text as AtkEditableText ptr, byval attrib_set as AtkAttributeSet ptr, byval start_offset as gint, byval end_offset as gint) as gboolean
declare sub atk_editable_text_set_text_contents (byval text as AtkEditableText ptr, byval string as zstring ptr)
declare sub atk_editable_text_insert_text (byval text as AtkEditableText ptr, byval string as zstring ptr, byval length as gint, byval position as gint ptr)
declare sub atk_editable_text_copy_text (byval text as AtkEditableText ptr, byval start_pos as gint, byval end_pos as gint)
declare sub atk_editable_text_cut_text (byval text as AtkEditableText ptr, byval start_pos as gint, byval end_pos as gint)
declare sub atk_editable_text_delete_text (byval text as AtkEditableText ptr, byval start_pos as gint, byval end_pos as gint)
declare sub atk_editable_text_paste_text (byval text as AtkEditableText ptr, byval position as gint)

#endif
