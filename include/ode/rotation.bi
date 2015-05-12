#ifndef __ode_rotation_bi__
#define __ode_rotation_bi__

#include once "common.bi"
#include once "compatibility.bi"

declare sub dRSetIdentity      cdecl alias "dRSetIdentity"      (byval R  as dMatrix3 ptr)
declare sub dRFromAxisAndAngle cdecl alias "dRFromAxisAndAngle" (byval R  as dMatrix3 ptr, byval ax as dReal, byval ay as dReal, byval az as dReal, byval angle as dReal)
declare sub dRFromEulerAngles  cdecl alias "dRFromEulerAngles"  (byval R  as dMatrix3 ptr, byval phi as dReal, byval theta as dReal, byval psi as dReal)
declare sub dRFrom2Axes        cdecl alias "dRFrom2Axes"        (byval R  as dMatrix3 ptr, byval ax as dReal, byval ay as dReal, byval az as dReal, byval bx as dReal, byval by as dReal, byval bz as dReal)
declare sub dRFromZAxis        cdecl alias "dRFromZAxis"        (byval R  as dMatrix3 ptr, byval ax as dReal, byval ay as dReal, byval az as dReal)

declare sub dQSetIdentity      cdecl alias "dQSetIdentity"      (byval q  as dQuaternion ptr)
declare sub dQFromAxisAndAngle cdecl alias "dQFromAxisAndAngle" (byval q  as dQuaternion ptr, byval ax as dReal, byval ay as dReal, byval az as dReal, byval angle as dReal)
declare sub dQMultiply0        cdecl alias "dQMultiply0"        (byval qa as dQuaternion, byval qb as dQuaternion, byval qc as dQuaternion)
declare sub dQMultiply1        cdecl alias "dQMultiply1"        (byval qa as dQuaternion, byval qb as dQuaternion, byval qc as dQuaternion)
declare sub dQMultiply2        cdecl alias "dQMultiply2"        (byval qa as dQuaternion, byval qb as dQuaternion, byval qc as dQuaternion)
declare sub dQMultiply3        cdecl alias "dQMultiply3"        (byval qa as dQuaternion, byval qb as dQuaternion, byval qc as dQuaternion)
declare sub dRfromQ            cdecl alias "dRfromQ"            (byval R  as dMatrix3 ptr, byval q as dQuaternion)
declare sub dQfromR            cdecl alias "dQfromR"            (byval q  as dQuaternion ptr, byval R as dMatrix3)
declare sub dDQfromW           cdecl alias "dDQfromW"           (byval dq as dReal ptr, byval w as dVector3, byval q as dQuaternion)

#endif
