''
''
'' contact -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __contact_bi__
#define __contact_bi__

#include once "ode/common.bi"

enum 
	dContactMu2 = &h001
	dContactFDir1 = &h002
	dContactBounce = &h004
	dContactSoftERP = &h008
	dContactSoftCFM = &h010
	dContactMotion1 = &h020
	dContactMotion2 = &h040
	dContactSlip1 = &h080
	dContactSlip2 = &h100
	dContactApprox0 = &h0000
	dContactApprox1_1 = &h1000
	dContactApprox1_2 = &h2000
	dContactApprox1 = &h3000
end enum

type dSurfaceParameters
	mode as integer
	mu as dReal
	mu2 as dReal
	bounce as dReal
	bounce_vel as dReal
	soft_erp as dReal
	soft_cfm as dReal
	motion1 as dReal
	motion2 as dReal
	slip1 as dReal
	slip2 as dReal
end type

type dContactGeom
	pos as dVector3
	normal as dVector3
	depth as dReal
	g1 as dGeomID
	g2 as dGeomID
end type

type dContact
	surface as dSurfaceParameters
	geom as dContactGeom
	fdir1 as dVector3
end type

#endif
