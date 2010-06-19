#ifndef __FB_OBJ_BI__
#define __FB_OBJ_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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

'' callbcks used when scanning object files for libraries
type FB_CALLBACK_ADDLIB as sub _
	( _
		byval libName as zstring ptr, _
		byval objName as zstring ptr _
	)

type FB_CALLBACK_ADDLIBPATH as sub _
	( _
		byval pathName as zstring ptr, _
		byval objName as zstring ptr _
	)

type FB_CALLBACK_ADDOPTION as sub _
	( _
		byval opt as FB_COMPOPT, _
		byval value as zstring ptr, _
		byval objName as zstring ptr _
	)

declare function fbObjInfoWriteObj _
	( _
		byval liblist as TLIST ptr, _
		byval libpathlist as TLIST ptr _
	) as integer

declare function fbObjInfoReadObj _
	( _
		byval objName as zstring ptr, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	) as integer

declare function fbObjInfoReadLib _
	( _
		byval libName as zstring ptr, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION, _
		byval libpathlist as TLIST ptr _
	) as integer

#endif '' __FB_OBJ_BI__
