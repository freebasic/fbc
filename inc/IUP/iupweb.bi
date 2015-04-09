'' FreeBASIC binding for iup-3.11.2

#pragma once

extern "C"

#define __IUPWEB_H
declare function IupWebBrowserOpen() as long
declare function IupWebBrowser() as Ihandle ptr

end extern
