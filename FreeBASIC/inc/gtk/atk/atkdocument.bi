''
''
'' atkdocument -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkdocument_bi__
#define __atkdocument_bi__

#include once "gtk/atk/atkobject.bi"
#include once "gtk/atk/atkutil.bi"

type AtkDocument as _AtkDocument
type AtkDocumentIface as _AtkDocumentIface

type _AtkDocumentIface
	parent as GTypeInterface
	get_document_type as function cdecl(byval as AtkDocument ptr) as gchar
	get_document as function cdecl(byval as AtkDocument ptr) as gpointer
	pad1 as AtkFunction
	pad2 as AtkFunction
	pad3 as AtkFunction
	pad4 as AtkFunction
	pad5 as AtkFunction
	pad6 as AtkFunction
	pad7 as AtkFunction
	pad8 as AtkFunction
end type

declare function atk_document_get_type cdecl alias "atk_document_get_type" () as GType
declare function atk_document_get_document_type cdecl alias "atk_document_get_document_type" (byval document as AtkDocument ptr) as zstring ptr
declare function atk_document_get_document cdecl alias "atk_document_get_document" (byval document as AtkDocument ptr) as gpointer

#endif
