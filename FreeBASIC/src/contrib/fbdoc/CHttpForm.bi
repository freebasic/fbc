#ifndef __CHTTPFORM_BI__
#define __CHTTPFORM_BI__

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

type CHttpForm as CHttpForm_


declare function 	CHttpForm_New				( _
												  byval _this as CHttpForm ptr = NULL _
												) as CHttpForm ptr

declare sub 		CHttpForm_Delete			( _
												  byval _this as CHttpForm ptr, _
											  	  byval isstatic as integer = FALSE _
											  	)
											  	  
'' FIXME: Was overload - won't work with June 8 2006 CVS build
declare function 	CHttpForm_Add4 ( _
												  byval _this as CHttpForm ptr, _
												  byval name_ as zstring ptr, _
												  byval value as zstring ptr, _
												  byval _type as zstring ptr = NULL _
												) as integer

declare function 	CHttpForm_Add3 				( _
												  byval _this as CHttpForm ptr, _
												  byval name_ as zstring ptr, _
												  byval value as integer _
												) as integer

declare function 	CHttpForm_GetHandle 		( _
												  byval _this as CHttpForm ptr _
												) as any ptr

#endif