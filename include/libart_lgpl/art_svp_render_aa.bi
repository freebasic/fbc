''
''
'' art_svp_render_aa -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_svp_render_aa_bi__
#define __art_svp_render_aa_bi__

#include once "art_svp.bi"

type ArtSVPRenderAAStep as _ArtSVPRenderAAStep
type ArtSVPRenderAAIter as _ArtSVPRenderAAIter

type _ArtSVPRenderAAStep
	x as integer
	delta as integer
end type

declare function art_svp_render_aa_iter (byval svp as ArtSVP ptr, byval x0 as integer, byval y0 as integer, byval x1 as integer, byval y1 as integer) as ArtSVPRenderAAIter ptr
declare sub art_svp_render_aa_iter_step (byval iter as ArtSVPRenderAAIter ptr, byval p_start as integer ptr, byval p_steps as ArtSVPRenderAAStep ptr ptr, byval p_n_steps as integer ptr)
declare sub art_svp_render_aa_iter_done (byval iter as ArtSVPRenderAAIter ptr)
declare sub art_svp_render_aa (byval svp as ArtSVP ptr, byval x0 as integer, byval y0 as integer, byval x1 as integer, byval y1 as integer, byval callback as sub cdecl(byval as any ptr, byval as integer, byval as integer, byval as ArtSVPRenderAAStep ptr, byval as integer), byval callback_data as any ptr)

#endif
