''
''
'' pdflib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pdflib_bi__
#define __pdflib_bi__

'' *---------------------------------------------------------------------------*
'' |              PDFlib - A library for generating PDF on the fly             |
'' +---------------------------------------------------------------------------+
'' | Copyright (c) 1997-2002 PDFlib GmbH and Thomas Merz. All rights reserved. |
'' +---------------------------------------------------------------------------+
'' |    This software is NOT in the public domain.  It can be used under two   |
'' |    substantially different licensing terms:                               |
'' |                                                                           |
'' |    The commercial license is available for a fee, and allows you to       |
'' |    - ship a commercial product based on PDFlib                            |
'' |    - implement commercial Web services with PDFlib                        |
'' |    - distribute (free or commercial) software when the source code is     |
'' |      not made available                                                   |
'' |    Details can be found in the file PDFlib-license.pdf.                   |
'' |                                                                           |
'' |    The "Aladdin Free Public License" doesn't require any license fee,     |
'' |    and allows you to                                                      |
'' |    - develop and distribute PDFlib-based software for which the complete  |
'' |      source code is made available                                        |
'' |    - redistribute PDFlib non-commercially under certain conditions        |
'' |    - redistribute PDFlib on digital media for a fee if the complete       |
'' |      contents of the media are freely redistributable                     |
'' |    Details can be found in the file aladdin-license.pdf.                  |
'' |                                                                           |
'' |    These conditions extend to ports to other programming languages.       |
'' |    PDFlib is distributed with no warranty of any kind. Commercial users,  |
'' |    however, will receive warranty and support statements in writing.      |
'' *---------------------------------------------------------------------------*

#inclib "pdf"

type PDF as any

#ifndef FILE
type FILE as any
#endif

#define PDFLIB_MAJORVERSION 4
#define PDFLIB_MINORVERSION 0
#define PDFLIB_REVISION 2
#define PDFLIB_VERSIONSTRING "4.0.2"

declare function PDF_get_majorversion cdecl alias "PDF_get_majorversion" () as integer
declare function PDF_get_minorversion cdecl alias "PDF_get_minorversion" () as integer
declare sub PDF_boot cdecl alias "PDF_boot" ()
declare sub PDF_shutdown cdecl alias "PDF_shutdown" ()

type errorproc_t as sub cdecl(byval as PDF ptr, byval as integer, byval as string)
type allocproc_t as sub cdecl(byval as PDF ptr, byval as integer, byval as string)
type reallocproc_t as sub cdecl(byval as PDF ptr, byval as any ptr, byval as integer, byval as string)
type freeproc_t as sub cdecl(byval as PDF ptr, byval as any ptr)

declare function PDF_new2 cdecl alias "PDF_new2" (byval errorhandler as errorproc_t, byval allocproc as allocproc_t, byval reallocproc as reallocproc_t, byval freeproc as freeproc_t, byval opaque as any ptr) as PDF ptr
declare function PDF_get_opaque cdecl alias "PDF_get_opaque" (byval p as PDF ptr) as any ptr
declare function PDF_new cdecl alias "PDF_new" () as PDF ptr
declare sub PDF_delete cdecl alias "PDF_delete" (byval p as PDF ptr)
declare function PDF_open_file cdecl alias "PDF_open_file" (byval p as PDF ptr, byval filename as string) as integer
declare function PDF_open_fp cdecl alias "PDF_open_fp" (byval p as PDF ptr, byval fp as FILE ptr) as integer

type writeproc_t as function cdecl(byval as PDF ptr, byval as any ptr, byval as integer) as integer

declare sub PDF_open_mem cdecl alias "PDF_open_mem" (byval p as PDF ptr, byval writeproc as writeproc_t)
declare sub PDF_close cdecl alias "PDF_close" (byval p as PDF ptr)
declare sub PDF_begin_page cdecl alias "PDF_begin_page" (byval p as PDF ptr, byval width as single, byval height as single)
declare sub PDF_end_page cdecl alias "PDF_end_page" (byval p as PDF ptr)

#define PDF_MemoryError 1
#define PDF_IOError 2
#define PDF_RuntimeError 3
#define PDF_IndexError 4
#define PDF_TypeError 5
#define PDF_DivisionByZero 6
#define PDF_OverflowError 7
#define PDF_SyntaxError 8
#define PDF_ValueError 9
#define PDF_SystemError 10
#define PDF_NonfatalError 11
#define PDF_UnknownError 12

