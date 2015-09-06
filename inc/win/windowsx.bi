'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _INC_WINDOWSX
#define GetInstanceModule(hInstance) cast(HMODULE, (hInstance))
#define GlobalPtrHandle(lp) cast(HGLOBAL, GlobalHandle(lp))
#define GlobalLockPtr(lp) cast(WINBOOL, GlobalLock(GlobalPtrHandle(lp)))
#define GlobalUnlockPtr(lp) GlobalUnlock(GlobalPtrHandle(lp))
#define GlobalAllocPtr(flags, cb) GlobalLock(GlobalAlloc((flags), (cb)))
#macro GlobalReAllocPtr(lp, cbNew, flags)
	scope
		GlobalUnlockPtr(lp)
		GlobalLock(GlobalReAlloc(GlobalPtrHandle(lp), (cbNew), (flags)))
	end scope
#endmacro
#macro GlobalFreePtr(lp)
	scope
		GlobalUnlockPtr(lp)
		cast(WINBOOL, cast(ULONG_PTR, GlobalFree(GlobalPtrHandle(lp))))
	end scope
#endmacro
#define DeletePen(hpen) DeleteObject(cast(HGDIOBJ, cast(HPEN, (hpen))))
#define SelectPen(hdc, hpen) cast(HPEN, SelectObject((hdc), cast(HGDIOBJ, cast(HPEN, (hpen)))))
#define GetStockPen(i) cast(HPEN, GetStockObject(i))
#define DeleteBrush(hbr) DeleteObject(cast(HGDIOBJ, cast(HBRUSH, (hbr))))
#define SelectBrush(hdc, hbr) cast(HBRUSH, SelectObject((hdc), cast(HGDIOBJ, cast(HBRUSH, (hbr)))))
#define GetStockBrush(i) cast(HBRUSH, GetStockObject(i))
#define DeleteRgn(hrgn) DeleteObject(cast(HGDIOBJ, cast(HRGN, (hrgn))))
#define CopyRgn(hrgnDst, hrgnSrc) CombineRgn(hrgnDst, hrgnSrc, 0, RGN_COPY)
#define IntersectRgn(hrgnResult, hrgnA, hrgnB) CombineRgn(hrgnResult, hrgnA, hrgnB, RGN_AND)
#define SubtractRgn(hrgnResult, hrgnA, hrgnB) CombineRgn(hrgnResult, hrgnA, hrgnB, RGN_DIFF)
#define UnionRgn(hrgnResult, hrgnA, hrgnB) CombineRgn(hrgnResult, hrgnA, hrgnB, RGN_OR)
#define XorRgn(hrgnResult, hrgnA, hrgnB) CombineRgn(hrgnResult, hrgnA, hrgnB, RGN_XOR)
#define DeletePalette(hpal) DeleteObject(cast(HGDIOBJ, cast(HPALETTE, (hpal))))
#define DeleteFont(hfont) DeleteObject(cast(HGDIOBJ, cast(HFONT, (hfont))))
#define SelectFont(hdc, hfont) cast(HFONT, SelectObject((hdc), cast(HGDIOBJ, cast(HFONT, (hfont)))))
#define GetStockFont(i) cast(HFONT, GetStockObject(i))
#define DeleteBitmap(hbm) DeleteObject(cast(HGDIOBJ, cast(HBITMAP, (hbm))))
#define SelectBitmap(hdc, hbm) cast(HBITMAP, SelectObject((hdc), cast(HGDIOBJ, cast(HBITMAP, (hbm)))))
#define InsetRect(lprc, dx, dy) InflateRect((lprc), -(dx), -(dy))
#define GetWindowInstance(hwnd) cast(HMODULE, GetWindowLongPtr(hwnd, GWLP_HINSTANCE))
#define GetWindowStyle(hwnd) cast(DWORD, GetWindowLong(hwnd, GWL_STYLE))
#define GetWindowExStyle(hwnd) cast(DWORD, GetWindowLong(hwnd, GWL_EXSTYLE))
#define GetWindowOwner(hwnd) GetWindow(hwnd, GW_OWNER)
#define GetFirstChild(hwnd) GetTopWindow(hwnd)
#define GetFirstSibling(hwnd) GetWindow(hwnd, GW_HWNDFIRST)
#define GetLastSibling(hwnd) GetWindow(hwnd, GW_HWNDLAST)
#define GetNextSibling(hwnd) GetWindow(hwnd, GW_HWNDNEXT)
#define GetPrevSibling(hwnd) GetWindow(hwnd, GW_HWNDPREV)
#define GetWindowID(hwnd) GetDlgCtrlID(hwnd)
#define SetWindowRedraw(hwnd, fRedraw) SNDMSG(hwnd, WM_SETREDRAW, cast(WPARAM, cast(WINBOOL, (fRedraw))), cast(LPARAM, 0))
#define SubclassWindow(hwnd, lpfn) cast(WNDPROC, SetWindowLongPtr((hwnd), GWLP_WNDPROC, cast(LPARAM, cast(WNDPROC, (lpfn)))))
#define IsMinimized(hwnd) IsIconic(hwnd)
#define IsMaximized(hwnd) IsZoomed(hwnd)
#define IsRestored(hwnd) ((GetWindowStyle(hwnd) and (WS_MINIMIZE or WS_MAXIMIZE)) = 0)
#define SetWindowFont(hwnd, hfont, fRedraw) FORWARD_WM_SETFONT((hwnd), (hfont), (fRedraw), SNDMSG)
#define GetWindowFont(hwnd) FORWARD_WM_GETFONT((hwnd), SNDMSG)
#define MapWindowRect(hwndFrom, hwndTo, lprc) MapWindowPoints((hwndFrom), (hwndTo), cptr(POINT ptr, (lprc)), 2)
#define IsLButtonDown() (GetKeyState(VK_LBUTTON) < 0)
#define IsRButtonDown() (GetKeyState(VK_RBUTTON) < 0)
#define IsMButtonDown() (GetKeyState(VK_MBUTTON) < 0)
#define SubclassDialog(hwndDlg, lpfn) SetWindowLongPtr(hwndDlg, DWLP_DLGPROC, cast(LPARAM, (lpfn)))
'' TODO: #define SetDlgMsgResult(hwnd,msg,result) (((msg)==WM_CTLCOLORMSGBOX || (msg)==WM_CTLCOLOREDIT || (msg)==WM_CTLCOLORLISTBOX || (msg)==WM_CTLCOLORBTN || (msg)==WM_CTLCOLORDLG || (msg)==WM_CTLCOLORSCROLLBAR || (msg)==WM_CTLCOLORSTATIC || (msg)==WM_COMPAREITEM || (msg)==WM_VKEYTOITEM || (msg)==WM_CHARTOITEM || (msg)==WM_QUERYDRAGICON || (msg)==WM_INITDIALOG) ? (WINBOOL)(result) : (SetWindowLongPtr((hwnd),DWLP_MSGRESULT,(LPARAM)(LRESULT)(result)),TRUE))
#macro DefDlgProcEx(hwnd, msg, wParam, lParam, pfRecursion)
	scope
		(*(pfRecursion)) = CTRUE
		DefDlgProc(hwnd, msg, wParam, lParam)
	end scope
#endmacro
#macro CheckDefDlgRecursion(pfRecursion)
	if *(pfRecursion) then
		(*(pfRecursion)) = FALSE
		return FALSE
	end if
