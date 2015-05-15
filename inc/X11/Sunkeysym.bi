'' FreeBASIC binding for xproto-7.0.27
''
'' based on the C header files:
''   Copyright (c) 1991, Oracle and/or its affiliates. All rights reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice (including the next
''   paragraph) shall be included in all copies or substantial portions of the
''   Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
''   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

const SunXK_FA_Grave = &h1005FF00
const SunXK_FA_Circum = &h1005FF01
const SunXK_FA_Tilde = &h1005FF02
const SunXK_FA_Acute = &h1005FF03
const SunXK_FA_Diaeresis = &h1005FF04
const SunXK_FA_Cedilla = &h1005FF05
const SunXK_F36 = &h1005FF10
const SunXK_F37 = &h1005FF11
const SunXK_Sys_Req = &h1005FF60
const SunXK_Print_Screen = &h0000FF61
const SunXK_Compose = &h0000FF20
const SunXK_AltGraph = &h0000FF7E
const SunXK_PageUp = &h0000FF55
const SunXK_PageDown = &h0000FF56
const SunXK_Undo = &h0000FF65
const SunXK_Again = &h0000FF66
const SunXK_Find = &h0000FF68
const SunXK_Stop = &h0000FF69
const SunXK_Props = &h1005FF70
const SunXK_Front = &h1005FF71
const SunXK_Copy = &h1005FF72
const SunXK_Open = &h1005FF73
const SunXK_Paste = &h1005FF74
const SunXK_Cut = &h1005FF75
const SunXK_PowerSwitch = &h1005FF76
const SunXK_AudioLowerVolume = &h1005FF77
const SunXK_AudioMute = &h1005FF78
const SunXK_AudioRaiseVolume = &h1005FF79
const SunXK_VideoDegauss = &h1005FF7A
const SunXK_VideoLowerBrightness = &h1005FF7B
const SunXK_VideoRaiseBrightness = &h1005FF7C
const SunXK_PowerSwitchShift = &h1005FF7D
