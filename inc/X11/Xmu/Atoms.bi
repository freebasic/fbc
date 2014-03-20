''
''
'' Atoms -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Atoms_bi__
#define __Atoms_bi__

type AtomPtr as _AtomRec ptr
extern _XA_ATOM_PAIR alias "_XA_ATOM_PAIR" as AtomPtr
extern _XA_CHARACTER_POSITION alias "_XA_CHARACTER_POSITION" as AtomPtr
extern _XA_CLASS alias "_XA_CLASS" as AtomPtr
extern _XA_CLIENT_WINDOW alias "_XA_CLIENT_WINDOW" as AtomPtr
extern _XA_CLIPBOARD alias "_XA_CLIPBOARD" as AtomPtr
extern _XA_COMPOUND_TEXT alias "_XA_COMPOUND_TEXT" as AtomPtr
extern _XA_DECNET_ADDRESS alias "_XA_DECNET_ADDRESS" as AtomPtr
extern _XA_DELETE alias "_XA_DELETE" as AtomPtr
extern _XA_FILENAME alias "_XA_FILENAME" as AtomPtr
extern _XA_HOSTNAME alias "_XA_HOSTNAME" as AtomPtr
extern _XA_IP_ADDRESS alias "_XA_IP_ADDRESS" as AtomPtr
extern _XA_LENGTH alias "_XA_LENGTH" as AtomPtr
extern _XA_LIST_LENGTH alias "_XA_LIST_LENGTH" as AtomPtr
extern _XA_NAME alias "_XA_NAME" as AtomPtr
extern _XA_NET_ADDRESS alias "_XA_NET_ADDRESS" as AtomPtr
extern _XA_NULL alias "_XA_NULL" as AtomPtr
extern _XA_OWNER_OS alias "_XA_OWNER_OS" as AtomPtr
extern _XA_SPAN alias "_XA_SPAN" as AtomPtr
extern _XA_TARGETS alias "_XA_TARGETS" as AtomPtr
extern _XA_TEXT alias "_XA_TEXT" as AtomPtr
extern _XA_TIMESTAMP alias "_XA_TIMESTAMP" as AtomPtr
extern _XA_USER alias "_XA_USER" as AtomPtr
extern _XA_UTF8_STRING alias "_XA_UTF8_STRING" as AtomPtr

declare sub XmuInternStrings cdecl alias "XmuInternStrings" (byval dpy as Display ptr, byval names as zstring ptr ptr, byval count as Cardinal, byval atoms_return as Atom ptr)
declare function XmuNameOfAtom cdecl alias "XmuNameOfAtom" (byval atom_ptr as AtomPtr) as zstring ptr

#endif
