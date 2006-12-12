''
''
'' libart -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __libart_bi__
#define __libart_bi__

#ifdef __FB_WIN32__
# pragma push(msbitfields)
#endif

extern "c" lib "art_lgpl_2"

#include once "libart/art_affine.bi"
#include once "libart/art_alphagamma.bi"
#include once "libart/art_bpath.bi"
#include once "libart/art_filterlevel.bi"
#include once "libart/art_gray_svp.bi"
#include once "libart/art_misc.bi"
#include once "libart/art_pathcode.bi"
#include once "libart/art_pixbuf.bi"
#include once "libart/art_point.bi"
#include once "libart/art_rect.bi"
#include once "libart/art_rect_svp.bi"
#include once "libart/art_rect_uta.bi"
#include once "libart/art_rgb.bi"
#include once "libart/art_rgb_affine.bi"
#include once "libart/art_rgb_bitmap_affine.bi"
#include once "libart/art_rgb_pixbuf_affine.bi"
#include once "libart/art_rgb_rgba_affine.bi"
#include once "libart/art_rgb_svp.bi"
#include once "libart/art_svp.bi"
#include once "libart/art_svp_ops.bi"
#include once "libart/art_svp_point.bi"
#include once "libart/art_svp_render_aa.bi"
#include once "libart/art_svp_vpath.bi"
#include once "libart/art_svp_vpath_stroke.bi"
#include once "libart/art_svp_wind.bi"
#include once "libart/art_uta.bi"
#include once "libart/art_uta_ops.bi"
#include once "libart/art_uta_rect.bi"
#include once "libart/art_uta_svp.bi"
#include once "libart/art_uta_vpath.bi"
#include once "libart/art_vpath.bi"
#include once "libart/art_vpath_bpath.bi"
#include once "libart/art_vpath_dash.bi"
#include once "libart/art_vpath_svp.bi"

end extern

#ifdef __FB_WIN32__
# pragma pop(msbitfields)
#endif

#endif
