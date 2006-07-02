#ifndef __CHTTP_BI__
#define __CHTTP_BI__

''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006 Jeffery R. Marshall (coder[at]execulink.com) and
''  the FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


#include once "common.bi"

#include once "CHttpForm.bi"

type CHttp as CHttp_


declare function 	CHttp_New					( _
												  byval _this as CHttp ptr = NULL _
												) as CHttp ptr

declare sub 		CHttp_Delete				( _
												  byval _this as CHttp ptr, _
											  	  byval isstatic as integer = FALSE _
												)
										  
declare function 	CHttp_Post					( _
												  byval _this as CHttp ptr, _
												  byval url as zstring ptr, _
												  byval form as CHttpForm ptr _
												) as string

declare function 	CHttp_GetHandle 			( _
												  byval _this as CHttp ptr _
												) as any ptr

#endif