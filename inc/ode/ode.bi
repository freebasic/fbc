' This is file ode.bi
' (FreeBasic binding for ODE library version 0.11.1)
'
' translated with help of h_2_bi.bas by
' Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net.
'
' Licence:
' (C) 2011-2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
'
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
' Original license text:
'/*************************************************************************
 '*                                                                       *
 '* Open Dynamics Engine, Copyright (C) 2001,2002 Russell L. Smith.       *
 '* All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 '*                                                                       *
 '* This library is free software; you can redistribute it and/or         *
 '* modify it under the terms of EITHER:                                  *
 '*   (1) The GNU Lesser General Public License as published by the Free  *
 '*       Software Foundation; either version 2.1 of the License, or (at  *
 '*       your option) any later version. The text of the GNU Lesser      *
 '*       General Public License is included with this library in the     *
 '*       file LICENSE.TXT.                                               *
 '*   (2) The BSD-style license that is included with this library in     *
 '*       the file LICENSE-BSD.TXT.                                       *
 '*                                                                       *
 '* This library is distributed in the hope that it will be useful,       *
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the files    *
 '* LICENSE.TXT and LICENSE-BSD.TXT for more details.                     *
 '*                                                                       *
 '*************************************************************************/

#INCLUDE ONCE "ode_config.bi"

#IFDEF __FB_UNIX__

#INCLIB "ode"

#ELSEIF DEFINED(__FB_WIN32__)

#PRAGMA push(msbitfields)
#IFDEF dSINGLE
#INCLIB "ode_single"
#ELSE
#INCLIB "ode_double"
#ENDIF

#ELSE

#ERROR Platform not supported

#ENDIF

EXTERN "C" ' (h_2_bi -P_oCD option)

#IFNDEF _ODE_ODE_H_
#DEFINE _ODE_ODE_H_

#IFNDEF _ODE_COMPATIBILITY_H_
#DEFINE _ODE_COMPATIBILITY_H_
#DEFINE dQtoR(q,R) dRfromQ((R),(q))
#DEFINE dRtoQ(R,q) dQfromR((q),(R))
#DEFINE dWtoDQ(w,q,dq) dDQfromW((dq),(w),(q))
#ENDIF ' _ODE_COMPATIBILITY_H_

#IFNDEF _ODE_COMMON_H_
#DEFINE _ODE_COMMON_H_

#IFNDEF _ODE_ERROR_H_
#DEFINE _ODE_ERROR_H_

TYPE dMessageFunction AS SUB(BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS va_list)

DECLARE SUB dSetErrorHandler(BYVAL AS dMessageFunction)
DECLARE SUB dSetDebugHandler(BYVAL AS dMessageFunction)
DECLARE SUB dSetMessageHandler(BYVAL AS dMessageFunction)
DECLARE FUNCTION dGetErrorHandler() AS dMessageFunction
DECLARE FUNCTION dGetDebugHandler() AS dMessageFunction
DECLARE FUNCTION dGetMessageHandler() AS dMessageFunction
DECLARE SUB dError(BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, ...)
DECLARE SUB dDebug(BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, ...)
DECLARE SUB dMessage(BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, ...)

#ENDIF ' _ODE_ERROR_H_

#IFNDEF M_PI
#DEFINE M_PI REAL(3.1415926535897932384626433832795029)
#ENDIF ' M_PI

#IFNDEF M_SQRT1_2
#DEFINE M_SQRT1_2 REAL(0.7071067811865475244008443621048490)
#ENDIF ' M_SQRT1_2

#IFNDEF dNODEBUG

#DEFINE dIASSERT(a) IF 0 = (a) THEN dDebug (d_ERR_IASSERT, _
       !"assertion \"" & #a & !"\" failed in %s() [%s]",__FUNCTION__,__FILE__)
#DEFINE dUASSERT(a,msg) IF 0 = (a) THEN dDebug (d_ERR_UASSERT, _
       msg & !" in %s()", __FUNCTION__)
#DEFINE dDEBUGMSG(msg) dMessage (d_ERR_UASSERT, _
       msg & !" in %s() File %s Line %d", __FUNCTION__, __FILE__,__LINE__)

#ELSE ' dNODEBUG

#DEFINE dIASSERT(a)
#DEFINE dUASSERT(a,msg)
#DEFINE dDEBUGMSG(msg)

#ENDIF ' dNODEBUG

#DEFINE dAASSERT(a) dUASSERT(a,!"Bad argument(s)")
#DEFINE dVARIABLEUSED(a) (CAST(ANY PTR, a))

#IF DEFINED(dSINGLE)

TYPE dReal AS SINGLE

#IFDEF dDOUBLE
#ERROR You can only #DEFINE dSINGLE or dDOUBLE, not both.
#ENDIF ' dDOUBLE

#ELSEIF DEFINED(dDOUBLE)

TYPE dReal AS DOUBLE

#ELSE ' DEFINED(dSINGLE...

#ERROR You must #DEFINE dSINGLE or dDOUBLE

#ENDIF ' DEFINED(dSINGLE...

#IF dTRIMESH_ENABLED
#IF dTRIMESH_OPCODE AND dTRIMESH_GIMPACT
#ERROR You can only #DEFINE dTRIMESH_OPCODE or dTRIMESH_GIMPACT, not both.
#ENDIF ' dTRIMESH_OPCODE...
#ENDIF ' dTRIMESH_ENABLE...

#IF dTRIMESH_16BIT_INDICES
#IF dTRIMESH_GIMPACT

TYPE dTriIndex AS uint32

#ELSE ' dTRIMESH_GIMPAC...

TYPE dTriIndex AS uint16

#ENDIF ' dTRIMESH_GIMPAC...
#ELSE ' dTRIMESH_16BIT_...

TYPE dTriIndex AS uint32

#ENDIF ' dTRIMESH_16BIT_...

#DEFINE dPAD(a) IIF(((a) > 1) , ((((a)-1) OR 3)+1) , (a))

TYPE dVector3
  AS dReal x(3)
END TYPE
TYPE dVector4
  AS dReal x(3)
END TYPE
TYPE dMatrix3
  AS dReal x(2,3)
END TYPE
TYPE dMatrix4
  AS dReal x(3,3)
END TYPE
TYPE dMatrix6
  AS dReal x(5,7)
END TYPE
TYPE dQuaternion
  AS dReal x(3)
END TYPE

#IF DEFINED(dSINGLE)
#DEFINE REAL(x) (x##f)
#DEFINE dRecip(x) ((1.0f/(x)))
#DEFINE dSqrt(x) (sqrtf(x))
#DEFINE dRecipSqrt(x) ((1.0f/sqrtf(x)))
#DEFINE dSin(x) (sinf(x))
#DEFINE dCos(x) (cosf(x))
#DEFINE dFabs(x) (fabsf(x))
#DEFINE dAtan2(y,x) (atan2f(y,x))
#DEFINE dFMod(a,b) (fmodf(a,b))
#DEFINE dFloor(x) floorf(x)

' moved to ode_config.bi:
' #DEFINE dIsNan(_V_)

#DEFINE dCopySign(a,b) (CAST(dReal, copysignf(a,b)))

#ELSEIF DEFINED(dDOUBLE)

#DEFINE REAL(x) (x)
#DEFINE dRecip(x) (1.0/(x))
#DEFINE dSqrt(x) sqrt(x)
#DEFINE dRecipSqrt(x) (1.0/sqrt(x))
#DEFINE dSin(x) SIN(x)
#DEFINE dCos(x) COS(x)
#DEFINE dFabs(x) fabs(x)
#DEFINE dAtan2(y,x) ATAN2((y),(x))
#DEFINE dFMod(a,b) (fmod((a),(b)))
#DEFINE dFloor(x) floor(x)

' moved to ode_config.bi:
' #DEFINE dIsNan(_V_)

#DEFINE dCopySign(a,b) (copysign((a),(b)))

#ELSE ' DEFINED(dSINGLE...

#ERROR You must #DEFINE dSINGLE or dDOUBLE

#ENDIF ' DEFINED(dSINGLE...

TYPE dxWorld AS dxWorld_
TYPE dxSpace AS dxSpace_
TYPE dxBody AS dxBody_
TYPE dxGeom AS dxGeom_
TYPE dxJoint AS dxJoint_
TYPE dxJointNode AS dxJointNode_
TYPE dxJointGroup AS dxJointGroup_
TYPE dWorldID AS dxWorld PTR
TYPE dSpaceID AS dxSpace PTR
TYPE dBodyID AS dxBody PTR
TYPE dGeomID AS dxGeom PTR
TYPE dJointID AS dxJoint PTR
TYPE dJointGroupID AS dxJointGroup PTR

ENUM
  d_ERR_UNKNOWN = 0
  d_ERR_IASSERT
  d_ERR_UASSERT
  d_ERR_LCP
END ENUM

ENUM dJointType
  dJointTypeNone = 0
  dJointTypeBall
  dJointTypeHinge
  dJointTypeSlider
  dJointTypeContact
  dJointTypeUniversal
  dJointTypeHinge2
  dJointTypeFixed
  dJointTypeNull
  dJointTypeAMotor
  dJointTypeLMotor
  dJointTypePlane2D
  dJointTypePR
  dJointTypePU
  dJointTypePiston
END ENUM

#MACRO D_ALL_PARAM_NAMES(start)
  dParamLoStop = start,

  dParamHiStop,
  dParamVel,
  dParamFMax,
  dParamFudgeFactor,
  dParamBounce,
  dParamCFM,
  dParamStopERP,
  dParamStopCFM,

  dParamSuspensionERP,
  dParamSuspensionCFM,
  dParamERP,
#ENDMACRO

#MACRO D_ALL_PARAM_NAMES_X(start,x)
  dParamGroup##x = start,

  dParamLoStop##x = start,
  dParamHiStop##x,
  dParamVel##x,
  dParamFMax##x,
  dParamFudgeFactor##x,
  dParamBounce##x,
  dParamCFM##x,
  dParamStopERP##x,
  dParamStopCFM##x,

  dParamSuspensionERP##x,
  dParamSuspensionCFM##x,
  dParamERP##x,
