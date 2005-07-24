''
''
'' mass -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __mass_bi__
#define __mass_bi__

#include once "ode/common.bi"

type dMass
	mass as dReal
	c as dVector4
	I as dMatrix3
end type

declare sub dMassSetZero cdecl alias "dMassSetZero" (byval as dMass ptr)
declare sub dMassSetParameters cdecl alias "dMassSetParameters" (byval as dMass ptr, byval themass as dReal, byval cgx as dReal, byval cgy as dReal, byval cgz as dReal, byval I11 as dReal, byval I22 as dReal, byval I33 as dReal, byval I12 as dReal, byval I13 as dReal, byval I23 as dReal)
declare sub dMassSetSphere cdecl alias "dMassSetSphere" (byval as dMass ptr, byval density as dReal, byval radius as dReal)
declare sub dMassSetSphereTotal cdecl alias "dMassSetSphereTotal" (byval as dMass ptr, byval total_mass as dReal, byval radius as dReal)
declare sub dMassSetCappedCylinder cdecl alias "dMassSetCappedCylinder" (byval as dMass ptr, byval density as dReal, byval direction as integer, byval radius as dReal, byval length as dReal)
declare sub dMassSetCappedCylinderTotal cdecl alias "dMassSetCappedCylinderTotal" (byval as dMass ptr, byval total_mass as dReal, byval direction as integer, byval radius as dReal, byval length as dReal)
declare sub dMassSetCylinder cdecl alias "dMassSetCylinder" (byval as dMass ptr, byval density as dReal, byval direction as integer, byval radius as dReal, byval length as dReal)
declare sub dMassSetCylinderTotal cdecl alias "dMassSetCylinderTotal" (byval as dMass ptr, byval total_mass as dReal, byval direction as integer, byval radius as dReal, byval length as dReal)
declare sub dMassSetBox cdecl alias "dMassSetBox" (byval as dMass ptr, byval density as dReal, byval lx as dReal, byval ly as dReal, byval lz as dReal)
declare sub dMassSetBoxTotal cdecl alias "dMassSetBoxTotal" (byval as dMass ptr, byval total_mass as dReal, byval lx as dReal, byval ly as dReal, byval lz as dReal)
declare sub dMassAdjust cdecl alias "dMassAdjust" (byval as dMass ptr, byval newmass as dReal)
declare sub dMassTranslate cdecl alias "dMassTranslate" (byval as dMass ptr, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dMassRotate cdecl alias "dMassRotate" (byval as dMass ptr, byval R as dMatrix3)
declare sub dMassAdd cdecl alias "dMassAdd" (byval a as dMass ptr, byval b as dMass ptr)


#endif
