' This is file ode_config.bi
' (FreeBasic config file for ODE library version 0.11.1)
'
' translated with help of h_2_bi.bas by
' Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net.
'
' Licence:
' (C) 2011-2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
' See also file ode.bi.

#IFNDEF ODECONFIG_H
#DEFINE ODECONFIG_H

#IFNDEF dDOUBLE
#IFNDEF dSINGLE
#PRINT ode.bi message: neither dSINGLE nor dDOUBLE #defined -> set default (dDOULE)
#DEFINE dDOUBLE
#ENDIF ' dSINGLE
#ENDIF ' dDOUBLE

#INCLUDE ONCE "crt/stdio.bi" '__HEADERS__: stdio.h
#INCLUDE ONCE "crt/stdlib.bi" '__HEADERS__: stdlib.h
#INCLUDE ONCE "crt/stdarg.bi" '__HEADERS__: stdarg.h
#INCLUDE ONCE "crt/math.bi" '__HEADERS__: math.h
#INCLUDE ONCE "crt/string.bi" '__HEADERS__: string.h

#DEFINE __ODE__

TYPE int32 AS INTEGER
TYPE uint32 AS UINTEGER
TYPE int16 AS SHORT
TYPE uint16 AS USHORT
TYPE int8 AS UBYTE
TYPE uint8 AS UBYTE

#IFDEF dSINGLE

CONST AS UINTEGER _INF_ = &b01111111100000000000000000000000
#DEFINE dIsNan(_V_) IIF((_INF_ AND CVI(MKS(_V_))) = _INF_, 1, 0)
#DEFINE dInfinity CVS(MKI(_INF_))

#ELSE ' dSINGLE

CONST AS ULONGINT _INF_ = &b0111111111110000000000000000000000000000000000000000000000000000
#DEFINE dIsNan(_V_) IIF((_INF_ AND CVLONGINT(MKD(_V_))) = _INF_, 1, 0)
#DEFINE dInfinity CVD(MKLONGINT(_INF_))

#ENDIF ' dSINGLE

' additional FB macros for easy vector/matrix handling, examples:
'   VAR a = NEW_dVector3(0,0,0)
'   VAR b = NEW_dMatrix3({1,0,0},{0,1,0},{0,0,1})
'   VAR c = NEW_dVector3(3,7,1)
'   ...
'   dMULTIPLY0_331(a,b,c)
'   ...
'   DELETE c
'   DELETE b
'   DELETE a
#DEFINE NEW_dVector3(VA...) CAST(dReal PTR, NEW dVector3({VA}))
#DEFINE NEW_dVector4(VA...) CAST(dReal PTR, NEW dVector4({VA}))
#DEFINE NEW_dMatrix3(VA...) CAST(dReal PTR, NEW dMatrix3({VA}))
#DEFINE NEW_dMatrix4(VA...) CAST(dReal PTR, NEW dMatrix4({VA}))
#DEFINE NEW_dMatrix6(VA...) CAST(dReal PTR, NEW dMatrix6({VA}))
#DEFINE NEW_dQuaternion(VA...) CAST(dReal PTR, NEW dQuaternion({VA}))

#ENDIF ' ODECONFIG_H
