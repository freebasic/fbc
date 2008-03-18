''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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


Type DAGCTX
	vertices	as integer
	head		as integer
	tail		as integer
	fhead		as integer
End Type

type DAGINF
	typ			as integer						'' op, var, ... (IR.VREGTYPE)

	op			as integer              		'' operator
	results		as integer
	reslist(0 to 7) as integer					'' results attached

	vreg		as integer						'' when it's not an op, lookup vreg
	realval		as integer
end type

Type DAGVTX
	mark		as integer
	l			as integer
	r			as integer

	inf			as DAGINF

	prv			as integer
	nxt			as integer
End Type

''
''
''
declare Sub 		dagInit				( )
declare function 	dagNewVtx 			( ) as integer
declare Sub 		dagDelVtx			( byval v as integer )
declare sub 		dagTopSort			( )


declare function 	irDagGetLeaf		( byval vreg as integer ) as integer
declare function 	irDagGetNode		( byval op as integer, byval vtx1 as integer, byval vtx2 as integer ) as integer
declare function 	irDagNewLeaf		( byval vreg as integer ) as integer
declare function 	irDagNewNode		( byval op as integer, byval vtx1 as integer, byval vtx2 as integer, byval vr as integer ) as integer
declare sub 		irDagAddResult		( byval v as integer, byval vr as integer )

