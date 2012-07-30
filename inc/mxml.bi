/'
 * "$Id: mxml.h 427 2011-01-03 02:03:29Z mike $"
 *
 * Header file for Mini-XML, a small XML-like file parsing library.
 *
 * Copyright 2003-2011 by Michael R Sweet.
 *
 * These coded instructions, statements, and computer programs are the
 * property of Michael R Sweet and are protected by Federal copyright
 * law.  Distribution and use rights are outlined in the file "COPYING"
 * which should have been included with this file.  If this file is
 * missing or damaged, see the license at:
 *
 *     http://www.minixml.org/
'/

/'
 * Prevent multiple inclusion...
'/

#ifndef _mxml_h_
#  define _mxml_h_
/'
 * Include necessary headers...
'/
#  include once "crt/stdio.bi"
#  include once "crt/stdlib.bi"
#  include once "crt/string.bi"
#  include once "crt/ctype.bi"
#  include once "crt/errno.bi"

#define MXML_VERSION "Mini-XML v2.7"

''pthread library is an external dependency
''only use when libmxml was compiled with 
''pthread support
#inclib "pthread"
#inclib "mxml"


/'
 * Constants...
 '/

#  define MXML_TAB		8	/' Tabs every N columns '/

#  define MXML_NO_CALLBACK	0	/' Don't use a type callback '/
#  define MXML_INTEGER_CALLBACK	@mxml_integer_cb
          /' Treat all data as integers '/
#  define MXML_OPAQUE_CALLBACK	@mxml_opaque_cb
          /' Treat all data as opaque '/
#  define MXML_REAL_CALLBACK	@mxml_real_cb
          /' Treat all data as real numbers '/
#  define MXML_TEXT_CALLBACK	0	/' Treat all data as text '/
#  define MXML_IGNORE_CALLBACK	@mxml_ignore_cb
          /' Ignore all non-element content '/

#  define MXML_NO_PARENT	0	/' No parent for the node '/

#  define MXML_DESCEND		1	/' Descend when finding/walking '/
#  define MXML_NO_DESCEND	0	/' Don't descend when finding/walking '/
#  define MXML_DESCEND_FIRST	-1	/' Descend for first find '/

#  define MXML_WS_BEFORE_OPEN	0	/' Callback for before open tag '/
#  define MXML_WS_AFTER_OPEN	1	/' Callback for after open tag '/
#  define MXML_WS_BEFORE_CLOSE	2	/' Callback for before close tag '/
#  define MXML_WS_AFTER_CLOSE	3	/' Callback for after close tag '/

#  define MXML_ADD_BEFORE	0	/' Add node before specified node '/
#  define MXML_ADD_AFTER	1	/' Add node after specified node '/
#  define MXML_ADD_TO_PARENT	NULL	/' Add node relative to parent '/


/'
 * Data types...
'/

enum mxml_sax_event_t		/'*** SAX event type. ***'/
  MXML_SAX_CDATA,			/' CDATA node '/
  MXML_SAX_COMMENT,			/' Comment node '/
  MXML_SAX_DATA,			/' Data node '/
  MXML_SAX_DIRECTIVE,			/' Processing directive node '/
  MXML_SAX_ELEMENT_CLOSE,		/' Element closed '/
  MXML_SAX_ELEMENT_OPEN			/' Element opened '/
end enum


enum mxml_type_t		/'*** The XML node type. ***'/
  MXML_IGNORE = -1,			/' Ignore/throw away node @since Mini-XML 2.3@ '/
  MXML_ELEMENT,				/' XML element with attributes '/
  MXML_INTEGER,				/' Integer value '/
  MXML_OPAQUE,				/' Opaque string '/
  MXML_REAL,				/' Real value '/
  MXML_TEXT,				/' Text fragment '/
  MXML_CUSTOM				/' Custom data @since Mini-XML 2.1@ '/
end enum

type mxml_custom_destroy_cb_t as sub cdecl(byval as any ptr)
          /'*** Custom data destructor ***'/

type mxml_error_cb_t as sub cdecl(byval as const zstring ptr)
          /'*** Error callback function ***'/

type mxml_attr_t		/'*** An XML element attribute value. @private@ ***'/

  dim name as zstring ptr		  /' Attribute name_ '/
  dim value as zstring ptr    /' Attribute value '/

