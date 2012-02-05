' This is file glib-object.bi
' (FreeBasic binding for glib-object library version 2.28.0)
'
' (C) 2011 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
' translated with help of h_2_bi.bas
' (http://www.freebasic-portal.de/downloads/ressourcencompiler/h2bi-bas-134.html)
'
' Licence:
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
'
' Original license text:
'
'/* GObject - GLib Type, Object, Parameter and Signal Library
 '* Copyright (C) 1998, 1999, 2000 Tim Janik and Red Hat, Inc.
 '*
 '* This library is free software; you can redistribute it and/or
 '* modify it under the terms of the GNU Lesser General Public
 '* License as published by the Free Software Foundation; either
 '* version 2 of the License, or (at your option) any later version.
 '*
 '* This library is distributed in the hope that it will be useful,
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the GNU
 '* Lesser General Public License for more details.
 '*
 '* You should have received a copy of the GNU Lesser General
 '* Public License along with this library; if not, write to the
 '* Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 '* Boston, MA 02111-1307, USA.
 '*/

#IFDEF __FB_WIN32__
#PRAGMA push(msbitfields)
#ENDIF

#INCLIB "gobject-2.0"

EXTERN "C"

#IFNDEF __GLIB_GOBJECT_H__
#DEFINE __GLIB_GOBJECT_H__
#DEFINE __GLIB_GOBJECT_H_INSIDE__

#IFNDEF __G_BINDING_H__
#DEFINE __G_BINDING_H__
#INCLUDE ONCE "glib.bi"

#IFNDEF __G_OBJECT_H__
#DEFINE __G_OBJECT_H__

#IFNDEF __G_TYPE_H__
#DEFINE __G_TYPE_H__

#DEFINE G_TYPE_FUNDAMENTAL(type) (g_type_fundamental_FB (type))
#DEFINE G_TYPE_FUNDAMENTAL_MAX (255 SHL G_TYPE_FUNDAMENTAL_SHIFT)
#DEFINE G_TYPE_INVALID G_TYPE_MAKE_FUNDAMENTAL (0)
#DEFINE G_TYPE_NONE G_TYPE_MAKE_FUNDAMENTAL (1)
#DEFINE G_TYPE_INTERFACE G_TYPE_MAKE_FUNDAMENTAL (2)
#DEFINE G_TYPE_CHAR G_TYPE_MAKE_FUNDAMENTAL (3)
#DEFINE G_TYPE_UCHAR G_TYPE_MAKE_FUNDAMENTAL (4)
#DEFINE G_TYPE_BOOLEAN G_TYPE_MAKE_FUNDAMENTAL (5)
#DEFINE G_TYPE_INT G_TYPE_MAKE_FUNDAMENTAL (6)
#DEFINE G_TYPE_UINT G_TYPE_MAKE_FUNDAMENTAL (7)
#DEFINE G_TYPE_LONG G_TYPE_MAKE_FUNDAMENTAL (8)
#DEFINE G_TYPE_ULONG G_TYPE_MAKE_FUNDAMENTAL (9)
#DEFINE G_TYPE_INT64 G_TYPE_MAKE_FUNDAMENTAL (10)
#DEFINE G_TYPE_UINT64 G_TYPE_MAKE_FUNDAMENTAL (11)
#DEFINE G_TYPE_ENUM G_TYPE_MAKE_FUNDAMENTAL (12)
#DEFINE G_TYPE_FLAGS G_TYPE_MAKE_FUNDAMENTAL (13)
#DEFINE G_TYPE_FLOAT G_TYPE_MAKE_FUNDAMENTAL (14)
#DEFINE G_TYPE_DOUBLE G_TYPE_MAKE_FUNDAMENTAL (15)
#DEFINE G_TYPE_STRING G_TYPE_MAKE_FUNDAMENTAL (16)
#DEFINE G_TYPE_POINTER G_TYPE_MAKE_FUNDAMENTAL (17)
#DEFINE G_TYPE_BOXED G_TYPE_MAKE_FUNDAMENTAL (18)
#DEFINE G_TYPE_PARAM G_TYPE_MAKE_FUNDAMENTAL (19)
#DEFINE G_TYPE_OBJECT G_TYPE_MAKE_FUNDAMENTAL (20)
#DEFINE G_TYPE_VARIANT G_TYPE_MAKE_FUNDAMENTAL (21)
#DEFINE G_TYPE_FUNDAMENTAL_SHIFT (2)
#DEFINE G_TYPE_MAKE_FUNDAMENTAL(x) (CAST(GType, ((x) SHL G_TYPE_FUNDAMENTAL_SHIFT)))
#DEFINE G_TYPE_RESERVED_GLIB_FIRST (22)
#DEFINE G_TYPE_RESERVED_GLIB_LAST (31)
#DEFINE G_TYPE_RESERVED_BSE_FIRST (32)
#DEFINE G_TYPE_RESERVED_BSE_LAST (48)
#DEFINE G_TYPE_RESERVED_USER_FIRST (49)
#DEFINE G_TYPE_IS_FUNDAMENTAL(type) ((type) <= G_TYPE_FUNDAMENTAL_MAX)
#DEFINE G_TYPE_IS_DERIVED(type) ((type) > G_TYPE_FUNDAMENTAL_MAX)
#DEFINE G_TYPE_IS_INTERFACE(type) (G_TYPE_FUNDAMENTAL (type)= G_TYPE_INTERFACE)
#DEFINE G_TYPE_IS_CLASSED(type) (g_type_test_flags ((type), G_TYPE_FLAG_CLASSED))
#DEFINE G_TYPE_IS_INSTANTIATABLE(type) (g_type_test_flags ((type), G_TYPE_FLAG_INSTANTIATABLE))
#DEFINE G_TYPE_IS_DERIVABLE(type) (g_type_test_flags ((type), G_TYPE_FLAG_DERIVABLE))
#DEFINE G_TYPE_IS_DEEP_DERIVABLE(type) (g_type_test_flags ((type), G_TYPE_FLAG_DEEP_DERIVABLE))
#DEFINE G_TYPE_IS_ABSTRACT(type) (g_type_test_flags ((type), G_TYPE_FLAG_ABSTRACT))
#DEFINE G_TYPE_IS_VALUE_ABSTRACT(type) (g_type_test_flags ((type), G_TYPE_FLAG_VALUE_ABSTRACT))
#DEFINE G_TYPE_IS_VALUE_TYPE(type) (g_type_check_is_value_type (type))
#DEFINE G_TYPE_HAS_VALUE_TABLE(type) (g_type_value_table_peek (type) <> NULL)

#IF GLIB_SIZEOF_SIZE_T <> GLIB_SIZEOF_LONG OR NOT DEFINED (__cplusplus)

TYPE GType AS gsize

#ELSE ' GLIB_SIZEOF_SIZE_T

TYPE GType AS gulong

#ENDIF ' GLIB_SIZEOF_SIZE_T

TYPE GValue AS _GValue
TYPE GTypeCValue AS _GTypeCValue
TYPE GTypePlugin AS _GTypePlugin
TYPE GTypeClass AS _GTypeClass
TYPE GTypeInterface AS _GTypeInterface
TYPE GTypeInstance AS _GTypeInstance
TYPE GTypeInfo AS _GTypeInfo
TYPE GTypeFundamentalInfo AS _GTypeFundamentalInfo
TYPE GInterfaceInfo AS _GInterfaceInfo
TYPE GTypeValueTable AS _GTypeValueTable
TYPE GTypeQuery AS _GTypeQuery

TYPE _GTypeClass
  AS GType g_type
END TYPE

TYPE _GTypeInstance
  AS GTypeClass PTR g_class
END TYPE

TYPE _GTypeInterface
  AS GType g_type
  AS GType g_instance_type
END TYPE

TYPE _GTypeQuery
  AS GType type
  AS CONST gchar PTR type_name
  AS guint class_size
  AS guint instance_size
END TYPE

#DEFINE G_TYPE_CHECK_INSTANCE(instance) (_G_TYPE_CHI (CAST(GTypeInstance PTR, (instance))))
#DEFINE G_TYPE_CHECK_INSTANCE_CAST(instance, g_type, c_type) (_G_TYPE_CIC ((instance), (g_type), c_type))
#DEFINE G_TYPE_CHECK_INSTANCE_TYPE(instance, g_type) (_G_TYPE_CIT ((instance), (g_type)))
#DEFINE G_TYPE_INSTANCE_GET_CLASS(instance, g_type, c_type) (_G_TYPE_IGC ((instance), (g_type), c_type))
#DEFINE G_TYPE_INSTANCE_GET_INTERFACE(instance, g_type, c_type) (_G_TYPE_IGI ((instance), (g_type), c_type))
#DEFINE G_TYPE_CHECK_CLASS_CAST(g_class, g_type, c_type) (_G_TYPE_CCC ((g_class), (g_type), c_type))
#DEFINE G_TYPE_CHECK_CLASS_TYPE(g_class, g_type) (_G_TYPE_CCT ((g_class), (g_type)))
#DEFINE G_TYPE_CHECK_VALUE(value) (_G_TYPE_CHV ((value)))
#DEFINE G_TYPE_CHECK_VALUE_TYPE(value, g_type) (_G_TYPE_CVH ((value), (g_type)))
#DEFINE G_TYPE_FROM_INSTANCE(instance) (G_TYPE_FROM_CLASS ((CAST(GTypeInstance PTR, (instance)))->g_class))
#DEFINE G_TYPE_FROM_CLASS(g_class) ((CAST(GTypeClass PTR, (g_class)))->g_type)
#DEFINE G_TYPE_FROM_INTERFACE(g_iface) ((CAST(GTypeInterface PTR, (g_iface)))->g_type)
#DEFINE G_TYPE_INSTANCE_GET_PRIVATE(instance, g_type, c_type) (CAST(c_type PTR, g_type_instance_get_private_FB (CAST(GTypeInstance PTR, (instance)), (g_type))))
#DEFINE G_TYPE_CLASS_GET_PRIVATE(klass, g_type, c_type) (CAST(c_type PTR, g_type_class_get_private_FB (CAST(GTypeClass PTR, (klass)), (g_type))))

ENUM GTypeDebugFlags
  G_TYPE_DEBUG_NONE = 0
  G_TYPE_DEBUG_OBJECTS = 1 SHL 0
  G_TYPE_DEBUG_SIGNALS = 1 SHL 1
  G_TYPE_DEBUG_MASK = &h03
END ENUM

DECLARE SUB g_type_init()
DECLARE SUB g_type_init_with_debug_flags(BYVAL AS GTypeDebugFlags)
DECLARE FUNCTION g_type_name(BYVAL AS GType) AS G_CONST_RETURN gchar PTR
DECLARE FUNCTION g_type_qname(BYVAL AS GType) AS GQuark
DECLARE FUNCTION g_type_from_name(BYVAL AS CONST gchar PTR) AS GType
DECLARE FUNCTION g_type_parent(BYVAL AS GType) AS GType
DECLARE FUNCTION g_type_depth(BYVAL AS GType) AS guint
DECLARE FUNCTION g_type_next_base(BYVAL AS GType, BYVAL AS GType) AS GType
DECLARE FUNCTION g_type_is_a(BYVAL AS GType, BYVAL AS GType) AS gboolean
DECLARE FUNCTION g_type_class_ref(BYVAL AS GType) AS gpointer
DECLARE FUNCTION g_type_class_peek(BYVAL AS GType) AS gpointer
DECLARE FUNCTION g_type_class_peek_static(BYVAL AS GType) AS gpointer
DECLARE SUB g_type_class_unref(BYVAL AS gpointer)
DECLARE FUNCTION g_type_class_peek_parent(BYVAL AS gpointer) AS gpointer
DECLARE FUNCTION g_type_interface_peek(BYVAL AS gpointer, BYVAL AS GType) AS gpointer
DECLARE FUNCTION g_type_interface_peek_parent(BYVAL AS gpointer) AS gpointer
DECLARE FUNCTION g_type_default_interface_ref(BYVAL AS GType) AS gpointer
DECLARE FUNCTION g_type_default_interface_peek(BYVAL AS GType) AS gpointer
DECLARE SUB g_type_default_interface_unref(BYVAL AS gpointer)
DECLARE FUNCTION g_type_children(BYVAL AS GType, BYVAL AS guint PTR) AS GType PTR
DECLARE FUNCTION g_type_interfaces(BYVAL AS GType, BYVAL AS guint PTR) AS GType PTR
DECLARE SUB g_type_set_qdata(BYVAL AS GType, BYVAL AS GQuark, BYVAL AS gpointer)
DECLARE FUNCTION g_type_get_qdata(BYVAL AS GType, BYVAL AS GQuark) AS gpointer
DECLARE SUB g_type_query(BYVAL AS GType, BYVAL AS GTypeQuery PTR)

TYPE GBaseInitFunc AS SUB(BYVAL AS gpointer)
TYPE GBaseFinalizeFunc AS SUB(BYVAL AS gpointer)
TYPE GClassInitFunc AS SUB(BYVAL AS gpointer, BYVAL AS gpointer)
TYPE GClassFinalizeFunc AS SUB(BYVAL AS gpointer, BYVAL AS gpointer)
TYPE GInstanceInitFunc AS SUB(BYVAL AS GTypeInstance PTR, BYVAL AS gpointer)
TYPE GInterfaceInitFunc AS SUB(BYVAL AS gpointer, BYVAL AS gpointer)
TYPE GInterfaceFinalizeFunc AS SUB(BYVAL AS gpointer, BYVAL AS gpointer)
TYPE GTypeClassCacheFunc AS FUNCTION(BYVAL AS gpointer, BYVAL AS GTypeClass PTR) AS gboolean
TYPE GTypeInterfaceCheckFunc AS SUB(BYVAL AS gpointer, BYVAL AS gpointer)

