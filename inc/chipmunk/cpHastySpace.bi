'' FreeBASIC binding for Chipmunk-7.0.3
''
'' based on the C header files:
''   Copyright (c) 2007-2015 Scott Lembcke and Howling Moon Software
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is
''   furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
''   SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2021 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

extern "C"

declare function cpHastySpaceNew() as cpSpace ptr
declare sub cpHastySpaceFree(byval space as cpSpace ptr)
declare sub cpHastySpaceSetThreads(byval space as cpSpace ptr, byval threads as culong)
declare function cpHastySpaceGetThreads(byval space as cpSpace ptr) as culong
declare sub cpHastySpaceStep(byval space as cpSpace ptr, byval dt as cpFloat)

end extern
