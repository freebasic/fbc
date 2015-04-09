'' FreeBASIC binding for libXmu-1.1.2

#pragma once

#include once "crt/long.bi"
#include once "X11/Xlib.bi"
#include once "X11/Xutil.bi"

extern "C"

const included_xmu_lookup_h = 1
declare function XmuLookupString(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr, byval keysymSet as culong) as long
declare function XmuLookupLatin1(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupLatin2(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupLatin3(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupLatin4(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupKana(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupJISX0201(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupArabic(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupCyrillic(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupGreek(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupAPL(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupHebrew(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long

end extern