end type

type mxml_element_t		/'*** An XML element value. @private@ ***'/

  dim name as zstring ptr		      /' Name of element '/
  dim num_attrs as integer	      /' Number of attributes '/
  dim attrs as mxml_attr_t ptr		/' Attributes '/

end type

type mxml_text_t		/'*** An XML text value. @private@ ***'/

  dim whitespace as integer	   /' Leading whitespace? '/
  dim string as zstring ptr	  /' Fragment string '/

end type

type mxml_custom_t		/'*** An XML custom value. @private@ ***'/

  dim data as any ptr		                  /' Pointer to (allocated) custom data '/
  dim destroy as mxml_custom_destroy_cb_t	/' Pointer to destructor function '/

end type

union mxml_value_t		/'*** An XML node value. @private@ ***'/

  dim element as mxml_element_t	/' Element '/
  dim integer as integer	      /' Integer number '/
  dim opaque as zstring ptr	    /' Opaque string '/
  dim real as double		        /' Real number '/
  dim text as mxml_text_t		    /' Text fragment '/
  dim custom as mxml_custom_t		/' Custom data @since Mini-XML 2.1@ '/

end union

type mxml_node_t			/'*** An XML node. @private@ ***'/

  dim type as mxml_type_t   		        /' Node type '/
  dim next as mxml_node_t ptr		        /' Next node under same parent '/
  dim prev as mxml_node_t	ptr		        /' Previous node under same parent '/
  dim parent as mxml_node_t	ptr	        /' Parent node '/
  dim child as mxml_node_t	ptr		      /' First child node '/
  dim last_child as mxml_node_t	ptr	    /' Last child node '/
  dim value as mxml_value_t		          /' Node value '/
  dim ref_count as integer              /' Use count '/
  dim user_data as any ptr              /' User data '/

end type

''typedef struct mxml_node_s mxml_node_t;	/'*** An XML node. ***'/

type mxml_index_t			 /'*** An XML node index. @private@ ***'/

  dim attr as zstring ptr 		        /' Attribute used for indexing or NULL '/
  dim num_nodes as integer	          /' Number of nodes in index '/
  dim alloc_nodes as integer	        /' Allocated nodes in index '/
  dim cur_node as integer            /' Current node '/
  dim nodes as mxml_node_t ptr ptr	/' Node array '/

end type

''typedef struct mxml_index_s mxml_index_t;
          /'*** An XML node index. ***'/

type mxml_custom_load_cb_t as function cdecl(byval as mxml_node_t ptr, byval as const zstring ptr) as integer
          /'*** Custom data load callback function ***'/

type mxml_custom_save_cb_t as function cdecl(byval as mxml_node_t ptr) as zstring ptr
          /'*** Custom data save callback function ***'/

type mxml_entity_cb_t as function cdecl(byval as const zstring ptr) as integer
          /'*** Entity callback function '/

type mxml_load_cb_t as function cdecl(byval as mxml_node_t ptr) as mxml_type_t
          /'*** Load callback function ***'/

type mxml_save_cb_t as function cdecl(byval as mxml_node_t ptr, byval as integer) as const zstring ptr
          /'*** Save callback function ***'/

type mxml_sax_cb_t as sub cdecl(byval as mxml_node_t ptr, byval as mxml_sax_event_t, byval as any ptr)
          /'*** SAX callback function ***'/


extern "C"

/'
 * Prototypes...
'/

declare sub mxmlAdd(byval parent as mxml_node_t ptr, byval where as integer,_
              byval child as mxml_node_t ptr, byval node as mxml_node_t ptr)
declare sub mxmlDelete(byval node as mxml_node_t ptr)
declare sub mxmlElementDeleteAttr(byval node as mxml_node_t ptr,_
                                  byval name_ as const zstring ptr)
declare function mxmlElementGetAttr(byval node as mxml_node_t ptr, byval name_ as const zstring ptr) as const zstring ptr
declare sub mxmlElementSetAttr(byval node as mxml_node_t ptr, byval name_ as const zstring ptr,_
                               byval value as const zstring ptr)
declare sub mxmlElementSetAttrf(byval node as mxml_node_t ptr, byval name_ as const zstring ptr,_
                          byval format_ as const zstring ptr,...)

