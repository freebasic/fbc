'' FreeBASIC binding for im-3.9.1
''
'' based on the C header files:
''   Copyright (C) 1994-2014 Tecgraf, PUC-Rio.                                
''                                                                            
''   Permission is hereby granted, free of charge, to any person obtaining    
''   a copy of this software and associated documentation files (the          
''   "Software"), to deal in the Software without restriction, including      
''   without limitation the rights to use, copy, modify, merge, publish,      
''   distribute, sublicense, and/or sell copies of the Software, and to       
''   permit persons to whom the Software is furnished to do so, subject to    
''   the following conditions:                                                
''                                                                            
''   The above copyright notice and this permission notice shall be           
''   included in all copies or substantial portions of the Software.          
''                                                                            
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,          
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF       
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY     
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,     
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE        
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                   
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "C"

#define __IM_ATTRIB_FLAT_H_
type imAttribTableCallback as function(byval user_data as any ptr, byval index as long, byval name as const zstring ptr, byval data_type as long, byval count as long, byval data as const any ptr) as long
type imAttribTablePrivate as imAttribTablePrivate_
declare function imAttribTableCreate(byval hash_size as long) as imAttribTablePrivate ptr
declare sub imAttribTableDestroy(byval ptable as imAttribTablePrivate ptr)
declare function imAttribTableCount(byval ptable as imAttribTablePrivate ptr) as long
declare sub imAttribTableRemoveAll(byval ptable as imAttribTablePrivate ptr)
declare function imAttribTableGet(byval ptable as const imAttribTablePrivate ptr, byval name as const zstring ptr, byval data_type as long ptr, byval count as long ptr) as const any ptr
declare function imAttribTableGetInteger(byval ptable as imAttribTablePrivate ptr, byval name as const zstring ptr, byval index as long) as long
declare function imAttribTableGetReal(byval ptable as imAttribTablePrivate ptr, byval name as const zstring ptr, byval index as long) as double
declare function imAttribTableGetString(byval ptable as imAttribTablePrivate ptr, byval name as const zstring ptr) as const zstring ptr
declare sub imAttribTableSet(byval ptable as imAttribTablePrivate ptr, byval name as const zstring ptr, byval data_type as long, byval count as long, byval data as const any ptr)
declare sub imAttribTableSetInteger(byval ptable as imAttribTablePrivate ptr, byval name as const zstring ptr, byval data_type as long, byval value as long)
declare sub imAttribTableSetReal(byval ptable as imAttribTablePrivate ptr, byval name as const zstring ptr, byval data_type as long, byval value as double)
declare sub imAttribTableSetString(byval ptable as imAttribTablePrivate ptr, byval name as const zstring ptr, byval value as const zstring ptr)
declare sub imAttribTableUnSet(byval ptable as imAttribTablePrivate ptr, byval name as const zstring ptr)
declare sub imAttribTableCopyFrom(byval ptable_dst as imAttribTablePrivate ptr, byval ptable_src as const imAttribTablePrivate ptr)
declare sub imAttribTableMergeFrom(byval ptable_dst as imAttribTablePrivate ptr, byval ptable_src as const imAttribTablePrivate ptr)
declare sub imAttribTableForEach(byval ptable as const imAttribTablePrivate ptr, byval user_data as any ptr, byval attrib_func as imAttribTableCallback)
declare function imAttribArrayCreate(byval hash_size as long) as imAttribTablePrivate ptr
declare function imAttribArrayGet(byval ptable as const imAttribTablePrivate ptr, byval index as long, byval name as zstring ptr, byval data_type as long ptr, byval count as long ptr) as const any ptr
declare sub imAttribArraySet(byval ptable as imAttribTablePrivate ptr, byval index as long, byval name as const zstring ptr, byval data_type as long, byval count as long, byval data as const any ptr)
declare sub imAttribArrayCopyFrom(byval ptable_dst as imAttribTablePrivate ptr, byval ptable_src as const imAttribTablePrivate ptr)

end extern
