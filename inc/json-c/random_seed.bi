'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''   random_seed.h
''
''   Copyright (c) 2013 Metaparadigm Pte. Ltd.
''   Michael Clark <michael@metaparadigm.com>
''
''   This library is free software; you can redistribute it and/or modify
''   it under the terms of the MIT license. See COPYING for details.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "C"

#define seed_h
declare function json_c_get_random_seed() as long

end extern