#endmacro
'' TODO: #define HANDLE_MSG(hwnd,message,fn) case (message): return HANDLE_##message((hwnd),(wParam),(lParam),(fn))
#macro HANDLE_WM_COMPACTING(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_COMPACTING(hwnd, compactRatio, fn) fn((hwnd), WM_COMPACTING, cast(WPARAM, cast(UINT, (compactRatio))), cast(LPARAM, 0))
#macro HANDLE_WM_WININICHANGE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(LPCTSTR, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_WININICHANGE(hwnd, lpszSectionName, fn) fn((hwnd), WM_WININICHANGE, cast(WPARAM, 0), cast(LPARAM, cast(LPCTSTR, (lpszSectionName))))
#macro HANDLE_WM_SYSCOLORCHANGE(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SYSCOLORCHANGE(hwnd, fn) fn((hwnd), WM_SYSCOLORCHANGE, cast(WPARAM, 0), cast(LPARAM, 0))
#define HANDLE_WM_QUERYNEWPALETTE(hwnd, wParam, lParam, fn) MAKELRESULT(cast(WINBOOL, fn(hwnd)), cast(LRESULT, 0))
#define FORWARD_WM_QUERYNEWPALETTE(hwnd, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_QUERYNEWPALETTE, cast(WPARAM, 0), cast(LPARAM, 0))))
#macro HANDLE_WM_PALETTEISCHANGING(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_PALETTEISCHANGING(hwnd, hwndPaletteChange, fn) fn((hwnd), WM_PALETTEISCHANGING, cast(WPARAM, cast(HWND, (hwndPaletteChange))), cast(LPARAM, 0))
#macro HANDLE_WM_PALETTECHANGED(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_PALETTECHANGED(hwnd, hwndPaletteChange, fn) fn((hwnd), WM_PALETTECHANGED, cast(WPARAM, cast(HWND, (hwndPaletteChange))), cast(LPARAM, 0))
#macro HANDLE_WM_FONTCHANGE(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_FONTCHANGE(hwnd, fn) fn((hwnd), WM_FONTCHANGE, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_SPOOLERSTATUS(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, (wParam)), clng(cshort(LOWORD(lParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SPOOLERSTATUS(hwnd, status, cJobInQueue, fn) fn((hwnd), WM_SPOOLERSTATUS, cast(WPARAM, (status)), MAKELPARAM((cJobInQueue), 0))
#macro HANDLE_WM_DEVMODECHANGE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(LPCTSTR, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_DEVMODECHANGE(hwnd, lpszDeviceName, fn) fn((hwnd), WM_DEVMODECHANGE, cast(WPARAM, 0), cast(LPARAM, cast(LPCTSTR, (lpszDeviceName))))
#macro HANDLE_WM_TIMECHANGE(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_TIMECHANGE(hwnd, fn) fn((hwnd), WM_TIMECHANGE, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_POWER(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(wParam))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_POWER(hwnd, code, fn) fn((hwnd), WM_POWER, cast(WPARAM, clng(code)), cast(LPARAM, 0))
#define HANDLE_WM_QUERYENDSESSION(hwnd, wParam, lParam, fn) MAKELRESULT(cast(WINBOOL, fn(hwnd)), cast(LRESULT, 0))
#define FORWARD_WM_QUERYENDSESSION(hwnd, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_QUERYENDSESSION, cast(WPARAM, 0), cast(LPARAM, 0))))
#macro HANDLE_WM_ENDSESSION(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(WINBOOL, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_ENDSESSION(hwnd, fEnding, fn) fn((hwnd), WM_ENDSESSION, cast(WPARAM, cast(WINBOOL, (fEnding))), cast(LPARAM, 0))
#macro HANDLE_WM_QUIT(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(wParam))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_QUIT(hwnd, exitCode, fn) fn((hwnd), WM_QUIT, cast(WPARAM, (exitCode)), cast(LPARAM, 0))
#define HANDLE_WM_SYSTEMERROR(hwnd, wParam, lParam, fn) cast(LRESULT, 0)
#define FORWARD_WM_SYSTEMERROR(hwnd, errCode, fn) cast(LRESULT, 0)
#define HANDLE_WM_CREATE(hwnd, wParam, lParam, fn) cast(LRESULT, iif(fn((hwnd), cast(LPCREATESTRUCT, (lParam))), 0, -1))
#define FORWARD_WM_CREATE(hwnd, lpCreateStruct, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_CREATE, cast(WPARAM, 0), cast(LPARAM, cast(LPCREATESTRUCT, (lpCreateStruct))))))
#define HANDLE_WM_NCCREATE(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(WINBOOL, fn((hwnd), cast(LPCREATESTRUCT, (lParam))))))
#define FORWARD_WM_NCCREATE(hwnd, lpCreateStruct, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_NCCREATE, cast(WPARAM, 0), cast(LPARAM, cast(LPCREATESTRUCT, (lpCreateStruct))))))
#macro HANDLE_WM_DESTROY(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_DESTROY(hwnd, fn) fn((hwnd), WM_DESTROY, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_NCDESTROY(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_NCDESTROY(hwnd, fn) fn((hwnd), WM_NCDESTROY, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_SHOWWINDOW(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(WINBOOL, (wParam)), cast(UINT, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SHOWWINDOW(hwnd, fShow, status, fn) fn((hwnd), WM_SHOWWINDOW, cast(WPARAM, cast(WINBOOL, (fShow))), cast(LPARAM, cast(UINT, (status))))
#macro HANDLE_WM_SETREDRAW(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(WINBOOL, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SETREDRAW(hwnd, fRedraw, fn) fn((hwnd), WM_SETREDRAW, cast(WPARAM, cast(WINBOOL, (fRedraw))), cast(LPARAM, 0))
#macro HANDLE_WM_ENABLE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(WINBOOL, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_ENABLE(hwnd, fEnable, fn) fn((hwnd), WM_ENABLE, cast(WPARAM, cast(WINBOOL, (fEnable))), cast(LPARAM, 0))
#macro HANDLE_WM_SETTEXT(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(LPCTSTR, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SETTEXT(hwnd, lpszText, fn) fn((hwnd), WM_SETTEXT, cast(WPARAM, 0), cast(LPARAM, cast(LPCTSTR, (lpszText))))
#define HANDLE_WM_GETTEXT(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, clng(fn((hwnd), clng(wParam), cast(LPTSTR, (lParam))))))
#define FORWARD_WM_GETTEXT(hwnd, cchTextMax, lpszText, fn) clng(cast(DWORD, fn((hwnd), WM_GETTEXT, cast(WPARAM, clng(cchTextMax)), cast(LPARAM, cast(LPTSTR, (lpszText))))))
#define HANDLE_WM_GETTEXTLENGTH(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, clng(fn(hwnd))))
#define FORWARD_WM_GETTEXTLENGTH(hwnd, fn) clng(cast(DWORD, fn((hwnd), WM_GETTEXTLENGTH, cast(WPARAM, 0), cast(LPARAM, 0))))
#define HANDLE_WM_WINDOWPOSCHANGING(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(WINBOOL, fn((hwnd), cast(LPWINDOWPOS, (lParam))))))
#define FORWARD_WM_WINDOWPOSCHANGING(hwnd, lpwpos, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_WINDOWPOSCHANGING, cast(WPARAM, 0), cast(LPARAM, cast(LPWINDOWPOS, (lpwpos))))))
#macro HANDLE_WM_WINDOWPOSCHANGED(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(const LPWINDOWPOS, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_WINDOWPOSCHANGED(hwnd, lpwpos, fn) fn((hwnd), WM_WINDOWPOSCHANGED, cast(WPARAM, 0), cast(LPARAM, cast(const LPWINDOWPOS, (lpwpos))))
#macro HANDLE_WM_MOVE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MOVE(hwnd, x, y, fn) fn((hwnd), WM_MOVE, cast(WPARAM, 0), MAKELPARAM((x), (y)))
#macro HANDLE_WM_SIZE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, (wParam)), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SIZE(hwnd, state, cx, cy, fn) fn((hwnd), WM_SIZE, cast(WPARAM, cast(UINT, (state))), MAKELPARAM((cx), (cy)))
#macro HANDLE_WM_CLOSE(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_CLOSE(hwnd, fn) fn((hwnd), WM_CLOSE, cast(WPARAM, 0), cast(LPARAM, 0))
#define HANDLE_WM_QUERYOPEN(hwnd, wParam, lParam, fn) MAKELRESULT(cast(WINBOOL, fn(hwnd)), 0)
#define FORWARD_WM_QUERYOPEN(hwnd, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_QUERYOPEN, cast(WPARAM, 0), cast(LPARAM, 0))))
#macro HANDLE_WM_GETMINMAXINFO(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(LPMINMAXINFO, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_GETMINMAXINFO(hwnd, lpMinMaxInfo, fn) fn((hwnd), WM_GETMINMAXINFO, cast(WPARAM, 0), cast(LPARAM, cast(LPMINMAXINFO, (lpMinMaxInfo))))
#macro HANDLE_WM_PAINT(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_PAINT(hwnd, fn) fn((hwnd), WM_PAINT, cast(WPARAM, 0), cast(LPARAM, 0))
#define HANDLE_WM_ERASEBKGND(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(WINBOOL, fn((hwnd), cast(HDC, (wParam))))))
#define FORWARD_WM_ERASEBKGND(hwnd, hdc, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_ERASEBKGND, cast(WPARAM, cast(HDC, (hdc))), cast(LPARAM, 0))))
#define HANDLE_WM_ICONERASEBKGND(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(WINBOOL, fn((hwnd), cast(HDC, (wParam))))))
#define FORWARD_WM_ICONERASEBKGND(hwnd, hdc, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_ICONERASEBKGND, cast(WPARAM, cast(HDC, (hdc))), cast(LPARAM, 0))))
#macro HANDLE_WM_NCPAINT(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HRGN, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_NCPAINT(hwnd, hrgn, fn) fn((hwnd), WM_NCPAINT, cast(WPARAM, cast(HRGN, (hrgn))), cast(LPARAM, 0))
#define HANDLE_WM_NCCALCSIZE(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(UINT, fn((hwnd), cast(WINBOOL, (wParam)), cptr(NCCALCSIZE_PARAMS ptr, (lParam))))))
#define FORWARD_WM_NCCALCSIZE(hwnd, fCalcValidRects, lpcsp, fn) cast(UINT, cast(DWORD, fn((hwnd), WM_NCCALCSIZE, cast(WPARAM, (fCalcValidRects)), cast(LPARAM, cptr(NCCALCSIZE_PARAMS ptr, (lpcsp))))))
#define HANDLE_WM_NCHITTEST(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(UINT, fn((hwnd), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam)))))))
#define FORWARD_WM_NCHITTEST(hwnd, x, y, fn) cast(UINT, cast(DWORD, fn((hwnd), WM_NCHITTEST, cast(WPARAM, 0), MAKELPARAM((x), (y)))))
#define HANDLE_WM_QUERYDRAGICON(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(UINT, fn(hwnd))))
#define FORWARD_WM_QUERYDRAGICON(hwnd, fn) cast(HICON, cast(UINT, cast(DWORD, fn((hwnd), WM_QUERYDRAGICON, cast(WPARAM, 0), cast(LPARAM, 0)))))
#macro HANDLE_WM_DROPFILES(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HDROP, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_DROPFILES(hwnd, hdrop, fn) fn((hwnd), WM_DROPFILES, cast(WPARAM, cast(HDROP, (hdrop))), cast(LPARAM, 0))
#macro HANDLE_WM_ACTIVATE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, LOWORD(wParam)), cast(HWND, (lParam)), cast(WINBOOL, HIWORD(wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_ACTIVATE(hwnd, state, hwndActDeact, fMinimized, fn) fn((hwnd), WM_ACTIVATE, MAKEWPARAM((state), (fMinimized)), cast(LPARAM, cast(HWND, (hwndActDeact))))
#macro HANDLE_WM_ACTIVATEAPP(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(WINBOOL, (wParam)), cast(DWORD, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_ACTIVATEAPP(hwnd, fActivate, dwThreadId, fn) fn((hwnd), WM_ACTIVATEAPP, cast(WPARAM, cast(WINBOOL, (fActivate))), cast(LPARAM, (dwThreadId)))
#define HANDLE_WM_NCACTIVATE(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(WINBOOL, fn((hwnd), cast(WINBOOL, (wParam)), cast(WPARAM, 0), cast(LPARAM, 0)))))
#define FORWARD_WM_NCACTIVATE(hwnd, fActive, hwndActDeact, fMinimized, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_NCACTIVATE, cast(WPARAM, cast(WINBOOL, (fActive))), cast(LPARAM, 0))))
#macro HANDLE_WM_SETFOCUS(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SETFOCUS(hwnd, hwndOldFocus, fn) fn((hwnd), WM_SETFOCUS, cast(WPARAM, cast(HWND, (hwndOldFocus))), cast(LPARAM, 0))
#macro HANDLE_WM_KILLFOCUS(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_KILLFOCUS(hwnd, hwndNewFocus, fn) fn((hwnd), WM_KILLFOCUS, cast(WPARAM, cast(HWND, (hwndNewFocus))), cast(LPARAM, 0))
#macro HANDLE_WM_KEYDOWN(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, (wParam)), CTRUE, clng(cshort(LOWORD(lParam))), cast(UINT, HIWORD(lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_KEYDOWN(hwnd, vk, cRepeat, flags, fn) fn((hwnd), WM_KEYDOWN, cast(WPARAM, cast(UINT, (vk))), MAKELPARAM((cRepeat), (flags)))
#macro HANDLE_WM_KEYUP(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, (wParam)), FALSE, clng(cshort(LOWORD(lParam))), cast(UINT, HIWORD(lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_KEYUP(hwnd, vk, cRepeat, flags, fn) fn((hwnd), WM_KEYUP, cast(WPARAM, cast(UINT, (vk))), MAKELPARAM((cRepeat), (flags)))
#macro HANDLE_WM_CHAR(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(TCHAR, (wParam)), clng(cshort(LOWORD(lParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_CHAR(hwnd, ch, cRepeat, fn) fn((hwnd), WM_CHAR, cast(WPARAM, cast(TCHAR, (ch))), MAKELPARAM((cRepeat), 0))
#macro HANDLE_WM_DEADCHAR(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(TCHAR, (wParam)), clng(cshort(LOWORD(lParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_DEADCHAR(hwnd, ch, cRepeat, fn) fn((hwnd), WM_DEADCHAR, cast(WPARAM, cast(TCHAR, (ch))), MAKELPARAM((cRepeat), 0))
#macro HANDLE_WM_SYSKEYDOWN(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, (wParam)), CTRUE, clng(cshort(LOWORD(lParam))), cast(UINT, HIWORD(lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SYSKEYDOWN(hwnd, vk, cRepeat, flags, fn) fn((hwnd), WM_SYSKEYDOWN, cast(WPARAM, cast(UINT, (vk))), MAKELPARAM((cRepeat), (flags)))
#macro HANDLE_WM_SYSKEYUP(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, (wParam)), FALSE, clng(cshort(LOWORD(lParam))), cast(UINT, HIWORD(lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SYSKEYUP(hwnd, vk, cRepeat, flags, fn) fn((hwnd), WM_SYSKEYUP, cast(WPARAM, cast(UINT, (vk))), MAKELPARAM((cRepeat), (flags)))
#macro HANDLE_WM_SYSCHAR(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(TCHAR, (wParam)), clng(cshort(LOWORD(lParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SYSCHAR(hwnd, ch, cRepeat, fn) fn((hwnd), WM_SYSCHAR, cast(WPARAM, cast(TCHAR, (ch))), MAKELPARAM((cRepeat), 0))
#macro HANDLE_WM_SYSDEADCHAR(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(TCHAR, (wParam)), clng(cshort(LOWORD(lParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SYSDEADCHAR(hwnd, ch, cRepeat, fn) fn((hwnd), WM_SYSDEADCHAR, cast(WPARAM, cast(TCHAR, (ch))), MAKELPARAM((cRepeat), 0))
#macro HANDLE_WM_MOUSEMOVE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MOUSEMOVE(hwnd, x, y, keyFlags, fn) fn((hwnd), WM_MOUSEMOVE, cast(WPARAM, cast(UINT, (keyFlags))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_LBUTTONDOWN(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), FALSE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_LBUTTONDOWN(hwnd, fDoubleClick, x, y, keyFlags, fn) fn((hwnd), iif((fDoubleClick), WM_LBUTTONDBLCLK, WM_LBUTTONDOWN), cast(WPARAM, cast(UINT, (keyFlags))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_LBUTTONDBLCLK(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), CTRUE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#macro HANDLE_WM_LBUTTONUP(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_LBUTTONUP(hwnd, x, y, keyFlags, fn) fn((hwnd), WM_LBUTTONUP, cast(WPARAM, cast(UINT, (keyFlags))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_RBUTTONDOWN(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), FALSE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_RBUTTONDOWN(hwnd, fDoubleClick, x, y, keyFlags, fn) fn((hwnd), iif((fDoubleClick), WM_RBUTTONDBLCLK, WM_RBUTTONDOWN), cast(WPARAM, cast(UINT, (keyFlags))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_RBUTTONDBLCLK(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), CTRUE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#macro HANDLE_WM_RBUTTONUP(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_RBUTTONUP(hwnd, x, y, keyFlags, fn) fn((hwnd), WM_RBUTTONUP, cast(WPARAM, cast(UINT, (keyFlags))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_MBUTTONDOWN(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), FALSE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MBUTTONDOWN(hwnd, fDoubleClick, x, y, keyFlags, fn) fn((hwnd), iif((fDoubleClick), WM_MBUTTONDBLCLK, WM_MBUTTONDOWN), cast(WPARAM, cast(UINT, (keyFlags))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_MBUTTONDBLCLK(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), CTRUE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#macro HANDLE_WM_MBUTTONUP(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MBUTTONUP(hwnd, x, y, keyFlags, fn) fn((hwnd), WM_MBUTTONUP, cast(WPARAM, cast(UINT, (keyFlags))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_MOUSEWHEEL(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), clng(cshort(HIWORD(wParam))), cast(UINT, cshort(LOWORD(wParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MOUSEWHEEL(hwnd, xPos, yPos, zDelta, fwKeys, fn) fn((hwnd), WM_MOUSEWHEEL, MAKEWPARAM((fwKeys), (zDelta)), MAKELPARAM(x, y))
#macro HANDLE_WM_NCMOUSEMOVE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_NCMOUSEMOVE(hwnd, x, y, codeHitTest, fn) fn((hwnd), WM_NCMOUSEMOVE, cast(WPARAM, cast(UINT, (codeHitTest))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_NCLBUTTONDOWN(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), FALSE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_NCLBUTTONDOWN(hwnd, fDoubleClick, x, y, codeHitTest, fn) fn((hwnd), iif((fDoubleClick), WM_NCLBUTTONDBLCLK, WM_NCLBUTTONDOWN), cast(WPARAM, cast(UINT, (codeHitTest))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_NCLBUTTONDBLCLK(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), CTRUE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#macro HANDLE_WM_NCLBUTTONUP(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_NCLBUTTONUP(hwnd, x, y, codeHitTest, fn) fn((hwnd), WM_NCLBUTTONUP, cast(WPARAM, cast(UINT, (codeHitTest))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_NCRBUTTONDOWN(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), FALSE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_NCRBUTTONDOWN(hwnd, fDoubleClick, x, y, codeHitTest, fn) fn((hwnd), iif((fDoubleClick), WM_NCRBUTTONDBLCLK, WM_NCRBUTTONDOWN), cast(WPARAM, cast(UINT, (codeHitTest))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_NCRBUTTONDBLCLK(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), CTRUE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#macro HANDLE_WM_NCRBUTTONUP(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_NCRBUTTONUP(hwnd, x, y, codeHitTest, fn) fn((hwnd), WM_NCRBUTTONUP, cast(WPARAM, cast(UINT, (codeHitTest))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_NCMBUTTONDOWN(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), FALSE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_NCMBUTTONDOWN(hwnd, fDoubleClick, x, y, codeHitTest, fn) fn((hwnd), iif((fDoubleClick), WM_NCMBUTTONDBLCLK, WM_NCMBUTTONDOWN), cast(WPARAM, cast(UINT, (codeHitTest))), MAKELPARAM((x), (y)))
#macro HANDLE_WM_NCMBUTTONDBLCLK(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), CTRUE, clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#macro HANDLE_WM_NCMBUTTONUP(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_NCMBUTTONUP(hwnd, x, y, codeHitTest, fn) fn((hwnd), WM_NCMBUTTONUP, cast(WPARAM, cast(UINT, (codeHitTest))), MAKELPARAM((x), (y)))
#define HANDLE_WM_MOUSEACTIVATE(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, clng(fn((hwnd), cast(HWND, (wParam)), cast(UINT, LOWORD(lParam)), cast(UINT, HIWORD(lParam))))))
#define FORWARD_WM_MOUSEACTIVATE(hwnd, hwndTopLevel, codeHitTest, msg, fn) clng(cast(DWORD, fn((hwnd), WM_MOUSEACTIVATE, cast(WPARAM, cast(HWND, (hwndTopLevel))), MAKELPARAM((codeHitTest), (msg)))))
#macro HANDLE_WM_CANCELMODE(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_CANCELMODE(hwnd, fn) fn((hwnd), WM_CANCELMODE, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_TIMER(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_TIMER(hwnd, id, fn) fn((hwnd), WM_TIMER, cast(WPARAM, cast(UINT, (id))), cast(LPARAM, 0))
#macro HANDLE_WM_INITMENU(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HMENU, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_INITMENU(hwnd, hMenu, fn) fn((hwnd), WM_INITMENU, cast(WPARAM, cast(HMENU, (hMenu))), cast(LPARAM, 0))
#macro HANDLE_WM_INITMENUPOPUP(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HMENU, (wParam)), cast(UINT, LOWORD(lParam)), cast(WINBOOL, HIWORD(lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_INITMENUPOPUP(hwnd, hMenu, item, fSystemMenu, fn) fn((hwnd), WM_INITMENUPOPUP, cast(WPARAM, cast(HMENU, (hMenu))), MAKELPARAM((item), (fSystemMenu)))
#macro HANDLE_WM_MENUSELECT(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HMENU, (lParam)), iif(HIWORD(wParam) and MF_POPUP, 0, clng(LOWORD(wParam))), iif(HIWORD(wParam) and MF_POPUP, GetSubMenu(cast(HMENU, lParam), LOWORD(wParam)), cast(HMENU, 0)), cast(UINT, iif(cshort(HIWORD(wParam)) = (-1), &hFFFFFFFF, HIWORD(wParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MENUSELECT(hwnd, hmenu, item, hmenuPopup, flags, fn) fn((hwnd), WM_MENUSELECT, MAKEWPARAM((item), (flags)), cast(LPARAM, cast(HMENU, iif((hmenu), (hmenu), (hmenuPopup)))))
#define HANDLE_WM_MENUCHAR(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, fn((hwnd), cast(UINT, LOWORD(wParam)), cast(UINT, HIWORD(wParam)), cast(HMENU, (lParam)))))
#define FORWARD_WM_MENUCHAR(hwnd, ch, flags, hmenu, fn) cast(DWORD, fn((hwnd), WM_MENUCHAR, MAKEWPARAM(flags, cast(WORD, (ch))), cast(LPARAM, cast(HMENU, (hmenu)))))
#macro HANDLE_WM_COMMAND(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(LOWORD(wParam)), cast(HWND, (lParam)), cast(UINT, HIWORD(wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_COMMAND(hwnd, id, hwndCtl, codeNotify, fn) fn((hwnd), WM_COMMAND, MAKEWPARAM(cast(UINT, (id)), cast(UINT, (codeNotify))), cast(LPARAM, cast(HWND, (hwndCtl))))
#macro HANDLE_WM_HSCROLL(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (lParam)), cast(UINT, LOWORD(wParam)), clng(cshort(HIWORD(wParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_HSCROLL(hwnd, hwndCtl, code, pos, fn) fn((hwnd), WM_HSCROLL, MAKEWPARAM(cast(UINT, clng(code)), cast(UINT, clng(pos))), cast(LPARAM, cast(HWND, (hwndCtl))))
#macro HANDLE_WM_VSCROLL(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (lParam)), cast(UINT, LOWORD(wParam)), clng(cshort(HIWORD(wParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_VSCROLL(hwnd, hwndCtl, code, pos, fn) fn((hwnd), WM_VSCROLL, MAKEWPARAM(cast(UINT, clng(code)), cast(UINT, clng(pos))), cast(LPARAM, cast(HWND, (hwndCtl))))
#macro HANDLE_WM_CUT(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_CUT(hwnd, fn) fn((hwnd), WM_CUT, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_COPY(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_COPY(hwnd, fn) fn((hwnd), WM_COPY, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_PASTE(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_PASTE(hwnd, fn) fn((hwnd), WM_PASTE, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_CLEAR(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_CLEAR(hwnd, fn) fn((hwnd), WM_CLEAR, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_UNDO(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_UNDO(hwnd, fn) fn((hwnd), WM_UNDO, cast(WPARAM, 0), cast(LPARAM, 0))
#define HANDLE_WM_RENDERFORMAT(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, cast(HANDLE, fn((hwnd), cast(UINT, (wParam))))))
#define FORWARD_WM_RENDERFORMAT(hwnd, fmt, fn) cast(HANDLE, cast(UINT_PTR, fn((hwnd), WM_RENDERFORMAT, cast(WPARAM, cast(UINT, (fmt))), cast(LPARAM, 0))))
#macro HANDLE_WM_RENDERALLFORMATS(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_RENDERALLFORMATS(hwnd, fn) fn((hwnd), WM_RENDERALLFORMATS, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_DESTROYCLIPBOARD(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_DESTROYCLIPBOARD(hwnd, fn) fn((hwnd), WM_DESTROYCLIPBOARD, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_DRAWCLIPBOARD(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_DRAWCLIPBOARD(hwnd, fn) fn((hwnd), WM_DRAWCLIPBOARD, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_PAINTCLIPBOARD(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)), cast(const LPPAINTSTRUCT, GlobalLock(cast(HGLOBAL, (lParam)))))
		GlobalUnlock(cast(HGLOBAL, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_PAINTCLIPBOARD(hwnd, hwndCBViewer, lpPaintStruct, fn) fn((hwnd), WM_PAINTCLIPBOARD, cast(WPARAM, cast(HWND, (hwndCBViewer))), cast(LPARAM, cast(LPPAINTSTRUCT, (lpPaintStruct))))
#macro HANDLE_WM_SIZECLIPBOARD(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)), cast(const LPRECT, GlobalLock(cast(HGLOBAL, (lParam)))))
		GlobalUnlock(cast(HGLOBAL, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SIZECLIPBOARD(hwnd, hwndCBViewer, lprc, fn) fn((hwnd), WM_SIZECLIPBOARD, cast(WPARAM, cast(HWND, (hwndCBViewer))), cast(LPARAM, cast(LPRECT, (lprc))))
#macro HANDLE_WM_VSCROLLCLIPBOARD(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)), cast(UINT, LOWORD(lParam)), clng(cshort(HIWORD(lParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_VSCROLLCLIPBOARD(hwnd, hwndCBViewer, code, pos, fn) fn((hwnd), WM_VSCROLLCLIPBOARD, cast(WPARAM, cast(HWND, (hwndCBViewer))), MAKELPARAM((code), (pos)))
#macro HANDLE_WM_HSCROLLCLIPBOARD(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)), cast(UINT, LOWORD(lParam)), clng(cshort(HIWORD(lParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_HSCROLLCLIPBOARD(hwnd, hwndCBViewer, code, pos, fn) fn((hwnd), WM_HSCROLLCLIPBOARD, cast(WPARAM, cast(HWND, (hwndCBViewer))), MAKELPARAM((code), (pos)))
#macro HANDLE_WM_ASKCBFORMATNAME(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(wParam), cast(LPTSTR, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_ASKCBFORMATNAME(hwnd, cchMax, rgchName, fn) fn((hwnd), WM_ASKCBFORMATNAME, cast(WPARAM, clng(cchMax)), cast(LPARAM, (rgchName)))
#macro HANDLE_WM_CHANGECBCHAIN(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)), cast(HWND, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_CHANGECBCHAIN(hwnd, hwndRemove, hwndNext, fn) fn((hwnd), WM_CHANGECBCHAIN, cast(WPARAM, cast(HWND, (hwndRemove))), cast(LPARAM, cast(HWND, (hwndNext))))
#define HANDLE_WM_SETCURSOR(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(WINBOOL, fn((hwnd), cast(HWND, (wParam)), cast(UINT, LOWORD(lParam)), cast(UINT, HIWORD(lParam))))))
#define FORWARD_WM_SETCURSOR(hwnd, hwndCursor, codeHitTest, msg, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_SETCURSOR, cast(WPARAM, cast(HWND, (hwndCursor))), MAKELPARAM((codeHitTest), (msg)))))
#macro HANDLE_WM_SYSCOMMAND(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, (wParam)), clng(cshort(LOWORD(lParam))), clng(cshort(HIWORD(lParam))))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SYSCOMMAND(hwnd, cmd, x, y, fn) fn((hwnd), WM_SYSCOMMAND, cast(WPARAM, cast(UINT, (cmd))), MAKELPARAM((x), (y)))
#define HANDLE_WM_MDICREATE(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(UINT, fn((hwnd), cast(LPMDICREATESTRUCT, (lParam))))))
#define FORWARD_WM_MDICREATE(hwnd, lpmcs, fn) cast(HWND, cast(UINT, cast(DWORD, fn((hwnd), WM_MDICREATE, cast(WPARAM, 0), cast(LPARAM, cast(LPMDICREATESTRUCT, (lpmcs)))))))
#macro HANDLE_WM_MDIDESTROY(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MDIDESTROY(hwnd, hwndDestroy, fn) fn((hwnd), WM_MDIDESTROY, cast(WPARAM, (hwndDestroy)), cast(LPARAM, 0))
#macro HANDLE_WM_MDIACTIVATE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(WINBOOL, -(lParam = cast(LPARAM, hwnd))), cast(HWND, (lParam)), cast(HWND, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MDIACTIVATE(hwnd, fActive, hwndActivate, hwndDeactivate, fn) fn(hwnd, WM_MDIACTIVATE, cast(WPARAM, (hwndDeactivate)), cast(LPARAM, (hwndActivate)))
#macro HANDLE_WM_MDIRESTORE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MDIRESTORE(hwnd, hwndRestore, fn) fn((hwnd), WM_MDIRESTORE, cast(WPARAM, (hwndRestore)), cast(LPARAM, 0))
#define HANDLE_WM_MDINEXT(hwnd, wParam, lParam, fn) cast(LRESULT, cast(HWND, fn((hwnd), cast(HWND, (wParam)), cast(WINBOOL, lParam))))
#define FORWARD_WM_MDINEXT(hwnd, hwndCur, fPrev, fn) cast(HWND, cast(UINT_PTR, fn((hwnd), WM_MDINEXT, cast(WPARAM, (hwndCur)), cast(LPARAM, (fPrev)))))
#macro HANDLE_WM_MDIMAXIMIZE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MDIMAXIMIZE(hwnd, hwndMaximize, fn) fn((hwnd), WM_MDIMAXIMIZE, cast(WPARAM, (hwndMaximize)), cast(LPARAM, 0))
#define HANDLE_WM_MDITILE(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, fn((hwnd), cast(UINT, (wParam)))))
#define FORWARD_WM_MDITILE(hwnd, cmd, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_MDITILE, cast(WPARAM, (cmd)), cast(LPARAM, 0))))
#define HANDLE_WM_MDICASCADE(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, fn((hwnd), cast(UINT, (wParam)))))
#define FORWARD_WM_MDICASCADE(hwnd, cmd, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_MDICASCADE, cast(WPARAM, (cmd)), cast(LPARAM, 0))))
#macro HANDLE_WM_MDIICONARRANGE(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MDIICONARRANGE(hwnd, fn) fn((hwnd), WM_MDIICONARRANGE, cast(WPARAM, 0), cast(LPARAM, 0))
#define HANDLE_WM_MDIGETACTIVE(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, fn(hwnd)))
#define FORWARD_WM_MDIGETACTIVE(hwnd, fn) cast(HWND, cast(UINT_PTR, fn((hwnd), WM_MDIGETACTIVE, cast(WPARAM, 0), cast(LPARAM, 0))))
#define HANDLE_WM_MDISETMENU(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, fn((hwnd), cast(WINBOOL, (wParam)), cast(HMENU, (wParam)), cast(HMENU, (lParam)))))
#define FORWARD_WM_MDISETMENU(hwnd, fRefresh, hmenuFrame, hmenuWindow, fn) cast(HMENU, cast(UINT_PTR, fn((hwnd), WM_MDISETMENU, cast(WPARAM, iif((fRefresh), (hmenuFrame), 0)), cast(LPARAM, (hmenuWindow)))))
#macro HANDLE_WM_CHILDACTIVATE(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_CHILDACTIVATE(hwnd, fn) fn((hwnd), WM_CHILDACTIVATE, cast(WPARAM, 0), cast(LPARAM, 0))
#define HANDLE_WM_INITDIALOG(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(UINT, cast(WINBOOL, fn((hwnd), cast(HWND, (wParam)), lParam)))))
#define FORWARD_WM_INITDIALOG(hwnd, hwndFocus, lParam, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_INITDIALOG, cast(WPARAM, cast(HWND, (hwndFocus))), (lParam))))
#define HANDLE_WM_NEXTDLGCTL(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, cast(HWND, fn((hwnd), cast(HWND, (wParam)), cast(WINBOOL, (lParam))))))
#define FORWARD_WM_NEXTDLGCTL(hwnd, hwndSetFocus, fNext, fn) cast(HWND, cast(UINT_PTR, fn((hwnd), WM_NEXTDLGCTL, cast(WPARAM, cast(HWND, (hwndSetFocus))), cast(LPARAM, (fNext)))))
#macro HANDLE_WM_PARENTNOTIFY(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, LOWORD(wParam)), cast(HWND, (lParam)), cast(UINT, HIWORD(wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_PARENTNOTIFY(hwnd, msg, hwndChild, idChild, fn) fn((hwnd), WM_PARENTNOTIFY, MAKEWPARAM(msg, idChild), cast(LPARAM, (hwndChild)))
#macro HANDLE_WM_ENTERIDLE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, (wParam)), cast(HWND, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_ENTERIDLE(hwnd, source, hwndSource, fn) fn((hwnd), WM_ENTERIDLE, cast(WPARAM, cast(UINT, (source))), cast(LPARAM, cast(HWND, (hwndSource))))
#define HANDLE_WM_GETDLGCODE(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(UINT, fn(hwnd, cast(LPMSG, (lParam))))))
#define FORWARD_WM_GETDLGCODE(hwnd, lpmsg, fn) cast(UINT, cast(DWORD, fn((hwnd), WM_GETDLGCODE, iif(lpmsg, lpmsg->wParam, 0), cast(LPARAM, cast(LPMSG, (lpmsg))))))
#define HANDLE_WM_CTLCOLORMSGBOX(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, cast(HBRUSH, fn((hwnd), cast(HDC, (wParam)), cast(HWND, (lParam)), CTLCOLOR_MSGBOX))))
#define FORWARD_WM_CTLCOLORMSGBOX(hwnd, hdc, hwndChild, fn) cast(HBRUSH, cast(UINT_PTR, fn((hwnd), WM_CTLCOLORMSGBOX, cast(WPARAM, cast(HDC, (hdc))), cast(LPARAM, cast(HWND, (hwndChild))))))
#define HANDLE_WM_CTLCOLOREDIT(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, cast(HBRUSH, fn((hwnd), cast(HDC, (wParam)), cast(HWND, (lParam)), CTLCOLOR_EDIT))))
#define FORWARD_WM_CTLCOLOREDIT(hwnd, hdc, hwndChild, fn) cast(HBRUSH, cast(UINT_PTR, fn((hwnd), WM_CTLCOLOREDIT, cast(WPARAM, cast(HDC, (hdc))), cast(LPARAM, cast(HWND, (hwndChild))))))
#define HANDLE_WM_CTLCOLORLISTBOX(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, cast(HBRUSH, fn((hwnd), cast(HDC, (wParam)), cast(HWND, (lParam)), CTLCOLOR_LISTBOX))))
#define FORWARD_WM_CTLCOLORLISTBOX(hwnd, hdc, hwndChild, fn) cast(HBRUSH, cast(UINT_PTR, fn((hwnd), WM_CTLCOLORLISTBOX, cast(WPARAM, cast(HDC, (hdc))), cast(LPARAM, cast(HWND, (hwndChild))))))
#define HANDLE_WM_CTLCOLORBTN(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, cast(HBRUSH, fn((hwnd), cast(HDC, (wParam)), cast(HWND, (lParam)), CTLCOLOR_BTN))))
#define FORWARD_WM_CTLCOLORBTN(hwnd, hdc, hwndChild, fn) cast(HBRUSH, cast(UINT_PTR, fn((hwnd), WM_CTLCOLORBTN, cast(WPARAM, cast(HDC, (hdc))), cast(LPARAM, cast(HWND, (hwndChild))))))
#define HANDLE_WM_CTLCOLORDLG(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, cast(HBRUSH, fn((hwnd), cast(HDC, (wParam)), cast(HWND, (lParam)), CTLCOLOR_DLG))))
#define FORWARD_WM_CTLCOLORDLG(hwnd, hdc, hwndChild, fn) cast(HBRUSH, cast(UINT_PTR, fn((hwnd), WM_CTLCOLORDLG, cast(WPARAM, cast(HDC, (hdc))), cast(LPARAM, cast(HWND, (hwndChild))))))
#define HANDLE_WM_CTLCOLORSCROLLBAR(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, cast(HBRUSH, fn((hwnd), cast(HDC, (wParam)), cast(HWND, (lParam)), CTLCOLOR_SCROLLBAR))))
#define FORWARD_WM_CTLCOLORSCROLLBAR(hwnd, hdc, hwndChild, fn) cast(HBRUSH, cast(UINT_PTR, fn((hwnd), WM_CTLCOLORSCROLLBAR, cast(WPARAM, cast(HDC, (hdc))), cast(LPARAM, cast(HWND, (hwndChild))))))
#define HANDLE_WM_CTLCOLORSTATIC(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, cast(HBRUSH, fn((hwnd), cast(HDC, (wParam)), cast(HWND, (lParam)), CTLCOLOR_STATIC))))
#define FORWARD_WM_CTLCOLORSTATIC(hwnd, hdc, hwndChild, fn) cast(HBRUSH, cast(UINT_PTR, fn((hwnd), WM_CTLCOLORSTATIC, cast(WPARAM, cast(HDC, (hdc))), cast(LPARAM, cast(HWND, (hwndChild))))))
#macro HANDLE_WM_SETFONT(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HFONT, (wParam)), cast(WINBOOL, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_SETFONT(hwnd, hfont, fRedraw, fn) fn((hwnd), WM_SETFONT, cast(WPARAM, cast(HFONT, (hfont))), cast(LPARAM, cast(WINBOOL, (fRedraw))))
#define HANDLE_WM_GETFONT(hwnd, wParam, lParam, fn) cast(LRESULT, cast(UINT_PTR, cast(HFONT, fn(hwnd))))
#define FORWARD_WM_GETFONT(hwnd, fn) cast(HFONT, cast(UINT_PTR, fn((hwnd), WM_GETFONT, cast(WPARAM, 0), cast(LPARAM, 0))))
#macro HANDLE_WM_DRAWITEM(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cptr(const DRAWITEMSTRUCT ptr, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_DRAWITEM(hwnd, lpDrawItem, fn) fn((hwnd), WM_DRAWITEM, cast(WPARAM, cptr(const DRAWITEMSTRUCT ptr, lpDrawItem)->CtlID), cast(LPARAM, cptr(const DRAWITEMSTRUCT ptr, (lpDrawItem))))
#macro HANDLE_WM_MEASUREITEM(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cptr(MEASUREITEMSTRUCT ptr, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_MEASUREITEM(hwnd, lpMeasureItem, fn) fn((hwnd), WM_MEASUREITEM, cast(WPARAM, cptr(MEASUREITEMSTRUCT ptr, lpMeasureItem)->CtlID), cast(LPARAM, cptr(MEASUREITEMSTRUCT ptr, (lpMeasureItem))))
#macro HANDLE_WM_DELETEITEM(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cptr(const DELETEITEMSTRUCT ptr, (lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_DELETEITEM(hwnd, lpDeleteItem, fn) fn((hwnd), WM_DELETEITEM, cast(WPARAM, cptr(const DELETEITEMSTRUCT ptr, (lpDeleteItem))->CtlID), cast(LPARAM, cptr(const DELETEITEMSTRUCT ptr, (lpDeleteItem))))
#define HANDLE_WM_COMPAREITEM(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, clng(fn((hwnd), cptr(const COMPAREITEMSTRUCT ptr, (lParam))))))
#define FORWARD_WM_COMPAREITEM(hwnd, lpCompareItem, fn) clng(cast(DWORD, fn((hwnd), WM_COMPAREITEM, cast(WPARAM, cptr(const COMPAREITEMSTRUCT ptr, (lpCompareItem))->CtlID), cast(LPARAM, cptr(const COMPAREITEMSTRUCT ptr, (lpCompareItem))))))
#define HANDLE_WM_VKEYTOITEM(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, clng(fn((hwnd), cast(UINT, LOWORD(wParam)), cast(HWND, (lParam)), clng(cshort(HIWORD(wParam)))))))
#define FORWARD_WM_VKEYTOITEM(hwnd, vk, hwndListBox, iCaret, fn) clng(cast(DWORD, fn((hwnd), WM_VKEYTOITEM, MAKEWPARAM((vk), (iCaret)), cast(LPARAM, (hwndListBox)))))
#define HANDLE_WM_CHARTOITEM(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, clng(fn((hwnd), cast(UINT, LOWORD(wParam)), cast(HWND, (lParam)), clng(cshort(HIWORD(wParam)))))))
#define FORWARD_WM_CHARTOITEM(hwnd, ch, hwndListBox, iCaret, fn) clng(cast(DWORD, fn((hwnd), WM_CHARTOITEM, MAKEWPARAM(cast(UINT, (ch)), cast(UINT, (iCaret))), cast(LPARAM, (hwndListBox)))))
#macro HANDLE_WM_QUEUESYNC(hwnd, wParam, lParam, fn)
	scope
		fn(hwnd)
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_QUEUESYNC(hwnd, fn) fn((hwnd), WM_QUEUESYNC, cast(WPARAM, 0), cast(LPARAM, 0))
#macro HANDLE_WM_COMMNOTIFY(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(wParam), cast(UINT, LOWORD(lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_COMMNOTIFY(hwnd, cid, flags, fn) fn((hwnd), WM_COMMNOTIFY, cast(WPARAM, (cid)), MAKELPARAM((flags), 0))
#macro HANDLE_WM_DISPLAYCHANGE(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(UINT, (wParam)), cast(UINT, LOWORD(lParam)), cast(UINT, HIWORD(wParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_DISPLAYCHANGE(hwnd, bitsPerPixel, cxScreen, cyScreen, fn) fn((hwnd), WM_DISPLAYCHANGE, cast(WPARAM, cast(UINT, (bitsPerPixel))), cast(LPARAM, MAKELPARAM(cast(UINT, (cxScreen)), cast(UINT, (cyScreen)))))
#define HANDLE_WM_DEVICECHANGE(hwnd, wParam, lParam, fn) cast(LRESULT, cast(DWORD, cast(WINBOOL, fn((hwnd), cast(UINT, (wParam)), cast(DWORD, (wParam))))))
#define FORWARD_WM_DEVICECHANGE(hwnd, uEvent, dwEventData, fn) cast(WINBOOL, cast(DWORD, fn((hwnd), WM_DEVICECHANGE, cast(WPARAM, cast(UINT, (uEvent))), cast(LPARAM, cast(DWORD, (dwEventData))))))
#macro HANDLE_WM_CONTEXTMENU(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)), cast(UINT, LOWORD(lParam)), cast(UINT, HIWORD(lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_CONTEXTMENU(hwnd, hwndContext, xPos, yPos, fn) fn((hwnd), WM_CONTEXTMENU, cast(WPARAM, cast(HWND, (hwndContext))), MAKELPARAM(cast(UINT, (xPos)), cast(UINT, (yPos))))
#macro HANDLE_WM_COPYDATA(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), cast(HWND, (wParam)), cast(PCOPYDATASTRUCT, lParam))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_COPYDATA(hwnd, hwndFrom, pcds, fn) cast(WINBOOL, cast(UINT, cast(DWORD, fn((hwnd), WM_COPYDATA, cast(WPARAM, (hwndFrom)), cast(LPARAM, (pcds))))))
#macro HANDLE_WM_HOTKEY(hwnd, wParam, lParam, fn)
	scope
		fn((hwnd), clng(wParam), cast(UINT, LOWORD(lParam)), cast(UINT, HIWORD(lParam)))
		cast(LRESULT, 0)
	end scope
#endmacro
#define FORWARD_WM_HOTKEY(hwnd, idHotKey, fuModifiers, vk, fn) fn((hwnd), WM_HOTKEY, cast(WPARAM, (idHotKey)), MAKELPARAM((fuModifiers), (vk)))
#define Static_Enable(hwndCtl, fEnable) EnableWindow((hwndCtl), (fEnable))
#define Static_GetText(hwndCtl, lpch, cchMax) GetWindowText((hwndCtl), (lpch), (cchMax))
#define Static_GetTextLength(hwndCtl) GetWindowTextLength(hwndCtl)
#define Static_SetText(hwndCtl, lpsz) SetWindowText((hwndCtl), (lpsz))
#define Static_SetIcon(hwndCtl, hIcon) cast(HICON, cast(UINT_PTR, SNDMSG((hwndCtl), STM_SETICON, cast(WPARAM, cast(HICON, (hIcon))), cast(LPARAM, 0))))
#define Static_GetIcon(hwndCtl, hIcon) cast(HICON, cast(UINT_PTR, SNDMSG((hwndCtl), STM_GETICON, cast(WPARAM, 0), cast(LPARAM, 0))))
#define Button_Enable(hwndCtl, fEnable) EnableWindow((hwndCtl), (fEnable))
#define Button_GetText(hwndCtl, lpch, cchMax) GetWindowText((hwndCtl), (lpch), (cchMax))
#define Button_GetTextLength(hwndCtl) GetWindowTextLength(hwndCtl)
#define Button_SetText(hwndCtl, lpsz) SetWindowText((hwndCtl), (lpsz))
#define Button_GetCheck(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), BM_GETCHECK, cast(WPARAM, 0), cast(LPARAM, 0))))
#define Button_SetCheck(hwndCtl, check) SNDMSG((hwndCtl), BM_SETCHECK, cast(WPARAM, clng(check)), cast(LPARAM, 0))
#define Button_GetState(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), BM_GETSTATE, cast(WPARAM, 0), cast(LPARAM, 0))))
#define Button_SetState(hwndCtl, state) cast(UINT, cast(DWORD, SNDMSG((hwndCtl), BM_SETSTATE, cast(WPARAM, clng(state)), cast(LPARAM, 0))))
#define Button_SetStyle(hwndCtl, style, fRedraw) SNDMSG((hwndCtl), BM_SETSTYLE, cast(WPARAM, LOWORD(style)), MAKELPARAM(iif((fRedraw), CTRUE, FALSE), 0))
#define Edit_Enable(hwndCtl, fEnable) EnableWindow((hwndCtl), (fEnable))
#define Edit_GetText(hwndCtl, lpch, cchMax) GetWindowText((hwndCtl), (lpch), (cchMax))
#define Edit_GetTextLength(hwndCtl) GetWindowTextLength(hwndCtl)
#define Edit_SetText(hwndCtl, lpsz) SetWindowText((hwndCtl), (lpsz))
#define Edit_LimitText(hwndCtl, cchMax) SNDMSG((hwndCtl), EM_LIMITTEXT, cast(WPARAM, (cchMax)), cast(LPARAM, 0))
#define Edit_GetLineCount(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), EM_GETLINECOUNT, cast(WPARAM, 0), cast(LPARAM, 0))))
#macro Edit_GetLine(hwndCtl, line, lpch, cchMax)
	scope
		(*cptr(long ptr, (lpch))) = (cchMax)
		clng(cast(DWORD, SNDMSG((hwndCtl), EM_GETLINE, cast(WPARAM, clng(line)), cast(LPARAM, cast(LPTSTR, (lpch))))))
	end scope
#endmacro
#define Edit_GetRect(hwndCtl, lprc) SNDMSG((hwndCtl), EM_GETRECT, cast(LPARAM, 0), cast(LPARAM, cptr(RECT ptr, (lprc))))
#define Edit_SetRect(hwndCtl, lprc) SNDMSG((hwndCtl), EM_SETRECT, cast(LPARAM, 0), cast(LPARAM, cptr(const RECT ptr, (lprc))))
#define Edit_SetRectNoPaint(hwndCtl, lprc) SNDMSG((hwndCtl), EM_SETRECTNP, cast(LPARAM, 0), cast(LPARAM, cptr(const RECT ptr, (lprc))))
#define Edit_GetSel(hwndCtl) cast(DWORD, SNDMSG((hwndCtl), EM_GETSEL, cast(WPARAM, 0), cast(LPARAM, 0)))
#define Edit_SetSel(hwndCtl, ichStart, ichEnd) SNDMSG((hwndCtl), EM_SETSEL, (ichStart), (ichEnd))
#define Edit_ReplaceSel(hwndCtl, lpszReplace) SNDMSG((hwndCtl), EM_REPLACESEL, cast(LPARAM, 0), cast(LPARAM, cast(LPCTSTR, (lpszReplace))))
#define Edit_GetModify(hwndCtl) cast(WINBOOL, cast(DWORD, SNDMSG((hwndCtl), EM_GETMODIFY, cast(WPARAM, 0), cast(LPARAM, 0))))
#define Edit_SetModify(hwndCtl, fModified) SNDMSG((hwndCtl), EM_SETMODIFY, cast(WPARAM, cast(UINT, (fModified))), cast(LPARAM, 0))
#define Edit_ScrollCaret(hwndCtl) cast(WINBOOL, cast(DWORD, SNDMSG((hwndCtl), EM_SCROLLCARET, cast(WPARAM, 0), cast(LPARAM, 0))))
#define Edit_LineFromChar(hwndCtl, ich) clng(cast(DWORD, SNDMSG((hwndCtl), EM_LINEFROMCHAR, cast(WPARAM, clng(ich)), cast(LPARAM, 0))))
#define Edit_LineIndex(hwndCtl, line) clng(cast(DWORD, SNDMSG((hwndCtl), EM_LINEINDEX, cast(WPARAM, clng(line)), cast(LPARAM, 0))))
#define Edit_LineLength(hwndCtl, line) clng(cast(DWORD, SNDMSG((hwndCtl), EM_LINELENGTH, cast(WPARAM, clng(line)), cast(LPARAM, 0))))
#define Edit_Scroll(hwndCtl, dv, dh) SNDMSG((hwndCtl), EM_LINESCROLL, cast(WPARAM, (dh)), cast(LPARAM, (dv)))
#define Edit_CanUndo(hwndCtl) cast(WINBOOL, cast(DWORD, SNDMSG((hwndCtl), EM_CANUNDO, cast(WPARAM, 0), cast(LPARAM, 0))))
#define Edit_Undo(hwndCtl) cast(WINBOOL, cast(DWORD, SNDMSG((hwndCtl), EM_UNDO, cast(WPARAM, 0), cast(LPARAM, 0))))
#define Edit_EmptyUndoBuffer(hwndCtl) SNDMSG((hwndCtl), EM_EMPTYUNDOBUFFER, cast(WPARAM, 0), cast(LPARAM, 0))
#define Edit_SetPasswordChar(hwndCtl, ch) SNDMSG((hwndCtl), EM_SETPASSWORDCHAR, cast(WPARAM, cast(UINT, (ch))), cast(LPARAM, 0))
#define Edit_SetTabStops(hwndCtl, cTabs, lpTabs) SNDMSG((hwndCtl), EM_SETTABSTOPS, cast(WPARAM, clng(cTabs)), cast(LPARAM, cptr(const long ptr, (lpTabs))))
#define Edit_FmtLines(hwndCtl, fAddEOL) cast(WINBOOL, cast(DWORD, SNDMSG((hwndCtl), EM_FMTLINES, cast(WPARAM, cast(WINBOOL, (fAddEOL))), cast(LPARAM, 0))))
#define Edit_GetHandle(hwndCtl) cast(HLOCAL, cast(UINT_PTR, SNDMSG((hwndCtl), EM_GETHANDLE, cast(WPARAM, 0), cast(LPARAM, 0))))
#define Edit_SetHandle(hwndCtl, h) SNDMSG((hwndCtl), EM_SETHANDLE, cast(WPARAM, cast(UINT_PTR, cast(HLOCAL, (h)))), cast(LPARAM, 0))
#define Edit_GetFirstVisibleLine(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), EM_GETFIRSTVISIBLELINE, cast(WPARAM, 0), cast(LPARAM, 0))))
#define Edit_SetReadOnly(hwndCtl, fReadOnly) cast(WINBOOL, cast(DWORD, SNDMSG((hwndCtl), EM_SETREADONLY, cast(WPARAM, cast(WINBOOL, (fReadOnly))), cast(LPARAM, 0))))
#define Edit_GetPasswordChar(hwndCtl) cast(TCHAR, cast(DWORD, SNDMSG((hwndCtl), EM_GETPASSWORDCHAR, cast(WPARAM, 0), cast(LPARAM, 0))))
#define Edit_SetWordBreakProc(hwndCtl, lpfnWordBreak) SNDMSG((hwndCtl), EM_SETWORDBREAKPROC, cast(LPARAM, 0), cast(LPARAM, cast(EDITWORDBREAKPROC, (lpfnWordBreak))))
#define Edit_GetWordBreakProc(hwndCtl) cast(EDITWORDBREAKPROC, SNDMSG((hwndCtl), EM_GETWORDBREAKPROC, cast(WPARAM, 0), cast(LPARAM, 0)))
#define ScrollBar_Enable(hwndCtl, flags) EnableScrollBar((hwndCtl), SB_CTL, (flags))
#define ScrollBar_Show(hwndCtl, fShow) ShowWindow((hwndCtl), iif((fShow), SW_SHOWNORMAL, SW_HIDE))
#define ScrollBar_SetPos(hwndCtl, pos, fRedraw) SetScrollPos((hwndCtl), SB_CTL, (pos), (fRedraw))
#define ScrollBar_GetPos(hwndCtl) GetScrollPos((hwndCtl), SB_CTL)
#define ScrollBar_SetRange(hwndCtl, posMin, posMax, fRedraw) SetScrollRange((hwndCtl), SB_CTL, (posMin), (posMax), (fRedraw))
#define ScrollBar_GetRange(hwndCtl, lpposMin, lpposMax) GetScrollRange((hwndCtl), SB_CTL, (lpposMin), (lpposMax))
#define ListBox_Enable(hwndCtl, fEnable) EnableWindow((hwndCtl), (fEnable))
#define ListBox_GetCount(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETCOUNT, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ListBox_ResetContent(hwndCtl) cast(WINBOOL, cast(DWORD, SNDMSG((hwndCtl), LB_RESETCONTENT, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ListBox_AddString(hwndCtl, lpsz) clng(cast(DWORD, SNDMSG((hwndCtl), LB_ADDSTRING, cast(LPARAM, 0), cast(LPARAM, cast(LPCTSTR, (lpsz))))))
#define ListBox_InsertString(hwndCtl, index, lpsz) clng(cast(DWORD, SNDMSG((hwndCtl), LB_INSERTSTRING, cast(WPARAM, clng(index)), cast(LPARAM, cast(LPCTSTR, (lpsz))))))
#define ListBox_AddItemData(hwndCtl, data) clng(cast(DWORD, SNDMSG((hwndCtl), LB_ADDSTRING, cast(LPARAM, 0), cast(LPARAM, (data)))))
#define ListBox_InsertItemData(hwndCtl, index, data) clng(cast(DWORD, SNDMSG((hwndCtl), LB_INSERTSTRING, cast(WPARAM, clng(index)), cast(LPARAM, (data)))))
#define ListBox_DeleteString(hwndCtl, index) clng(cast(DWORD, SNDMSG((hwndCtl), LB_DELETESTRING, cast(WPARAM, clng(index)), cast(LPARAM, 0))))
#define ListBox_GetTextLen(hwndCtl, index) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETTEXTLEN, cast(WPARAM, clng(index)), cast(LPARAM, 0))))
#define ListBox_GetText(hwndCtl, index, lpszBuffer) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETTEXT, cast(WPARAM, clng(index)), cast(LPARAM, cast(LPCTSTR, (lpszBuffer))))))
#define ListBox_GetItemData(hwndCtl, index) cast(LRESULT, cast(ULONG_PTR, SNDMSG((hwndCtl), LB_GETITEMDATA, cast(WPARAM, clng(index)), cast(LPARAM, 0))))
#define ListBox_SetItemData(hwndCtl, index, data) clng(cast(DWORD, SNDMSG((hwndCtl), LB_SETITEMDATA, cast(WPARAM, clng(index)), cast(LPARAM, (data)))))
#define ListBox_FindString(hwndCtl, indexStart, lpszFind) clng(cast(DWORD, SNDMSG((hwndCtl), LB_FINDSTRING, cast(WPARAM, clng(indexStart)), cast(LPARAM, cast(LPCTSTR, (lpszFind))))))
#define ListBox_FindItemData(hwndCtl, indexStart, data) clng(cast(DWORD, SNDMSG((hwndCtl), LB_FINDSTRING, cast(WPARAM, clng(indexStart)), cast(LPARAM, (data)))))
#define ListBox_SetSel(hwndCtl, fSelect, index) clng(cast(DWORD, SNDMSG((hwndCtl), LB_SETSEL, cast(WPARAM, cast(WINBOOL, (fSelect))), cast(LPARAM, (index)))))
#define ListBox_SelItemRange(hwndCtl, fSelect, first, last) clng(cast(DWORD, SNDMSG((hwndCtl), LB_SELITEMRANGE, cast(WPARAM, cast(WINBOOL, (fSelect))), MAKELPARAM((first), (last)))))
#define ListBox_GetCurSel(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETCURSEL, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ListBox_SetCurSel(hwndCtl, index) clng(cast(DWORD, SNDMSG((hwndCtl), LB_SETCURSEL, cast(WPARAM, clng(index)), cast(LPARAM, 0))))
#define ListBox_SelectString(hwndCtl, indexStart, lpszFind) clng(cast(DWORD, SNDMSG((hwndCtl), LB_SELECTSTRING, cast(WPARAM, clng(indexStart)), cast(LPARAM, cast(LPCTSTR, (lpszFind))))))
#define ListBox_SelectItemData(hwndCtl, indexStart, data) clng(cast(DWORD, SNDMSG((hwndCtl), LB_SELECTSTRING, cast(WPARAM, clng(indexStart)), cast(LPARAM, (data)))))
#define ListBox_GetSel(hwndCtl, index) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETSEL, cast(WPARAM, clng(index)), cast(LPARAM, 0))))
#define ListBox_GetSelCount(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETSELCOUNT, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ListBox_GetTopIndex(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETTOPINDEX, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ListBox_GetSelItems(hwndCtl, cItems, lpItems) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETSELITEMS, cast(WPARAM, clng(cItems)), cast(LPARAM, cptr(long ptr, (lpItems))))))
#define ListBox_SetTopIndex(hwndCtl, indexTop) clng(cast(DWORD, SNDMSG((hwndCtl), LB_SETTOPINDEX, cast(WPARAM, clng(indexTop)), cast(LPARAM, 0))))
#define ListBox_SetColumnWidth(hwndCtl, cxColumn) SNDMSG((hwndCtl), LB_SETCOLUMNWIDTH, cast(WPARAM, clng(cxColumn)), cast(LPARAM, 0))
#define ListBox_GetHorizontalExtent(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETHORIZONTALEXTENT, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ListBox_SetHorizontalExtent(hwndCtl, cxExtent) SNDMSG((hwndCtl), LB_SETHORIZONTALEXTENT, cast(WPARAM, clng(cxExtent)), cast(LPARAM, 0))
#define ListBox_SetTabStops(hwndCtl, cTabs, lpTabs) cast(WINBOOL, cast(DWORD, SNDMSG((hwndCtl), LB_SETTABSTOPS, cast(WPARAM, clng(cTabs)), cast(LPARAM, cptr(long ptr, (lpTabs))))))
#define ListBox_GetItemRect(hwndCtl, index, lprc) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETITEMRECT, cast(WPARAM, clng(index)), cast(LPARAM, cptr(RECT ptr, (lprc))))))
#define ListBox_SetCaretIndex(hwndCtl, index) clng(cast(DWORD, SNDMSG((hwndCtl), LB_SETCARETINDEX, cast(WPARAM, clng(index)), cast(LPARAM, 0))))
#define ListBox_GetCaretIndex(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETCARETINDEX, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ListBox_FindStringExact(hwndCtl, indexStart, lpszFind) clng(cast(DWORD, SNDMSG((hwndCtl), LB_FINDSTRINGEXACT, cast(WPARAM, clng(indexStart)), cast(LPARAM, cast(LPCTSTR, (lpszFind))))))
#define ListBox_SetItemHeight(hwndCtl, index, cy) clng(cast(DWORD, SNDMSG((hwndCtl), LB_SETITEMHEIGHT, cast(WPARAM, clng(index)), MAKELPARAM((cy), 0))))
#define ListBox_GetItemHeight(hwndCtl, index) clng(cast(DWORD, SNDMSG((hwndCtl), LB_GETITEMHEIGHT, cast(WPARAM, clng(index)), cast(LPARAM, 0))))
#define ListBox_Dir(hwndCtl, attrs, lpszFileSpec) clng(cast(DWORD, SNDMSG((hwndCtl), LB_DIR, cast(WPARAM, cast(UINT, (attrs))), cast(LPARAM, cast(LPCTSTR, (lpszFileSpec))))))
#define ComboBox_Enable(hwndCtl, fEnable) EnableWindow((hwndCtl), (fEnable))
#define ComboBox_GetText(hwndCtl, lpch, cchMax) GetWindowText((hwndCtl), (lpch), (cchMax))
#define ComboBox_GetTextLength(hwndCtl) GetWindowTextLength(hwndCtl)
#define ComboBox_SetText(hwndCtl, lpsz) SetWindowText((hwndCtl), (lpsz))
#define ComboBox_LimitText(hwndCtl, cchLimit) clng(cast(DWORD, SNDMSG((hwndCtl), CB_LIMITTEXT, cast(WPARAM, clng(cchLimit)), cast(LPARAM, 0))))
#define ComboBox_GetEditSel(hwndCtl) cast(DWORD, SNDMSG((hwndCtl), CB_GETEDITSEL, cast(WPARAM, 0), cast(LPARAM, 0)))
#define ComboBox_SetEditSel(hwndCtl, ichStart, ichEnd) clng(cast(DWORD, SNDMSG((hwndCtl), CB_SETEDITSEL, cast(LPARAM, 0), MAKELPARAM((ichStart), (ichEnd)))))
#define ComboBox_GetCount(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), CB_GETCOUNT, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ComboBox_ResetContent(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), CB_RESETCONTENT, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ComboBox_AddString(hwndCtl, lpsz) clng(cast(DWORD, SNDMSG((hwndCtl), CB_ADDSTRING, cast(LPARAM, 0), cast(LPARAM, cast(LPCTSTR, (lpsz))))))
#define ComboBox_InsertString(hwndCtl, index, lpsz) clng(cast(DWORD, SNDMSG((hwndCtl), CB_INSERTSTRING, cast(WPARAM, clng(index)), cast(LPARAM, cast(LPCTSTR, (lpsz))))))
#define ComboBox_AddItemData(hwndCtl, data) clng(cast(DWORD, SNDMSG((hwndCtl), CB_ADDSTRING, cast(LPARAM, 0), cast(LPARAM, (data)))))
#define ComboBox_InsertItemData(hwndCtl, index, data) clng(cast(DWORD, SNDMSG((hwndCtl), CB_INSERTSTRING, cast(WPARAM, clng(index)), cast(LPARAM, (data)))))
#define ComboBox_DeleteString(hwndCtl, index) clng(cast(DWORD, SNDMSG((hwndCtl), CB_DELETESTRING, cast(WPARAM, clng(index)), cast(LPARAM, 0))))
#define ComboBox_GetLBTextLen(hwndCtl, index) clng(cast(DWORD, SNDMSG((hwndCtl), CB_GETLBTEXTLEN, cast(WPARAM, clng(index)), cast(LPARAM, 0))))
#define ComboBox_GetLBText(hwndCtl, index, lpszBuffer) clng(cast(DWORD, SNDMSG((hwndCtl), CB_GETLBTEXT, cast(WPARAM, clng(index)), cast(LPARAM, cast(LPCTSTR, (lpszBuffer))))))
#define ComboBox_GetItemData(hwndCtl, index) cast(LRESULT, cast(ULONG_PTR, SNDMSG((hwndCtl), CB_GETITEMDATA, cast(WPARAM, clng(index)), cast(LPARAM, 0))))
#define ComboBox_SetItemData(hwndCtl, index, data) clng(cast(DWORD, SNDMSG((hwndCtl), CB_SETITEMDATA, cast(WPARAM, clng(index)), cast(LPARAM, (data)))))
#define ComboBox_FindString(hwndCtl, indexStart, lpszFind) clng(cast(DWORD, SNDMSG((hwndCtl), CB_FINDSTRING, cast(WPARAM, clng(indexStart)), cast(LPARAM, cast(LPCTSTR, (lpszFind))))))
#define ComboBox_FindItemData(hwndCtl, indexStart, data) clng(cast(DWORD, SNDMSG((hwndCtl), CB_FINDSTRING, cast(WPARAM, clng(indexStart)), cast(LPARAM, (data)))))
#define ComboBox_GetCurSel(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), CB_GETCURSEL, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ComboBox_SetCurSel(hwndCtl, index) clng(cast(DWORD, SNDMSG((hwndCtl), CB_SETCURSEL, cast(WPARAM, clng(index)), cast(LPARAM, 0))))
#define ComboBox_SelectString(hwndCtl, indexStart, lpszSelect) clng(cast(DWORD, SNDMSG((hwndCtl), CB_SELECTSTRING, cast(WPARAM, clng(indexStart)), cast(LPARAM, cast(LPCTSTR, (lpszSelect))))))
#define ComboBox_SelectItemData(hwndCtl, indexStart, data) clng(cast(DWORD, SNDMSG((hwndCtl), CB_SELECTSTRING, cast(WPARAM, clng(indexStart)), cast(LPARAM, (data)))))
#define ComboBox_Dir(hwndCtl, attrs, lpszFileSpec) clng(cast(DWORD, SNDMSG((hwndCtl), CB_DIR, cast(WPARAM, cast(UINT, (attrs))), cast(LPARAM, cast(LPCTSTR, (lpszFileSpec))))))
#define ComboBox_ShowDropdown(hwndCtl, fShow) cast(WINBOOL, cast(DWORD, SNDMSG((hwndCtl), CB_SHOWDROPDOWN, cast(WPARAM, cast(WINBOOL, (fShow))), cast(LPARAM, 0))))
#define ComboBox_FindStringExact(hwndCtl, indexStart, lpszFind) clng(cast(DWORD, SNDMSG((hwndCtl), CB_FINDSTRINGEXACT, cast(WPARAM, clng(indexStart)), cast(LPARAM, cast(LPCTSTR, (lpszFind))))))
#define ComboBox_GetDroppedState(hwndCtl) cast(WINBOOL, cast(DWORD, SNDMSG((hwndCtl), CB_GETDROPPEDSTATE, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ComboBox_GetDroppedControlRect(hwndCtl, lprc) SNDMSG((hwndCtl), CB_GETDROPPEDCONTROLRECT, cast(LPARAM, 0), cast(LPARAM, cptr(RECT ptr, (lprc))))
#define ComboBox_GetItemHeight(hwndCtl) clng(cast(DWORD, SNDMSG((hwndCtl), CB_GETITEMHEIGHT, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ComboBox_SetItemHeight(hwndCtl, index, cyItem) clng(cast(DWORD, SNDMSG((hwndCtl), CB_SETITEMHEIGHT, cast(WPARAM, clng(index)), cast(LPARAM, clng(cyItem)))))
#define ComboBox_GetExtendedUI(hwndCtl) cast(UINT, cast(DWORD, SNDMSG((hwndCtl), CB_GETEXTENDEDUI, cast(WPARAM, 0), cast(LPARAM, 0))))
#define ComboBox_SetExtendedUI(hwndCtl, flags) clng(cast(DWORD, SNDMSG((hwndCtl), CB_SETEXTENDEDUI, cast(WPARAM, cast(UINT, (flags))), cast(LPARAM, 0))))
#define GET_WPARAM(wp, lp) (wp)
#define GET_LPARAM(wp, lp) (lp)
#define GET_X_LPARAM(lp) clng(cshort(LOWORD(lp)))
#define GET_Y_LPARAM(lp) clng(cshort(HIWORD(lp)))
#define GET_WM_ACTIVATE_STATE(wp, lp) LOWORD(wp)
#define GET_WM_ACTIVATE_FMINIMIZED(wp, lp) cast(WINBOOL, HIWORD(wp))
#define GET_WM_ACTIVATE_HWND(wp, lp) cast(HWND, (lp))
'' TODO: #define GET_WM_ACTIVATE_MPS(s,fmin,hwnd) (WPARAM)MAKELONG((s),(fmin)),(LPARAM)(hwnd)
#define GET_WM_CHARTOITEM_CHAR(wp, lp) cast(TCHAR, LOWORD(wp))
#define GET_WM_CHARTOITEM_POS(wp, lp) HIWORD(wp)
#define GET_WM_CHARTOITEM_HWND(wp, lp) cast(HWND, (lp))
'' TODO: #define GET_WM_CHARTOITEM_MPS(ch,pos,hwnd) (WPARAM)MAKELONG((pos),(ch)),(LPARAM)(hwnd)
#define GET_WM_COMMAND_ID(wp, lp) LOWORD(wp)
#define GET_WM_COMMAND_HWND(wp, lp) cast(HWND, (lp))
#define GET_WM_COMMAND_CMD(wp, lp) HIWORD(wp)
'' TODO: #define GET_WM_COMMAND_MPS(id,hwnd,cmd) (WPARAM)MAKELONG(id,cmd),(LPARAM)(hwnd)
const WM_CTLCOLOR = &h0019
#define GET_WM_CTLCOLOR_HDC(wp, lp, msg) cast(HDC, (wp))
#define GET_WM_CTLCOLOR_HWND(wp, lp, msg) cast(HWND, (lp))
#define GET_WM_CTLCOLOR_TYPE(wp, lp, msg) cast(WORD, msg - WM_CTLCOLORMSGBOX)
#define GET_WM_CTLCOLOR_MSG(type) cast(WORD, WM_CTLCOLORMSGBOX + (type))
'' TODO: #define GET_WM_CTLCOLOR_MPS(hdc,hwnd,type) (WPARAM)(hdc),(LPARAM)(hwnd)
#define GET_WM_MENUSELECT_CMD(wp, lp) LOWORD(wp)
#define GET_WM_MENUSELECT_FLAGS(wp, lp) cast(UINT, clng(cshort(HIWORD(wp))))
#define GET_WM_MENUSELECT_HMENU(wp, lp) cast(HMENU, (lp))
'' TODO: #define GET_WM_MENUSELECT_MPS(cmd,f,hmenu) (WPARAM)MAKELONG(cmd,f),(LPARAM)(hmenu)
#define GET_WM_MDIACTIVATE_FACTIVATE(hwnd, wp, lp) (lp = cast(LPARAM, hwnd))
#define GET_WM_MDIACTIVATE_HWNDDEACT(wp, lp) cast(HWND, (wp))
#define GET_WM_MDIACTIVATE_HWNDACTIVATE(wp, lp) cast(HWND, (lp))
'' TODO: #define GET_WM_MDIACTIVATE_MPS(f,hwndD,hwndA) (WPARAM)(hwndA),0
'' TODO: #define GET_WM_MDISETMENU_MPS(hmenuF,hmenuW) (WPARAM)hmenuF,(LPARAM)hmenuW
#define GET_WM_MENUCHAR_CHAR(wp, lp) cast(TCHAR, LOWORD(wp))
#define GET_WM_MENUCHAR_HMENU(wp, lp) cast(HMENU, (lp))
#define GET_WM_MENUCHAR_FMENU(wp, lp) cast(WINBOOL, HIWORD(wp))
'' TODO: #define GET_WM_MENUCHAR_MPS(ch,hmenu,f) (WPARAM)MAKELONG(ch,f),(LPARAM)(hmenu)
#define GET_WM_PARENTNOTIFY_MSG(wp, lp) LOWORD(wp)
#define GET_WM_PARENTNOTIFY_ID(wp, lp) HIWORD(wp)
#define GET_WM_PARENTNOTIFY_HWNDCHILD(wp, lp) cast(HWND, (lp))
#define GET_WM_PARENTNOTIFY_X(wp, lp) clng(cshort(LOWORD(lp)))
#define GET_WM_PARENTNOTIFY_Y(wp, lp) clng(cshort(HIWORD(lp)))
'' TODO: #define GET_WM_PARENTNOTIFY_MPS(msg,id,hwnd) (WPARAM)MAKELONG(id,msg),(LPARAM)(hwnd)
'' TODO: #define GET_WM_PARENTNOTIFY2_MPS(msg,x,y) (WPARAM)MAKELONG(0,msg),MAKELONG(x,y)
#define GET_WM_VKEYTOITEM_CODE(wp, lp) clng(cshort(LOWORD(wp)))
#define GET_WM_VKEYTOITEM_ITEM(wp, lp) HIWORD(wp)
#define GET_WM_VKEYTOITEM_HWND(wp, lp) cast(HWND, (lp))
'' TODO: #define GET_WM_VKEYTOITEM_MPS(code,item,hwnd) (WPARAM)MAKELONG(item,code),(LPARAM)(hwnd)
#define GET_EM_SETSEL_START(wp, lp) cast(INT_, (wp))
#define GET_EM_SETSEL_END(wp, lp) (lp)
'' TODO: #define GET_EM_SETSEL_MPS(iStart,iEnd) (WPARAM)(iStart),(LPARAM)(iEnd)
'' TODO: #define GET_EM_LINESCROLL_MPS(vert,horz) (WPARAM)horz,(LPARAM)vert
#define GET_WM_CHANGECBCHAIN_HWNDNEXT(wp, lp) cast(HWND, (lp))
#define GET_WM_HSCROLL_CODE(wp, lp) LOWORD(wp)
#define GET_WM_HSCROLL_POS(wp, lp) HIWORD(wp)
#define GET_WM_HSCROLL_HWND(wp, lp) cast(HWND, (lp))
'' TODO: #define GET_WM_HSCROLL_MPS(code,pos,hwnd) (WPARAM)MAKELONG(code,pos),(LPARAM)(hwnd)
#define GET_WM_VSCROLL_CODE(wp, lp) LOWORD(wp)
#define GET_WM_VSCROLL_POS(wp, lp) HIWORD(wp)
#define GET_WM_VSCROLL_HWND(wp, lp) cast(HWND, (lp))
'' TODO: #define GET_WM_VSCROLL_MPS(code,pos,hwnd) (WPARAM)MAKELONG(code,pos),(LPARAM)(hwnd)