declare sub PDF_set_parameter cdecl alias "PDF_set_parameter" (byval p as PDF ptr, byval key as string, byval value as string)
declare sub PDF_set_value cdecl alias "PDF_set_value" (byval p as PDF ptr, byval key as string, byval value as single)
declare function PDF_get_parameter cdecl alias "PDF_get_parameter" (byval p as PDF ptr, byval key as string, byval modifier as single) as zstring ptr
declare function PDF_get_value cdecl alias "PDF_get_value" (byval p as PDF ptr, byval key as string, byval modifier as single) as single
declare function PDF_findfont cdecl alias "PDF_findfont" (byval p as PDF ptr, byval fontname as string, byval encoding as string, byval embed as integer) as integer
declare sub PDF_setfont cdecl alias "PDF_setfont" (byval p as PDF ptr, byval font as integer, byval fontsize as single)
declare function PDF_encoding_get_name cdecl alias "PDF_encoding_get_name" (byval p as PDF ptr, byval encoding as string, byval slot as integer) as zstring ptr
declare sub PDF_show cdecl alias "PDF_show" (byval p as PDF ptr, byval text as string)
declare sub PDF_show_xy cdecl alias "PDF_show_xy" (byval p as PDF ptr, byval text as string, byval x as single, byval y as single)
declare sub PDF_continue_text cdecl alias "PDF_continue_text" (byval p as PDF ptr, byval text as string)
declare function PDF_show_boxed cdecl alias "PDF_show_boxed" (byval p as PDF ptr, byval text as string, byval left as single, byval top as single, byval width as single, byval height as single, byval hmode as string, byval feature as string) as integer
declare sub PDF_set_text_matrix cdecl alias "PDF_set_text_matrix" (byval p as PDF ptr, byval a as single, byval b as single, byval c as single, byval d as single, byval e as single, byval f as single)
declare sub PDF_set_text_pos cdecl alias "PDF_set_text_pos" (byval p as PDF ptr, byval x as single, byval y as single)
declare function PDF_stringwidth cdecl alias "PDF_stringwidth" (byval p as PDF ptr, byval text as string, byval font as integer, byval size as single) as single
declare sub PDF_show2 cdecl alias "PDF_show2" (byval p as PDF ptr, byval text as string, byval len as integer)
declare sub PDF_show_xy2 cdecl alias "PDF_show_xy2" (byval p as PDF ptr, byval text as string, byval len as integer, byval x as single, byval y as single)
declare sub PDF_continue_text2 cdecl alias "PDF_continue_text2" (byval p as PDF ptr, byval text as string, byval len as integer)
declare function PDF_stringwidth2 cdecl alias "PDF_stringwidth2" (byval p as PDF ptr, byval text as string, byval len as integer, byval font as integer, byval size as single) as single

#define MAX_DASH_LENGTH 8

declare sub PDF_setdash cdecl alias "PDF_setdash" (byval p as PDF ptr, byval b as single, byval w as single)
declare sub PDF_setpolydash cdecl alias "PDF_setpolydash" (byval p as PDF ptr, byval dasharray as single ptr, byval length as integer)
declare sub PDF_setflat cdecl alias "PDF_setflat" (byval p as PDF ptr, byval flatness as single)
declare sub PDF_setlinejoin cdecl alias "PDF_setlinejoin" (byval p as PDF ptr, byval linejoin as integer)
declare sub PDF_setlinecap cdecl alias "PDF_setlinecap" (byval p as PDF ptr, byval linecap as integer)
declare sub PDF_setmiterlimit cdecl alias "PDF_setmiterlimit" (byval p as PDF ptr, byval miter as single)
declare sub PDF_setlinewidth cdecl alias "PDF_setlinewidth" (byval p as PDF ptr, byval width as single)
declare sub PDF_initgraphics cdecl alias "PDF_initgraphics" (byval p as PDF ptr)
declare sub PDF_save cdecl alias "PDF_save" (byval p as PDF ptr)
declare sub PDF_restore cdecl alias "PDF_restore" (byval p as PDF ptr)
declare sub PDF_translate cdecl alias "PDF_translate" (byval p as PDF ptr, byval tx as single, byval ty as single)
declare sub PDF_scale cdecl alias "PDF_scale" (byval p as PDF ptr, byval sx as single, byval sy as single)
declare sub PDF_rotate cdecl alias "PDF_rotate" (byval p as PDF ptr, byval phi as single)
declare sub PDF_skew cdecl alias "PDF_skew" (byval p as PDF ptr, byval alpha as single, byval beta as single)
declare sub PDF_concat cdecl alias "PDF_concat" (byval p as PDF ptr, byval a as single, byval b as single, byval c as single, byval d as single, byval e as single, byval f as single)
declare sub PDF_setmatrix cdecl alias "PDF_setmatrix" (byval p as PDF ptr, byval a as single, byval b as single, byval c as single, byval d as single, byval e as single, byval f as single)
declare sub PDF_moveto cdecl alias "PDF_moveto" (byval p as PDF ptr, byval x as single, byval y as single)
declare sub PDF_lineto cdecl alias "PDF_lineto" (byval p as PDF ptr, byval x as single, byval y as single)
declare sub PDF_curveto cdecl alias "PDF_curveto" (byval p as PDF ptr, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, byval x3 as single, byval y3 as single)
declare sub PDF_circle cdecl alias "PDF_circle" (byval p as PDF ptr, byval x as single, byval y as single, byval r as single)
declare sub PDF_arc cdecl alias "PDF_arc" (byval p as PDF ptr, byval x as single, byval y as single, byval r as single, byval alpha as single, byval beta as single)
declare sub PDF_arcn cdecl alias "PDF_arcn" (byval p as PDF ptr, byval x as single, byval y as single, byval r as single, byval alpha as single, byval beta as single)
declare sub PDF_rect cdecl alias "PDF_rect" (byval p as PDF ptr, byval x as single, byval y as single, byval width as single, byval height as single)
declare sub PDF_closepath cdecl alias "PDF_closepath" (byval p as PDF ptr)
declare sub PDF_stroke cdecl alias "PDF_stroke" (byval p as PDF ptr)
declare sub PDF_closepath_stroke cdecl alias "PDF_closepath_stroke" (byval p as PDF ptr)
declare sub PDF_fill cdecl alias "PDF_fill" (byval p as PDF ptr)
declare sub PDF_fill_stroke cdecl alias "PDF_fill_stroke" (byval p as PDF ptr)
declare sub PDF_closepath_fill_stroke cdecl alias "PDF_closepath_fill_stroke" (byval p as PDF ptr)
declare sub PDF_endpath cdecl alias "PDF_endpath" (byval p as PDF ptr)
declare sub PDF_clip cdecl alias "PDF_clip" (byval p as PDF ptr)
declare sub PDF_setgray_fill cdecl alias "PDF_setgray_fill" (byval p as PDF ptr, byval gray as single)
declare sub PDF_setgray_stroke cdecl alias "PDF_setgray_stroke" (byval p as PDF ptr, byval gray as single)
declare sub PDF_setgray cdecl alias "PDF_setgray" (byval p as PDF ptr, byval gray as single)
declare sub PDF_setrgbcolor_fill cdecl alias "PDF_setrgbcolor_fill" (byval p as PDF ptr, byval red as single, byval green as single, byval blue as single)
declare sub PDF_setrgbcolor_stroke cdecl alias "PDF_setrgbcolor_stroke" (byval p as PDF ptr, byval red as single, byval green as single, byval blue as single)
declare sub PDF_setrgbcolor cdecl alias "PDF_setrgbcolor" (byval p as PDF ptr, byval red as single, byval green as single, byval blue as single)
declare function PDF_makespotcolor cdecl alias "PDF_makespotcolor" (byval p as PDF ptr, byval spotname as string, byval len as integer) as integer
declare sub PDF_setcolor cdecl alias "PDF_setcolor" (byval p as PDF ptr, byval fstype as string, byval colorspace as string, byval c1 as single, byval c2 as single, byval c3 as single, byval c4 as single)
declare function PDF_begin_pattern cdecl alias "PDF_begin_pattern" (byval p as PDF ptr, byval width as single, byval height as single, byval xstep as single, byval ystep as single, byval painttype as integer) as integer
declare sub PDF_end_pattern cdecl alias "PDF_end_pattern" (byval p as PDF ptr)
declare function PDF_begin_template cdecl alias "PDF_begin_template" (byval p as PDF ptr, byval width as single, byval height as single) as integer
declare sub PDF_end_template cdecl alias "PDF_end_template" (byval p as PDF ptr)
declare sub PDF_place_image cdecl alias "PDF_place_image" (byval p as PDF ptr, byval image as integer, byval x as single, byval y as single, byval scale as single)
declare function PDF_open_image cdecl alias "PDF_open_image" (byval p as PDF ptr, byval imagetype as string, byval source as string, byval data as string, byval length as integer, byval width as integer, byval height as integer, byval components as integer, byval bpc as integer, byval params as string) as integer
declare function PDF_open_image_file cdecl alias "PDF_open_image_file" (byval p as PDF ptr, byval imagetype as string, byval filename as string, byval stringparam as string, byval intparam as integer) as integer
declare sub PDF_close_image cdecl alias "PDF_close_image" (byval p as PDF ptr, byval image as integer)
declare sub PDF_add_thumbnail cdecl alias "PDF_add_thumbnail" (byval p as PDF ptr, byval image as integer)
declare function PDF_open_CCITT cdecl alias "PDF_open_CCITT" (byval p as PDF ptr, byval filename as string, byval width as integer, byval height as integer, byval BitReverse as integer, byval K as integer, byval BlackIs1 as integer) as integer
declare function PDF_add_bookmark cdecl alias "PDF_add_bookmark" (byval p as PDF ptr, byval text as string, byval parent as integer, byval open as integer) as integer
declare sub PDF_set_info cdecl alias "PDF_set_info" (byval p as PDF ptr, byval key as string, byval value as string)
declare sub PDF_attach_file cdecl alias "PDF_attach_file" (byval p as PDF ptr, byval llx as single, byval lly as single, byval urx as single, byval ury as single, byval filename as string, byval description as string, byval author as string, byval mimetype as string, byval icon as string)
declare sub PDF_add_note cdecl alias "PDF_add_note" (byval p as PDF ptr, byval llx as single, byval lly as single, byval urx as single, byval ury as single, byval contents as string, byval title as string, byval icon as string, byval open as integer)
declare sub PDF_add_pdflink cdecl alias "PDF_add_pdflink" (byval p as PDF ptr, byval llx as single, byval lly as single, byval urx as single, byval ury as single, byval filename as string, byval page as integer, byval dest as string)
declare sub PDF_add_launchlink cdecl alias "PDF_add_launchlink" (byval p as PDF ptr, byval llx as single, byval lly as single, byval urx as single, byval ury as single, byval filename as string)
declare sub PDF_add_locallink cdecl alias "PDF_add_locallink" (byval p as PDF ptr, byval llx as single, byval lly as single, byval urx as single, byval ury as single, byval page as integer, byval dest as string)
declare sub PDF_add_weblink cdecl alias "PDF_add_weblink" (byval p as PDF ptr, byval llx as single, byval lly as single, byval urx as single, byval ury as single, byval url as string)
declare sub PDF_set_border_style cdecl alias "PDF_set_border_style" (byval p as PDF ptr, byval style as string, byval width as single)
declare sub PDF_set_border_color cdecl alias "PDF_set_border_color" (byval p as PDF ptr, byval red as single, byval green as single, byval blue as single)
declare sub PDF_set_border_dash cdecl alias "PDF_set_border_dash" (byval p as PDF ptr, byval b as single, byval w as single)
declare function PDF_open_pdi cdecl alias "PDF_open_pdi" (byval p as PDF ptr, byval filename as string, byval stringparam as string, byval intparam as integer) as integer
declare sub PDF_close_pdi cdecl alias "PDF_close_pdi" (byval p as PDF ptr, byval doc as integer)
declare function PDF_open_pdi_page cdecl alias "PDF_open_pdi_page" (byval p as PDF ptr, byval doc as integer, byval page as integer, byval label as string) as integer
declare sub PDF_place_pdi_page cdecl alias "PDF_place_pdi_page" (byval p as PDF ptr, byval page as integer, byval x as single, byval y as single, byval sx as single, byval sy as single)
declare sub PDF_close_pdi_page cdecl alias "PDF_close_pdi_page" (byval p as PDF ptr, byval page as integer)
declare function PDF_get_pdi_parameter cdecl alias "PDF_get_pdi_parameter" (byval p as PDF ptr, byval key as string, byval doc as integer, byval page as integer, byval index as integer, byval len as integer ptr) as zstring ptr
declare function PDF_get_pdi_value cdecl alias "PDF_get_pdi_value" (byval p as PDF ptr, byval key as string, byval doc as integer, byval page as integer, byval index as integer) as single
declare function PDF_get_buffer cdecl alias "PDF_get_buffer" (byval p as PDF ptr, byval size as integer ptr) as zstring ptr

#define a0_width 2380.0
#define a0_height 3368.0
#define a1_width 1684.0
#define a1_height 2380.0
#define a2_width 1190.0
#define a2_height 1684.0
#define a3_width 842.0
#define a3_height 1190.0
#define a4_width 595.0
#define a4_height 842.0
#define a5_width 421.0
#define a5_height 595.0
#define a6_width 297.0
#define a6_height 421.0
#define b5_width 501.0
#define b5_height 709.0
#define letter_width 612.0
#define letter_height 792.0
#define legal_width 612.0
#define legal_height 1008.0
#define ledger_width 1224.0
#define ledger_height 792.0
#define p11x17_width 792.0
#define p11x17_height 1224.0

#endif
