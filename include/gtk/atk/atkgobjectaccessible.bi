''
''
'' atkgobjectaccessible -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkgobjectaccessible_bi__
#define __atkgobjectaccessible_bi__

#include once "gtk/atk.bi"

#define ATK_TYPE_GOBJECT_ACCESSIBLE() atk_gobject_accessible_get_type()
#define ATK_GOBJECT_ACCESSIBLE(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_GOBJECT_ACCESSIBLE, AtkGObjectAccessible)
#define ATK_GOBJECT_ACCESSIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_GOBJECT_ACCESSIBLE, AtkGObjectAccessibleClass)
#define ATK_IS_GOBJECT_ACCESSIBLE(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_GOBJECT_ACCESSIBLE)
#define ATK_IS_GOBJECT_ACCESSIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_GOBJECT_ACCESSIBLE)
#define ATK_GOBJECT_ACCESSIBLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_GOBJECT_ACCESSIBLE, AtkGObjectAccessibleClass)

type AtkGObjectAccessible as _AtkGObjectAccessible
type AtkGObjectAccessibleClass as _AtkGObjectAccessibleClass

type _AtkGObjectAccessible
	parent as AtkObject
end type

declare function atk_gobject_accessible_get_type () as GType

type _AtkGObjectAccessibleClass
	parent_class as AtkObjectClass
	pad1 as AtkFunction
	pad2 as AtkFunction
end type

declare function atk_gobject_accessible_for_object (byval obj as GObject ptr) as AtkObject ptr
declare function atk_gobject_accessible_get_object (byval obj as AtkGObjectAccessible ptr) as GObject ptr

#endif
