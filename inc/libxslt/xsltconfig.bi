'' FreeBASIC binding for libxslt-1.1.28
''
'' based on the C header files:
''    Copyright (C) 2001-2002 Daniel Veillard.  All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is fur-
''   nished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FIT-
''   NESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   DANIEL VEILLARD BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON-
''   NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of Daniel Veillard shall not
''   be used in advertising or otherwise to promote the sale, use or other deal-
''   ings in this Software without prior written authorization from him.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define __XML_XSLTCONFIG_H__
#define LIBXSLT_DOTTED_VERSION "1.1.28"
const LIBXSLT_VERSION = 10128
#define LIBXSLT_VERSION_STRING "10128"
#define LIBXSLT_VERSION_EXTRA "-GITv1.1.27-16-g9382efe"
#define WITH_XSLT_DEBUG
#define WITH_DEBUGGER
#define WITH_MODULES
#define LIBXSLT_DEFAULT_PLUGINS_PATH() "/usr/lib/libxslt-plugins"
