#ifndef __CHTTPSTREAM_BI__
#define __CHTTPSTREAM_BI__

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

type CHttpStream as CHttpStream_


declare function 	CHttpStream_New				( _
												  byval http as CHttp ptr = NULL, _
												  byval _this as CHttpStream ptr = NULL _
												) as CHttpStream ptr

declare sub 		CHttpStream_Delete			( _
												  byval _this as CHttpStream ptr, _
											  	  byval isstatic as integer = FALSE _
												)
										  
declare function 	CHttpStream_Receive 		( _
												  byval _this as CHttpStream ptr, _
												  byval url as zstring ptr, _
												  byval doreset as integer = FALSE _
											    ) as integer


declare function 	CHttpStream_Read 			( _
												  byval _this as CHttpStream ptr _
												) as string

declare function 	CHttpStream_Send 			( _
												  byval _this as CHttpStream ptr, _
												  byval url as zstring ptr, _
												  byval data_ as any ptr, _
												  byval bytes as integer, _
												  byval doreset as integer = FALSE _
											    ) as integer

#endif