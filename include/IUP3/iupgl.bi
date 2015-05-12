/'** \file
 * \brief OpenGL canvas for Iup.
 *
 * See Copyright Notice in "iup.bi"
 *'/

#ifndef __iupgl_bi__
#define __iupgl_bi__

/'* Attributes
** To set the appropriate visual (pixel format) the following
** attributes may be specified. Their values should be set
** before the canvas is mapped to the scrren.
** After mapping, changing their values has no effect.
*'/

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

extern "C"

declare sub IupGLCanvasOpen ()
declare function IupGLCanvas (byval action as zstring ptr) as Ihandle ptr
declare sub IupGLMakeCurrent (byval ih as Ihandle ptr)
declare function IupGLIsCurrent (byval ih as Ihandle ptr) as integer
declare sub IupGLSwapBuffers (byval ih as Ihandle ptr)
declare sub IupGLPalette (byval ih as Ihandle ptr, byval index as integer, byval r as single, byval g as single, byval b as single)
declare sub IupGLUseFont (byval ih as Ihandle ptr, byval first as integer, byval count as integer, byval list_base as integer)
declare sub IupGLWait (byval gl as integer)

end extern

#endif