ENUM GTypeFundamentalFlags
  G_TYPE_FLAG_CLASSED = (1 SHL 0)
  G_TYPE_FLAG_INSTANTIATABLE = (1 SHL 1)
  G_TYPE_FLAG_DERIVABLE = (1 SHL 2)
  G_TYPE_FLAG_DEEP_DERIVABLE = (1 SHL 3)
END ENUM

ENUM GTypeFlags
  G_TYPE_FLAG_ABSTRACT = (1 SHL 4)
  G_TYPE_FLAG_VALUE_ABSTRACT = (1 SHL 5)
END ENUM

TYPE _GTypeInfo
  AS guint16 class_size
  AS GBaseInitFunc base_init
  AS GBaseFinalizeFunc base_finalize
  AS GClassInitFunc class_init
  AS GClassFinalizeFunc class_finalize
  AS gconstpointer class_data
  AS guint16 instance_size
  AS guint16 n_preallocs
  AS GInstanceInitFunc instance_init
  AS CONST GTypeValueTable PTR value_table
END TYPE

TYPE _GTypeFundamentalInfo
  AS GTypeFundamentalFlags type_flags
END TYPE

TYPE _GInterfaceInfo
  AS GInterfaceInitFunc interface_init
  AS GInterfaceFinalizeFunc interface_finalize
  AS gpointer interface_data
END TYPE

TYPE _GTypeValueTable
  value_init AS SUB(BYVAL AS GValue PTR)
  value_free AS SUB(BYVAL AS GValue PTR)
  value_copy AS SUB(BYVAL AS CONST GValue PTR, BYVAL AS GValue PTR)
  value_peek_pointer AS FUNCTION(BYVAL AS CONST GValue PTR) AS gpointer
  AS gchar PTR collect_format
  collect_value AS FUNCTION(BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS GTypeCValue PTR, BYVAL AS guint) AS gchar PTR
  AS gchar PTR lcopy_format
  lcopy_value AS FUNCTION(BYVAL AS CONST GValue PTR, BYVAL AS guint, BYVAL AS GTypeCValue PTR, BYVAL AS guint) AS gchar PTR
END TYPE

DECLARE FUNCTION g_type_register_static(BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS CONST GTypeInfo PTR, BYVAL AS GTypeFlags) AS GType
DECLARE FUNCTION g_type_register_static_simple(BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS guint, BYVAL AS GClassInitFunc, BYVAL AS guint, BYVAL AS GInstanceInitFunc, BYVAL AS GTypeFlags) AS GType
DECLARE FUNCTION g_type_register_dynamic(BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS GTypePlugin PTR, BYVAL AS GTypeFlags) AS GType
DECLARE FUNCTION g_type_register_fundamental(BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS CONST GTypeInfo PTR, BYVAL AS CONST GTypeFundamentalInfo PTR, BYVAL AS GTypeFlags) AS GType
DECLARE SUB g_type_add_interface_static(BYVAL AS GType, BYVAL AS GType, BYVAL AS CONST GInterfaceInfo PTR)
DECLARE SUB g_type_add_interface_dynamic(BYVAL AS GType, BYVAL AS GType, BYVAL AS GTypePlugin PTR)
DECLARE SUB g_type_interface_add_prerequisite(BYVAL AS GType, BYVAL AS GType)
DECLARE FUNCTION g_type_interface_prerequisites(BYVAL AS GType, BYVAL AS guint PTR) AS GType PTR
DECLARE SUB g_type_class_add_private(BYVAL AS gpointer, BYVAL AS gsize)
DECLARE FUNCTION g_type_instance_get_private_FB ALIAS "g_type_instance_get_private"(BYVAL AS GTypeInstance PTR, BYVAL AS GType) AS gpointer
DECLARE SUB g_type_add_class_private(BYVAL AS GType, BYVAL AS gsize)
DECLARE FUNCTION g_type_class_get_private_FB ALIAS "g_type_class_get_private"(BYVAL AS GTypeClass PTR, BYVAL AS GType) AS gpointer

