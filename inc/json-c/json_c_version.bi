'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''   Copyright (c) 2012 Eric Haszlakiewicz
''
''   This library is free software; you can redistribute it and/or modify
''   it under the terms of the MIT license. See COPYING for details.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

'' The following symbols have been renamed:
''     constant JSON_C_VERSION_NUM => JSON_C_VERSION_NUM_
''     #define JSON_C_VERSION => JSON_C_VERSION_

extern "C"

#define _json_c_version_h_
const JSON_C_MAJOR_VERSION = 0
const JSON_C_MINOR_VERSION = 12
const JSON_C_MICRO_VERSION = 0
const JSON_C_VERSION_NUM_ = ((JSON_C_MAJOR_VERSION shl 16) or (JSON_C_MINOR_VERSION shl 8)) or JSON_C_MICRO_VERSION
#define JSON_C_VERSION_ "0.12"
declare function json_c_version() as const zstring ptr
declare function json_c_version_num() as long

end extern