#ENDMACRO

ENUM
  D_ALL_PARAM_NAMES(0)
  dParamsInGroup
  D_ALL_PARAM_NAMES_X(&h000, 1)
  D_ALL_PARAM_NAMES_X(&h100, 2)
  D_ALL_PARAM_NAMES_X(&h200, 3)
  dParamGroup = &h100
END ENUM

ENUM
  dAMotorUser = 0
  dAMotorEuler = 1
END ENUM

TYPE dJointFeedback
  AS dVector3 f1
  AS dVector3 t1
  AS dVector3 f2
  AS dVector3 t2
END TYPE

DECLARE SUB dGeomMoved(BYVAL AS dGeomID)
DECLARE FUNCTION dGeomGetBodyNext(BYVAL AS dGeomID) AS dGeomID
DECLARE FUNCTION dGetConfiguration() AS CONST ZSTRING PTR
DECLARE FUNCTION dCheckConfiguration(BYVAL AS CONST ZSTRING PTR) AS INTEGER

#ENDIF ' _ODE_COMMON_H_

#IFNDEF _ODE_ODEINIT_H_
#DEFINE _ODE_ODEINIT_H_

ENUM dInitODEFlags
  dInitFlagManualThreadCleanup = &h00000001
END ENUM

DECLARE SUB dInitODE()
DECLARE FUNCTION dInitODE2(BYVAL AS UINTEGER) AS INTEGER

ENUM dAllocateODEDataFlags
  dAllocateFlagBasicData = 0
  dAllocateFlagCollisionData = &h00000001
  dAllocateMaskAll = NOT 0U
END ENUM

DECLARE FUNCTION dAllocateODEDataForThread(BYVAL AS UINTEGER) AS INTEGER
DECLARE SUB dCleanupODEAllDataForThread()
DECLARE SUB dCloseODE()

#ENDIF ' _ODE_ODEINIT_H_

#IFNDEF _ODE_CONTACT_H_
#DEFINE _ODE_CONTACT_H_

ENUM
  dContactMu2 = &h001
  dContactFDir1 = &h002
  dContactBounce = &h004
  dContactSoftERP = &h008
  dContactSoftCFM = &h010
  dContactMotion1 = &h020
  dContactMotion2 = &h040
  dContactMotionN = &h080
  dContactSlip1 = &h100
  dContactSlip2 = &h200
  dContactApprox0 = &h0000
  dContactApprox1_1 = &h1000
  dContactApprox1_2 = &h2000
  dContactApprox1 = &h3000
END ENUM

TYPE dSurfaceParameters
  AS INTEGER mode
  AS dReal mu
  AS dReal mu2
  AS dReal bounce
  AS dReal bounce_vel
  AS dReal soft_erp
  AS dReal soft_cfm
  AS dReal motion1, motion2, motionN
  AS dReal slip1, slip2
END TYPE

TYPE dContactGeom
  AS dVector3 pos
  AS dVector3 normal
  AS dReal depth
  AS dGeomID g1, g2
  AS INTEGER side1, side2
END TYPE

TYPE dContact
  AS dSurfaceParameters surface
  AS dContactGeom geom
  AS dVector3 fdir1
END TYPE

#ENDIF ' _ODE_CONTACT_H_

#IFNDEF _ODE_MEMORY_H_
#DEFINE _ODE_MEMORY_H_

TYPE dAllocFunction AS FUNCTION(BYVAL AS size_t) AS ANY PTR
TYPE dReallocFunction AS FUNCTION(BYVAL AS ANY PTR, BYVAL AS size_t, BYVAL AS size_t) AS ANY PTR
TYPE dFreeFunction AS SUB(BYVAL AS ANY PTR, BYVAL AS size_t)

DECLARE SUB dSetAllocHandler(BYVAL AS dAllocFunction)
DECLARE SUB dSetReallocHandler(BYVAL AS dReallocFunction)
DECLARE SUB dSetFreeHandler(BYVAL AS dFreeFunction)
DECLARE FUNCTION dGetAllocHandler() AS dAllocFunction
DECLARE FUNCTION dGetReallocHandler() AS dReallocFunction
DECLARE FUNCTION dGetFreeHandler() AS dFreeFunction
DECLARE FUNCTION dAlloc(BYVAL AS size_t) AS ANY PTR
DECLARE FUNCTION dRealloc(BYVAL AS ANY PTR, BYVAL AS size_t, BYVAL AS size_t) AS ANY PTR
DECLARE SUB dFree(BYVAL AS ANY PTR, BYVAL AS size_t)

#ENDIF ' _ODE_MEMORY_H_

#IFNDEF _ODE_ODEMATH_H_
#DEFINE _ODE_ODEMATH_H_

#IFDEF __GNUC__
#DEFINE PURE_INLINE extern inline
#ELSE ' __GNUC__
#DEFINE PURE_INLINE inline
#ENDIF ' __GNUC__

#DEFINE dACCESS33(A,i,j) ((A)[(i)*4+(j)])
#DEFINE dVALIDVEC3(v) IIF(dIsNan(v[0]) ORELSE dIsNan(v[1]) ORELSE dIsNan(v[2]), 0, 1)
#DEFINE dVALIDVEC4(v) IIF(dIsNan(v[0]) ORELSE dIsNan(v[1]) ORELSE dIsNan(v[2]) ORELSE dIsNan(v[3]), 0, 1)
#DEFINE dVALIDMAT3(m) IIF(dIsNan(m[0]) ORELSE dIsNan(m[1]) ORELSE dIsNan(m[2]) ORELSE dIsNan(m[3]) ORELSE dIsNan(m[4]) ORELSE dIsNan(m[5]) ORELSE dIsNan(m[6]) ORELSE dIsNan(m[7]) ORELSE dIsNan(m[8]) ORELSE dIsNan(m[9]) ORELSE dIsNan(m[10]) ORELSE dIsNan(m[11]), 0, 1)
#DEFINE dVALIDMAT4(m) IIF(dIsNan(m[0]) ORELSE dIsNan(m[1]) ORELSE dIsNan(m[2]) ORELSE dIsNan(m[3]) ORELSE dIsNan(m[4]) ORELSE dIsNan(m[5]) ORELSE dIsNan(m[6]) ORELSE dIsNan(m[7]) ORELSE dIsNan(m[8]) ORELSE dIsNan(m[9]) ORELSE dIsNan(m[10]) ORELSE dIsNan(m[11]) ORELSE dIsNan(m[12]) ORELSE dIsNan(m[13]) ORELSE dIsNan(m[14]) ORELSE dIsNan(m[15]), 0, 1)

#DEFINE dOP(a,op,b,c) _
    (a)[0] = ((b)[0]) op ((c)[0]) : _
    (a)[1] = ((b)[1]) op ((c)[1]) : _
    (a)[2] = ((b)[2]) op ((c)[2])
#DEFINE dOPC(a,op,b,c) _
    (a)[0] = ((b)[0]) op (c) : _
    (a)[1] = ((b)[1]) op (c) : _
    (a)[2] = ((b)[2]) op (c)
#DEFINE dOPE(a,op,b) _
    (a)[0] op ((b)[0]) : _
    (a)[1] op ((b)[1]) : _
    (a)[2] op ((b)[2])
#DEFINE dOPEC(a,op,c) _
    (a)[0] op (c) : _
    (a)[1] op (c) : _
    (a)[2] op (c)
#DEFINE dOPE2(a,op1,b,op2,c) _
    (a)[0] op1 ((b)[0]) op2 ((c)[0]) : _
    (a)[1] op1 ((b)[1]) op2 ((c)[1]) : _
    (a)[2] op1 ((b)[2]) op2 ((c)[2])

#DEFINE dLENGTHSQUARED(a) (((a)[0])*((a)[0]) + ((a)[1])*((a)[1]) + ((a)[2])*((a)[2]))
#DEFINE dLENGTH(a) ( dSqrt( dLENGTHSQUARED(a)))
#DEFINE dDOTpq(a,b,p,q) ((a)[0]*(b)[0] + (a)[p]*(b)[q] + (a)[2*(p)]*(b)[2*(q)])

#DEFINE dDOT(a,b) dDOTpq(a,b,1,1)
#DEFINE dDOT13(a,b) dDOTpq(a,b,1,3)
#DEFINE dDOT31(a,b) dDOTpq(a,b,3,1)
#DEFINE dDOT33(a,b) dDOTpq(a,b,3,3)
#DEFINE dDOT14(a,b) dDOTpq(a,b,1,4)
#DEFINE dDOT41(a,b) dDOTpq(a,b,4,1)
#DEFINE dDOT44(a,b) dDOTpq(a,b,4,4)

#DEFINE dCROSS(a,op,b,c) _
  (a)[0] op ((b)[1]*(c)[2] - (b)[2]*(c)[1]) : _
  (a)[1] op ((b)[2]*(c)[0] - (b)[0]*(c)[2]) : _
  (a)[2] op ((b)[0]*(c)[1] - (b)[1]*(c)[0])
#DEFINE dCROSSpqr(a,op,b,c,p,q,r) _
  (a)[  0] op ((b)[  q]*(c)[2*r] - (b)[2*q]*(c)[  r]) : _
  (a)[  p] op ((b)[2*q]*(c)[  0] - (b)[  0]*(c)[2*r]) : _
  (a)[2*p] op ((b)[  0]*(c)[  r] - (b)[  q]*(c)[  0])

#DEFINE dCROSS114(a,op,b,c) dCROSSpqr(a,op,b,c,1,1,4)
#DEFINE dCROSS141(a,op,b,c) dCROSSpqr(a,op,b,c,1,4,1)
#DEFINE dCROSS144(a,op,b,c) dCROSSpqr(a,op,b,c,1,4,4)
#DEFINE dCROSS411(a,op,b,c) dCROSSpqr(a,op,b,c,4,1,1)
#DEFINE dCROSS414(a,op,b,c) dCROSSpqr(a,op,b,c,4,1,4)
#DEFINE dCROSS441(a,op,b,c) dCROSSpqr(a,op,b,c,4,4,1)
#DEFINE dCROSS444(a,op,b,c) dCROSSpqr(a,op,b,c,4,4,4)

