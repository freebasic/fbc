'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

type REFPROPERTYKEY as const PROPERTYKEY const ptr
#define IsEqualPropertyKey(a, b) (((a).pid = (b).pid) andalso IsEqualIID(@(a).fmtid, @(b).fmtid))
#define _PROPERTYKEY_EQUALITY_OPERATORS_
