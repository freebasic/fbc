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

#if defined(LUA_NOOBJECT) or ((not defined(LUA_NOOBJECT)) and defined(LUA_TNONE))
	extern "C"
#endif

#define __IMLUA_H

#ifdef LUA_NOOBJECT
	declare sub imlua_open()
#endif

#ifdef LUA_TNONE
	declare function imlua_open(byval L as lua_State ptr) as long
	declare function imlua_close(byval L as lua_State ptr) as long
	declare function imlua_open_capture(byval L as lua_State ptr) as long
	declare function imlua_open_process(byval L as lua_State ptr) as long
	declare function imlua_open_fftw(byval L as lua_State ptr) as long
#endif

#if defined(LUA_NOOBJECT) or ((not defined(LUA_NOOBJECT)) and defined(LUA_TNONE))
	end extern
#endif