#DEFINE dCROSSMAT(R,a,skip,plus,minus) _
  (R)[1] = minus (a)[2] : _
  (R)[2] = plus (a)[1] : _
  (R)[(skip)+0)] = plus (a)[2] : _
  (R)[(skip)+2)] = minus (a)[0] : _
  (R)[2*(skip)+0)] = minus (a)[1] : _
  (R)[2*(skip)+1)] = plus (a)[0]
#DEFINE dDISTANCE(a,b) _
 (dSqrt( ((a)[0]-(b)[0])*((a)[0]-(b)[0]) + ((a)[1]-(b)[1])*((a)[1]-(b)[1]) + ((a)[2]-(b)[2])*((a)[2]-(b)[2]) ))
#DEFINE dMULTIPLYOP0_331(A,op,B,C) _
  (A)[0] op dDOT((B),(C)) : _
  (A)[1] op dDOT((B+4),(C)) : _
  (A)[2] op dDOT((B+8),(C))
#DEFINE dMULTIPLYOP1_331(A,op,B,C) _
  (A)[0] op dDOT41((B),(C)) : _
  (A)[1] op dDOT41((B+1),(C)) : _
  (A)[2] op dDOT41((B+2),(C))
#DEFINE dMULTIPLYOP0_133(A,op,B,C) _
  (A)[0] op dDOT14((B),(C)) : _
  (A)[1] op dDOT14((B),(C+1)) : _
  (A)[2] op dDOT14((B),(C+2))
#DEFINE dMULTIPLYOP0_333(A,op,B,C) _
  (A)[0] op dDOT14((B),(C)) : _
  (A)[1] op dDOT14((B),(C+1)) : _
  (A)[2] op dDOT14((B),(C+2)) : _
  (A)[4] op dDOT14((B+4),(C)) : _
  (A)[5] op dDOT14((B+4),(C+1)) : _
  (A)[6] op dDOT14((B+4),(C+2)) : _
  (A)[8] op dDOT14((B+8),(C)) : _
  (A)[9] op dDOT14((B+8),(C+1)) : _
  (A)[10] op dDOT14((B+8),(C+2))
#DEFINE dMULTIPLYOP1_333(A,op,B,C) _
  (A)[0] op dDOT44((B),(C)) : _
  (A)[1] op dDOT44((B),(C+1)) : _
  (A)[2] op dDOT44((B),(C+2)) : _
  (A)[4] op dDOT44((B+1),(C)) : _
  (A)[5] op dDOT44((B+1),(C+1)) : _
  (A)[6] op dDOT44((B+1),(C+2)) : _
  (A)[8] op dDOT44((B+2),(C)) : _
  (A)[9] op dDOT44((B+2),(C+1)) : _
  (A)[10] op dDOT44((B+2),(C+2))
#DEFINE dMULTIPLYOP2_333(A,op,B,C) _
  (A)[0] op dDOT((B),(C)) : _
  (A)[1] op dDOT((B),(C+4)) : _
  (A)[2] op dDOT((B),(C+8)) : _
  (A)[4] op dDOT((B+4),(C)) : _
  (A)[5] op dDOT((B+4),(C+4)) : _
  (A)[6] op dDOT((B+4),(C+8)) : _
  (A)[8] op dDOT((B+8),(C)) : _
  (A)[9] op dDOT((B+8),(C+4)) : _
  (A)[10] op dDOT((B+8),(C+8))

#DEFINE dMULTIPLY0_331(A,B,C) dMULTIPLYOP0_331(A,=,B,C)
#DEFINE dMULTIPLY1_331(A,B,C) dMULTIPLYOP1_331(A,=,B,C)
#DEFINE dMULTIPLY0_133(A,B,C) dMULTIPLYOP0_133(A,=,B,C)
#DEFINE dMULTIPLY0_333(A,B,C) dMULTIPLYOP0_333(A,=,B,C)
#DEFINE dMULTIPLY1_333(A,B,C) dMULTIPLYOP1_333(A,=,B,C)
#DEFINE dMULTIPLY2_333(A,B,C) dMULTIPLYOP2_333(A,=,B,C)
#DEFINE dMULTIPLYADD0_331(A,B,C) dMULTIPLYOP0_331(A,+=,B,C)
#DEFINE dMULTIPLYADD1_331(A,B,C) dMULTIPLYOP1_331(A,+=,B,C)
#DEFINE dMULTIPLYADD0_133(A,B,C) dMULTIPLYOP0_133(A,+=,B,C)
#DEFINE dMULTIPLYADD0_333(A,B,C) dMULTIPLYOP0_333(A,+=,B,C)
#DEFINE dMULTIPLYADD1_333(A,B,C) dMULTIPLYOP1_333(A,+=,B,C)
#DEFINE dMULTIPLYADD2_333(A,B,C) dMULTIPLYOP2_333(A,+=,B,C)

#IF DEFINED(__ODE__)

DECLARE FUNCTION _dSafeNormalize3(BYVAL AS dVector3 PTR) AS INTEGER
DECLARE FUNCTION _dSafeNormalize4(BYVAL AS dVector4 PTR) AS INTEGER

#ENDIF ' DEFINED(__ODE__...

DECLARE FUNCTION dSafeNormalize3_ ALIAS "dSafeNormalize3"(BYVAL AS dVector3 PTR) AS INTEGER
DECLARE FUNCTION dSafeNormalize4_ ALIAS "dSafeNormalize4"(BYVAL AS dVector4 PTR) AS INTEGER
DECLARE SUB dNormalize3_ ALIAS "dNormalize3"(BYVAL AS dVector3 PTR)
DECLARE SUB dNormalize4_ ALIAS "dNormalize4"(BYVAL AS dVector4 PTR)

#IF DEFINED(__ODE__)
#DEFINE dSafeNormalize3(a) _dSafeNormalize3(a)
#DEFINE dSafeNormalize4(a) _dSafeNormalize4(a)
#DEFINE dNormalize3(a) _dNormalize3(a)
#DEFINE dNormalize4(a) _dNormalize4(a)
#ENDIF ' DEFINED(__ODE__...

DECLARE SUB dPlaneSpace(BYVAL AS CONST dVector3 PTR, BYVAL AS dVector3 PTR, BYVAL AS dVector3 PTR)
DECLARE SUB dOrthogonalizeR(BYVAL AS dMatrix3 PTR)

#ENDIF ' _ODE_ODEMATH_H_

#IFNDEF _ODE_MATRIX_H_
#DEFINE _ODE_MATRIX_H_

