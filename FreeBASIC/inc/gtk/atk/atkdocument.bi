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

#include once "atkobject.bi"
#include once "atkutil.bi"

#define ATK_TYPE_DOCUMENT() atk_document_get_type()
#define ATK_IS_DOCUMENT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_DOCUMENT)
#define ATK_DOCUMENT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_DOCUMENT, AtkDocument)
#define ATK_DOCUMENT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_DOCUMENT, AtkDocumentIface)

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

declare function atk_document_get_type () as GType
declare function atk_document_get_document_type (byval document as AtkDocument ptr) as zstring ptr
declare function atk_document_get_document (byval document as AtkDocument ptr) as gpointer

#endif
