'' FreeBASIC binding for mxml-2.9
''
'' based on the C header files:
''   "$Id: mxml.h 451 2014-01-04 21:50:06Z msweet $"
''
''   Header file for Mini-XML, a small XML-like file parsing library.
''
''   Copyright 2003-2014 by Michael R Sweet.
''
''   These coded instructions, statements, and computer programs are the
''   property of Michael R Sweet and are protected by Federal copyright
''   law.  Distribution and use rights are outlined in the file "COPYING"
''   which should have been included with this file.  If this file is
''   missing or damaged, see the license at:
''
''       http://www.msweet.org/projects.php/Mini-XML
''
''   The Mini-XML library and included programs are provided under the
''   terms of the GNU Library General Public License version 2 (LGPL2)
''   with the following exceptions:
''
''     1. Static linking of applications to the Mini-XML library
''   does not constitute a derivative work and does not require
''   the author to provide source code for the application, use
''   the shared Mini-XML libraries, or link their applications
''   against a user-supplied version of Mini-XML.
''
''   If you link the application to a modified version of
''   Mini-XML, then the changes to Mini-XML must be provided
''   under the terms of the LGPL2 in sections 1, 2, and 4.
''
''     2. You do not have to provide a copy of the Mini-XML license
''   with programs that are linked to the Mini-XML library, nor
''   do you have to identify the Mini-XML license in your
''   program or documentation as required by section 6 of the
''   LGPL2.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "pthread"
#inclib "mxml"

#include once "crt/stdio.bi"
#include once "crt/stdlib.bi"
#include once "crt/string.bi"
#include once "crt/ctype.bi"
#include once "crt/errno.bi"

extern "C"

#define _mxml_h_
const MXML_MAJOR_VERSION = 2
const MXML_MINOR_VERSION = 8
const MXML_TAB = 8
const MXML_NO_CALLBACK = 0
const MXML_TEXT_CALLBACK = 0
const MXML_NO_PARENT = 0
const MXML_DESCEND = 1
const MXML_NO_DESCEND = 0
const MXML_DESCEND_FIRST = -1
const MXML_WS_BEFORE_OPEN = 0
const MXML_WS_AFTER_OPEN = 1
const MXML_WS_BEFORE_CLOSE = 2
const MXML_WS_AFTER_CLOSE = 3
const MXML_ADD_BEFORE = 0
const MXML_ADD_AFTER = 1
#define MXML_ADD_TO_PARENT NULL

type mxml_sax_event_e as long
enum
	MXML_SAX_CDATA
	MXML_SAX_COMMENT
	MXML_SAX_DATA
	MXML_SAX_DIRECTIVE
	MXML_SAX_ELEMENT_CLOSE
	MXML_SAX_ELEMENT_OPEN
end enum

type mxml_sax_event_t as mxml_sax_event_e

type mxml_type_e as long
enum
	MXML_IGNORE = -1
	MXML_ELEMENT
	MXML_INTEGER
	MXML_OPAQUE
	MXML_REAL
	MXML_TEXT
	MXML_CUSTOM
end enum

type mxml_type_t as mxml_type_e
type mxml_custom_destroy_cb_t as sub(byval as any ptr)
type mxml_error_cb_t as sub(byval as const zstring ptr)

type mxml_attr_s
	name as zstring ptr
	value as zstring ptr
end type

type mxml_attr_t as mxml_attr_s

type mxml_element_s
	name as zstring ptr
	num_attrs as long
	attrs as mxml_attr_t ptr
end type

type mxml_element_t as mxml_element_s

type mxml_text_s
	whitespace as long
	string as zstring ptr
end type

type mxml_text_t as mxml_text_s

type mxml_custom_s
	data as any ptr
	destroy as mxml_custom_destroy_cb_t
end type

type mxml_custom_t as mxml_custom_s

union mxml_value_u
	element as mxml_element_t
	integer as long
	opaque as zstring ptr
	real as double
	text as mxml_text_t
	custom as mxml_custom_t
end union

type mxml_value_t as mxml_value_u

type mxml_node_s
	as mxml_type_t type
	next as mxml_node_s ptr
	prev as mxml_node_s ptr
	parent as mxml_node_s ptr
	child as mxml_node_s ptr
	last_child as mxml_node_s ptr
	value as mxml_value_t
	ref_count as long
	user_data as any ptr
end type

type mxml_node_t as mxml_node_s

type mxml_index_s
	attr as zstring ptr
	num_nodes as long
	alloc_nodes as long
	cur_node as long
	nodes as mxml_node_t ptr ptr
end type

