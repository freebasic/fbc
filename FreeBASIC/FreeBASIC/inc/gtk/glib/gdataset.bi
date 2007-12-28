''
''
'' gdataset -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdataset_bi__
#define __gdataset_bi__

#include once "gquark.bi"

type GData as _GData
type GDataForeachFunc as sub cdecl(byval as GQuark, byval as gpointer, byval as gpointer)

declare sub g_datalist_init (byval datalist as GData ptr ptr)
declare sub g_datalist_clear (byval datalist as GData ptr ptr)
declare function g_datalist_id_get_data (byval datalist as GData ptr ptr, byval key_id as GQuark) as gpointer
declare sub g_datalist_id_set_data_full (byval datalist as GData ptr ptr, byval key_id as GQuark, byval data as gpointer, byval destroy_func as GDestroyNotify)
declare function g_datalist_id_remove_no_notify (byval datalist as GData ptr ptr, byval key_id as GQuark) as gpointer
declare sub g_datalist_foreach (byval datalist as GData ptr ptr, byval func as GDataForeachFunc, byval user_data as gpointer)
declare sub g_dataset_destroy (byval dataset_location as gconstpointer)
declare function g_dataset_id_get_data (byval dataset_location as gconstpointer, byval key_id as GQuark) as gpointer
declare sub g_dataset_id_set_data_full (byval dataset_location as gconstpointer, byval key_id as GQuark, byval data as gpointer, byval destroy_func as GDestroyNotify)
declare function g_dataset_id_remove_no_notify (byval dataset_location as gconstpointer, byval key_id as GQuark) as gpointer
declare sub g_dataset_foreach (byval dataset_location as gconstpointer, byval func as GDataForeachFunc, byval user_data as gpointer)

#endif
