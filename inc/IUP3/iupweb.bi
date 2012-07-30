/'** \file
 * \brief Web control.
 *
 * See Copyright Notice in "iup.bi"
 *'/

#ifndef __iupweb_bi__
#define __iupweb_bi__

#if defined(__FB_WIN32__)
#include once "IUP3/iupole.bi"
#else
#inclib "webkit-1.0
#endif

extern "C"

declare function IupWebBrowserOpen () as integer
declare function IupWebBrowser () as Ihandle ptr

end extern

#endif
