'' FreeBASIC binding for tre-0.8.0
''
'' based on the C header files:
''   This is the license, copyright notice, and disclaimer for TRE, a regex
''   matching package (library and tools) with support for approximate
''   matching.
''
''   Copyright (c) 2001-2009 Ville Laurikari <vl@iki.fi>
''   All rights reserved.
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions
''   are met:
''
''     1. Redistributions of source code must retain the above copyright
''        notice, this list of conditions and the following disclaimer.
''
''     2. Redistributions in binary form must reproduce the above copyright
''        notice, this list of conditions and the following disclaimer in the
''        documentation and/or other materials provided with the distribution.
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER AND CONTRIBUTORS
''   ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''   A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
''   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
''   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
''   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
''   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
''   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
''   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "tre.bi"

const TRE_REGEX_H = 1

#ifndef TRE_USE_SYSTEM_REGEX_H
	#define regcomp tre_regcomp
	#define regerror tre_regerror
	#define regexec tre_regexec
	#define regfree tre_regfree
#endif

#define regacomp tre_regacomp
#define regaexec tre_regaexec
#define regancomp tre_regancomp
#define reganexec tre_reganexec
#define regawncomp tre_regawncomp
#define regawnexec tre_regawnexec
#define regncomp tre_regncomp
#define regnexec tre_regnexec
#define regwcomp tre_regwcomp
#define regwexec tre_regwexec
#define regwncomp tre_regwncomp
#define regwnexec tre_regwnexec
