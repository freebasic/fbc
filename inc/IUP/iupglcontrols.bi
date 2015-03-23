#pragma once

extern "C"

#define __IUPGLCONTROLS_H
declare function IupGLControlsOpen() as long
declare function IupGLCanvasBoxv(byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupGLCanvasBox(byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupGLSubCanvas() as Ihandle ptr
declare function IupGLLabel(byval title as const zstring ptr) as Ihandle ptr
declare function IupGLSeparator() as Ihandle ptr
declare function IupGLButton(byval title as const zstring ptr) as Ihandle ptr
declare function IupGLToggle(byval title as const zstring ptr) as Ihandle ptr
declare function IupGLLink(byval url as const zstring ptr, byval title as const zstring ptr) as Ihandle ptr
declare function IupGLProgressBar() as Ihandle ptr
declare function IupGLVal() as Ihandle ptr
declare function IupGLFrame(byval child as Ihandle ptr) as Ihandle ptr
declare function IupGLExpander(byval child as Ihandle ptr) as Ihandle ptr
declare function IupGLScrollBox(byval child as Ihandle ptr) as Ihandle ptr
declare function IupGLSizeBox(byval child as Ihandle ptr) as Ihandle ptr

end extern