DECLARE SUB dSetZero(BYVAL AS dReal PTR, BYVAL AS INTEGER)
DECLARE SUB dSetValue(BYVAL AS dReal PTR, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE FUNCTION dDot_ ALIAS "dDot"(BYVAL AS CONST dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS INTEGER) AS dReal
DECLARE SUB dMultiply0(BYVAL AS dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dMultiply1(BYVAL AS dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dMultiply2(BYVAL AS dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE FUNCTION dFactorCholesky(BYVAL AS dReal PTR, BYVAL AS INTEGER) AS INTEGER
DECLARE SUB dSolveCholesky(BYVAL AS CONST dReal PTR, BYVAL AS dReal PTR, BYVAL AS INTEGER)
DECLARE FUNCTION dInvertPDMatrix(BYVAL AS CONST dReal PTR, BYVAL AS dReal PTR, BYVAL AS INTEGER) AS INTEGER
DECLARE FUNCTION dIsPositiveDefinite(BYVAL AS CONST dReal PTR, BYVAL AS INTEGER) AS INTEGER
DECLARE SUB dFactorLDLT(BYVAL AS dReal PTR, BYVAL AS dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dSolveL1(BYVAL AS CONST dReal PTR, BYVAL AS dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dSolveL1T(BYVAL AS CONST dReal PTR, BYVAL AS dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dVectorScale(BYVAL AS dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS INTEGER)
DECLARE SUB dSolveLDLT(BYVAL AS CONST dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dLDLTAddTL(BYVAL AS dReal PTR, BYVAL AS dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dLDLTRemove(BYVAL AS dReal PTR PTR, BYVAL AS CONST INTEGER PTR, BYVAL AS dReal PTR, BYVAL AS dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dRemoveRowCol(BYVAL AS dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)

#ENDIF ' _ODE_MATRIX_H_

#IFNDEF _ODE_TIMER_H_
#DEFINE _ODE_TIMER_H_

TYPE dStopwatch
  AS DOUBLE time
  AS UINTEGER cc(1)
END TYPE

DECLARE SUB dStopwatchReset(BYVAL AS dStopwatch PTR)
DECLARE SUB dStopwatchStart(BYVAL AS dStopwatch PTR)
DECLARE SUB dStopwatchStop(BYVAL AS dStopwatch PTR)
DECLARE FUNCTION dStopwatchTime(BYVAL AS dStopwatch PTR) AS DOUBLE
DECLARE SUB dTimerStart(BYVAL AS CONST ZSTRING PTR)
DECLARE SUB dTimerNow(BYVAL AS CONST ZSTRING PTR)
DECLARE SUB dTimerEnd()
DECLARE SUB dTimerReport(BYVAL AS FILE PTR, BYVAL AS INTEGER)
DECLARE FUNCTION dTimerTicksPerSecond() AS DOUBLE
DECLARE FUNCTION dTimerResolution() AS DOUBLE

#ENDIF ' _ODE_TIMER_H_

#IFNDEF _ODE_ROTATION_H_
#DEFINE _ODE_ROTATION_H_

DECLARE SUB dRSetIdentity(BYVAL AS dMatrix3 PTR)
DECLARE SUB dRFromAxisAndAngle(BYVAL AS dMatrix3 PTR, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dRFromEulerAngles(BYVAL AS dMatrix3 PTR, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dRFrom2Axes(BYVAL AS dMatrix3 PTR, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dRFromZAxis(BYVAL AS dMatrix3 PTR, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dQSetIdentity(BYVAL AS dQuaternion PTR)
DECLARE SUB dQFromAxisAndAngle(BYVAL AS dQuaternion PTR, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dQMultiply0(BYVAL AS dQuaternion PTR, BYVAL AS CONST dQuaternion PTR, BYVAL AS CONST dQuaternion PTR)
DECLARE SUB dQMultiply1(BYVAL AS dQuaternion PTR, BYVAL AS CONST dQuaternion PTR, BYVAL AS CONST dQuaternion PTR)
DECLARE SUB dQMultiply2(BYVAL AS dQuaternion PTR, BYVAL AS CONST dQuaternion PTR, BYVAL AS CONST dQuaternion PTR)
DECLARE SUB dQMultiply3(BYVAL AS dQuaternion PTR, BYVAL AS CONST dQuaternion PTR, BYVAL AS CONST dQuaternion PTR)
DECLARE SUB dRfromQ(BYVAL AS dMatrix3 PTR, BYVAL AS CONST dQuaternion PTR)
DECLARE SUB dQfromR(BYVAL AS dQuaternion PTR, BYVAL AS CONST dMatrix3 PTR)
DECLARE SUB dDQfromW(BYVAL AS dReal PTR, BYVAL AS CONST dVector3 PTR, BYVAL AS CONST dQuaternion PTR)

#ENDIF ' _ODE_ROTATION_H_

#IFNDEF _ODE_MASS_H_
#DEFINE _ODE_MASS_H_

TYPE dMass AS dMass_

DECLARE FUNCTION dMassCheck(BYVAL AS CONST dMass PTR) AS INTEGER
DECLARE SUB dMassSetZero(BYVAL AS dMass PTR)
DECLARE SUB dMassSetParameters(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dMassSetSphere(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dMassSetSphereTotal(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dMassSetCapsule(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dMassSetCapsuleTotal(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dMassSetCylinder(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dMassSetCylinderTotal(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dMassSetBox(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dMassSetBoxTotal(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dMassSetTrimesh(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS dGeomID)
DECLARE SUB dMassSetTrimeshTotal(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS dGeomID)
DECLARE SUB dMassAdjust(BYVAL AS dMass PTR, BYVAL AS dReal)
DECLARE SUB dMassTranslate(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dMassRotate(BYVAL AS dMass PTR, BYVAL AS CONST dMatrix3 PTR)
DECLARE SUB dMassAdd(BYVAL AS dMass PTR, BYVAL AS CONST dMass PTR)
DECLARE SUB dMassSetCappedCylinder(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dMassSetCappedCylinderTotal(BYVAL AS dMass PTR, BYVAL AS dReal, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal)

TYPE dMass_
  AS dReal mass
  AS dVector3 c
  AS dMatrix3 I
END TYPE

#ENDIF ' _ODE_MASS_H_

#IFNDEF _ODE_MISC_H_
#DEFINE _ODE_MISC_H_

DECLARE FUNCTION dTestRand() AS INTEGER
DECLARE FUNCTION dRand() AS UINTEGER
DECLARE FUNCTION dRandGetSeed() AS UINTEGER
DECLARE SUB dRandSetSeed(BYVAL AS UINTEGER)
DECLARE FUNCTION dRandInt(BYVAL AS INTEGER) AS INTEGER
DECLARE FUNCTION dRandReal() AS dReal

DECLARE SUB dPrintMatrix(BYVAL AS CONST dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS ZSTRING PTR, BYVAL AS FILE PTR)

DECLARE SUB dMakeRandomVector(BYVAL AS dReal PTR, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dMakeRandomMatrix(BYVAL AS dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dClearUpperTriangle(BYVAL AS dReal PTR, BYVAL AS INTEGER)
DECLARE FUNCTION dMaxDifference(BYVAL AS CONST dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS dReal
DECLARE FUNCTION dMaxDifferenceLowerTriangle(BYVAL AS CONST dReal PTR, BYVAL AS CONST dReal PTR, BYVAL AS INTEGER) AS dReal

#ENDIF ' _ODE_MISC_H_

#IFNDEF _ODE_OBJECTS_H_
#DEFINE _ODE_OBJECTS_H_

DECLARE FUNCTION dWorldCreate() AS dWorldID
DECLARE SUB dWorldDestroy(BYVAL AS dWorldID)
DECLARE SUB dWorldSetGravity(BYVAL AS dWorldID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dWorldGetGravity(BYVAL AS dWorldID, BYVAL AS dVector3 PTR)
DECLARE SUB dWorldSetERP(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetERP(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetCFM(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetCFM(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldStep(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE SUB dWorldImpulseToForce(BYVAL AS dWorldID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dVector3 PTR)
DECLARE SUB dWorldQuickStep(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE SUB dWorldSetQuickStepNumIterations(BYVAL AS dWorldID, BYVAL AS INTEGER)
DECLARE FUNCTION dWorldGetQuickStepNumIterations(BYVAL AS dWorldID) AS INTEGER
DECLARE SUB dWorldSetQuickStepW(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetQuickStepW(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetContactMaxCorrectingVel(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetContactMaxCorrectingVel(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetContactSurfaceLayer(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetContactSurfaceLayer(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldStepFast1(BYVAL AS dWorldID, BYVAL AS dReal, BYVAL AS INTEGER)
DECLARE SUB dWorldSetAutoEnableDepthSF1(BYVAL AS dWorldID, BYVAL AS INTEGER)
DECLARE FUNCTION dWorldGetAutoEnableDepthSF1(BYVAL AS dWorldID) AS INTEGER
DECLARE FUNCTION dWorldGetAutoDisableLinearThreshold(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetAutoDisableLinearThreshold(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetAutoDisableAngularThreshold(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetAutoDisableAngularThreshold(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetAutoDisableLinearAverageThreshold(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetAutoDisableLinearAverageThreshold(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetAutoDisableAngularAverageThreshold(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetAutoDisableAngularAverageThreshold(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetAutoDisableAverageSamplesCount(BYVAL AS dWorldID) AS INTEGER
DECLARE SUB dWorldSetAutoDisableAverageSamplesCount(BYVAL AS dWorldID, BYVAL AS UINTEGER)
DECLARE FUNCTION dWorldGetAutoDisableSteps(BYVAL AS dWorldID) AS INTEGER
DECLARE SUB dWorldSetAutoDisableSteps(BYVAL AS dWorldID, BYVAL AS INTEGER)
DECLARE FUNCTION dWorldGetAutoDisableTime(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetAutoDisableTime(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetAutoDisableFlag(BYVAL AS dWorldID) AS INTEGER
DECLARE SUB dWorldSetAutoDisableFlag(BYVAL AS dWorldID, BYVAL AS INTEGER)
DECLARE FUNCTION dWorldGetLinearDampingThreshold(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetLinearDampingThreshold(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetAngularDampingThreshold(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetAngularDampingThreshold(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetLinearDamping(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetLinearDamping(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetAngularDamping(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetAngularDamping(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE SUB dWorldSetDamping(BYVAL AS dWorldID, BYVAL AS dReal, BYVAL AS dReal)
DECLARE FUNCTION dWorldGetMaxAngularSpeed(BYVAL AS dWorldID) AS dReal
DECLARE SUB dWorldSetMaxAngularSpeed(BYVAL AS dWorldID, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetAutoDisableLinearThreshold(BYVAL AS dBodyID) AS dReal
DECLARE SUB dBodySetAutoDisableLinearThreshold(BYVAL AS dBodyID, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetAutoDisableAngularThreshold(BYVAL AS dBodyID) AS dReal
DECLARE SUB dBodySetAutoDisableAngularThreshold(BYVAL AS dBodyID, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetAutoDisableAverageSamplesCount(BYVAL AS dBodyID) AS INTEGER
DECLARE SUB dBodySetAutoDisableAverageSamplesCount(BYVAL AS dBodyID, BYVAL AS UINTEGER)
DECLARE FUNCTION dBodyGetAutoDisableSteps(BYVAL AS dBodyID) AS INTEGER
DECLARE SUB dBodySetAutoDisableSteps(BYVAL AS dBodyID, BYVAL AS INTEGER)
DECLARE FUNCTION dBodyGetAutoDisableTime(BYVAL AS dBodyID) AS dReal
DECLARE SUB dBodySetAutoDisableTime(BYVAL AS dBodyID, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetAutoDisableFlag(BYVAL AS dBodyID) AS INTEGER
DECLARE SUB dBodySetAutoDisableFlag(BYVAL AS dBodyID, BYVAL AS INTEGER)
DECLARE SUB dBodySetAutoDisableDefaults(BYVAL AS dBodyID)
DECLARE FUNCTION dBodyGetWorld(BYVAL AS dBodyID) AS dWorldID
DECLARE FUNCTION dBodyCreate(BYVAL AS dWorldID) AS dBodyID
DECLARE SUB dBodyDestroy(BYVAL AS dBodyID)
DECLARE SUB dBodySetData(BYVAL AS dBodyID, BYVAL AS ANY PTR)
DECLARE FUNCTION dBodyGetData(BYVAL AS dBodyID) AS ANY PTR
DECLARE SUB dBodySetPosition(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dBodySetRotation(BYVAL AS dBodyID, BYVAL AS CONST dMatrix3 PTR)
DECLARE SUB dBodySetQuaternion(BYVAL AS dBodyID, BYVAL AS CONST dQuaternion PTR)
DECLARE SUB dBodySetLinearVel(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dBodySetAngularVel(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetPosition(BYVAL AS dBodyID) AS CONST dReal PTR
DECLARE SUB dBodyCopyPosition(BYVAL AS dBodyID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dBodyGetRotation(BYVAL AS dBodyID) AS CONST dReal PTR
DECLARE SUB dBodyCopyRotation(BYVAL AS dBodyID, BYVAL AS dMatrix3 PTR)
DECLARE FUNCTION dBodyGetQuaternion(BYVAL AS dBodyID) AS CONST dReal PTR
DECLARE SUB dBodyCopyQuaternion(BYVAL AS dBodyID, BYVAL AS dQuaternion PTR)
DECLARE FUNCTION dBodyGetLinearVel(BYVAL AS dBodyID) AS CONST dReal PTR
DECLARE FUNCTION dBodyGetAngularVel(BYVAL AS dBodyID) AS CONST dReal PTR
DECLARE SUB dBodySetMass(BYVAL AS dBodyID, BYVAL AS CONST dMass PTR)
DECLARE SUB dBodyGetMass(BYVAL AS dBodyID, BYVAL AS dMass PTR)
DECLARE SUB dBodyAddForce(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dBodyAddTorque(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dBodyAddRelForce(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dBodyAddRelTorque(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dBodyAddForceAtPos(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dBodyAddForceAtRelPos(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dBodyAddRelForceAtPos(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dBodyAddRelForceAtRelPos(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetForce(BYVAL AS dBodyID) AS CONST dReal PTR
DECLARE FUNCTION dBodyGetTorque(BYVAL AS dBodyID) AS CONST dReal PTR
DECLARE SUB dBodySetForce(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dBodySetTorque(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dBodyGetRelPointPos(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dVector3 PTR)
DECLARE SUB dBodyGetRelPointVel(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dVector3 PTR)
DECLARE SUB dBodyGetPointVel(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dVector3 PTR)
DECLARE SUB dBodyGetPosRelPoint(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dVector3 PTR)
DECLARE SUB dBodyVectorToWorld(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dVector3 PTR)
DECLARE SUB dBodyVectorFromWorld(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dVector3 PTR)
DECLARE SUB dBodySetFiniteRotationMode(BYVAL AS dBodyID, BYVAL AS INTEGER)
DECLARE SUB dBodySetFiniteRotationAxis(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetFiniteRotationMode(BYVAL AS dBodyID) AS INTEGER
DECLARE SUB dBodyGetFiniteRotationAxis(BYVAL AS dBodyID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dBodyGetNumJoints(BYVAL AS dBodyID) AS INTEGER
DECLARE FUNCTION dBodyGetJoint(BYVAL AS dBodyID, BYVAL AS INTEGER) AS dJointID
DECLARE SUB dBodySetDynamic(BYVAL AS dBodyID)
DECLARE SUB dBodySetKinematic(BYVAL AS dBodyID)
DECLARE FUNCTION dBodyIsKinematic(BYVAL AS dBodyID) AS INTEGER
DECLARE SUB dBodyEnable(BYVAL AS dBodyID)
DECLARE SUB dBodyDisable(BYVAL AS dBodyID)
DECLARE FUNCTION dBodyIsEnabled(BYVAL AS dBodyID) AS INTEGER
DECLARE SUB dBodySetGravityMode(BYVAL AS dBodyID, BYVAL AS INTEGER)
DECLARE FUNCTION dBodyGetGravityMode(BYVAL AS dBodyID) AS INTEGER
DECLARE SUB dBodySetMovedCallback(BYVAL AS dBodyID, BYVAL AS SUB(BYVAL AS dBodyID))
DECLARE FUNCTION dBodyGetFirstGeom(BYVAL AS dBodyID) AS dGeomID
DECLARE FUNCTION dBodyGetNextGeom(BYVAL AS dGeomID) AS dGeomID
DECLARE SUB dBodySetDampingDefaults(BYVAL AS dBodyID)
DECLARE FUNCTION dBodyGetLinearDamping(BYVAL AS dBodyID) AS dReal
DECLARE SUB dBodySetLinearDamping(BYVAL AS dBodyID, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetAngularDamping(BYVAL AS dBodyID) AS dReal
DECLARE SUB dBodySetAngularDamping(BYVAL AS dBodyID, BYVAL AS dReal)
DECLARE SUB dBodySetDamping(BYVAL AS dBodyID, BYVAL AS dReal, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetLinearDampingThreshold(BYVAL AS dBodyID) AS dReal
DECLARE SUB dBodySetLinearDampingThreshold(BYVAL AS dBodyID, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetAngularDampingThreshold(BYVAL AS dBodyID) AS dReal
DECLARE SUB dBodySetAngularDampingThreshold(BYVAL AS dBodyID, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetMaxAngularSpeed(BYVAL AS dBodyID) AS dReal
DECLARE SUB dBodySetMaxAngularSpeed(BYVAL AS dBodyID, BYVAL AS dReal)
DECLARE FUNCTION dBodyGetGyroscopicMode(BYVAL AS dBodyID) AS INTEGER
DECLARE SUB dBodySetGyroscopicMode(BYVAL AS dBodyID, BYVAL AS INTEGER)
DECLARE FUNCTION dJointCreateBall(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreateHinge(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreateSlider(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreateContact(BYVAL AS dWorldID, BYVAL AS dJointGroupID, BYVAL AS CONST dContact PTR) AS dJointID
DECLARE FUNCTION dJointCreateHinge2(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreateUniversal(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreatePR(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreatePU(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreatePiston(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreateFixed(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreateNull(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreateAMotor(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreateLMotor(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE FUNCTION dJointCreatePlane2D(BYVAL AS dWorldID, BYVAL AS dJointGroupID) AS dJointID
DECLARE SUB dJointDestroy(BYVAL AS dJointID)
DECLARE FUNCTION dJointGroupCreate(BYVAL AS INTEGER) AS dJointGroupID
DECLARE SUB dJointGroupDestroy(BYVAL AS dJointGroupID)
DECLARE SUB dJointGroupEmpty(BYVAL AS dJointGroupID)
DECLARE FUNCTION dJointGetNumBodies(BYVAL AS dJointID) AS INTEGER
DECLARE SUB dJointAttach(BYVAL AS dJointID, BYVAL AS dBodyID, BYVAL AS dBodyID)
DECLARE SUB dJointEnable(BYVAL AS dJointID)
DECLARE SUB dJointDisable(BYVAL AS dJointID)
DECLARE FUNCTION dJointIsEnabled(BYVAL AS dJointID) AS INTEGER
DECLARE SUB dJointSetData(BYVAL AS dJointID, BYVAL AS ANY PTR)
DECLARE FUNCTION dJointGetData(BYVAL AS dJointID) AS ANY PTR
DECLARE FUNCTION dJointGetType(BYVAL AS dJointID) AS dJointType
DECLARE FUNCTION dJointGetBody(BYVAL AS dJointID, BYVAL AS INTEGER) AS dBodyID
DECLARE SUB dJointSetFeedback(BYVAL AS dJointID, BYVAL AS dJointFeedback PTR)
DECLARE FUNCTION dJointGetFeedback(BYVAL AS dJointID) AS dJointFeedback PTR
DECLARE SUB dJointSetBallAnchor(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetBallAnchor2(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetBallParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointSetHingeAnchor(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetHingeAnchorDelta(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetHingeAxis(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetHingeAxisOffset(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetHingeParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointAddHingeTorque(BYVAL AS dJointID, BYVAL AS dReal)
DECLARE SUB dJointSetSliderAxis(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetSliderAxisDelta(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetSliderParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointAddSliderForce(BYVAL AS dJointID, BYVAL AS dReal)
DECLARE SUB dJointSetHinge2Anchor(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetHinge2Axis1(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetHinge2Axis2(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetHinge2Param(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointAddHinge2Torques(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetUniversalAnchor(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetUniversalAxis1(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetUniversalAxis1Offset(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetUniversalAxis2(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetUniversalAxis2Offset(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetUniversalParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointAddUniversalTorques(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPRAnchor(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPRAxis1(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPRAxis2(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPRParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointAddPRTorque(BYVAL AS dJointID, BYVAL AS dReal)
DECLARE SUB dJointSetPUAnchor(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPUAnchorDelta(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPUAnchorOffset(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPUAxis1(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPUAxis2(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPUAxis3(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPUAxisP(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPUParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointAddPUTorque(BYVAL AS dJointID, BYVAL AS dReal)
DECLARE SUB dJointSetPistonAnchor(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPistonAnchorOffset(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPistonAxis(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPistonAxisDelta(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetPistonParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointAddPistonForce(BYVAL AS dJointID, BYVAL AS dReal)
DECLARE SUB dJointSetFixed(BYVAL AS dJointID)
DECLARE SUB dJointSetFixedParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointSetAMotorNumAxes(BYVAL AS dJointID, BYVAL AS INTEGER)
DECLARE SUB dJointSetAMotorAxis(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetAMotorAngle(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointSetAMotorParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointSetAMotorMode(BYVAL AS dJointID, BYVAL AS INTEGER)
DECLARE SUB dJointAddAMotorTorques(BYVAL AS dJointID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetLMotorNumAxes(BYVAL AS dJointID, BYVAL AS INTEGER)
DECLARE SUB dJointSetLMotorAxis(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dJointSetLMotorParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointSetPlane2DXParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointSetPlane2DYParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointSetPlane2DAngleParam(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dReal)
DECLARE SUB dJointGetBallAnchor(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetBallAnchor2(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dJointGetBallParam(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE SUB dJointGetHingeAnchor(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetHingeAnchor2(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetHingeAxis(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dJointGetHingeParam(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE FUNCTION dJointGetHingeAngle(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetHingeAngleRate(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetSliderPosition(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetSliderPositionRate(BYVAL AS dJointID) AS dReal
DECLARE SUB dJointGetSliderAxis(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dJointGetSliderParam(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE SUB dJointGetHinge2Anchor(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetHinge2Anchor2(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetHinge2Axis1(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetHinge2Axis2(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dJointGetHinge2Param(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE FUNCTION dJointGetHinge2Angle1(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetHinge2Angle1Rate(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetHinge2Angle2Rate(BYVAL AS dJointID) AS dReal
DECLARE SUB dJointGetUniversalAnchor(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetUniversalAnchor2(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetUniversalAxis1(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetUniversalAxis2(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dJointGetUniversalParam(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE SUB dJointGetUniversalAngles(BYVAL AS dJointID, BYVAL AS dReal PTR, BYVAL AS dReal PTR)
DECLARE FUNCTION dJointGetUniversalAngle1(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetUniversalAngle2(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetUniversalAngle1Rate(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetUniversalAngle2Rate(BYVAL AS dJointID) AS dReal
DECLARE SUB dJointGetPRAnchor(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dJointGetPRPosition(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetPRPositionRate(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetPRAngle(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetPRAngleRate(BYVAL AS dJointID) AS dReal
DECLARE SUB dJointGetPRAxis1(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetPRAxis2(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dJointGetPRParam(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE SUB dJointGetPUAnchor(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dJointGetPUPosition(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetPUPositionRate(BYVAL AS dJointID) AS dReal
DECLARE SUB dJointGetPUAxis1(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetPUAxis2(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetPUAxis3(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetPUAxisP(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetPUAngles(BYVAL AS dJointID, BYVAL AS dReal PTR, BYVAL AS dReal PTR)
DECLARE FUNCTION dJointGetPUAngle1(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetPUAngle1Rate(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetPUAngle2(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetPUAngle2Rate(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetPUParam(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE FUNCTION dJointGetPistonPosition(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetPistonPositionRate(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetPistonAngle(BYVAL AS dJointID) AS dReal
DECLARE FUNCTION dJointGetPistonAngleRate(BYVAL AS dJointID) AS dReal
DECLARE SUB dJointGetPistonAnchor(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetPistonAnchor2(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE SUB dJointGetPistonAxis(BYVAL AS dJointID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dJointGetPistonParam(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE FUNCTION dJointGetAMotorNumAxes(BYVAL AS dJointID) AS INTEGER
DECLARE SUB dJointGetAMotorAxis(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dJointGetAMotorAxisRel(BYVAL AS dJointID, BYVAL AS INTEGER) AS INTEGER
DECLARE FUNCTION dJointGetAMotorAngle(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE FUNCTION dJointGetAMotorAngleRate(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE FUNCTION dJointGetAMotorParam(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE FUNCTION dJointGetAMotorMode(BYVAL AS dJointID) AS INTEGER
DECLARE FUNCTION dJointGetLMotorNumAxes(BYVAL AS dJointID) AS INTEGER
DECLARE SUB dJointGetLMotorAxis(BYVAL AS dJointID, BYVAL AS INTEGER, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dJointGetLMotorParam(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE FUNCTION dJointGetFixedParam(BYVAL AS dJointID, BYVAL AS INTEGER) AS dReal
DECLARE FUNCTION dConnectingJoint(BYVAL AS dBodyID, BYVAL AS dBodyID) AS dJointID
DECLARE FUNCTION dConnectingJointList(BYVAL AS dBodyID, BYVAL AS dBodyID, BYVAL AS dJointID PTR) AS INTEGER
DECLARE FUNCTION dAreConnected(BYVAL AS dBodyID, BYVAL AS dBodyID) AS INTEGER
DECLARE FUNCTION dAreConnectedExcluding(BYVAL AS dBodyID, BYVAL AS dBodyID, BYVAL AS INTEGER) AS INTEGER

#ENDIF ' _ODE_OBJECTS_H_

#IFNDEF _ODE_COLLISION_SPACE_H_
#DEFINE _ODE_COLLISION_SPACE_H_

TYPE dNearCallback AS SUB(BYVAL AS ANY PTR, BYVAL AS dGeomID, BYVAL AS dGeomID)

DECLARE FUNCTION dSimpleSpaceCreate(BYVAL AS dSpaceID) AS dSpaceID
DECLARE FUNCTION dHashSpaceCreate(BYVAL AS dSpaceID) AS dSpaceID
DECLARE FUNCTION dQuadTreeSpaceCreate(BYVAL AS dSpaceID, BYVAL AS CONST dVector3 PTR, BYVAL AS CONST dVector3 PTR, BYVAL AS INTEGER) AS dSpaceID

#DEFINE dSAP_AXES_XYZ ((0) OR(1 SHL 2) OR(2 SHL 4))
#DEFINE dSAP_AXES_XZY ((0) OR(2 SHL 2) OR(1 SHL 4))
#DEFINE dSAP_AXES_YXZ ((1) OR(0 SHL 2) OR(2 SHL 4))
#DEFINE dSAP_AXES_YZX ((1) OR(2 SHL 2) OR(0 SHL 4))
#DEFINE dSAP_AXES_ZXY ((2) OR(0 SHL 2) OR(1 SHL 4))
#DEFINE dSAP_AXES_ZYX ((2) OR(1 SHL 2) OR(0 SHL 4))

DECLARE FUNCTION dSweepAndPruneSpaceCreate(BYVAL AS dSpaceID, BYVAL AS INTEGER) AS dSpaceID
DECLARE SUB dSpaceDestroy(BYVAL AS dSpaceID)
DECLARE SUB dHashSpaceSetLevels(BYVAL AS dSpaceID, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dHashSpaceGetLevels(BYVAL AS dSpaceID, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR)
DECLARE SUB dSpaceSetCleanup(BYVAL AS dSpaceID, BYVAL AS INTEGER)
DECLARE FUNCTION dSpaceGetCleanup(BYVAL AS dSpaceID) AS INTEGER
DECLARE SUB dSpaceSetSublevel(BYVAL AS dSpaceID, BYVAL AS INTEGER)
DECLARE FUNCTION dSpaceGetSublevel(BYVAL AS dSpaceID) AS INTEGER
DECLARE SUB dSpaceSetManualCleanup(BYVAL AS dSpaceID, BYVAL AS INTEGER)
DECLARE FUNCTION dSpaceGetManualCleanup(BYVAL AS dSpaceID) AS INTEGER
DECLARE SUB dSpaceAdd(BYVAL AS dSpaceID, BYVAL AS dGeomID)
DECLARE SUB dSpaceRemove(BYVAL AS dSpaceID, BYVAL AS dGeomID)
DECLARE FUNCTION dSpaceQuery(BYVAL AS dSpaceID, BYVAL AS dGeomID) AS INTEGER
DECLARE SUB dSpaceClean(BYVAL AS dSpaceID)
DECLARE FUNCTION dSpaceGetNumGeoms(BYVAL AS dSpaceID) AS INTEGER
DECLARE FUNCTION dSpaceGetGeom(BYVAL AS dSpaceID, BYVAL AS INTEGER) AS dGeomID
DECLARE FUNCTION dSpaceGetClass(BYVAL AS dSpaceID) AS INTEGER

#ENDIF ' _ODE_COLLISION_SPACE_H_

#IFNDEF _ODE_COLLISION_H_
#DEFINE _ODE_COLLISION_H_

DECLARE SUB dGeomDestroy(BYVAL AS dGeomID)
DECLARE SUB dGeomSetData(BYVAL AS dGeomID, BYVAL AS ANY PTR)
DECLARE FUNCTION dGeomGetData(BYVAL AS dGeomID) AS ANY PTR
DECLARE SUB dGeomSetBody(BYVAL AS dGeomID, BYVAL AS dBodyID)
DECLARE FUNCTION dGeomGetBody(BYVAL AS dGeomID) AS dBodyID
DECLARE SUB dGeomSetPosition(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dGeomSetRotation(BYVAL AS dGeomID, BYVAL AS CONST dMatrix3 PTR)
DECLARE SUB dGeomSetQuaternion(BYVAL AS dGeomID, BYVAL AS CONST dQuaternion PTR)
DECLARE FUNCTION dGeomGetPosition(BYVAL AS dGeomID) AS CONST dReal PTR
DECLARE SUB dGeomCopyPosition(BYVAL AS dGeomID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dGeomGetRotation(BYVAL AS dGeomID) AS CONST dReal PTR
DECLARE SUB dGeomCopyRotation(BYVAL AS dGeomID, BYVAL AS dMatrix3 PTR)
DECLARE SUB dGeomGetQuaternion(BYVAL AS dGeomID, BYVAL AS dQuaternion PTR)
DECLARE SUB dGeomGetAABB(BYVAL AS dGeomID, BYVAL AS dReal PTR)
DECLARE FUNCTION dGeomIsSpace(BYVAL AS dGeomID) AS INTEGER
DECLARE FUNCTION dGeomGetSpace(BYVAL AS dGeomID) AS dSpaceID
DECLARE FUNCTION dGeomGetClass(BYVAL AS dGeomID) AS INTEGER
DECLARE SUB dGeomSetCategoryBits(BYVAL AS dGeomID, BYVAL AS UINTEGER)
DECLARE SUB dGeomSetCollideBits(BYVAL AS dGeomID, BYVAL AS UINTEGER)
DECLARE FUNCTION dGeomGetCategoryBits(BYVAL AS dGeomID) AS UINTEGER
DECLARE FUNCTION dGeomGetCollideBits(BYVAL AS dGeomID) AS UINTEGER
DECLARE SUB dGeomEnable(BYVAL AS dGeomID)
DECLARE SUB dGeomDisable(BYVAL AS dGeomID)
DECLARE FUNCTION dGeomIsEnabled(BYVAL AS dGeomID) AS INTEGER
DECLARE SUB dGeomSetOffsetPosition(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dGeomSetOffsetRotation(BYVAL AS dGeomID, BYVAL AS CONST dMatrix3 PTR)
DECLARE SUB dGeomSetOffsetQuaternion(BYVAL AS dGeomID, BYVAL AS CONST dQuaternion PTR)
DECLARE SUB dGeomSetOffsetWorldPosition(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dGeomSetOffsetWorldRotation(BYVAL AS dGeomID, BYVAL AS CONST dMatrix3 PTR)
DECLARE SUB dGeomSetOffsetWorldQuaternion(BYVAL AS dGeomID, BYREF AS CONST dQuaternion)
DECLARE SUB dGeomClearOffset(BYVAL AS dGeomID)
DECLARE FUNCTION dGeomIsOffset(BYVAL AS dGeomID) AS INTEGER
DECLARE FUNCTION dGeomGetOffsetPosition(BYVAL AS dGeomID) AS CONST dReal PTR
DECLARE SUB dGeomCopyOffsetPosition(BYVAL AS dGeomID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dGeomGetOffsetRotation(BYVAL AS dGeomID) AS CONST dReal PTR
DECLARE SUB dGeomCopyOffsetRotation(BYVAL AS dGeomID, BYVAL AS dMatrix3 PTR)
DECLARE SUB dGeomGetOffsetQuaternion(BYVAL AS dGeomID, BYVAL AS dQuaternion PTR)

#DEFINE CONTACTS_UNIMPORTANT &h80000000

DECLARE FUNCTION dCollide(BYVAL AS dGeomID, BYVAL AS dGeomID, BYVAL AS INTEGER, BYVAL AS dContactGeom PTR, BYVAL AS INTEGER) AS INTEGER
DECLARE SUB dSpaceCollide(BYVAL AS dSpaceID, BYVAL AS ANY PTR, BYVAL AS dNearCallback)
DECLARE SUB dSpaceCollide2(BYVAL AS dGeomID, BYVAL AS dGeomID, BYVAL AS ANY PTR, BYVAL AS dNearCallback)

ENUM
  dMaxUserClasses = 4
END ENUM

ENUM
  dSphereClass = 0
  dBoxClass
  dCapsuleClass
  dCylinderClass
  dPlaneClass
  dRayClass
  dConvexClass
  dGeomTransformClass
  dTriMeshClass
  dHeightfieldClass
  dFirstSpaceClass
  dSimpleSpaceClass = dFirstSpaceClass
  dHashSpaceClass
  dSweepAndPruneSpaceClass
  dQuadTreeSpaceClass
  dLastSpaceClass = dQuadTreeSpaceClass
  dFirstUserClass
  dLastUserClass = dFirstUserClass + dMaxUserClasses - 1
  dGeomNumClasses
END ENUM

DECLARE FUNCTION dCreateSphere(BYVAL AS dSpaceID, BYVAL AS dReal) AS dGeomID
DECLARE SUB dGeomSphereSetRadius(BYVAL AS dGeomID, BYVAL AS dReal)
DECLARE FUNCTION dGeomSphereGetRadius(BYVAL AS dGeomID) AS dReal
DECLARE FUNCTION dGeomSpherePointDepth(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal) AS dReal
DECLARE FUNCTION dCreateConvex(BYVAL AS dSpaceID, BYVAL AS dReal PTR, BYVAL AS UINTEGER, BYVAL AS dReal PTR, BYVAL AS UINTEGER, BYVAL AS UINTEGER PTR) AS dGeomID
DECLARE SUB dGeomSetConvex(BYVAL AS dGeomID, BYVAL AS dReal PTR, BYVAL AS UINTEGER, BYVAL AS dReal PTR, BYVAL AS UINTEGER, BYVAL AS UINTEGER PTR)
DECLARE FUNCTION dCreateBox(BYVAL AS dSpaceID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal) AS dGeomID
DECLARE SUB dGeomBoxSetLengths(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dGeomBoxGetLengths(BYVAL AS dGeomID, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dGeomBoxPointDepth(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal) AS dReal
DECLARE FUNCTION dCreatePlane(BYVAL AS dSpaceID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal) AS dGeomID
DECLARE SUB dGeomPlaneSetParams(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dGeomPlaneGetParams(BYVAL AS dGeomID, BYVAL AS dVector4 PTR)
DECLARE FUNCTION dGeomPlanePointDepth(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal) AS dReal
DECLARE FUNCTION dCreateCapsule(BYVAL AS dSpaceID, BYVAL AS dReal, BYVAL AS dReal) AS dGeomID
DECLARE SUB dGeomCapsuleSetParams(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dGeomCapsuleGetParams(BYVAL AS dGeomID, BYVAL AS dReal PTR, BYVAL AS dReal PTR)
DECLARE FUNCTION dGeomCapsulePointDepth(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal) AS dReal

#DEFINE dCreateCCylinder dCreateCapsule
#DEFINE dGeomCCylinderSetParams dGeomCapsuleSetParams
#DEFINE dGeomCCylinderGetParams dGeomCapsuleGetParams
#DEFINE dGeomCCylinderPointDepth dGeomCapsulePointDepth
#DEFINE dCCylinderClass dCapsuleClass

DECLARE FUNCTION dCreateCylinder(BYVAL AS dSpaceID, BYVAL AS dReal, BYVAL AS dReal) AS dGeomID
DECLARE SUB dGeomCylinderSetParams(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dGeomCylinderGetParams(BYVAL AS dGeomID, BYVAL AS dReal PTR, BYVAL AS dReal PTR)
DECLARE FUNCTION dCreateRay(BYVAL AS dSpaceID, BYVAL AS dReal) AS dGeomID
DECLARE SUB dGeomRaySetLength(BYVAL AS dGeomID, BYVAL AS dReal)
DECLARE FUNCTION dGeomRayGetLength(BYVAL AS dGeomID) AS dReal
DECLARE SUB dGeomRaySet(BYVAL AS dGeomID, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dGeomRayGet(BYVAL AS dGeomID, BYVAL AS dVector3 PTR, BYVAL AS dVector3 PTR)
DECLARE SUB dGeomRaySetParams(BYVAL AS dGeomID, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dGeomRayGetParams(BYVAL AS dGeomID, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR)
DECLARE SUB dGeomRaySetClosestHit(BYVAL AS dGeomID, BYVAL AS INTEGER)
DECLARE FUNCTION dGeomRayGetClosestHit(BYVAL AS dGeomID) AS INTEGER

#IFNDEF _ODE_COLLISION_TRIMESH_H_
#DEFINE _ODE_COLLISION_TRIMESH_H_

TYPE dxTriMeshData AS dxTriMeshData_
TYPE dTriMeshDataID AS dxTriMeshData PTR

DECLARE FUNCTION dGeomTriMeshDataCreate() AS dTriMeshDataID
DECLARE SUB dGeomTriMeshDataDestroy(BYVAL AS dTriMeshDataID)

ENUM
  TRIMESH_FACE_NORMALS
END ENUM

DECLARE SUB dGeomTriMeshDataSet(BYVAL AS dTriMeshDataID, BYVAL AS INTEGER, BYVAL AS ANY PTR)
DECLARE FUNCTION dGeomTriMeshDataGet(BYVAL AS dTriMeshDataID, BYVAL AS INTEGER) AS ANY PTR
DECLARE SUB dGeomTriMeshSetLastTransform(BYVAL AS dGeomID, BYVAL AS dMatrix4 PTR)
DECLARE FUNCTION dGeomTriMeshGetLastTransform(BYVAL AS dGeomID) AS dReal PTR
DECLARE SUB dGeomTriMeshDataBuildSingle(BYVAL AS dTriMeshDataID, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dGeomTriMeshDataBuildSingle1(BYVAL AS dTriMeshDataID, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR)
DECLARE SUB dGeomTriMeshDataBuildDouble(BYVAL AS dTriMeshDataID, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB dGeomTriMeshDataBuildDouble1(BYVAL AS dTriMeshDataID, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR)
DECLARE SUB dGeomTriMeshDataBuildSimple(BYVAL AS dTriMeshDataID, BYVAL AS CONST dReal PTR, BYVAL AS INTEGER, BYVAL AS CONST dTriIndex PTR, BYVAL AS INTEGER)
DECLARE SUB dGeomTriMeshDataBuildSimple1(BYVAL AS dTriMeshDataID, BYVAL AS CONST dReal PTR, BYVAL AS INTEGER, BYVAL AS CONST dTriIndex PTR, BYVAL AS INTEGER, BYVAL AS CONST INTEGER PTR)
DECLARE SUB dGeomTriMeshDataPreprocess(BYVAL AS dTriMeshDataID)
DECLARE SUB dGeomTriMeshDataGetBuffer(BYVAL AS dTriMeshDataID, BYVAL AS UBYTE PTR PTR, BYVAL AS INTEGER PTR)
DECLARE SUB dGeomTriMeshDataSetBuffer(BYVAL AS dTriMeshDataID, BYVAL AS UBYTE PTR)

TYPE dTriCallback AS FUNCTION(BYVAL AS dGeomID, BYVAL AS dGeomID, BYVAL AS INTEGER) AS INTEGER

DECLARE SUB dGeomTriMeshSetCallback(BYVAL AS dGeomID, BYVAL AS dTriCallback)
DECLARE FUNCTION dGeomTriMeshGetCallback(BYVAL AS dGeomID) AS dTriCallback

TYPE dTriArrayCallback AS SUB(BYVAL AS dGeomID, BYVAL AS dGeomID, BYVAL AS CONST INTEGER PTR, BYVAL AS INTEGER)

DECLARE SUB dGeomTriMeshSetArrayCallback(BYVAL AS dGeomID, BYVAL AS dTriArrayCallback)
DECLARE FUNCTION dGeomTriMeshGetArrayCallback(BYVAL AS dGeomID) AS dTriArrayCallback

TYPE dTriRayCallback AS FUNCTION(BYVAL AS dGeomID, BYVAL AS dGeomID, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal) AS INTEGER

DECLARE SUB dGeomTriMeshSetRayCallback(BYVAL AS dGeomID, BYVAL AS dTriRayCallback)
DECLARE FUNCTION dGeomTriMeshGetRayCallback(BYVAL AS dGeomID) AS dTriRayCallback

TYPE dTriTriMergeCallback AS FUNCTION(BYVAL AS dGeomID, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER

DECLARE SUB dGeomTriMeshSetTriMergeCallback(BYVAL AS dGeomID, BYVAL AS dTriTriMergeCallback)
DECLARE FUNCTION dGeomTriMeshGetTriMergeCallback(BYVAL AS dGeomID) AS dTriTriMergeCallback
DECLARE FUNCTION dCreateTriMesh(BYVAL AS dSpaceID, BYVAL AS dTriMeshDataID, BYVAL AS dTriCallback, BYVAL AS dTriArrayCallback, BYVAL AS dTriRayCallback) AS dGeomID
DECLARE SUB dGeomTriMeshSetData(BYVAL AS dGeomID, BYVAL AS dTriMeshDataID)
DECLARE FUNCTION dGeomTriMeshGetData(BYVAL AS dGeomID) AS dTriMeshDataID
DECLARE SUB dGeomTriMeshEnableTC(BYVAL AS dGeomID, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE FUNCTION dGeomTriMeshIsTCEnabled(BYVAL AS dGeomID, BYVAL AS INTEGER) AS INTEGER
DECLARE SUB dGeomTriMeshClearTCCache(BYVAL AS dGeomID)
DECLARE FUNCTION dGeomTriMeshGetTriMeshDataID(BYVAL AS dGeomID) AS dTriMeshDataID
DECLARE SUB dGeomTriMeshGetTriangle(BYVAL AS dGeomID, BYVAL AS INTEGER, BYVAL AS dVector3 PTR PTR, BYVAL AS dVector3 PTR PTR, BYVAL AS dVector3 PTR PTR)
DECLARE SUB dGeomTriMeshGetPoint(BYVAL AS dGeomID, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dGeomTriMeshGetTriangleCount(BYVAL AS dGeomID) AS INTEGER
DECLARE SUB dGeomTriMeshDataUpdate(BYVAL AS dTriMeshDataID)

#ENDIF ' _ODE_COLLISION_TRIMESH_H_

DECLARE FUNCTION dCreateGeomTransform(BYVAL AS dSpaceID) AS dGeomID
DECLARE SUB dGeomTransformSetGeom(BYVAL AS dGeomID, BYVAL AS dGeomID)
DECLARE FUNCTION dGeomTransformGetGeom(BYVAL AS dGeomID) AS dGeomID
DECLARE SUB dGeomTransformSetCleanup(BYVAL AS dGeomID, BYVAL AS INTEGER)
DECLARE FUNCTION dGeomTransformGetCleanup(BYVAL AS dGeomID) AS INTEGER
DECLARE SUB dGeomTransformSetInfo(BYVAL AS dGeomID, BYVAL AS INTEGER)
DECLARE FUNCTION dGeomTransformGetInfo(BYVAL AS dGeomID) AS INTEGER

TYPE dxHeightfieldData AS dxHeightfieldData_
TYPE dHeightfieldDataID AS dxHeightfieldData PTR
TYPE dHeightfieldGetHeight AS FUNCTION(BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS dReal

DECLARE FUNCTION dCreateHeightfield(BYVAL AS dSpaceID, BYVAL AS dHeightfieldDataID, BYVAL AS INTEGER) AS dGeomID
DECLARE FUNCTION dGeomHeightfieldDataCreate() AS dHeightfieldDataID
DECLARE SUB dGeomHeightfieldDataDestroy(BYVAL AS dHeightfieldDataID)
DECLARE SUB dGeomHeightfieldDataBuildCallback(BYVAL AS dHeightfieldDataID, BYVAL AS ANY PTR, BYVAL AS dHeightfieldGetHeight, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS INTEGER)
DECLARE SUB dGeomHeightfieldDataBuildByte(BYVAL AS dHeightfieldDataID, BYVAL AS CONST UBYTE PTR, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS INTEGER)
DECLARE SUB dGeomHeightfieldDataBuildShort(BYVAL AS dHeightfieldDataID, BYVAL AS CONST SHORT PTR, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS INTEGER)
DECLARE SUB dGeomHeightfieldDataBuildSingle(BYVAL AS dHeightfieldDataID, BYVAL AS CONST SINGLE PTR, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS INTEGER)
DECLARE SUB dGeomHeightfieldDataBuildDouble(BYVAL AS dHeightfieldDataID, BYVAL AS CONST DOUBLE PTR, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS dReal, BYVAL AS INTEGER)
DECLARE SUB dGeomHeightfieldDataSetBounds(BYVAL AS dHeightfieldDataID, BYVAL AS dReal, BYVAL AS dReal)
DECLARE SUB dGeomHeightfieldSetHeightfieldData(BYVAL AS dGeomID, BYVAL AS dHeightfieldDataID)
DECLARE FUNCTION dGeomHeightfieldGetHeightfieldData(BYVAL AS dGeomID) AS dHeightfieldDataID
DECLARE SUB dClosestLineSegmentPoints(BYVAL AS CONST dVector3 PTR, BYVAL AS CONST dVector3 PTR, BYVAL AS CONST dVector3 PTR, BYVAL AS CONST dVector3 PTR, BYVAL AS dVector3 PTR, BYVAL AS dVector3 PTR)
DECLARE FUNCTION dBoxTouchesBox(BYVAL AS CONST dVector3 PTR, BYVAL AS CONST dMatrix3 PTR, BYVAL AS CONST dVector3 PTR, BYVAL AS CONST dVector3 PTR, BYVAL AS CONST dMatrix3 PTR, BYVAL AS CONST dVector3 PTR) AS INTEGER
DECLARE FUNCTION dBoxBox(BYVAL AS CONST dVector3 PTR, BYVAL AS CONST dMatrix3 PTR, BYVAL AS CONST dVector3 PTR, BYVAL AS CONST dVector3 PTR, BYVAL AS CONST dMatrix3 PTR, BYVAL AS CONST dVector3 PTR, BYVAL AS dVector3 PTR, BYVAL AS dReal PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER, BYVAL AS dContactGeom PTR, BYVAL AS INTEGER) AS INTEGER
DECLARE SUB dInfiniteAABB(BYVAL AS dGeomID, BYVAL AS dReal PTR)

TYPE dGetAABBFn AS SUB(BYVAL AS dGeomID, BYVAL AS dReal PTR)
TYPE dColliderFn AS FUNCTION(BYVAL AS dGeomID, BYVAL AS dGeomID, BYVAL AS INTEGER, BYVAL AS dContactGeom PTR, BYVAL AS INTEGER) AS INTEGER
TYPE dGetColliderFnFn AS FUNCTION(BYVAL AS INTEGER) AS dColliderFn
TYPE dGeomDtorFn AS SUB(BYVAL AS dGeomID)
TYPE dAABBTestFn AS FUNCTION(BYVAL AS dGeomID, BYVAL AS dGeomID, BYVAL AS dReal PTR) AS INTEGER

TYPE dGeomClass
  AS INTEGER bytes
  AS dGetColliderFnFn collider
  AS dGetAABBFn aabb
  AS dAABBTestFn aabb_test
  AS dGeomDtorFn dtor
END TYPE

DECLARE FUNCTION dCreateGeomClass(BYVAL AS CONST dGeomClass PTR) AS INTEGER
DECLARE FUNCTION dGeomGetClassData(BYVAL AS dGeomID) AS ANY PTR
DECLARE FUNCTION dCreateGeom(BYVAL AS INTEGER) AS dGeomID
DECLARE SUB dSetColliderOverride(BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS dColliderFn)

#ENDIF ' _ODE_COLLISION_H_

#IFNDEF _ODE_EXPORT_DIF_
#DEFINE _ODE_EXPORT_DIF_

DECLARE SUB dWorldExportDIF(BYVAL AS dWorldID, BYVAL AS FILE PTR, BYVAL AS CONST ZSTRING PTR)

#ENDIF ' _ODE_EXPORT_DIF_
#ENDIF ' _ODE_ODE_H_

END EXTERN ' (h_2_bi -P_oCD option)

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF

' Translated at 11-12-21 11:16:25, by h_2_bi (version 0.2.1.1,
' released under GPLv3 by Thomas[ dot ]Freiherr{ at }gmx[ dot ]net)

'   Protocol: ode.bi
' Parameters: ode
'                                  Process time [s]: 0.3448729329975322
'                                  Bytes translated: 82930
'                                      Maximum deep: 3
'                                SUB/FUNCTION names: 568
'                                mangled TYPE names: 11
' dxWorld
' dxSpace
' dxBody
' dxGeom
' dxJoint
' dxJointNode
' dxJointGroup
' dMass
' dContactGeom
' dxTriMeshData
' dxHeightfieldData
'                                        files done: 21
' ode-0.11.1/include/ode/ode.h
' ode-0.11.1/include/ode/odeconfig.h
' ode-0.11.1/include/ode/compatibility.h
' ode-0.11.1/include/ode/common.h
' ode-0.11.1/include/ode/error.h
' ode-0.11.1/include/ode/odeinit.h
' ode-0.11.1/include/ode/contact.h
' ode-0.11.1/include/ode/memory.h
' ode-0.11.1/include/ode/odemath.h
' ode-0.11.1/include/ode/matrix.h
' ode-0.11.1/include/ode/timer.h
' ode-0.11.1/include/ode/rotation.h
' ode-0.11.1/include/ode/mass.h
' ode-0.11.1/include/ode/misc.h
' ode-0.11.1/include/ode/objects.h
' ode-0.11.1/include/ode/odecpp.h
' ode-0.11.1/include/ode/collision_space.h
' ode-0.11.1/include/ode/collision.h
' ode-0.11.1/include/ode/collision_trimesh.h
' ode-0.11.1/include/ode/odecpp_collision.h
' ode-0.11.1/include/ode/export-dif.h
'                                      files missed: 1
' float.h
'                                       __FOLDERS__: 3
' ode-0.11.1/include/ode/
' ode-0.11.1/include/
' ode-0.11.1/ode/src/
'                                        __MACROS__: 2
' 550: #define ODE_API
' 4: #define ODE_API_DEPRECATED
'                                       __HEADERS__: 3
' ode/odecpp_collision.h>
' ode/odecpp.h>
' ode/config.h>ode_config.bi
'                                         __TYPES__: 0
'                                     __POST_REPS__: 5
' 1: dSafeNormalize3&_ ALIAS "dSafeNormalize3"
' 1: dSafeNormalize4&_ ALIAS "dSafeNormalize4"
' 1: dNormalize3&_ ALIAS "dNormalize3"
' 1: dNormalize4&_ ALIAS "dNormalize4"
' 1: dDot&_ ALIAS "dDot"
