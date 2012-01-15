''
''
'' mxml -- Mini-XML, a small XML-like file parsing library 
''         (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __mxml_bi__
#define __mxml_bi__

#inclib "mxml"

#ifndef FILE
type FILE as any
#endif

#define MXML_WRAP 72
#define MXML_TAB 8
#define MXML_NO_CALLBACK 0
#define MXML_TEXT_CALLBACK 0
#define MXML_NO_PARENT 0
#define MXML_DESCEND 1
#define MXML_NO_DESCEND 0
#define MXML_DESCEND_FIRST -1
#define MXML_WS_BEFORE_OPEN 0
#define MXML_WS_AFTER_OPEN 1
#define MXML_WS_BEFORE_CLOSE 2
#define MXML_WS_AFTER_CLOSE 3
#define MXML_ADD_BEFORE 0
#define MXML_ADD_AFTER 1

enum mxml_type_e
	MXML_ELEMENT
	MXML_INTEGER
	MXML_OPAQUE
	MXML_REAL
	MXML_TEXT
	MXML_CUSTOM
end enum

type mxml_type_t as mxml_type_e

type mxml_attr_s
	name as zstring ptr
	value as zstring ptr
end type

type mxml_attr_t as mxml_attr_s

type mxml_value_s
	name as zstring ptr
	num_attrs as integer
	attrs as mxml_attr_t ptr
end type

type mxml_element_t as mxml_value_s

type mxml_text_s
	whitespace as integer
	string as zstring ptr
end type

type mxml_text_t as mxml_text_s

type mxml_custom_s
	data as any ptr
	destroy as sub cdecl(byval as any ptr)
end type

type mxml_custom_t as mxml_custom_s

union mxml_value_u
	element as mxml_element_t
	integer as integer
	opaque as zstring ptr
	real as double
	text as mxml_text_t
	custom as mxml_custom_t
end union

type mxml_value_t as mxml_value_u

type mxml_node_s
	type as mxml_type_t
	next as mxml_node_s ptr
	prev as mxml_node_s ptr
	parent as mxml_node_s ptr
	child as mxml_node_s ptr
	last_child as mxml_node_s ptr
	value as mxml_value_t
end type

type mxml_node_t as mxml_node_s

type mxml_index_s
	attr as zstring ptr
	num_nodes as integer
	alloc_nodes as integer
	cur_node as integer
	nodes as mxml_node_t ptr ptr
end type

type mxml_index_t as mxml_index_s
type mxml_custom_load_cb_t as function cdecl(byval as mxml_node_t ptr, byval as zstring ptr) as integer
type mxml_custom_save_cb_t as function cdecl(byval as mxml_node_t ptr) as byte

declare sub mxmlAdd cdecl alias "mxmlAdd" (byval parent as mxml_node_t ptr, byval where as integer, byval child as mxml_node_t ptr, byval node as mxml_node_t ptr)
declare sub mxmlDelete cdecl alias "mxmlDelete" (byval node as mxml_node_t ptr)
declare function mxmlElementGetAttr cdecl alias "mxmlElementGetAttr" (byval node as mxml_node_t ptr, byval name as zstring ptr) as zstring ptr
declare sub mxmlElementSetAttr cdecl alias "mxmlElementSetAttr" (byval node as mxml_node_t ptr, byval name as zstring ptr, byval value as zstring ptr)
declare function mxmlEntityAddCallback cdecl alias "mxmlEntityAddCallback" (byval cb as function cdecl(byval as zstring ptr) as integer) as integer
declare function mxmlEntityGetName cdecl alias "mxmlEntityGetName" (byval val as integer) as zstring ptr
declare function mxmlEntityGetValue cdecl alias "mxmlEntityGetValue" (byval name as zstring ptr) as integer
declare sub mxmlEntityRemoveCallback cdecl alias "mxmlEntityRemoveCallback" (byval cb as function cdecl(byval as zstring ptr) as integer)
declare function mxmlFindElement cdecl alias "mxmlFindElement" (byval node as mxml_node_t ptr, byval top as mxml_node_t ptr, byval name as zstring ptr, byval attr as zstring ptr, byval value as zstring ptr, byval descend as integer) as mxml_node_t ptr
declare sub mxmlIndexDelete cdecl alias "mxmlIndexDelete" (byval ind as mxml_index_t ptr)
declare function mxmlIndexEnum cdecl alias "mxmlIndexEnum" (byval ind as mxml_index_t ptr) as mxml_node_t ptr
declare function mxmlIndexFind cdecl alias "mxmlIndexFind" (byval ind as mxml_index_t ptr, byval element as zstring ptr, byval value as zstring ptr) as mxml_node_t ptr
declare function mxmlIndexNew cdecl alias "mxmlIndexNew" (byval node as mxml_node_t ptr, byval element as zstring ptr, byval attr as zstring ptr) as mxml_index_t ptr
declare function mxmlIndexReset cdecl alias "mxmlIndexReset" (byval ind as mxml_index_t ptr) as mxml_node_t ptr
declare function mxmlLoadFd cdecl alias "mxmlLoadFd" (byval top as mxml_node_t ptr, byval fd as integer, byval cb as function cdecl(byval as mxml_node_t ptr) as mxml_type_t) as mxml_node_t ptr
declare function mxmlLoadFile cdecl alias "mxmlLoadFile" (byval top as mxml_node_t ptr, byval fp as FILE ptr, byval cb as function cdecl(byval as mxml_node_t ptr) as mxml_type_t) as mxml_node_t ptr
declare function mxmlLoadString cdecl alias "mxmlLoadString" (byval top as mxml_node_t ptr, byval s as zstring ptr, byval cb as function cdecl(byval as mxml_node_t ptr) as mxml_type_t) as mxml_node_t ptr
declare function mxmlNewCustom cdecl alias "mxmlNewCustom" (byval parent as mxml_node_t ptr, byval data as any ptr, byval destroy as sub cdecl(byval as any ptr)) as mxml_node_t ptr
declare function mxmlNewElement cdecl alias "mxmlNewElement" (byval parent as mxml_node_t ptr, byval name as zstring ptr) as mxml_node_t ptr
declare function mxmlNewInteger cdecl alias "mxmlNewInteger" (byval parent as mxml_node_t ptr, byval integer as integer) as mxml_node_t ptr
declare function mxmlNewOpaque cdecl alias "mxmlNewOpaque" (byval parent as mxml_node_t ptr, byval opaque as zstring ptr) as mxml_node_t ptr
declare function mxmlNewReal cdecl alias "mxmlNewReal" (byval parent as mxml_node_t ptr, byval real as double) as mxml_node_t ptr
declare function mxmlNewText cdecl alias "mxmlNewText" (byval parent as mxml_node_t ptr, byval whitespace as integer, byval string as zstring ptr) as mxml_node_t ptr
declare function mxmlNewTextf cdecl alias "mxmlNewTextf" (byval parent as mxml_node_t ptr, byval whitespace as integer, byval format as zstring ptr, ...) as mxml_node_t ptr
declare sub mxmlRemove cdecl alias "mxmlRemove" (byval node as mxml_node_t ptr)
declare function mxmlSaveAllocString cdecl alias "mxmlSaveAllocString" (byval node as mxml_node_t ptr, byval cb as function cdecl(byval as mxml_node_t ptr, byval as integer) as byte) as zstring ptr
declare function mxmlSaveFd cdecl alias "mxmlSaveFd" (byval node as mxml_node_t ptr, byval fd as integer, byval cb as function cdecl(byval as mxml_node_t ptr, byval as integer) as byte) as integer
declare function mxmlSaveFile cdecl alias "mxmlSaveFile" (byval node as mxml_node_t ptr, byval fp as FILE ptr, byval cb as function cdecl(byval as mxml_node_t ptr, byval as integer) as byte) as integer
declare function mxmlSaveString cdecl alias "mxmlSaveString" (byval node as mxml_node_t ptr, byval buffer as zstring ptr, byval bufsize as integer, byval cb as function cdecl(byval as mxml_node_t ptr, byval as integer) as byte) as integer
declare function mxmlSetCustom cdecl alias "mxmlSetCustom" (byval node as mxml_node_t ptr, byval data as any ptr, byval destroy as sub cdecl(byval as any ptr)) as integer
declare sub mxmlSetCustomHandlers cdecl alias "mxmlSetCustomHandlers" (byval load as mxml_custom_load_cb_t, byval save as mxml_custom_save_cb_t)
declare function mxmlSetElement cdecl alias "mxmlSetElement" (byval node as mxml_node_t ptr, byval name as zstring ptr) as integer
declare sub mxmlSetErrorCallback cdecl alias "mxmlSetErrorCallback" (byval cb as sub cdecl(byval as zstring ptr))
declare function mxmlSetInteger cdecl alias "mxmlSetInteger" (byval node as mxml_node_t ptr, byval integer as integer) as integer
declare function mxmlSetOpaque cdecl alias "mxmlSetOpaque" (byval node as mxml_node_t ptr, byval opaque as zstring ptr) as integer
declare function mxmlSetReal cdecl alias "mxmlSetReal" (byval node as mxml_node_t ptr, byval real as double) as integer
declare function mxmlSetText cdecl alias "mxmlSetText" (byval node as mxml_node_t ptr, byval whitespace as integer, byval string as zstring ptr) as integer
declare function mxmlSetTextf cdecl alias "mxmlSetTextf" (byval node as mxml_node_t ptr, byval whitespace as integer, byval format as zstring ptr, ...) as integer
declare function mxmlWalkNext cdecl alias "mxmlWalkNext" (byval node as mxml_node_t ptr, byval top as mxml_node_t ptr, byval descend as integer) as mxml_node_t ptr
declare function mxmlWalkPrev cdecl alias "mxmlWalkPrev" (byval node as mxml_node_t ptr, byval top as mxml_node_t ptr, byval descend as integer) as mxml_node_t ptr
declare sub mxml_error cdecl alias "mxml_error" (byval format as zstring ptr, ...)
declare function mxml_integer_cb cdecl alias "mxml_integer_cb" (byval node as mxml_node_t ptr) as mxml_type_t
declare function mxml_opaque_cb cdecl alias "mxml_opaque_cb" (byval node as mxml_node_t ptr) as mxml_type_t
declare function mxml_real_cb cdecl alias "mxml_real_cb" (byval node as mxml_node_t ptr) as mxml_type_t

#endif
