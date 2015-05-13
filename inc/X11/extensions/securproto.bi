#pragma once

#include once "X11/extensions/secur.bi"

'' The following symbols have been renamed:
''     typedef xSecurityAuthorizationRevokedEvent => xSecurityAuthorizationRevokedEvent_

#define _SECURPROTO_H
const X_SecurityQueryVersion = 0
const X_SecurityGenerateAuthorization = 1
const X_SecurityRevokeAuthorization = 2

type xSecurityQueryVersionReq
	reqType as CARD8
	securityReqType as CARD8
	length as CARD16
	majorVersion as CARD16
	minorVersion as CARD16
end type

const sz_xSecurityQueryVersionReq = 8

type xSecurityQueryVersionReply
	as CARD8 type
	pad0 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD16
	minorVersion as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xSecurityQueryVersionReply = 32

type xSecurityGenerateAuthorizationReq
	reqType as CARD8
	securityReqType as CARD8
	length as CARD16
	nbytesAuthProto as CARD16
	nbytesAuthData as CARD16
	valueMask as CARD32
end type

const sz_xSecurityGenerateAuthorizationReq = 12

type xSecurityGenerateAuthorizationReply
	as CARD8 type
	pad0 as CARD8
	sequenceNumber as CARD16
	length as CARD32
	authId as CARD32
	dataLength as CARD16
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xSecurityGenerateAuthorizationReply = 32

type xSecurityRevokeAuthorizationReq
	reqType as CARD8
	securityReqType as CARD8
	length as CARD16
	authId as CARD32
end type

const sz_xSecurityRevokeAuthorizationReq = 8

type _xSecurityAuthorizationRevokedEvent
	as UBYTE type
	detail as UBYTE
	sequenceNumber as CARD16
	authId as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

type xSecurityAuthorizationRevokedEvent_ as _xSecurityAuthorizationRevokedEvent
const sz_xSecurityAuthorizationRevokedEvent = 32
