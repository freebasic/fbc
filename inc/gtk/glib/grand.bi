''
''
'' grand -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __grand_bi__
#define __grand_bi__

#include once "gtypes.bi"

type GRand as _GRand

declare function g_rand_new_with_seed (byval seed as guint32) as GRand ptr
declare function g_rand_new_with_seed_array (byval seed as guint32 ptr, byval seed_length as guint) as GRand ptr
declare function g_rand_new () as GRand ptr
declare sub g_rand_free (byval rand_ as GRand ptr)
declare function g_rand_copy (byval rand_ as GRand ptr) as GRand ptr
declare sub g_rand_set_seed (byval rand_ as GRand ptr, byval seed as guint32)
declare sub g_rand_set_seed_array (byval rand_ as GRand ptr, byval seed as guint32 ptr, byval seed_length as guint)
declare function g_rand_int (byval rand_ as GRand ptr) as guint32
declare function g_rand_int_range (byval rand_ as GRand ptr, byval begin as gint32, byval end as gint32) as gint32
declare function g_rand_double (byval rand_ as GRand ptr) as gdouble
declare function g_rand_double_range (byval rand_ as GRand ptr, byval begin as gdouble, byval end as gdouble) as gdouble
declare sub g_random_set_seed (byval seed as guint32)
declare function g_random_int () as guint32
declare function g_random_int_range (byval begin as gint32, byval end as gint32) as gint32
declare function g_random_double () as gdouble
declare function g_random_double_range (byval begin as gdouble, byval end as gdouble) as gdouble

#endif
