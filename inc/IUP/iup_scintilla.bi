'' FreeBASIC binding for iup-3.11.2

#pragma once

extern "C"

#define __IUP_SCINTILLA_H
declare sub IupScintillaOpen()
declare function IupScintilla() as Ihandle ptr

#ifdef SCINTILLA_H
	declare function IupScintillaSendMessage(byval ih as Ihandle ptr, byval iMessage as ulong, byval wParam as uptr_t, byval lParam as sptr_t) as sptr_t
#endif

end extern
