#pragma once

#define _SECUR_H
#define SECURITY_EXTENSION_NAME "SECURITY"
const SECURITY_MAJOR_VERSION = 1
const SECURITY_MINOR_VERSION = 0
const XSecurityNumberEvents = 1
const XSecurityNumberErrors = 2
const XSecurityBadAuthorization = 0
const XSecurityBadAuthorizationProtocol = 1
const XSecurityClientTrusted = 0
const XSecurityClientUntrusted = 1
const XSecurityTimeout = 1 shl 0
const XSecurityTrustLevel = 1 shl 1
const XSecurityGroup = 1 shl 2
const XSecurityEventMask = 1 shl 3
#define XSecurityAllAuthorizationAttributes (((XSecurityTimeout or XSecurityTrustLevel) or XSecurityGroup) or XSecurityEventMask)
const XSecurityAuthorizationRevokedMask = 1 shl 0
#define XSecurityAllEventMasks XSecurityAuthorizationRevokedMask
const XSecurityAuthorizationRevoked = 0
#define XSecurityAuthorizationName "XC-QUERY-SECURITY-1"
const XSecurityAuthorizationNameLen = 19
