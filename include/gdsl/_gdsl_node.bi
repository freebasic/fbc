''
''
'' _gdsl_node -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef ___gdsl_node_bi__
#define ___gdsl_node_bi__

#include once "gdsl_types.bi"

type _gdsl_node_t as any ptr

extern "c"
declare function _gdsl_node_alloc () as _gdsl_node_t
declare function _gdsl_node_free (byval NODE as _gdsl_node_t) as gdsl_element_t
declare function _gdsl_node_get_succ (byval NODE as _gdsl_node_t) as _gdsl_node_t
declare function _gdsl_node_get_pred (byval NODE as _gdsl_node_t) as _gdsl_node_t
declare function _gdsl_node_get_content (byval NODE as _gdsl_node_t) as gdsl_element_t
declare sub _gdsl_node_set_succ (byval NODE as _gdsl_node_t, byval SUCC as _gdsl_node_t)
declare sub _gdsl_node_set_pred (byval NODE as _gdsl_node_t, byval PRED as _gdsl_node_t)
declare sub _gdsl_node_set_content (byval NODE as _gdsl_node_t, byval CONTENT as gdsl_element_t)
declare sub _gdsl_node_link (byval NODE1 as _gdsl_node_t, byval NODE2 as _gdsl_node_t)
declare sub _gdsl_node_unlink (byval NODE1 as _gdsl_node_t, byval NODE2 as _gdsl_node_t)
declare sub _gdsl_node_write (byval NODE as _gdsl_node_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_node_write_xml (byval NODE as _gdsl_node_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
declare sub _gdsl_node_dump (byval NODE as _gdsl_node_t, byval WRITE_F as gdsl_write_func_t, byval OUTPUT_FILE as FILE ptr, byval USER_DATA as any ptr)
end extern

#endif
