''
''
'' atknoopobject -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atknoopobject_bi__
#define __atknoopobject_bi__

#define ATK_TYPE_NO_OP_OBJECT() atk_no_op_object_get_type()
#define ATK_NO_OP_OBJECT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_NO_OP_OBJECT, AtkNoOpObject)
#define ATK_NO_OP_OBJECT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_NO_OP_OBJECT, AtkNoOpObjectClass)
#define ATK_IS_NO_OP_OBJECT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_NO_OP_OBJECT)
#define ATK_IS_NO_OP_OBJECT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_NO_OP_OBJECT)
#define ATK_NO_OP_OBJECT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_NO_OP_OBJECT, AtkNoOpObjectClass)

type AtkNoOpObject as _AtkNoOpObject
type AtkNoOpObjectClass as _AtkNoOpObjectClass

type _AtkNoOpObject
	parent as AtkObject
end type

declare function atk_no_op_object_get_type () as GType

type _AtkNoOpObjectClass
	parent_class as AtkObjectClass
end type

declare function atk_no_op_object_new (byval obj as GObject ptr) as AtkObject ptr

#endif