type mxml_index_t as mxml_index_s
type mxml_custom_load_cb_t as function(byval as mxml_node_t ptr, byval as const zstring ptr) as long
type mxml_custom_save_cb_t as function(byval as mxml_node_t ptr) as zstring ptr
type mxml_entity_cb_t as function(byval as const zstring ptr) as long
type mxml_load_cb_t as function(byval as mxml_node_t ptr) as mxml_type_t
type mxml_save_cb_t as function(byval as mxml_node_t ptr, byval as long) as const zstring ptr
type mxml_sax_cb_t as sub(byval as mxml_node_t ptr, byval as mxml_sax_event_t, byval as any ptr)

declare sub mxmlAdd(byval parent as mxml_node_t ptr, byval where as long, byval child as mxml_node_t ptr, byval node as mxml_node_t ptr)
declare sub mxmlDelete(byval node as mxml_node_t ptr)
declare sub mxmlElementDeleteAttr(byval node as mxml_node_t ptr, byval name as const zstring ptr)
declare function mxmlElementGetAttr(byval node as mxml_node_t ptr, byval name as const zstring ptr) as const zstring ptr
declare sub mxmlElementSetAttr(byval node as mxml_node_t ptr, byval name as const zstring ptr, byval value as const zstring ptr)
declare sub mxmlElementSetAttrf(byval node as mxml_node_t ptr, byval name as const zstring ptr, byval format as const zstring ptr, ...)
declare function mxmlEntityAddCallback(byval cb as mxml_entity_cb_t) as long
declare function mxmlEntityGetName(byval val as long) as const zstring ptr
declare function mxmlEntityGetValue(byval name as const zstring ptr) as long
declare sub mxmlEntityRemoveCallback(byval cb as mxml_entity_cb_t)
declare function mxmlFindElement(byval node as mxml_node_t ptr, byval top as mxml_node_t ptr, byval name as const zstring ptr, byval attr as const zstring ptr, byval value as const zstring ptr, byval descend as long) as mxml_node_t ptr
declare function mxmlFindPath(byval node as mxml_node_t ptr, byval path as const zstring ptr) as mxml_node_t ptr
declare function mxmlGetCDATA(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetCustom(byval node as mxml_node_t ptr) as const any ptr
declare function mxmlGetElement(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetFirstChild(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetInteger(byval node as mxml_node_t ptr) as long
declare function mxmlGetLastChild(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetNextSibling(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetOpaque(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetParent(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetPrevSibling(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetReal(byval node as mxml_node_t ptr) as double
declare function mxmlGetRefCount(byval node as mxml_node_t ptr) as long
declare function mxmlGetText(byval node as mxml_node_t ptr, byval whitespace as long ptr) as const zstring ptr
declare function mxmlGetType(byval node as mxml_node_t ptr) as mxml_type_t
declare function mxmlGetUserData(byval node as mxml_node_t ptr) as any ptr
declare sub mxmlIndexDelete(byval ind as mxml_index_t ptr)
declare function mxmlIndexEnum(byval ind as mxml_index_t ptr) as mxml_node_t ptr
declare function mxmlIndexFind(byval ind as mxml_index_t ptr, byval element as const zstring ptr, byval value as const zstring ptr) as mxml_node_t ptr
declare function mxmlIndexGetCount(byval ind as mxml_index_t ptr) as long
declare function mxmlIndexNew(byval node as mxml_node_t ptr, byval element as const zstring ptr, byval attr as const zstring ptr) as mxml_index_t ptr
declare function mxmlIndexReset(byval ind as mxml_index_t ptr) as mxml_node_t ptr
declare function mxmlLoadFd(byval top as mxml_node_t ptr, byval fd as long, byval cb as function(byval as mxml_node_t ptr) as mxml_type_t) as mxml_node_t ptr
declare function mxmlLoadFile(byval top as mxml_node_t ptr, byval fp as FILE ptr, byval cb as function(byval as mxml_node_t ptr) as mxml_type_t) as mxml_node_t ptr
declare function mxmlLoadString(byval top as mxml_node_t ptr, byval s as const zstring ptr, byval cb as function(byval as mxml_node_t ptr) as mxml_type_t) as mxml_node_t ptr
declare function mxmlNewCDATA(byval parent as mxml_node_t ptr, byval string as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewCustom(byval parent as mxml_node_t ptr, byval data as any ptr, byval destroy as mxml_custom_destroy_cb_t) as mxml_node_t ptr
declare function mxmlNewElement(byval parent as mxml_node_t ptr, byval name as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewInteger(byval parent as mxml_node_t ptr, byval integer as long) as mxml_node_t ptr
declare function mxmlNewOpaque(byval parent as mxml_node_t ptr, byval opaque as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewReal(byval parent as mxml_node_t ptr, byval real as double) as mxml_node_t ptr
declare function mxmlNewText(byval parent as mxml_node_t ptr, byval whitespace as long, byval string as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewTextf(byval parent as mxml_node_t ptr, byval whitespace as long, byval format as const zstring ptr, ...) as mxml_node_t ptr
declare function mxmlNewXML(byval version as const zstring ptr) as mxml_node_t ptr
declare function mxmlRelease(byval node as mxml_node_t ptr) as long
declare sub mxmlRemove(byval node as mxml_node_t ptr)
declare function mxmlRetain(byval node as mxml_node_t ptr) as long
declare function mxmlSaveAllocString(byval node as mxml_node_t ptr, byval cb as mxml_save_cb_t) as zstring ptr
declare function mxmlSaveFd(byval node as mxml_node_t ptr, byval fd as long, byval cb as mxml_save_cb_t) as long
declare function mxmlSaveFile(byval node as mxml_node_t ptr, byval fp as FILE ptr, byval cb as mxml_save_cb_t) as long
declare function mxmlSaveString(byval node as mxml_node_t ptr, byval buffer as zstring ptr, byval bufsize as long, byval cb as mxml_save_cb_t) as long
declare function mxmlSAXLoadFd(byval top as mxml_node_t ptr, byval fd as long, byval cb as function(byval as mxml_node_t ptr) as mxml_type_t, byval sax as mxml_sax_cb_t, byval sax_data as any ptr) as mxml_node_t ptr
declare function mxmlSAXLoadFile(byval top as mxml_node_t ptr, byval fp as FILE ptr, byval cb as function(byval as mxml_node_t ptr) as mxml_type_t, byval sax as mxml_sax_cb_t, byval sax_data as any ptr) as mxml_node_t ptr
declare function mxmlSAXLoadString(byval top as mxml_node_t ptr, byval s as const zstring ptr, byval cb as function(byval as mxml_node_t ptr) as mxml_type_t, byval sax as mxml_sax_cb_t, byval sax_data as any ptr) as mxml_node_t ptr
declare function mxmlSetCDATA(byval node as mxml_node_t ptr, byval data as const zstring ptr) as long
declare function mxmlSetCustom(byval node as mxml_node_t ptr, byval data as any ptr, byval destroy as mxml_custom_destroy_cb_t) as long
declare sub mxmlSetCustomHandlers(byval load as mxml_custom_load_cb_t, byval save as mxml_custom_save_cb_t)
declare function mxmlSetElement(byval node as mxml_node_t ptr, byval name as const zstring ptr) as long
declare sub mxmlSetErrorCallback(byval cb as mxml_error_cb_t)
declare function mxmlSetInteger(byval node as mxml_node_t ptr, byval integer as long) as long
declare function mxmlSetOpaque(byval node as mxml_node_t ptr, byval opaque as const zstring ptr) as long
declare function mxmlSetReal(byval node as mxml_node_t ptr, byval real as double) as long
declare function mxmlSetText(byval node as mxml_node_t ptr, byval whitespace as long, byval string as const zstring ptr) as long
declare function mxmlSetTextf(byval node as mxml_node_t ptr, byval whitespace as long, byval format as const zstring ptr, ...) as long
declare function mxmlSetUserData(byval node as mxml_node_t ptr, byval data as any ptr) as long
declare sub mxmlSetWrapMargin(byval column as long)
declare function mxmlWalkNext(byval node as mxml_node_t ptr, byval top as mxml_node_t ptr, byval descend as long) as mxml_node_t ptr
declare function mxmlWalkPrev(byval node as mxml_node_t ptr, byval top as mxml_node_t ptr, byval descend as long) as mxml_node_t ptr
declare sub mxml_error(byval format as const zstring ptr, ...)
declare function mxml_ignore_cb(byval node as mxml_node_t ptr) as mxml_type_t
declare function MXML_IGNORE_CALLBACK alias "mxml_ignore_cb"(byval node as mxml_node_t ptr) as mxml_type_t
declare function mxml_integer_cb(byval node as mxml_node_t ptr) as mxml_type_t
declare function MXML_INTEGER_CALLBACK alias "mxml_integer_cb"(byval node as mxml_node_t ptr) as mxml_type_t
declare function mxml_opaque_cb(byval node as mxml_node_t ptr) as mxml_type_t
declare function MXML_OPAQUE_CALLBACK alias "mxml_opaque_cb"(byval node as mxml_node_t ptr) as mxml_type_t
declare function mxml_real_cb(byval node as mxml_node_t ptr) as mxml_type_t
declare function MXML_REAL_CALLBACK alias "mxml_real_cb"(byval node as mxml_node_t ptr) as mxml_type_t

end extern