#MACRO _G_DEFINE_TYPE_EXTENDED_BEGIN(TypeName, type_name, TYPE_PARENT, flags)
 DECLARE SUB type_name##_init CDECL(BYVAL AS TypeName PTR)
 DECLARE SUB type_name##_class_init CDECL(BYVAL AS TypeName##Class PTR)

 STATIC SHARED AS gpointer type_name##_parent_class = NULL

 SUB type_name##_class_intern_init CDECL(BYVAL klass AS gpointer) STATIC
   type_name##_parent_class = g_type_class_peek_parent (klass)
   type_name##_class_init (CAST(TypeName##Class PTR, klass))
 END SUB

 FUNCTION type_name##_get_type CDECL() AS GType
   STATIC AS gsize g_define_type_id__volatile = 0
   IF (g_once_init_enter (@g_define_type_id__volatile)) THEN
     VAR g_define_type_id = _
         g_type_register_static_simple(TYPE_PARENT, _
                                       g_intern_static_string (#TypeName), _
                                       SIZEOF (TypeName##Class), _
                                       CAST(GClassInitFunc, @type_name##_class_intern_init), _
                                       SIZEOF (TypeName), _
                                       CAST(GInstanceInitFunc, @type_name##_init), _
                                       CAST(GTypeFlags, flags))
#ENDMACRO

#MACRO _G_DEFINE_BOXED_TYPE_BEGIN(TypeName, type_name, copy_func, free_func)
 FUNCTION type_name##_get_type CDECL() AS GType
   STATIC AS gsize g_define_type_id__volatile = 0
   IF (g_once_init_enter (@g_define_type_id__volatile)) THEN
     VAR g_define_type_id = _
         g_boxed_type_register_static(g_intern_static_string (#TypeName), CAST(GBoxedCopyFunc, @copy_func), CAST(GBoxedFreeFunc, @free_func))
#ENDMACRO

#MACRO _G_DEFINE_POINTER_TYPE_BEGIN(TypeName, type_name)
 FUNCTION type_name##_get_type CDECL() AS GType
   STATIC AS gsize g_define_type_id__volatile = 0
   IF (g_once_init_enter (@g_define_type_id__volatile)) THEN
     VAR g_define_type_id = _
         g_pointer_type_register_static (g_intern_static_string (#TypeName))
#ENDMACRO

#MACRO _G_DEFINE_TYPE_EXTENDED_END()
     g_once_init_leave (@g_define_type_id__volatile, g_define_type_id)
   END IF : RETURN g_define_type_id__volatile
 END FUNCTION
#ENDMACRO

#DEFINE G_DEFINE_TYPE(TN, t_n, T_P) G_DEFINE_TYPE_EXTENDED (TN, t_n, T_P, 0, )
#MACRO G_DEFINE_TYPE_WITH_CODE(TN, t_n, T_P, _C_)
 _G_DEFINE_TYPE_EXTENDED_BEGIN (TN, t_n, T_P, 0)
 _C_
 _G_DEFINE_TYPE_EXTENDED_END()
#ENDMACRO

#DEFINE G_DEFINE_ABSTRACT_TYPE(TN, t_n, T_P) G_DEFINE_TYPE_EXTENDED (TN, t_n, T_P, G_TYPE_FLAG_ABSTRACT, )
#MACRO G_DEFINE_ABSTRACT_TYPE_WITH_CODE(TN, t_n, T_P, _C_)
 _G_DEFINE_TYPE_EXTENDED_BEGIN (TN, t_n, T_P, G_TYPE_FLAG_ABSTRACT)
 _C_
 _G_DEFINE_TYPE_EXTENDED_END()
#ENDMACRO

#MACRO G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, _f_, _C_)
 _G_DEFINE_TYPE_EXTENDED_BEGIN (TN, t_n, T_P, _f_)
 _C_
 _G_DEFINE_TYPE_EXTENDED_END()
#ENDMACRO

#DEFINE G_DEFINE_INTERFACE(TN, t_n, T_P) G_DEFINE_INTERFACE_WITH_CODE(TN, t_n, T_P, )
#MACRO G_DEFINE_INTERFACE_WITH_CODE(TN, t_n, T_P, _C_)
 _G_DEFINE_INTERFACE_EXTENDED_BEGIN(TN, t_n, T_P)
 _C_
 _G_DEFINE_TYPE_EXTENDED_END()
#ENDMACRO

#DEFINE G_IMPLEMENT_INTERFACE(TYPE_IFACE, iface_init) g_type_add_interface_static (g_define_type_id, TYPE_IFACE, @TYPE( CAST(GInterfaceInitFunc, @iface_init), NULL, NULL ))

#DEFINE G_DEFINE_BOXED_TYPE(TypeName, type_name, copy_func, free_func) G_DEFINE_BOXED_TYPE_WITH_CODE (TypeName, type_name, copy_func, free_func, )
#MACRO G_DEFINE_BOXED_TYPE_WITH_CODE(TypeName, type_name, copy_func, free_func, _C_)
 _G_DEFINE_BOXED_TYPE_BEGIN (TypeName, type_name, copy_func, free_func)
 _C_
 _G_DEFINE_TYPE_EXTENDED_END()
#ENDMACRO

#DEFINE G_DEFINE_POINTER_TYPE(TypeName, type_name) G_DEFINE_POINTER_TYPE_WITH_CODE (TypeName, type_name, )
#MACRO G_DEFINE_POINTER_TYPE_WITH_CODE(TypeName, type_name, _C_)
 _G_DEFINE_POINTER_TYPE_BEGIN (TypeName, type_name)
 _C_
 _G_DEFINE_TYPE_EXTENDED_END()
#ENDMACRO

DECLARE FUNCTION g_type_get_plugin(BYVAL AS GType) AS GTypePlugin PTR
DECLARE FUNCTION g_type_interface_get_plugin(BYVAL AS GType, BYVAL AS GType) AS GTypePlugin PTR
DECLARE FUNCTION g_type_fundamental_next() AS GType
DECLARE FUNCTION g_type_fundamental_FB ALIAS "g_type_fundamental"(BYVAL AS GType) AS GType
DECLARE FUNCTION g_type_create_instance(BYVAL AS GType) AS GTypeInstance PTR
DECLARE SUB g_type_free_instance(BYVAL AS GTypeInstance PTR)
DECLARE SUB g_type_add_class_cache_func(BYVAL AS gpointer, BYVAL AS GTypeClassCacheFunc)
DECLARE SUB g_type_remove_class_cache_func(BYVAL AS gpointer, BYVAL AS GTypeClassCacheFunc)
DECLARE SUB g_type_class_unref_uncached(BYVAL AS gpointer)
DECLARE SUB g_type_add_interface_check(BYVAL AS gpointer, BYVAL AS GTypeInterfaceCheckFunc)
DECLARE SUB g_type_remove_interface_check(BYVAL AS gpointer, BYVAL AS GTypeInterfaceCheckFunc)
DECLARE FUNCTION g_type_value_table_peek(BYVAL AS GType) AS GTypeValueTable PTR
DECLARE FUNCTION g_type_check_instance_FB ALIAS "g_type_check_instance"(BYVAL AS GTypeInstance PTR) AS gboolean
DECLARE FUNCTION g_type_check_instance_cast_FB ALIAS "g_type_check_instance_cast"(BYVAL AS GTypeInstance PTR, BYVAL AS GType) AS GTypeInstance PTR
DECLARE FUNCTION g_type_check_instance_is_a(BYVAL AS GTypeInstance PTR, BYVAL AS GType) AS gboolean
DECLARE FUNCTION g_type_check_class_cast_FB ALIAS "g_type_check_class_cast"(BYVAL AS GTypeClass PTR, BYVAL AS GType) AS GTypeClass PTR
DECLARE FUNCTION g_type_check_class_is_a(BYVAL AS GTypeClass PTR, BYVAL AS GType) AS gboolean
DECLARE FUNCTION g_type_check_is_value_type(BYVAL AS GType) AS gboolean
DECLARE FUNCTION g_type_check_value_FB ALIAS "g_type_check_value"(BYVAL AS GValue PTR) AS gboolean
DECLARE FUNCTION g_type_check_value_holds(BYVAL AS GValue PTR, BYVAL AS GType) AS gboolean
DECLARE FUNCTION g_type_test_flags(BYVAL AS GType, BYVAL AS guint) AS gboolean
DECLARE FUNCTION g_type_name_from_instance(BYVAL AS GTypeInstance PTR) AS G_CONST_RETURN gchar PTR
DECLARE FUNCTION g_type_name_from_class(BYVAL AS GTypeClass PTR) AS G_CONST_RETURN gchar PTR
DECLARE SUB g_value_c_init()
DECLARE SUB g_value_types_init()
DECLARE SUB g_enum_types_init()
DECLARE SUB g_param_type_init()
DECLARE SUB g_boxed_type_init()
DECLARE SUB g_object_type_init()
DECLARE SUB g_param_spec_types_init()
DECLARE SUB g_value_transforms_init()
DECLARE SUB g_signal_init()

#IFNDEF G_DISABLE_CAST_CHECKS
#DEFINE _G_TYPE_CIC(ip, gt, ct) _
    (CAST(ct PTR, g_type_check_instance_cast_FB (CAST(GTypeInstance PTR, ip), gt)))
#DEFINE _G_TYPE_CCC(cp, gt, ct) _
    (CAST(ct PTR, g_type_check_class_cast_FB (CAST(GTypeClass PTR, cp), gt)))
#ELSE ' G_DISABLE_CAST_CHECKS
#DEFINE _G_TYPE_CIC(ip, gt, ct) (CAST(ct PTR, ip))
#DEFINE _G_TYPE_CCC(cp, gt, ct) (CAST(ct PTR, cp))
#ENDIF ' G_DISABLE_CAST_CHECKS

#DEFINE _G_TYPE_CHI(ip) (g_type_check_instance_FB (CAST(GTypeInstance PTR, ip)))
#DEFINE _G_TYPE_CHV(vl) (g_type_check_value_FB (CAST(GValue PTR, vl)))
#DEFINE _G_TYPE_IGC(ip, gt, ct) (CAST(ct PTR, ((CAST(GTypeInstance PTR, ip))->g_class)))
#DEFINE _G_TYPE_IGI(ip, gt, ct) (CAST(ct PTR, g_type_interface_peek ((CAST(GTypeInstance PTR, ip))->g_class, gt)))

#DEFINE _G_TYPE_CIT(ip, gt) (g_type_check_instance_is_a (CAST(GTypeInstance PTR, ip), gt))
#DEFINE _G_TYPE_CCT(cp, gt) (g_type_check_class_is_a (CAST(GTypeClass PTR, cp), gt))
#DEFINE _G_TYPE_CVH(vl, gt) (g_type_check_value_holds (CAST(GValue PTR, vl), gt))

#DEFINE G_TYPE_FLAG_RESERVED_ID_BIT (CAST(GType, (1 SHL 0)))

EXTERN AS GTypeDebugFlags _g_type_debug_flags

#ENDIF ' __G_TYPE_H__

#IFNDEF __G_VALUE_H__
#DEFINE __G_VALUE_H__

#DEFINE G_TYPE_IS_VALUE(type) (g_type_check_is_value_type (type))
#DEFINE G_IS_VALUE(value) (G_TYPE_CHECK_VALUE (value))
#DEFINE G_VALUE_TYPE(value) ((CAST(GValue PTR, (value)))->g_type)
#DEFINE G_VALUE_TYPE_NAME(value) (g_type_name (G_VALUE_TYPE (value)))
#DEFINE G_VALUE_HOLDS(value,type) (G_TYPE_CHECK_VALUE_TYPE ((value), (type)))

TYPE GValueTransform AS SUB(BYVAL AS CONST GValue PTR, BYVAL AS GValue PTR)

UNION _GValue_data
  AS gint v_int
  AS guint v_uint
  AS glong v_long
  AS gulong v_ulong
  AS gint64 v_int64
  AS guint64 v_uint64
  AS gfloat v_float
  AS gdouble v_double
  AS gpointer v_pointer
END UNION

TYPE _GValue
  AS GType g_type
  AS _GValue_data data(1)
END TYPE

DECLARE FUNCTION g_value_init(BYVAL AS GValue PTR, BYVAL AS GType) AS GValue PTR
DECLARE SUB g_value_copy(BYVAL AS CONST GValue PTR, BYVAL AS GValue PTR)
DECLARE FUNCTION g_value_reset(BYVAL AS GValue PTR) AS GValue PTR
DECLARE SUB g_value_unset(BYVAL AS GValue PTR)
DECLARE SUB g_value_set_instance(BYVAL AS GValue PTR, BYVAL AS gpointer)
DECLARE FUNCTION g_value_fits_pointer(BYVAL AS CONST GValue PTR) AS gboolean
DECLARE FUNCTION g_value_peek_pointer(BYVAL AS CONST GValue PTR) AS gpointer
DECLARE FUNCTION g_value_type_compatible(BYVAL AS GType, BYVAL AS GType) AS gboolean
DECLARE FUNCTION g_value_type_transformable(BYVAL AS GType, BYVAL AS GType) AS gboolean
DECLARE FUNCTION g_value_transform(BYVAL AS CONST GValue PTR, BYVAL AS GValue PTR) AS gboolean
DECLARE SUB g_value_register_transform_func(BYVAL AS GType, BYVAL AS GType, BYVAL AS GValueTransform)

#DEFINE G_VALUE_NOCOPY_CONTENTS (1 SHL 27)
#ENDIF ' __G_VALUE_H__

#IFNDEF __G_PARAM_H__
#DEFINE __G_PARAM_H__

#DEFINE G_TYPE_IS_PARAM(type) (G_TYPE_FUNDAMENTAL (type)= G_TYPE_PARAM)
#DEFINE G_PARAM_SPEC(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM, GParamSpec))
#DEFINE G_IS_PARAM_SPEC(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM))
#DEFINE G_PARAM_SPEC_CLASS(pclass) (G_TYPE_CHECK_CLASS_CAST ((pclass), G_TYPE_PARAM, GParamSpecClass))
#DEFINE G_IS_PARAM_SPEC_CLASS(pclass) (G_TYPE_CHECK_CLASS_TYPE ((pclass), G_TYPE_PARAM))
#DEFINE G_PARAM_SPEC_GET_CLASS(pspec) (G_TYPE_INSTANCE_GET_CLASS ((pspec), G_TYPE_PARAM, GParamSpecClass))
#DEFINE G_PARAM_SPEC_TYPE(pspec) (G_TYPE_FROM_INSTANCE (pspec))
#DEFINE G_PARAM_SPEC_TYPE_NAME(pspec) (g_type_name (G_PARAM_SPEC_TYPE (pspec)))
#DEFINE G_PARAM_SPEC_VALUE_TYPE(pspec) (G_PARAM_SPEC (pspec)->value_type)
#DEFINE G_VALUE_HOLDS_PARAM(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_PARAM))

ENUM GParamFlags
  G_PARAM_READABLE = 1 SHL 0
  G_PARAM_WRITABLE = 1 SHL 1
  G_PARAM_CONSTRUCT = 1 SHL 2
  G_PARAM_CONSTRUCT_ONLY = 1 SHL 3
  G_PARAM_LAX_VALIDATION = 1 SHL 4
  G_PARAM_STATIC_NAME = 1 SHL 5
#IFNDEF G_DISABLE_DEPRECATED
  G_PARAM_PRIVATE = G_PARAM_STATIC_NAME
#ENDIF ' G_DISABLE_DEPRECATED
  G_PARAM_STATIC_NICK = 1 SHL 6
  G_PARAM_STATIC_BLURB = 1 SHL 7
  G_PARAM_DEPRECATED = 1 SHL 31
END ENUM

#DEFINE G_PARAM_READWRITE (G_PARAM_READABLE OR G_PARAM_WRITABLE)
#DEFINE G_PARAM_STATIC_STRINGS (G_PARAM_STATIC_NAME OR G_PARAM_STATIC_NICK OR G_PARAM_STATIC_BLURB)
#DEFINE G_PARAM_MASK (&h000000FF)
#DEFINE G_PARAM_USER_SHIFT (8)

TYPE GParamSpec AS _GParamSpec
TYPE GParamSpecClass AS _GParamSpecClass
TYPE GParameter AS _GParameter
TYPE GParamSpecPool AS _GParamSpecPool

TYPE _GParamSpec
  AS GTypeInstance g_type_instance
  AS gchar PTR name
  AS GParamFlags flags
  AS GType value_type
  AS GType owner_type
  AS gchar PTR _nick
  AS gchar PTR _blurb
  AS GData PTR qdata
  AS guint ref_count
  AS guint param_id
END TYPE

TYPE _GParamSpecClass
  AS GTypeClass g_type_class
  AS GType value_type
  finalize AS SUB(BYVAL AS GParamSpec PTR)
  value_set_default AS SUB(BYVAL AS GParamSpec PTR, BYVAL AS GValue PTR)
  value_validate AS FUNCTION(BYVAL AS GParamSpec PTR, BYVAL AS GValue PTR) AS gboolean
  values_cmp AS FUNCTION(BYVAL AS GParamSpec PTR, BYVAL AS CONST GValue PTR, BYVAL AS CONST GValue PTR) AS gint
  AS gpointer dummy(3)
END TYPE

TYPE _GParameter
  AS CONST gchar PTR name
  AS GValue value
END TYPE

DECLARE FUNCTION g_param_spec_ref(BYVAL AS GParamSpec PTR) AS GParamSpec PTR
DECLARE SUB g_param_spec_unref(BYVAL AS GParamSpec PTR)
DECLARE SUB g_param_spec_sink(BYVAL AS GParamSpec PTR)
DECLARE FUNCTION g_param_spec_ref_sink(BYVAL AS GParamSpec PTR) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_get_qdata(BYVAL AS GParamSpec PTR, BYVAL AS GQuark) AS gpointer
DECLARE SUB g_param_spec_set_qdata(BYVAL AS GParamSpec PTR, BYVAL AS GQuark, BYVAL AS gpointer)
DECLARE SUB g_param_spec_set_qdata_full(BYVAL AS GParamSpec PTR, BYVAL AS GQuark, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION g_param_spec_steal_qdata(BYVAL AS GParamSpec PTR, BYVAL AS GQuark) AS gpointer
DECLARE FUNCTION g_param_spec_get_redirect_target(BYVAL AS GParamSpec PTR) AS GParamSpec PTR
DECLARE SUB g_param_value_set_default(BYVAL AS GParamSpec PTR, BYVAL AS GValue PTR)
DECLARE FUNCTION g_param_value_defaults(BYVAL AS GParamSpec PTR, BYVAL AS GValue PTR) AS gboolean
DECLARE FUNCTION g_param_value_validate(BYVAL AS GParamSpec PTR, BYVAL AS GValue PTR) AS gboolean
DECLARE FUNCTION g_param_value_convert(BYVAL AS GParamSpec PTR, BYVAL AS CONST GValue PTR, BYVAL AS GValue PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION g_param_values_cmp(BYVAL AS GParamSpec PTR, BYVAL AS CONST GValue PTR, BYVAL AS CONST GValue PTR) AS gint
DECLARE FUNCTION g_param_spec_get_name(BYVAL AS GParamSpec PTR) AS G_CONST_RETURN gchar PTR
DECLARE FUNCTION g_param_spec_get_nick(BYVAL AS GParamSpec PTR) AS G_CONST_RETURN gchar PTR
DECLARE FUNCTION g_param_spec_get_blurb(BYVAL AS GParamSpec PTR) AS G_CONST_RETURN gchar PTR
DECLARE SUB g_value_set_param(BYVAL AS GValue PTR, BYVAL AS GParamSpec PTR)
DECLARE FUNCTION g_value_get_param(BYVAL AS CONST GValue PTR) AS GParamSpec PTR
DECLARE FUNCTION g_value_dup_param(BYVAL AS CONST GValue PTR) AS GParamSpec PTR
DECLARE SUB g_value_take_param(BYVAL AS GValue PTR, BYVAL AS GParamSpec PTR)

#IFNDEF G_DISABLE_DEPRECATED

DECLARE SUB g_value_set_param_take_ownership(BYVAL AS GValue PTR, BYVAL AS GParamSpec PTR)

#ENDIF ' G_DISABLE_DEPRECATED

TYPE GParamSpecTypeInfo AS _GParamSpecTypeInfo

TYPE _GParamSpecTypeInfo
  AS guint16 instance_size
  AS guint16 n_preallocs
  instance_init AS SUB(BYVAL AS GParamSpec PTR)
  AS GType value_type
  finalize AS SUB(BYVAL AS GParamSpec PTR)
  value_set_default AS SUB(BYVAL AS GParamSpec PTR, BYVAL AS GValue PTR)
  value_validate AS FUNCTION(BYVAL AS GParamSpec PTR, BYVAL AS GValue PTR) AS gboolean
  values_cmp AS FUNCTION(BYVAL AS GParamSpec PTR, BYVAL AS CONST GValue PTR, BYVAL AS CONST GValue PTR) AS gint
END TYPE

DECLARE FUNCTION g_param_type_register_static(BYVAL AS CONST gchar PTR, BYVAL AS CONST GParamSpecTypeInfo PTR) AS GType
DECLARE FUNCTION _g_param_type_register_static_constant(BYVAL AS CONST gchar PTR, BYVAL AS CONST GParamSpecTypeInfo PTR, BYVAL AS GType) AS GType
DECLARE FUNCTION g_param_spec_internal(BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GParamFlags) AS gpointer
DECLARE FUNCTION g_param_spec_pool_new(BYVAL AS gboolean) AS GParamSpecPool PTR
DECLARE SUB g_param_spec_pool_insert(BYVAL AS GParamSpecPool PTR, BYVAL AS GParamSpec PTR, BYVAL AS GType)
DECLARE SUB g_param_spec_pool_remove(BYVAL AS GParamSpecPool PTR, BYVAL AS GParamSpec PTR)
DECLARE FUNCTION g_param_spec_pool_lookup(BYVAL AS GParamSpecPool PTR, BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS gboolean) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_pool_list_owned(BYVAL AS GParamSpecPool PTR, BYVAL AS GType) AS GList PTR
DECLARE FUNCTION g_param_spec_pool_list(BYVAL AS GParamSpecPool PTR, BYVAL AS GType, BYVAL AS guint PTR) AS GParamSpec PTR PTR

#ENDIF ' __G_PARAM_H__

#IFNDEF __G_CLOSURE_H__
#DEFINE __G_CLOSURE_H__

#DEFINE G_CLOSURE_NEEDS_MARSHAL(closure) ((CAST(GClosure PTR, (closure)))->marshal = NULL)
#DEFINE G_CLOSURE_N_NOTIFIERS(cl) ((cl)->meta_marshal + ((cl)->n_guards SHL 1L) + _
                                          (cl)->n_fnotifiers + (cl)->n_inotifiers)
#DEFINE G_CCLOSURE_SWAP_DATA(cclosure) ((CAST(GClosure PTR, (cclosure)))->derivative_flag)
#DEFINE G_CALLBACK(f) (CAST(GCallback, (f)))

TYPE GClosure AS _GClosure
TYPE GClosureNotifyData AS _GClosureNotifyData
TYPE GCallback AS SUB()
TYPE GClosureNotify AS SUB(BYVAL AS gpointer, BYVAL AS GClosure PTR)
TYPE GClosureMarshal AS SUB(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
TYPE GCClosure AS _GCClosure

TYPE _GClosureNotifyData
  AS gpointer data
  AS GClosureNotify notify
END TYPE

TYPE _GClosure
  AS guint ref_count : 15
  AS guint meta_marshal : 1
  AS guint n_guards : 1
  AS guint n_fnotifiers : 2
  AS guint n_inotifiers : 8
  AS guint in_inotify : 1
  AS guint floating : 1
  AS guint derivative_flag : 1
  AS guint in_marshal : 1
  AS guint is_invalid : 1
  marshal AS SUB(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
  AS gpointer data
  AS GClosureNotifyData PTR notifiers
END TYPE

TYPE _GCClosure
  AS GClosure closure
  AS gpointer callback
END TYPE

DECLARE FUNCTION g_cclosure_new(BYVAL AS GCallback, BYVAL AS gpointer, BYVAL AS GClosureNotify) AS GClosure PTR
DECLARE FUNCTION g_cclosure_new_swap(BYVAL AS GCallback, BYVAL AS gpointer, BYVAL AS GClosureNotify) AS GClosure PTR
DECLARE FUNCTION g_signal_type_cclosure_new(BYVAL AS GType, BYVAL AS guint) AS GClosure PTR
DECLARE FUNCTION g_closure_ref(BYVAL AS GClosure PTR) AS GClosure PTR
DECLARE SUB g_closure_sink(BYVAL AS GClosure PTR)
DECLARE SUB g_closure_unref(BYVAL AS GClosure PTR)
DECLARE FUNCTION g_closure_new_simple(BYVAL AS guint, BYVAL AS gpointer) AS GClosure PTR
DECLARE SUB g_closure_add_finalize_notifier(BYVAL AS GClosure PTR, BYVAL AS gpointer, BYVAL AS GClosureNotify)
DECLARE SUB g_closure_remove_finalize_notifier(BYVAL AS GClosure PTR, BYVAL AS gpointer, BYVAL AS GClosureNotify)
DECLARE SUB g_closure_add_invalidate_notifier(BYVAL AS GClosure PTR, BYVAL AS gpointer, BYVAL AS GClosureNotify)
DECLARE SUB g_closure_remove_invalidate_notifier(BYVAL AS GClosure PTR, BYVAL AS gpointer, BYVAL AS GClosureNotify)
DECLARE SUB g_closure_add_marshal_guards(BYVAL AS GClosure PTR, BYVAL AS gpointer, BYVAL AS GClosureNotify, BYVAL AS gpointer, BYVAL AS GClosureNotify)
DECLARE SUB g_closure_set_marshal(BYVAL AS GClosure PTR, BYVAL AS GClosureMarshal)
DECLARE SUB g_closure_set_meta_marshal(BYVAL AS GClosure PTR, BYVAL AS gpointer, BYVAL AS GClosureMarshal)
DECLARE SUB g_closure_invalidate(BYVAL AS GClosure PTR)
DECLARE SUB g_closure_invoke(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer)

#ENDIF ' __G_CLOSURE_H__

#IFNDEF __G_SIGNAL_H__
#DEFINE __G_SIGNAL_H__

#IFNDEF __G_MARSHAL_H__
#DEFINE __G_MARSHAL_H__

DECLARE SUB g_cclosure_marshal_VOID__VOID(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__BOOLEAN(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__CHAR(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__UCHAR(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__INT(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__UINT(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__LONG(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__ULONG(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__ENUM(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__FLAGS(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__FLOAT(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__DOUBLE(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__STRING(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__PARAM(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__BOXED(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__POINTER(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__OBJECT(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__VARIANT(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_VOID__UINT_POINTER(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_BOOLEAN__FLAGS(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)

#DEFINE g_cclosure_marshal_BOOL__FLAGS g_cclosure_marshal_BOOLEAN__FLAGS

DECLARE SUB g_cclosure_marshal_STRING__OBJECT_POINTER(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)
DECLARE SUB g_cclosure_marshal_BOOLEAN__BOXED_BOXED(BYVAL AS GClosure PTR, BYVAL AS GValue PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer, BYVAL AS gpointer)

#DEFINE g_cclosure_marshal_BOOL__BOXED_BOXED g_cclosure_marshal_BOOLEAN__BOXED_BOXED
#ENDIF ' __G_MARSHAL_H__

TYPE GSignalQuery AS _GSignalQuery
TYPE GSignalInvocationHint AS _GSignalInvocationHint
TYPE GSignalCMarshaller AS GClosureMarshal
TYPE GSignalEmissionHook AS FUNCTION(BYVAL AS GSignalInvocationHint PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS gpointer) AS gboolean
TYPE GSignalAccumulator AS FUNCTION(BYVAL AS GSignalInvocationHint PTR, BYVAL AS GValue PTR, BYVAL AS CONST GValue PTR, BYVAL AS gpointer) AS gboolean

ENUM GSignalFlags
  G_SIGNAL_RUN_FIRST = 1 SHL 0
  G_SIGNAL_RUN_LAST = 1 SHL 1
  G_SIGNAL_RUN_CLEANUP = 1 SHL 2
  G_SIGNAL_NO_RECURSE = 1 SHL 3
  G_SIGNAL_DETAILED = 1 SHL 4
  G_SIGNAL_ACTION = 1 SHL 5
  G_SIGNAL_NO_HOOKS = 1 SHL 6
END ENUM

#DEFINE G_SIGNAL_FLAGS_MASK &h7F

ENUM GConnectFlags
  G_CONNECT_AFTER = 1 SHL 0
  G_CONNECT_SWAPPED = 1 SHL 1
END ENUM

ENUM GSignalMatchType
  G_SIGNAL_MATCH_ID = 1 SHL 0
  G_SIGNAL_MATCH_DETAIL = 1 SHL 1
  G_SIGNAL_MATCH_CLOSURE = 1 SHL 2
  G_SIGNAL_MATCH_FUNC = 1 SHL 3
  G_SIGNAL_MATCH_DATA = 1 SHL 4
  G_SIGNAL_MATCH_UNBLOCKED = 1 SHL 5
END ENUM

#DEFINE G_SIGNAL_MATCH_MASK &h3F
#DEFINE G_SIGNAL_TYPE_STATIC_SCOPE (G_TYPE_FLAG_RESERVED_ID_BIT)

TYPE _GSignalInvocationHint
  AS guint signal_id
  AS GQuark detail
  AS GSignalFlags run_type
END TYPE

TYPE _GSignalQuery
  AS guint signal_id
  AS CONST gchar PTR signal_name
  AS GType itype
  AS GSignalFlags signal_flags
  AS GType return_type
  AS guint n_params
  AS CONST GType PTR param_types
END TYPE

DECLARE FUNCTION g_signal_newv(BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS GSignalFlags, BYVAL AS GClosure PTR, BYVAL AS GSignalAccumulator, BYVAL AS gpointer, BYVAL AS GSignalCMarshaller, BYVAL AS GType, BYVAL AS guint, BYVAL AS GType PTR) AS guint
DECLARE FUNCTION g_signal_new_valist(BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS GSignalFlags, BYVAL AS GClosure PTR, BYVAL AS GSignalAccumulator, BYVAL AS gpointer, BYVAL AS GSignalCMarshaller, BYVAL AS GType, BYVAL AS guint, BYVAL AS va_list) AS guint
DECLARE FUNCTION g_signal_new(BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS GSignalFlags, BYVAL AS guint, BYVAL AS GSignalAccumulator, BYVAL AS gpointer, BYVAL AS GSignalCMarshaller, BYVAL AS GType, BYVAL AS guint, ...) AS guint
DECLARE FUNCTION g_signal_new_class_handler(BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS GSignalFlags, BYVAL AS GCallback, BYVAL AS GSignalAccumulator, BYVAL AS gpointer, BYVAL AS GSignalCMarshaller, BYVAL AS GType, BYVAL AS guint, ...) AS guint
DECLARE SUB g_signal_emitv(BYVAL AS CONST GValue PTR, BYVAL AS guint, BYVAL AS GQuark, BYVAL AS GValue PTR)
DECLARE SUB g_signal_emit_valist(BYVAL AS gpointer, BYVAL AS guint, BYVAL AS GQuark, BYVAL AS va_list)
DECLARE SUB g_signal_emit(BYVAL AS gpointer, BYVAL AS guint, BYVAL AS GQuark, ...)
DECLARE SUB g_signal_emit_by_name(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, ...)
DECLARE FUNCTION g_signal_lookup(BYVAL AS CONST gchar PTR, BYVAL AS GType) AS guint
DECLARE FUNCTION g_signal_name(BYVAL AS guint) AS G_CONST_RETURN gchar PTR
DECLARE SUB g_signal_query(BYVAL AS guint, BYVAL AS GSignalQuery PTR)
DECLARE FUNCTION g_signal_list_ids(BYVAL AS GType, BYVAL AS guint PTR) AS guint PTR
DECLARE FUNCTION g_signal_parse_name(BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS guint PTR, BYVAL AS GQuark PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION g_signal_get_invocation_hint(BYVAL AS gpointer) AS GSignalInvocationHint PTR
DECLARE SUB g_signal_stop_emission(BYVAL AS gpointer, BYVAL AS guint, BYVAL AS GQuark)
DECLARE SUB g_signal_stop_emission_by_name(BYVAL AS gpointer, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_signal_add_emission_hook(BYVAL AS guint, BYVAL AS GQuark, BYVAL AS GSignalEmissionHook, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS gulong
DECLARE SUB g_signal_remove_emission_hook(BYVAL AS guint, BYVAL AS gulong)
DECLARE FUNCTION g_signal_has_handler_pending(BYVAL AS gpointer, BYVAL AS guint, BYVAL AS GQuark, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION g_signal_connect_closure_by_id(BYVAL AS gpointer, BYVAL AS guint, BYVAL AS GQuark, BYVAL AS GClosure PTR, BYVAL AS gboolean) AS gulong
DECLARE FUNCTION g_signal_connect_closure(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS GClosure PTR, BYVAL AS gboolean) AS gulong
DECLARE FUNCTION g_signal_connect_data(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS GCallback, BYVAL AS gpointer, BYVAL AS GClosureNotify, BYVAL AS GConnectFlags) AS gulong
DECLARE SUB g_signal_handler_block(BYVAL AS gpointer, BYVAL AS gulong)
DECLARE SUB g_signal_handler_unblock(BYVAL AS gpointer, BYVAL AS gulong)
DECLARE SUB g_signal_handler_disconnect(BYVAL AS gpointer, BYVAL AS gulong)
DECLARE FUNCTION g_signal_handler_is_connected(BYVAL AS gpointer, BYVAL AS gulong) AS gboolean
DECLARE FUNCTION g_signal_handler_find(BYVAL AS gpointer, BYVAL AS GSignalMatchType, BYVAL AS guint, BYVAL AS GQuark, BYVAL AS GClosure PTR, BYVAL AS gpointer, BYVAL AS gpointer) AS gulong
DECLARE FUNCTION g_signal_handlers_block_matched(BYVAL AS gpointer, BYVAL AS GSignalMatchType, BYVAL AS guint, BYVAL AS GQuark, BYVAL AS GClosure PTR, BYVAL AS gpointer, BYVAL AS gpointer) AS guint
DECLARE FUNCTION g_signal_handlers_unblock_matched(BYVAL AS gpointer, BYVAL AS GSignalMatchType, BYVAL AS guint, BYVAL AS GQuark, BYVAL AS GClosure PTR, BYVAL AS gpointer, BYVAL AS gpointer) AS guint
DECLARE FUNCTION g_signal_handlers_disconnect_matched(BYVAL AS gpointer, BYVAL AS GSignalMatchType, BYVAL AS guint, BYVAL AS GQuark, BYVAL AS GClosure PTR, BYVAL AS gpointer, BYVAL AS gpointer) AS guint
DECLARE SUB g_signal_override_class_closure(BYVAL AS guint, BYVAL AS GType, BYVAL AS GClosure PTR)
DECLARE SUB g_signal_override_class_handler(BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS GCallback)
DECLARE SUB g_signal_chain_from_overridden(BYVAL AS CONST GValue PTR, BYVAL AS GValue PTR)
DECLARE SUB g_signal_chain_from_overridden_handler(BYVAL AS gpointer, ...)

#DEFINE g_signal_connect(instance, detailed_signal, c_handler, data) _
    g_signal_connect_data ((instance), (detailed_signal), (c_handler), (data), NULL, CAST(GConnectFlags, 0))
#DEFINE g_signal_connect_after(instance, detailed_signal, c_handler, data) _
    g_signal_connect_data ((instance), (detailed_signal), (c_handler), (data), NULL, G_CONNECT_AFTER)
#DEFINE g_signal_connect_swapped(instance, detailed_signal, c_handler, data) _
    g_signal_connect_data ((instance), (detailed_signal), (c_handler), (data), NULL, G_CONNECT_SWAPPED)
#DEFINE g_signal_handlers_disconnect_by_func(instance, func, data) _
    g_signal_handlers_disconnect_matched ((instance), _
       CAST(GSignalMatchType, (G_SIGNAL_MATCH_FUNC OR G_SIGNAL_MATCH_DATA)), _
       0, 0, NULL, (func), (data))
#DEFINE g_signal_handlers_block_by_func(instance, func, data) _
    g_signal_handlers_block_matched ((instance), _
              CAST(GSignalMatchType, (G_SIGNAL_MATCH_FUNC OR G_SIGNAL_MATCH_DATA)), _
              0, 0, NULL, (func), (data))
#DEFINE g_signal_handlers_unblock_by_func(instance, func, data) _
    g_signal_handlers_unblock_matched ((instance), _
              CAST(GSignalMatchType, (G_SIGNAL_MATCH_FUNC OR G_SIGNAL_MATCH_DATA)), _
              0, 0, NULL, (func), (data))

DECLARE FUNCTION g_signal_accumulator_true_handled(BYVAL AS GSignalInvocationHint PTR, BYVAL AS GValue PTR, BYVAL AS CONST GValue PTR, BYVAL AS gpointer) AS gboolean
DECLARE FUNCTION g_signal_accumulator_first_wins(BYVAL AS GSignalInvocationHint PTR, BYVAL AS GValue PTR, BYVAL AS CONST GValue PTR, BYVAL AS gpointer) AS gboolean
DECLARE SUB g_signal_handlers_destroy(BYVAL AS gpointer)
DECLARE SUB _g_signals_destroy(BYVAL AS GType)

#ENDIF ' __G_SIGNAL_H__

#DEFINE G_TYPE_IS_OBJECT(type) (G_TYPE_FUNDAMENTAL (type)= G_TYPE_OBJECT)
#DEFINE G_OBJECT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), G_TYPE_OBJECT, GObject))
#DEFINE G_OBJECT_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), G_TYPE_OBJECT, GObjectClass))
#DEFINE G_IS_OBJECT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), G_TYPE_OBJECT))
#DEFINE G_IS_OBJECT_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_OBJECT))
#DEFINE G_OBJECT_GET_CLASS(object) (G_TYPE_INSTANCE_GET_CLASS ((object), G_TYPE_OBJECT, GObjectClass))
#DEFINE G_OBJECT_TYPE(object) (G_TYPE_FROM_INSTANCE (object))
#DEFINE G_OBJECT_TYPE_NAME(object) (g_type_name (G_OBJECT_TYPE (object)))
#DEFINE G_OBJECT_CLASS_TYPE(class) (G_TYPE_FROM_CLASS (class))
#DEFINE G_OBJECT_CLASS_NAME(class) (g_type_name (G_OBJECT_CLASS_TYPE (class)))
#DEFINE G_VALUE_HOLDS_OBJECT(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_OBJECT))
#DEFINE G_TYPE_INITIALLY_UNOWNED (g_initially_unowned_get_type())
#DEFINE G_INITIALLY_UNOWNED(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), G_TYPE_INITIALLY_UNOWNED, GInitiallyUnowned))
#DEFINE G_INITIALLY_UNOWNED_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), G_TYPE_INITIALLY_UNOWNED, GInitiallyUnownedClass))
#DEFINE G_IS_INITIALLY_UNOWNED(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), G_TYPE_INITIALLY_UNOWNED))
#DEFINE G_IS_INITIALLY_UNOWNED_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_INITIALLY_UNOWNED))
#DEFINE G_INITIALLY_UNOWNED_GET_CLASS(object) (G_TYPE_INSTANCE_GET_CLASS ((object), G_TYPE_INITIALLY_UNOWNED, GInitiallyUnownedClass))

TYPE GObject AS _GObject
TYPE GObjectClass AS _GObjectClass
TYPE GInitiallyUnowned AS _GObject
TYPE GInitiallyUnownedClass AS _GObjectClass
TYPE GObjectConstructParam AS _GObjectConstructParam
TYPE GObjectGetPropertyFunc AS SUB(BYVAL AS GObject PTR, BYVAL AS guint, BYVAL AS GValue PTR, BYVAL AS GParamSpec PTR)
TYPE GObjectSetPropertyFunc AS SUB(BYVAL AS GObject PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS GParamSpec PTR)
TYPE GObjectFinalizeFunc AS SUB(BYVAL AS GObject PTR)
TYPE GWeakNotify AS SUB(BYVAL AS gpointer, BYVAL AS GObject PTR)

TYPE _GObject
  AS GTypeInstance g_type_instance
  AS guint ref_count
  AS GData PTR qdata
END TYPE

TYPE _GObjectClass
  AS GTypeClass g_type_class
  AS GSList PTR construct_properties
  constructor AS FUNCTION(BYVAL AS GType, BYVAL AS guint, BYVAL AS GObjectConstructParam PTR) AS GObject PTR
  set_property AS SUB(BYVAL AS GObject PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS GParamSpec PTR)
  get_property AS SUB(BYVAL AS GObject PTR, BYVAL AS guint, BYVAL AS GValue PTR, BYVAL AS GParamSpec PTR)
  dispose AS SUB(BYVAL AS GObject PTR)
  finalize AS SUB(BYVAL AS GObject PTR)
  dispatch_properties_changed AS SUB(BYVAL AS GObject PTR, BYVAL AS guint, BYVAL AS GParamSpec PTR PTR)
  notify AS SUB(BYVAL AS GObject PTR, BYVAL AS GParamSpec PTR)
  constructed AS SUB(BYVAL AS GObject PTR)
  AS gsize flags
  AS gpointer pdummy(5)
END TYPE

TYPE _GObjectConstructParam
  AS GParamSpec PTR pspec
  AS GValue PTR value
END TYPE

DECLARE FUNCTION g_initially_unowned_get_type() AS GType
DECLARE SUB g_object_class_install_property(BYVAL AS GObjectClass PTR, BYVAL AS guint, BYVAL AS GParamSpec PTR)
DECLARE FUNCTION g_object_class_find_property(BYVAL AS GObjectClass PTR, BYVAL AS CONST gchar PTR) AS GParamSpec PTR
DECLARE FUNCTION g_object_class_list_properties(BYVAL AS GObjectClass PTR, BYVAL AS guint PTR) AS GParamSpec PTR PTR
DECLARE SUB g_object_class_override_property(BYVAL AS GObjectClass PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR)
DECLARE SUB g_object_class_install_properties(BYVAL AS GObjectClass PTR, BYVAL AS guint, BYVAL AS GParamSpec PTR PTR)
DECLARE SUB g_object_interface_install_property(BYVAL AS gpointer, BYVAL AS GParamSpec PTR)
DECLARE FUNCTION g_object_interface_find_property(BYVAL AS gpointer, BYVAL AS CONST gchar PTR) AS GParamSpec PTR
DECLARE FUNCTION g_object_interface_list_properties(BYVAL AS gpointer, BYVAL AS guint PTR) AS GParamSpec PTR PTR
DECLARE FUNCTION g_object_get_type() AS GType
DECLARE FUNCTION g_object_new(BYVAL AS GType, BYVAL AS CONST gchar PTR, ...) AS gpointer
DECLARE FUNCTION g_object_newv(BYVAL AS GType, BYVAL AS guint, BYVAL AS GParameter PTR) AS gpointer
DECLARE FUNCTION g_object_new_valist(BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS va_list) AS GObject PTR
DECLARE SUB g_object_set(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_object_get(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, ...)
DECLARE FUNCTION g_object_connect(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, ...) AS gpointer
DECLARE SUB g_object_disconnect(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_object_set_valist(BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE SUB g_object_get_valist(BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE SUB g_object_set_property(BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GValue PTR)
DECLARE SUB g_object_get_property(BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR)
DECLARE SUB g_object_freeze_notify(BYVAL AS GObject PTR)
DECLARE SUB g_object_notify(BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_object_notify_by_pspec(BYVAL AS GObject PTR, BYVAL AS GParamSpec PTR)
DECLARE SUB g_object_thaw_notify(BYVAL AS GObject PTR)
DECLARE FUNCTION g_object_is_floating(BYVAL AS gpointer) AS gboolean
DECLARE FUNCTION g_object_ref_sink(BYVAL AS gpointer) AS gpointer
DECLARE FUNCTION g_object_ref(BYVAL AS gpointer) AS gpointer
DECLARE SUB g_object_unref(BYVAL AS gpointer)
DECLARE SUB g_object_weak_ref(BYVAL AS GObject PTR, BYVAL AS GWeakNotify, BYVAL AS gpointer)
DECLARE SUB g_object_weak_unref(BYVAL AS GObject PTR, BYVAL AS GWeakNotify, BYVAL AS gpointer)
DECLARE SUB g_object_add_weak_pointer(BYVAL AS GObject PTR, BYVAL AS gpointer PTR)
DECLARE SUB g_object_remove_weak_pointer(BYVAL AS GObject PTR, BYVAL AS gpointer PTR)

TYPE GToggleNotify AS SUB(BYVAL AS gpointer, BYVAL AS GObject PTR, BYVAL AS gboolean)

DECLARE SUB g_object_add_toggle_ref(BYVAL AS GObject PTR, BYVAL AS GToggleNotify, BYVAL AS gpointer)
DECLARE SUB g_object_remove_toggle_ref(BYVAL AS GObject PTR, BYVAL AS GToggleNotify, BYVAL AS gpointer)
DECLARE FUNCTION g_object_get_qdata(BYVAL AS GObject PTR, BYVAL AS GQuark) AS gpointer
DECLARE SUB g_object_set_qdata(BYVAL AS GObject PTR, BYVAL AS GQuark, BYVAL AS gpointer)
DECLARE SUB g_object_set_qdata_full(BYVAL AS GObject PTR, BYVAL AS GQuark, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION g_object_steal_qdata(BYVAL AS GObject PTR, BYVAL AS GQuark) AS gpointer
DECLARE FUNCTION g_object_get_data(BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR) AS gpointer
DECLARE SUB g_object_set_data(BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)
DECLARE SUB g_object_set_data_full(BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION g_object_steal_data(BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR) AS gpointer
DECLARE SUB g_object_watch_closure(BYVAL AS GObject PTR, BYVAL AS GClosure PTR)
DECLARE FUNCTION g_cclosure_new_object(BYVAL AS GCallback, BYVAL AS GObject PTR) AS GClosure PTR
DECLARE FUNCTION g_cclosure_new_object_swap(BYVAL AS GCallback, BYVAL AS GObject PTR) AS GClosure PTR
DECLARE FUNCTION g_closure_new_object(BYVAL AS guint, BYVAL AS GObject PTR) AS GClosure PTR
DECLARE SUB g_value_set_object(BYVAL AS GValue PTR, BYVAL AS gpointer)
DECLARE FUNCTION g_value_get_object(BYVAL AS CONST GValue PTR) AS gpointer
DECLARE FUNCTION g_value_dup_object(BYVAL AS CONST GValue PTR) AS gpointer
DECLARE FUNCTION g_signal_connect_object(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS GCallback, BYVAL AS gpointer, BYVAL AS GConnectFlags) AS gulong
DECLARE SUB g_object_force_floating(BYVAL AS GObject PTR)
DECLARE SUB g_object_run_dispose(BYVAL AS GObject PTR)
DECLARE SUB g_value_take_object(BYVAL AS GValue PTR, BYVAL AS gpointer)

#IFNDEF G_DISABLE_DEPRECATED

DECLARE SUB g_value_set_object_take_ownership(BYVAL AS GValue PTR, BYVAL AS gpointer)

#ENDIF ' G_DISABLE_DEPRECATED

#IF NOT DEFINED(G_DISABLE_DEPRECATED) OR DEFINED(GTK_COMPILATION)

DECLARE FUNCTION g_object_compat_control(BYVAL AS gsize, BYVAL AS gpointer) AS gsize

#ENDIF ' NOT DEFINED(G_DISABLE_DEPRECATED)

#DEFINE G_OBJECT_WARN_INVALID_PSPEC(object, pname, property_id, pspec) _
   g_warning (!"%s: invalid %s id %u for \"%s\" of type `%s' in `%s'", _
              G_STRLOC, _
              (pname), _
              (property_id), _
              CAST(GParamSpec PTR, (pspec))->name, _
              g_type_name (G_PARAM_SPEC_TYPE (CAST(GParamSpec PTR, (pspec)))), _
              G_OBJECT_TYPE_NAME (CAST(GObject PTR, (object))))

#DEFINE G_OBJECT_WARN_INVALID_PROPERTY_ID(object, property_id, pspec) _
    G_OBJECT_WARN_INVALID_PSPEC ((object), !"property", (property_id), (pspec))

'DECLARE SUB g_clear_object(BYVAL AS GObject PTR PTR)
#MACRO g_clear_object(object_ptr) _
 SCOPE
  VAR _p = CAST(gpointer PTR, (object_ptr))
  VAR _o = g_atomic_pointer_get (_p)
  WHILE (0 = g_atomic_pointer_compare_and_exchange (_p, _o, NULL))
   _o = g_atomic_pointer_get (_p)
  WEND : IF (_o) THEN g_object_unref (_o)
 END SCOPE
#ENDMACRO

#ENDIF ' __G_OBJECT_H__

#DEFINE G_TYPE_BINDING_FLAGS (g_binding_flags_get_type ())
#DEFINE G_TYPE_BINDING (g_binding_get_type ())
#DEFINE G_BINDING(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_BINDING, GBinding))
#DEFINE G_IS_BINDING(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_BINDING))

TYPE GBinding AS _GBinding
TYPE GBindingTransformFunc AS FUNCTION(BYVAL AS GBinding PTR, BYVAL AS CONST GValue PTR, BYVAL AS GValue PTR, BYVAL AS gpointer) AS gboolean

ENUM GBindingFlags
  G_BINDING_DEFAULT = 0
  G_BINDING_BIDIRECTIONAL = 1 SHL 0
  G_BINDING_SYNC_CREATE = 1 SHL 1
  G_BINDING_INVERT_BOOLEAN = 1 SHL 2
END ENUM

DECLARE FUNCTION g_binding_flags_get_type() AS GType
DECLARE FUNCTION g_binding_get_type() AS GType
DECLARE FUNCTION g_binding_get_flags(BYVAL AS GBinding PTR) AS GBindingFlags
DECLARE FUNCTION g_binding_get_source(BYVAL AS GBinding PTR) AS GObject PTR
DECLARE FUNCTION g_binding_get_target(BYVAL AS GBinding PTR) AS GObject PTR
DECLARE FUNCTION g_binding_get_source_property(BYVAL AS GBinding PTR) AS G_CONST_RETURN gchar PTR
DECLARE FUNCTION g_binding_get_target_property(BYVAL AS GBinding PTR) AS G_CONST_RETURN gchar PTR
DECLARE FUNCTION g_object_bind_property(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS GBindingFlags) AS GBinding PTR
DECLARE FUNCTION g_object_bind_property_full(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS GBindingFlags, BYVAL AS GBindingTransformFunc, BYVAL AS GBindingTransformFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS GBinding PTR
DECLARE FUNCTION g_object_bind_property_with_closures(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS GBindingFlags, BYVAL AS GClosure PTR, BYVAL AS GClosure PTR) AS GBinding PTR

#ENDIF ' __G_BINDING_H__

#IFNDEF __G_BOXED_H__
#DEFINE __G_BOXED_H__

#DEFINE G_TYPE_IS_BOXED(type) (G_TYPE_FUNDAMENTAL (type)= G_TYPE_BOXED)
#DEFINE G_VALUE_HOLDS_BOXED(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_BOXED))

TYPE GBoxedCopyFunc AS FUNCTION(BYVAL AS gpointer) AS gpointer
TYPE GBoxedFreeFunc AS SUB(BYVAL AS gpointer)

DECLARE FUNCTION g_boxed_copy(BYVAL AS GType, BYVAL AS gconstpointer) AS gpointer
DECLARE SUB g_boxed_free(BYVAL AS GType, BYVAL AS gpointer)
DECLARE SUB g_value_set_boxed(BYVAL AS GValue PTR, BYVAL AS gconstpointer)
DECLARE SUB g_value_set_static_boxed(BYVAL AS GValue PTR, BYVAL AS gconstpointer)
DECLARE FUNCTION g_value_get_boxed(BYVAL AS CONST GValue PTR) AS gpointer
DECLARE FUNCTION g_value_dup_boxed(BYVAL AS CONST GValue PTR) AS gpointer
DECLARE FUNCTION g_boxed_type_register_static(BYVAL AS CONST gchar PTR, BYVAL AS GBoxedCopyFunc, BYVAL AS GBoxedFreeFunc) AS GType

#DEFINE G_TYPE_CLOSURE (g_closure_get_type ())
#DEFINE G_TYPE_VALUE (g_value_get_type ())
#DEFINE G_TYPE_VALUE_ARRAY (g_value_array_get_type ())
#DEFINE G_TYPE_DATE (g_date_get_type ())
#DEFINE G_TYPE_STRV (g_strv_get_type ())
#DEFINE G_TYPE_GSTRING (g_gstring_get_type ())
#DEFINE G_TYPE_HASH_TABLE (g_hash_table_get_type ())
#DEFINE G_TYPE_REGEX (g_regex_get_type ())
#DEFINE G_TYPE_ARRAY (g_array_get_type ())
#DEFINE G_TYPE_BYTE_ARRAY (g_byte_array_get_type ())
#DEFINE G_TYPE_PTR_ARRAY (g_ptr_array_get_type ())
#DEFINE G_TYPE_VARIANT_TYPE (g_variant_type_get_gtype ())
#DEFINE G_TYPE_ERROR (g_error_get_type ())
#DEFINE G_TYPE_DATE_TIME (g_date_time_get_type ())

DECLARE SUB g_value_take_boxed(BYVAL AS GValue PTR, BYVAL AS gconstpointer)

#IFNDEF G_DISABLE_DEPRECATED

DECLARE SUB g_value_set_boxed_take_ownership(BYVAL AS GValue PTR, BYVAL AS gconstpointer)

#ENDIF ' G_DISABLE_DEPRECATED

DECLARE FUNCTION g_closure_get_type() AS GType
DECLARE FUNCTION g_value_get_type() AS GType
DECLARE FUNCTION g_value_array_get_type() AS GType
DECLARE FUNCTION g_date_get_type() AS GType
DECLARE FUNCTION g_strv_get_type() AS GType
DECLARE FUNCTION g_gstring_get_type() AS GType
DECLARE FUNCTION g_hash_table_get_type() AS GType
DECLARE FUNCTION g_array_get_type() AS GType
DECLARE FUNCTION g_byte_array_get_type() AS GType
DECLARE FUNCTION g_ptr_array_get_type() AS GType
DECLARE FUNCTION g_variant_type_get_gtype() AS GType
DECLARE FUNCTION g_regex_get_type() AS GType
DECLARE FUNCTION g_error_get_type() AS GType
DECLARE FUNCTION g_date_time_get_type() AS GType

#IFNDEF G_DISABLE_DEPRECATED

DECLARE FUNCTION g_variant_get_gtype() AS GType

#ENDIF ' G_DISABLE_DEPRECATED

TYPE GStrv AS gchar PTR PTR

#ENDIF ' __G_BOXED_H__

#IFNDEF __G_ENUMS_H__
#DEFINE __G_ENUMS_H__

#DEFINE G_TYPE_IS_ENUM(type) (G_TYPE_FUNDAMENTAL (type)= G_TYPE_ENUM)
#DEFINE G_ENUM_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), G_TYPE_ENUM, GEnumClass))
#DEFINE G_IS_ENUM_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_ENUM))
#DEFINE G_ENUM_CLASS_TYPE(class) (G_TYPE_FROM_CLASS (class))
#DEFINE G_ENUM_CLASS_TYPE_NAME(class) (g_type_name (G_ENUM_CLASS_TYPE (class)))
#DEFINE G_TYPE_IS_FLAGS(type) (G_TYPE_FUNDAMENTAL (type)= G_TYPE_FLAGS)
#DEFINE G_FLAGS_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), G_TYPE_FLAGS, GFlagsClass))
#DEFINE G_IS_FLAGS_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_FLAGS))
#DEFINE G_FLAGS_CLASS_TYPE(class) (G_TYPE_FROM_CLASS (class))
#DEFINE G_FLAGS_CLASS_TYPE_NAME(class) (g_type_name (G_FLAGS_CLASS_TYPE (class)))
#DEFINE G_VALUE_HOLDS_ENUM(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_ENUM))
#DEFINE G_VALUE_HOLDS_FLAGS(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_FLAGS))

TYPE GEnumClass AS _GEnumClass
TYPE GFlagsClass AS _GFlagsClass
TYPE GEnumValue AS _GEnumValue
TYPE GFlagsValue AS _GFlagsValue

TYPE _GEnumClass
  AS GTypeClass g_type_class
  AS gint minimum
  AS gint maximum
  AS guint n_values
  AS GEnumValue PTR values
END TYPE

TYPE _GFlagsClass
  AS GTypeClass g_type_class
  AS guint mask
  AS guint n_values
  AS GFlagsValue PTR values
END TYPE

TYPE _GEnumValue
  AS gint value
  AS CONST gchar PTR value_name
  AS CONST gchar PTR value_nick
END TYPE

TYPE _GFlagsValue
  AS guint value
  AS CONST gchar PTR value_name
  AS CONST gchar PTR value_nick
END TYPE

DECLARE FUNCTION g_enum_get_value(BYVAL AS GEnumClass PTR, BYVAL AS gint) AS GEnumValue PTR
DECLARE FUNCTION g_enum_get_value_by_name(BYVAL AS GEnumClass PTR, BYVAL AS CONST gchar PTR) AS GEnumValue PTR
DECLARE FUNCTION g_enum_get_value_by_nick(BYVAL AS GEnumClass PTR, BYVAL AS CONST gchar PTR) AS GEnumValue PTR
DECLARE FUNCTION g_flags_get_first_value(BYVAL AS GFlagsClass PTR, BYVAL AS guint) AS GFlagsValue PTR
DECLARE FUNCTION g_flags_get_value_by_name(BYVAL AS GFlagsClass PTR, BYVAL AS CONST gchar PTR) AS GFlagsValue PTR
DECLARE FUNCTION g_flags_get_value_by_nick(BYVAL AS GFlagsClass PTR, BYVAL AS CONST gchar PTR) AS GFlagsValue PTR
DECLARE SUB g_value_set_enum(BYVAL AS GValue PTR, BYVAL AS gint)
DECLARE FUNCTION g_value_get_enum(BYVAL AS CONST GValue PTR) AS gint
DECLARE SUB g_value_set_flags(BYVAL AS GValue PTR, BYVAL AS guint)
DECLARE FUNCTION g_value_get_flags(BYVAL AS CONST GValue PTR) AS guint
DECLARE FUNCTION g_enum_register_static(BYVAL AS CONST gchar PTR, BYVAL AS CONST GEnumValue PTR) AS GType
DECLARE FUNCTION g_flags_register_static(BYVAL AS CONST gchar PTR, BYVAL AS CONST GFlagsValue PTR) AS GType
DECLARE SUB g_enum_complete_type_info(BYVAL AS GType, BYVAL AS GTypeInfo PTR, BYVAL AS CONST GEnumValue PTR)
DECLARE SUB g_flags_complete_type_info(BYVAL AS GType, BYVAL AS GTypeInfo PTR, BYVAL AS CONST GFlagsValue PTR)

#ENDIF ' __G_ENUMS_H__

#IFNDEF __G_PARAMSPECS_H__
#DEFINE __G_PARAMSPECS_H__

#DEFINE G_TYPE_PARAM_CHAR (g_param_spec_types[0])
#DEFINE G_IS_PARAM_SPEC_CHAR(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_CHAR))
#DEFINE G_PARAM_SPEC_CHAR(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_CHAR, GParamSpecChar))
#DEFINE G_TYPE_PARAM_UCHAR (g_param_spec_types[1])
#DEFINE G_IS_PARAM_SPEC_UCHAR(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_UCHAR))
#DEFINE G_PARAM_SPEC_UCHAR(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_UCHAR, GParamSpecUChar))
#DEFINE G_TYPE_PARAM_BOOLEAN (g_param_spec_types[2])
#DEFINE G_IS_PARAM_SPEC_BOOLEAN(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_BOOLEAN))
#DEFINE G_PARAM_SPEC_BOOLEAN(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_BOOLEAN, GParamSpecBoolean))
#DEFINE G_TYPE_PARAM_INT (g_param_spec_types[3])
#DEFINE G_IS_PARAM_SPEC_INT(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_INT))
#DEFINE G_PARAM_SPEC_INT(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_INT, GParamSpecInt))
#DEFINE G_TYPE_PARAM_UINT (g_param_spec_types[4])
#DEFINE G_IS_PARAM_SPEC_UINT(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_UINT))
#DEFINE G_PARAM_SPEC_UINT(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_UINT, GParamSpecUInt))
#DEFINE G_TYPE_PARAM_LONG (g_param_spec_types[5])
#DEFINE G_IS_PARAM_SPEC_LONG(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_LONG))
#DEFINE G_PARAM_SPEC_LONG(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_LONG, GParamSpecLong))
#DEFINE G_TYPE_PARAM_ULONG (g_param_spec_types[6])
#DEFINE G_IS_PARAM_SPEC_ULONG(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_ULONG))
#DEFINE G_PARAM_SPEC_ULONG(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_ULONG, GParamSpecULong))
#DEFINE G_TYPE_PARAM_INT64 (g_param_spec_types[7])
#DEFINE G_IS_PARAM_SPEC_INT64(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_INT64))
#DEFINE G_PARAM_SPEC_INT64(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_INT64, GParamSpecInt64))
#DEFINE G_TYPE_PARAM_UINT64 (g_param_spec_types[8])
#DEFINE G_IS_PARAM_SPEC_UINT64(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_UINT64))
#DEFINE G_PARAM_SPEC_UINT64(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_UINT64, GParamSpecUInt64))
#DEFINE G_TYPE_PARAM_UNICHAR (g_param_spec_types[9])
#DEFINE G_PARAM_SPEC_UNICHAR(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_UNICHAR, GParamSpecUnichar))
#DEFINE G_IS_PARAM_SPEC_UNICHAR(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_UNICHAR))
#DEFINE G_TYPE_PARAM_ENUM (g_param_spec_types[10])
#DEFINE G_IS_PARAM_SPEC_ENUM(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_ENUM))
#DEFINE G_PARAM_SPEC_ENUM(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_ENUM, GParamSpecEnum))
#DEFINE G_TYPE_PARAM_FLAGS (g_param_spec_types[11])
#DEFINE G_IS_PARAM_SPEC_FLAGS(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_FLAGS))
#DEFINE G_PARAM_SPEC_FLAGS(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_FLAGS, GParamSpecFlags))
#DEFINE G_TYPE_PARAM_FLOAT (g_param_spec_types[12])
#DEFINE G_IS_PARAM_SPEC_FLOAT(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_FLOAT))
#DEFINE G_PARAM_SPEC_FLOAT(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_FLOAT, GParamSpecFloat))
#DEFINE G_TYPE_PARAM_DOUBLE (g_param_spec_types[13])
#DEFINE G_IS_PARAM_SPEC_DOUBLE(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_DOUBLE))
#DEFINE G_PARAM_SPEC_DOUBLE(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_DOUBLE, GParamSpecDouble))
#DEFINE G_TYPE_PARAM_STRING (g_param_spec_types[14])
#DEFINE G_IS_PARAM_SPEC_STRING(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_STRING))
#DEFINE G_PARAM_SPEC_STRING(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_STRING, GParamSpecString))
#DEFINE G_TYPE_PARAM_PARAM (g_param_spec_types[15])
#DEFINE G_IS_PARAM_SPEC_PARAM(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_PARAM))
#DEFINE G_PARAM_SPEC_PARAM(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_PARAM, GParamSpecParam))
#DEFINE G_TYPE_PARAM_BOXED (g_param_spec_types[16])
#DEFINE G_IS_PARAM_SPEC_BOXED(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_BOXED))
#DEFINE G_PARAM_SPEC_BOXED(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_BOXED, GParamSpecBoxed))
#DEFINE G_TYPE_PARAM_POINTER (g_param_spec_types[17])
#DEFINE G_IS_PARAM_SPEC_POINTER(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_POINTER))
#DEFINE G_PARAM_SPEC_POINTER(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_POINTER, GParamSpecPointer))
#DEFINE G_TYPE_PARAM_VALUE_ARRAY (g_param_spec_types[18])
#DEFINE G_IS_PARAM_SPEC_VALUE_ARRAY(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_VALUE_ARRAY))
#DEFINE G_PARAM_SPEC_VALUE_ARRAY(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_VALUE_ARRAY, GParamSpecValueArray))
#DEFINE G_TYPE_PARAM_OBJECT (g_param_spec_types[19])
#DEFINE G_IS_PARAM_SPEC_OBJECT(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_OBJECT))
#DEFINE G_PARAM_SPEC_OBJECT(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_OBJECT, GParamSpecObject))
#DEFINE G_TYPE_PARAM_OVERRIDE (g_param_spec_types[20])
#DEFINE G_IS_PARAM_SPEC_OVERRIDE(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_OVERRIDE))
#DEFINE G_PARAM_SPEC_OVERRIDE(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_OVERRIDE, GParamSpecOverride))
#DEFINE G_TYPE_PARAM_GTYPE (g_param_spec_types[21])
#DEFINE G_IS_PARAM_SPEC_GTYPE(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_GTYPE))
#DEFINE G_PARAM_SPEC_GTYPE(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_GTYPE, GParamSpecGType))
#DEFINE G_TYPE_PARAM_VARIANT (g_param_spec_types[22])
#DEFINE G_IS_PARAM_SPEC_VARIANT(pspec) (G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM_VARIANT))
#DEFINE G_PARAM_SPEC_VARIANT(pspec) (G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM_VARIANT, GParamSpecVariant))

TYPE GParamSpecChar AS _GParamSpecChar
TYPE GParamSpecUChar AS _GParamSpecUChar
TYPE GParamSpecBoolean AS _GParamSpecBoolean
TYPE GParamSpecInt AS _GParamSpecInt
TYPE GParamSpecUInt AS _GParamSpecUInt
TYPE GParamSpecLong AS _GParamSpecLong
TYPE GParamSpecULong AS _GParamSpecULong
TYPE GParamSpecInt64 AS _GParamSpecInt64
TYPE GParamSpecUInt64 AS _GParamSpecUInt64
TYPE GParamSpecUnichar AS _GParamSpecUnichar
TYPE GParamSpecEnum AS _GParamSpecEnum
TYPE GParamSpecFlags AS _GParamSpecFlags
TYPE GParamSpecFloat AS _GParamSpecFloat
TYPE GParamSpecDouble AS _GParamSpecDouble
TYPE GParamSpecString AS _GParamSpecString
TYPE GParamSpecParam AS _GParamSpecParam
TYPE GParamSpecBoxed AS _GParamSpecBoxed
TYPE GParamSpecPointer AS _GParamSpecPointer
TYPE GParamSpecValueArray AS _GParamSpecValueArray
TYPE GParamSpecObject AS _GParamSpecObject
TYPE GParamSpecOverride AS _GParamSpecOverride
TYPE GParamSpecGType AS _GParamSpecGType
TYPE GParamSpecVariant AS _GParamSpecVariant

TYPE _GParamSpecChar
  AS GParamSpec parent_instance
  AS gint8 minimum
  AS gint8 maximum
  AS gint8 default_value
END TYPE

TYPE _GParamSpecUChar
  AS GParamSpec parent_instance
  AS guint8 minimum
  AS guint8 maximum
  AS guint8 default_value
END TYPE

TYPE _GParamSpecBoolean
  AS GParamSpec parent_instance
  AS gboolean default_value
END TYPE

TYPE _GParamSpecInt
  AS GParamSpec parent_instance
  AS gint minimum
  AS gint maximum
  AS gint default_value
END TYPE

TYPE _GParamSpecUInt
  AS GParamSpec parent_instance
  AS guint minimum
  AS guint maximum
  AS guint default_value
END TYPE

TYPE _GParamSpecLong
  AS GParamSpec parent_instance
  AS glong minimum
  AS glong maximum
  AS glong default_value
END TYPE

TYPE _GParamSpecULong
  AS GParamSpec parent_instance
  AS gulong minimum
  AS gulong maximum
  AS gulong default_value
END TYPE

TYPE _GParamSpecInt64
  AS GParamSpec parent_instance
  AS gint64 minimum
  AS gint64 maximum
  AS gint64 default_value
END TYPE

TYPE _GParamSpecUInt64
  AS GParamSpec parent_instance
  AS guint64 minimum
  AS guint64 maximum
  AS guint64 default_value
END TYPE

TYPE _GParamSpecUnichar
  AS GParamSpec parent_instance
  AS gunichar default_value
END TYPE

TYPE _GParamSpecEnum
  AS GParamSpec parent_instance
  AS GEnumClass PTR enum_class
  AS gint default_value
END TYPE

TYPE _GParamSpecFlags
  AS GParamSpec parent_instance
  AS GFlagsClass PTR flags_class
  AS guint default_value
END TYPE

TYPE _GParamSpecFloat
  AS GParamSpec parent_instance
  AS gfloat minimum
  AS gfloat maximum
  AS gfloat default_value
  AS gfloat epsilon
END TYPE

TYPE _GParamSpecDouble
  AS GParamSpec parent_instance
  AS gdouble minimum
  AS gdouble maximum
  AS gdouble default_value
  AS gdouble epsilon
END TYPE

TYPE _GParamSpecString
  AS GParamSpec parent_instance
  AS gchar PTR default_value
  AS gchar PTR cset_first
  AS gchar PTR cset_nth
  AS gchar substitutor
  AS guint null_fold_if_empty : 1
  AS guint ensure_non_null : 1
END TYPE

TYPE _GParamSpecParam
  AS GParamSpec parent_instance
END TYPE

TYPE _GParamSpecBoxed
  AS GParamSpec parent_instance
END TYPE

TYPE _GParamSpecPointer
  AS GParamSpec parent_instance
END TYPE

TYPE _GParamSpecValueArray
  AS GParamSpec parent_instance
  AS GParamSpec PTR element_spec
  AS guint fixed_n_elements
END TYPE

TYPE _GParamSpecObject
  AS GParamSpec parent_instance
END TYPE

TYPE _GParamSpecOverride
  AS GParamSpec parent_instance
  AS GParamSpec PTR overridden
END TYPE

TYPE _GParamSpecGType
  AS GParamSpec parent_instance
  AS GType is_a_type
END TYPE

TYPE _GParamSpecVariant
  AS GParamSpec parent_instance
  AS GVariantType PTR type
  AS GVariant PTR default_value
  AS gpointer padding(3)
END TYPE

DECLARE FUNCTION g_param_spec_char_FB ALIAS "g_param_spec_char"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint8, BYVAL AS gint8, BYVAL AS gint8, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_uchar_FB ALIAS "g_param_spec_uchar"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint8, BYVAL AS guint8, BYVAL AS guint8, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_boolean_FB ALIAS "g_param_spec_boolean"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_int_FB ALIAS "g_param_spec_int"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_uint_FB ALIAS "g_param_spec_uint"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_long_FB ALIAS "g_param_spec_long"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS glong, BYVAL AS glong, BYVAL AS glong, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_ulong_FB ALIAS "g_param_spec_ulong"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gulong, BYVAL AS gulong, BYVAL AS gulong, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_int64_FB ALIAS "g_param_spec_int64"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint64, BYVAL AS gint64, BYVAL AS gint64, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_uint64_FB ALIAS "g_param_spec_uint64"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint64, BYVAL AS guint64, BYVAL AS guint64, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_unichar_FB ALIAS "g_param_spec_unichar"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gunichar, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_enum_FB ALIAS "g_param_spec_enum"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS gint, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_flags_FB ALIAS "g_param_spec_flags"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS guint, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_float_FB ALIAS "g_param_spec_float"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gfloat, BYVAL AS gfloat, BYVAL AS gfloat, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_double_FB ALIAS "g_param_spec_double"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_string_FB ALIAS "g_param_spec_string"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_param_FB ALIAS "g_param_spec_param"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_boxed_FB ALIAS "g_param_spec_boxed"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_pointer_FB ALIAS "g_param_spec_pointer"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_value_array_FB ALIAS "g_param_spec_value_array"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GParamSpec PTR, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_object_FB ALIAS "g_param_spec_object"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_override_FB ALIAS "g_param_spec_override"(BYVAL AS CONST gchar PTR, BYVAL AS GParamSpec PTR) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_gtype_FB ALIAS "g_param_spec_gtype"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GType, BYVAL AS GParamFlags) AS GParamSpec PTR
DECLARE FUNCTION g_param_spec_variant_FB ALIAS "g_param_spec_variant"(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GVariantType PTR, BYVAL AS GVariant PTR, BYVAL AS GParamFlags) AS GParamSpec PTR

DIM AS GType PTR g_param_spec_types

#ENDIF ' __G_PARAMSPECS_H__

#IFNDEF __G_SOURCECLOSURE_H__
#DEFINE __G_SOURCECLOSURE_H__

DECLARE SUB g_source_set_closure(BYVAL AS GSource PTR, BYVAL AS GClosure PTR)
DECLARE SUB g_source_set_dummy_callback(BYVAL AS GSource PTR)
DECLARE FUNCTION g_io_channel_get_type() AS GType
DECLARE FUNCTION g_io_condition_get_type() AS GType

#DEFINE G_TYPE_IO_CHANNEL (g_io_channel_get_type ())
#DEFINE G_TYPE_IO_CONDITION (g_io_condition_get_type ())
#ENDIF ' __G_SOURCECLOSURE_H__

#IFNDEF __G_TYPE_MODULE_H__
#DEFINE __G_TYPE_MODULE_H__

TYPE GTypeModule AS _GTypeModule
TYPE GTypeModuleClass AS _GTypeModuleClass

#DEFINE G_TYPE_TYPE_MODULE (g_type_module_get_type ())
#DEFINE G_TYPE_MODULE(module) (G_TYPE_CHECK_INSTANCE_CAST ((module), G_TYPE_TYPE_MODULE, GTypeModule))
#DEFINE G_TYPE_MODULE_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), G_TYPE_TYPE_MODULE, GTypeModuleClass))
#DEFINE G_IS_TYPE_MODULE(module) (G_TYPE_CHECK_INSTANCE_TYPE ((module), G_TYPE_TYPE_MODULE))
#DEFINE G_IS_TYPE_MODULE_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_TYPE_MODULE))
#DEFINE G_TYPE_MODULE_GET_CLASS(module) (G_TYPE_INSTANCE_GET_CLASS ((module), G_TYPE_TYPE_MODULE, GTypeModuleClass))

TYPE _GTypeModule
  AS GObject parent_instance
  AS guint use_count
  AS GSList PTR type_infos
  AS GSList PTR interface_infos
  AS gchar PTR name
END TYPE

TYPE _GTypeModuleClass
  AS GObjectClass parent_class
  load AS FUNCTION(BYVAL AS GTypeModule PTR) AS gboolean
  unload AS SUB(BYVAL AS GTypeModule PTR)
  reserved1 AS SUB()
  reserved2 AS SUB()
  reserved3 AS SUB()
  reserved4 AS SUB()
END TYPE

#DEFINE G_DEFINE_DYNAMIC_TYPE(TN, t_n, T_P) G_DEFINE_DYNAMIC_TYPE_EXTENDED (TN, t_n, T_P, 0, )

#MACRO G_DEFINE_DYNAMIC_TYPE_EXTENDED(TypeName, type_name, TYPE_PARENT, flags, CODE)
 DECLARE SUB type_name##_init CDECL(BYVAL self AS TypeName PTR)
 DECLARE SUB type_name##_class_init CDECL(BYVAL klass AS TypeName##Class PTR)
 DECLARE SUB type_name##_class_finalize CDECL(BYVAL klass AS TypeName##Class PTR)
 STATIC SHARED AS gpointer type_name##_parent_class = NULL
 STATIC SHARED AS GType type_name##_type_id = 0
 SUB type_name##_class_intern_init CDECL(BYVAL klass AS gpointer)
   type_name##_parent_class = g_type_class_peek_parent (klass)
   type_name##_class_init (CAST(TypeName##Class PTR, klass))
 END SUB

 FUNCTION type_name##_get_type CDECL() AS GType
   RETURN type_name##_type_id
 END FUNCTION

 SUB type_name##_register_type CDECL(BYVAL type_module AS GTypeModule PTR)
   DIM AS GType g_define_type_id
   CONST AS GTypeInfo g_define_type_info = TYPE<GTypeInfo>( _
     SIZEOF (TypeName##Class), _
     CAST(GBaseInitFunc, NULL), _
     CAST(GBaseFinalizeFunc, NULL), _
     CAST(GClassInitFunc, @type_name##_class_intern_init), _
     CAST(GClassFinalizeFunc, @type_name##_class_finalize), _
     NULL, _
     SIZEOF (TypeName), _
     0, _
     CAST(GInstanceInitFunc, @type_name##_init), _
     NULL _
     )
   type_name##_type_id = g_type_module_register_type (type_module, TYPE_PARENT, #TypeName, @g_define_type_info, CAST(GTypeFlags, flags))
   g_define_type_id = type_name##_type_id
#ENDMACRO

#MACRO G_IMPLEMENT_INTERFACE_DYNAMIC(TYPE_IFACE, iface_init)
 SCOPE
  CONST AS GInterfaceInfo g_implement_interface_info = TYPE<GInterfaceInfo>( CAST(GInterfaceInitFunc, iface_init), NULL, NULL )
  g_type_module_add_interface (type_module, g_define_type_id, TYPE_IFACE, @g_implement_interface_info)
 END SCOPE
#ENDMACRO

DECLARE FUNCTION g_type_module_get_type() AS GType
DECLARE FUNCTION g_type_module_use(BYVAL AS GTypeModule PTR) AS gboolean
DECLARE SUB g_type_module_unuse(BYVAL AS GTypeModule PTR)
DECLARE SUB g_type_module_set_name(BYVAL AS GTypeModule PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_type_module_register_type(BYVAL AS GTypeModule PTR, BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS CONST GTypeInfo PTR, BYVAL AS GTypeFlags) AS GType
DECLARE SUB g_type_module_add_interface(BYVAL AS GTypeModule PTR, BYVAL AS GType, BYVAL AS GType, BYVAL AS CONST GInterfaceInfo PTR)
DECLARE FUNCTION g_type_module_register_enum(BYVAL AS GTypeModule PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GEnumValue PTR) AS GType
DECLARE FUNCTION g_type_module_register_flags(BYVAL AS GTypeModule PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GFlagsValue PTR) AS GType

#ENDIF ' __G_TYPE_MODULE_H__

#IFNDEF __G_TYPE_PLUGIN_H__
#DEFINE __G_TYPE_PLUGIN_H__

#DEFINE G_TYPE_TYPE_PLUGIN (g_type_plugin_get_type ())
#DEFINE G_TYPE_PLUGIN(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), G_TYPE_TYPE_PLUGIN, GTypePlugin))
#DEFINE G_TYPE_PLUGIN_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), G_TYPE_TYPE_PLUGIN, GTypePluginClass))
#DEFINE G_IS_TYPE_PLUGIN(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), G_TYPE_TYPE_PLUGIN))
#DEFINE G_IS_TYPE_PLUGIN_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), G_TYPE_TYPE_PLUGIN))
#DEFINE G_TYPE_PLUGIN_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), G_TYPE_TYPE_PLUGIN, GTypePluginClass))

TYPE GTypePluginClass AS _GTypePluginClass
TYPE GTypePluginUse AS SUB(BYVAL AS GTypePlugin PTR)
TYPE GTypePluginUnuse AS SUB(BYVAL AS GTypePlugin PTR)
TYPE GTypePluginCompleteTypeInfo AS SUB(BYVAL AS GTypePlugin PTR, BYVAL AS GType, BYVAL AS GTypeInfo PTR, BYVAL AS GTypeValueTable PTR)
TYPE GTypePluginCompleteInterfaceInfo AS SUB(BYVAL AS GTypePlugin PTR, BYVAL AS GType, BYVAL AS GType, BYVAL AS GInterfaceInfo PTR)

TYPE _GTypePluginClass
  AS GTypeInterface base_iface
  AS GTypePluginUse use_plugin
  AS GTypePluginUnuse unuse_plugin
  AS GTypePluginCompleteTypeInfo complete_type_info
  AS GTypePluginCompleteInterfaceInfo complete_interface_info
END TYPE

DECLARE FUNCTION g_type_plugin_get_type() AS GType
DECLARE SUB g_type_plugin_use(BYVAL AS GTypePlugin PTR)
DECLARE SUB g_type_plugin_unuse(BYVAL AS GTypePlugin PTR)
DECLARE SUB g_type_plugin_complete_type_info(BYVAL AS GTypePlugin PTR, BYVAL AS GType, BYVAL AS GTypeInfo PTR, BYVAL AS GTypeValueTable PTR)
DECLARE SUB g_type_plugin_complete_interface_info(BYVAL AS GTypePlugin PTR, BYVAL AS GType, BYVAL AS GType, BYVAL AS GInterfaceInfo PTR)

#ENDIF ' __G_TYPE_PLUGIN_H__

#IFNDEF __G_VALUE_ARRAY_H__
#DEFINE __G_VALUE_ARRAY_H__

TYPE GValueArray AS _GValueArray

TYPE _GValueArray
  AS guint n_values
  AS GValue PTR values
  AS guint n_prealloced
END TYPE

DECLARE FUNCTION g_value_array_get_nth(BYVAL AS GValueArray PTR, BYVAL AS guint) AS GValue PTR
DECLARE FUNCTION g_value_array_new(BYVAL AS guint) AS GValueArray PTR
DECLARE SUB g_value_array_free(BYVAL AS GValueArray PTR)
DECLARE FUNCTION g_value_array_copy(BYVAL AS CONST GValueArray PTR) AS GValueArray PTR
DECLARE FUNCTION g_value_array_prepend(BYVAL AS GValueArray PTR, BYVAL AS CONST GValue PTR) AS GValueArray PTR
DECLARE FUNCTION g_value_array_append(BYVAL AS GValueArray PTR, BYVAL AS CONST GValue PTR) AS GValueArray PTR
DECLARE FUNCTION g_value_array_insert(BYVAL AS GValueArray PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR) AS GValueArray PTR
DECLARE FUNCTION g_value_array_remove(BYVAL AS GValueArray PTR, BYVAL AS guint) AS GValueArray PTR
DECLARE FUNCTION g_value_array_sort(BYVAL AS GValueArray PTR, BYVAL AS GCompareFunc) AS GValueArray PTR
DECLARE FUNCTION g_value_array_sort_with_data(BYVAL AS GValueArray PTR, BYVAL AS GCompareDataFunc, BYVAL AS gpointer) AS GValueArray PTR

#ENDIF ' __G_VALUE_ARRAY_H__

#IFNDEF __G_VALUETYPES_H__
#DEFINE __G_VALUETYPES_H__

#DEFINE G_VALUE_HOLDS_CHAR(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_CHAR))
#DEFINE G_VALUE_HOLDS_UCHAR(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_UCHAR))
#DEFINE G_VALUE_HOLDS_BOOLEAN(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_BOOLEAN))
#DEFINE G_VALUE_HOLDS_INT(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_INT))
#DEFINE G_VALUE_HOLDS_UINT(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_UINT))
#DEFINE G_VALUE_HOLDS_LONG(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_LONG))
#DEFINE G_VALUE_HOLDS_ULONG(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_ULONG))
#DEFINE G_VALUE_HOLDS_INT64(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_INT64))
#DEFINE G_VALUE_HOLDS_UINT64(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_UINT64))
#DEFINE G_VALUE_HOLDS_FLOAT(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_FLOAT))
#DEFINE G_VALUE_HOLDS_DOUBLE(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_DOUBLE))
#DEFINE G_VALUE_HOLDS_STRING(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_STRING))
#DEFINE G_VALUE_HOLDS_POINTER(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_POINTER))
#DEFINE G_TYPE_GTYPE (g_gtype_get_type())
#DEFINE G_VALUE_HOLDS_GTYPE(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_GTYPE))
#DEFINE G_VALUE_HOLDS_VARIANT(value) (G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_VARIANT))

DECLARE SUB g_value_set_char(BYVAL AS GValue PTR, BYVAL AS UBYTE)
DECLARE FUNCTION g_value_get_char(BYVAL AS CONST GValue PTR) AS UBYTE
DECLARE SUB g_value_set_uchar(BYVAL AS GValue PTR, BYVAL AS guchar)
DECLARE FUNCTION g_value_get_uchar(BYVAL AS CONST GValue PTR) AS guchar
DECLARE SUB g_value_set_boolean(BYVAL AS GValue PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_value_get_boolean(BYVAL AS CONST GValue PTR) AS gboolean
DECLARE SUB g_value_set_int(BYVAL AS GValue PTR, BYVAL AS gint)
DECLARE FUNCTION g_value_get_int(BYVAL AS CONST GValue PTR) AS gint
DECLARE SUB g_value_set_uint(BYVAL AS GValue PTR, BYVAL AS guint)
DECLARE FUNCTION g_value_get_uint(BYVAL AS CONST GValue PTR) AS guint
DECLARE SUB g_value_set_long(BYVAL AS GValue PTR, BYVAL AS glong)
DECLARE FUNCTION g_value_get_long(BYVAL AS CONST GValue PTR) AS glong
DECLARE SUB g_value_set_ulong(BYVAL AS GValue PTR, BYVAL AS gulong)
DECLARE FUNCTION g_value_get_ulong(BYVAL AS CONST GValue PTR) AS gulong
DECLARE SUB g_value_set_int64(BYVAL AS GValue PTR, BYVAL AS gint64)
DECLARE FUNCTION g_value_get_int64(BYVAL AS CONST GValue PTR) AS gint64
DECLARE SUB g_value_set_uint64(BYVAL AS GValue PTR, BYVAL AS guint64)
DECLARE FUNCTION g_value_get_uint64(BYVAL AS CONST GValue PTR) AS guint64
DECLARE SUB g_value_set_float(BYVAL AS GValue PTR, BYVAL AS gfloat)
DECLARE FUNCTION g_value_get_float(BYVAL AS CONST GValue PTR) AS gfloat
DECLARE SUB g_value_set_double(BYVAL AS GValue PTR, BYVAL AS gdouble)
DECLARE FUNCTION g_value_get_double(BYVAL AS CONST GValue PTR) AS gdouble
DECLARE SUB g_value_set_string(BYVAL AS GValue PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_value_set_static_string(BYVAL AS GValue PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_value_get_string(BYVAL AS CONST GValue PTR) AS G_CONST_RETURN gchar PTR
DECLARE FUNCTION g_value_dup_string(BYVAL AS CONST GValue PTR) AS gchar PTR
DECLARE SUB g_value_set_pointer(BYVAL AS GValue PTR, BYVAL AS gpointer)
DECLARE FUNCTION g_value_get_pointer(BYVAL AS CONST GValue PTR) AS gpointer
DECLARE FUNCTION g_gtype_get_type() AS GType
DECLARE SUB g_value_set_gtype(BYVAL AS GValue PTR, BYVAL AS GType)
DECLARE FUNCTION g_value_get_gtype(BYVAL AS CONST GValue PTR) AS GType
DECLARE SUB g_value_set_variant(BYVAL AS GValue PTR, BYVAL AS GVariant PTR)
DECLARE SUB g_value_take_variant(BYVAL AS GValue PTR, BYVAL AS GVariant PTR)
DECLARE FUNCTION g_value_get_variant(BYVAL AS CONST GValue PTR) AS GVariant PTR
DECLARE FUNCTION g_value_dup_variant(BYVAL AS CONST GValue PTR) AS GVariant PTR
DECLARE FUNCTION g_pointer_type_register_static(BYVAL AS CONST gchar PTR) AS GType
DECLARE FUNCTION g_strdup_value_contents(BYVAL AS CONST GValue PTR) AS gchar PTR
DECLARE SUB g_value_take_string(BYVAL AS GValue PTR, BYVAL AS gchar PTR)

#IFNDEF G_DISABLE_DEPRECATED

DECLARE SUB g_value_set_string_take_ownership(BYVAL AS GValue PTR, BYVAL AS gchar PTR)

#ENDIF ' G_DISABLE_DEPRECATED

TYPE gchararray AS gchar PTR

#ENDIF ' __G_VALUETYPES_H__

#UNDEF __GLIB_GOBJECT_H_INSIDE__
#ENDIF ' __GLIB_GOBJECT_H__

END EXTERN

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF
