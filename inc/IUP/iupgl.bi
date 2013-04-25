''
''
'' iupgl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupgl_bi__
#define __iupgl_bi__

#define IUP_BUFFER "BUFFER"
#define IUP_STEREO "STEREO"
#define IUP_BUFFER_SIZE "BUFFER_SIZE"
#define IUP_RED_SIZE "RED_SIZE"
#define IUP_GREEN_SIZE "GREEN_SIZE"
#define IUP_BLUE_SIZE "BLUE_SIZE"
#define IUP_ALPHA_SIZE "ALPHA_SIZE"
#define IUP_DEPTH_SIZE "DEPTH_SIZE"
#define IUP_STENCIL_SIZE "STENCIL_SIZE"
#define IUP_ACCUM_RED_SIZE "ACCUM_RED_SIZE"
#define IUP_ACCUM_GREEN_SIZE "ACCUM_GREEN_SIZE"
#define IUP_ACCUM_BLUE_SIZE "ACCUM_BLUE_SIZE"
#define IUP_ACCUM_ALPHA_SIZE "ACCUM_ALPHA_SIZE"
#define IUP_DOUBLE "DOUBLE"
#define IUP_SINGLE "SINGLE"
#define IUP_INDEX "INDEX"
#define IUP_RGBA "RGBA"
#define IUP_YES "YES"
#define IUP_NO "NO"

declare sub IupGLCanvasOpen cdecl alias "IupGLCanvasOpen" ()
declare function IupGLCanvas cdecl alias "IupGLCanvas" (byval action as zstring ptr) as Ihandle ptr
declare sub IupGLMakeCurrent cdecl alias "IupGLMakeCurrent" (byval ih as Ihandle ptr)
declare function IupGLIsCurrent cdecl alias "IupGLIsCurrent" (byval ih as Ihandle ptr) as integer
declare sub IupGLSwapBuffers cdecl alias "IupGLSwapBuffers" (byval ih as Ihandle ptr)
declare sub IupGLPalette cdecl alias "IupGLPalette" (byval ih as Ihandle ptr, byval index as integer, byval r as single, byval g as single, byval b as single)
declare sub IupGLUseFont cdecl alias "IupGLUseFont" (byval ih as Ihandle ptr, byval first as integer, byval count as integer, byval list_base as integer)
declare sub IupGLWait cdecl alias "IupGLWait" (byval gl as integer)

#endif