declare function mxmlEntityAddCallback(byval cb as mxml_entity_cb_t) as integer
declare function mxmlEntityGetName(byval val_ as integer) as const zstring ptr
declare function mxmlEntityGetValue(byval name_ as const zstring ptr) as integer
declare sub mxmlEntityRemoveCallback(byval cb as mxml_entity_cb_t)
declare function mxmlFindElement(byval node as mxml_node_t ptr, byval top as mxml_node_t ptr,_
                       byval name_ as const zstring ptr, byval attr as const zstring ptr,_
           byval value as const zstring ptr, byval descend as integer) as mxml_node_t ptr
declare function mxmlFindPath(byval node as mxml_node_t ptr, byval path as const zstring ptr) as mxml_node_t ptr
declare function mxmlGetCDATA(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetCustom(byval node as mxml_node_t ptr) as const any ptr
declare function mxmlGetElement(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetFirstChild(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetInteger(byval node as mxml_node_t ptr) as integer
declare function mxmlGetLastChild(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetNextSibling(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetOpaque(byval node as mxml_node_t ptr) as const zstring ptr
declare function mxmlGetParent(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetPrevSibling(byval node as mxml_node_t ptr) as mxml_node_t ptr
declare function mxmlGetReal(byval node as mxml_node_t ptr) as double
declare function mxmlGetRefCount(byval node as mxml_node_t ptr) as integer
declare function mxmlGetText(byval node as mxml_node_t ptr, byval whitespace as integer ptr) as const zstring ptr
declare function mxmlGetType(byval node as mxml_node_t ptr) as mxml_type_t
declare function mxmlGetUserData(byval node as mxml_node_t ptr) as any ptr
declare sub mxmlIndexDelete(byval ind as mxml_index_t ptr)
declare function mxmlIndexEnum(byval ind as mxml_index_t ptr) as mxml_node_t ptr
declare function mxmlIndexFind(byval ind as mxml_index_t ptr,_
                     byval element as const zstring ptr,_
                     byval value as const zstring ptr) as mxml_node_t ptr
declare function mxmlIndexGetCount(byval ind as mxml_index_t ptr) as integer
declare function mxmlIndexNew(byval node as mxml_node_t ptr,_
                              byval element as const zstring ptr,_
                              byval attr as const zstring ptr) as mxml_index_t ptr
declare function mxmlIndexReset(byval ind as mxml_index_t ptr) as mxml_node_t ptr
declare function mxmlLoadFd(byval top as mxml_node_t ptr, _
                            byval fd as integer,_
                            byval cb as function cdecl (byval as mxml_node_t ptr) as mxml_type_t ) as mxml_node_t ptr
declare function mxmlLoadFile(byval top as mxml_node_t ptr,_
                              byval fp as FILE ptr,_
                              byval cb as function cdecl (byval as mxml_node_t ptr) as mxml_type_t ) as mxml_node_t ptr
declare function mxmlLoadString(byval top as mxml_node_t ptr,_ 
                                byval s as const zstring ptr,_
                                byval cb as function cdecl (byval as mxml_node_t ptr) as mxml_type_t ) as mxml_node_t ptr
declare function mxmlNewCDATA(byval parent as mxml_node_t ptr, byval string_ as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewCustom(byval parent as mxml_node_t ptr, byval data_ as any ptr,_
                               byval destroy as mxml_custom_destroy_cb_t) as mxml_node_t ptr
declare function mxmlNewElement(byval parent as mxml_node_t ptr, byval name_ as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewInteger(byval parent as mxml_node_t ptr, byval int as integer) as mxml_node_t ptr
declare function mxmlNewOpaque(byval parent as mxml_node_t ptr, byval opaque as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewReal(byval parent as mxml_node_t ptr, byval real as double) as mxml_node_t ptr
declare function mxmlNewText(byval parent as mxml_node_t ptr, byval whitespace as integer,_
                   byval string_ as const zstring ptr) as mxml_node_t ptr
declare function mxmlNewTextf(byval parent as mxml_node_t ptr, byval whitespace as integer,_
                              byval format_ as const zstring ptr, ...)  as mxml_node_t ptr

declare function mxmlNewXML(byval version as const zstring ptr) as mxml_node_t ptr
declare function mxmlRelease(byval node as mxml_node_t ptr) as integer
declare sub mxmlRemove(byval node as mxml_node_t ptr)
declare function mxmlRetain(byval node as mxml_node_t ptr) as integer
declare function mxmlSaveAllocString(byval node as mxml_node_t ptr,_
                                     byval cb as mxml_save_cb_t) as zstring ptr
declare function mxmlSaveFd(byval node as mxml_node_t ptr, byval fd as integer,_
                            byval cb as mxml_save_cb_t) as integer
declare function mxmlSaveFile(byval node as mxml_node_t ptr, byval fp as FILE ptr,_
                              byval cb as mxml_save_cb_t) as integer
declare function	mxmlSaveString(byval node as mxml_node_t ptr, byval buffer as zstring ptr,_
                                 byval bufsize as integer, byval cb as mxml_save_cb_t) as integer
declare function		mxmlSAXLoadFd(byval top as mxml_node_t ptr,_
                                  byval fd as integer,_
                                  byval cb as function cdecl (byval as mxml_node_t ptr) as mxml_type_t,_
                                  byval sax as mxml_sax_cb_t, byval sax_data as any ptr) as mxml_node_t ptr
declare function		mxmlSAXLoadFile(byval top as mxml_node_t ptr, byval fp as FILE ptr,_
                                    byval cb as function cdecl (byval as mxml_node_t ptr) as mxml_type_t,_
                                    byval sax as mxml_sax_cb_t, byval sax_data as any ptr) as mxml_node_t ptr
declare function		mxmlSAXLoadString(byval top as mxml_node_t ptr,_
                                      byval s as const zstring ptr,_
                                      byval cb as function cdecl (byval as mxml_node_t ptr) as mxml_type_t,_
                                      byval sax as mxml_sax_cb_t, byval sax_data as any ptr) as mxml_node_t ptr
declare function		mxmlSetCDATA(byval node as mxml_node_t ptr, byval data_ as const zstring ptr) as integer
declare function		mxmlSetCustom(byval node as mxml_node_t ptr, byval data_ as any ptr,_
                                  byval destroy as mxml_custom_destroy_cb_t)as integer
declare sub         mxmlSetCustomHandlers(byval load_ as mxml_custom_load_cb_t,_
                                          byval save_ as mxml_custom_save_cb_t)
declare function		mxmlSetElement(byval node as mxml_node_t ptr, byval name_ as const zstring ptr) as integer
declare sub mxmlSetErrorCallback(byval cb as mxml_error_cb_t)
declare function		mxmlSetInteger(byval node as mxml_node_t ptr, byval int as integer) as integer
declare function		mxmlSetOpaque(byval node as mxml_node_t ptr, byval opaque as const zstring ptr) as integer
declare function		mxmlSetReal(byval node as mxml_node_t ptr, byval real as double) as integer
declare function		mxmlSetText(byval node as mxml_node_t ptr, byval whitespace as integer,_
                                byval string_ as const zstring ptr) as integer
declare function		mxmlSetTextf(byval node as mxml_node_t ptr, byval whitespace as integer,_
                                 byval format_ as const zstring ptr, ...) as integer

declare function mxmlSetUserData(byval node as mxml_node_t ptr, byval data_ as any ptr) as integer
declare sub mxmlSetWrapMargin(byval column as integer)
declare function mxmlWalkNext(byval node as mxml_node_t ptr, byval top as mxml_node_t ptr,_
                              byval descend as integer) as mxml_node_t ptr
declare function mxmlWalkPrev(byval node as mxml_node_t ptr, byval top as mxml_node_t ptr,_
                              byval descend as integer) as mxml_node_t ptr


/'
 * Semi-private functions...
 '/

declare sub mxml_error(byval format_ as const zstring ptr, ...)
declare function mxml_ignore_cb(byval node as mxml_node_t ptr) as mxml_type_t	
declare function mxml_integer_cb(byval node as mxml_node_t ptr) as mxml_type_t
declare function mxml_opaque_cb(byval node as mxml_node_t ptr) as mxml_type_t
declare function mxml_real_cb(byval node as mxml_node_t ptr) as mxml_type_t

end extern

#endif /' !_mxml_h_ '/


/'
 * End of "$Id: mxml.h 427 2011-01-03 02:03:29Z mike $".
 '/
