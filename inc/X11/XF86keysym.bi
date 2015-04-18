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
''
''   Copyright 1985, 1987, 1988, 1990, 1991, 1993-1996, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''   The X Window System is a Trademark of The Open Group.
''
''
''   Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Digital not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''
''   Copyright 1987 by Apollo Computer Inc., Chelmsford, Massachusetts.
''   Copyright 1989 by Hewlett-Packard Company.
''
''                           All Rights Reserved
''
''   Permission to use, duplicate, change, and distribute this software and
''   its documentation for any purpose and without fee is granted, provided
''   that the above copyright notice appear in such copy and that this
''   copyright notice appear in all supporting documentation, and that the
''   names of Apollo Computer Inc., the Hewlett-Packard Company, or the X
''   Consortium not be used in advertising or publicity pertaining to
''   distribution of the software without written prior permission.
''
''   HEWLETT-PACKARD MAKES NO WARRANTY OF ANY KIND WITH REGARD
''   TO THIS SOFWARE, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
''   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
''   PURPOSE.  Hewlett-Packard shall not be liable for errors
''   contained herein or direct, indirect, special, incidental or
''   consequential damages in connection with the furnishing,
''   performance, or use of this material.
''
''
''   Copyright (c) 1999  The XFree86 Project Inc.
''
''   All Rights Reserved.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The XFree86 Project
''   Inc. shall not be used in advertising or otherwise to promote the
''   sale, use or other dealings in this Software without prior written
''   authorization from The XFree86 Project Inc.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

const XF86XK_ModeLock = &h1008FF01
const XF86XK_MonBrightnessUp = &h1008FF02
const XF86XK_MonBrightnessDown = &h1008FF03
const XF86XK_KbdLightOnOff = &h1008FF04
const XF86XK_KbdBrightnessUp = &h1008FF05
const XF86XK_KbdBrightnessDown = &h1008FF06
const XF86XK_Standby = &h1008FF10
const XF86XK_AudioLowerVolume = &h1008FF11
const XF86XK_AudioMute = &h1008FF12
const XF86XK_AudioRaiseVolume = &h1008FF13
const XF86XK_AudioPlay = &h1008FF14
const XF86XK_AudioStop = &h1008FF15
const XF86XK_AudioPrev = &h1008FF16
const XF86XK_AudioNext = &h1008FF17
const XF86XK_HomePage = &h1008FF18
const XF86XK_Mail = &h1008FF19
const XF86XK_Start = &h1008FF1A
const XF86XK_Search = &h1008FF1B
const XF86XK_AudioRecord = &h1008FF1C
const XF86XK_Calculator = &h1008FF1D
const XF86XK_Memo = &h1008FF1E
const XF86XK_ToDoList = &h1008FF1F
const XF86XK_Calendar = &h1008FF20
const XF86XK_PowerDown = &h1008FF21
const XF86XK_ContrastAdjust = &h1008FF22
const XF86XK_RockerUp = &h1008FF23
const XF86XK_RockerDown = &h1008FF24
const XF86XK_RockerEnter = &h1008FF25
const XF86XK_Back = &h1008FF26
const XF86XK_Forward = &h1008FF27
const XF86XK_Stop = &h1008FF28
const XF86XK_Refresh = &h1008FF29
const XF86XK_PowerOff = &h1008FF2A
const XF86XK_WakeUp = &h1008FF2B
const XF86XK_Eject = &h1008FF2C
const XF86XK_ScreenSaver = &h1008FF2D
const XF86XK_WWW = &h1008FF2E
const XF86XK_Sleep = &h1008FF2F
const XF86XK_Favorites = &h1008FF30
const XF86XK_AudioPause = &h1008FF31
const XF86XK_AudioMedia = &h1008FF32
const XF86XK_MyComputer = &h1008FF33
const XF86XK_VendorHome = &h1008FF34
const XF86XK_LightBulb = &h1008FF35
const XF86XK_Shop = &h1008FF36
const XF86XK_History = &h1008FF37
const XF86XK_OpenURL = &h1008FF38
const XF86XK_AddFavorite = &h1008FF39
const XF86XK_HotLinks = &h1008FF3A
const XF86XK_BrightnessAdjust = &h1008FF3B
const XF86XK_Finance = &h1008FF3C
const XF86XK_Community = &h1008FF3D
const XF86XK_AudioRewind = &h1008FF3E
const XF86XK_BackForward = &h1008FF3F
const XF86XK_Launch0 = &h1008FF40
const XF86XK_Launch1 = &h1008FF41
const XF86XK_Launch2 = &h1008FF42
const XF86XK_Launch3 = &h1008FF43
const XF86XK_Launch4 = &h1008FF44
const XF86XK_Launch5 = &h1008FF45
const XF86XK_Launch6 = &h1008FF46
const XF86XK_Launch7 = &h1008FF47
const XF86XK_Launch8 = &h1008FF48
const XF86XK_Launch9 = &h1008FF49
const XF86XK_LaunchA = &h1008FF4A
const XF86XK_LaunchB = &h1008FF4B
const XF86XK_LaunchC = &h1008FF4C
const XF86XK_LaunchD = &h1008FF4D
const XF86XK_LaunchE = &h1008FF4E
const XF86XK_LaunchF = &h1008FF4F
const XF86XK_ApplicationLeft = &h1008FF50
const XF86XK_ApplicationRight = &h1008FF51
const XF86XK_Book = &h1008FF52
const XF86XK_CD = &h1008FF53
const XF86XK_Calculater = &h1008FF54
const XF86XK_Clear = &h1008FF55
const XF86XK_Close = &h1008FF56
const XF86XK_Copy = &h1008FF57
const XF86XK_Cut = &h1008FF58
const XF86XK_Display = &h1008FF59
const XF86XK_DOS = &h1008FF5A
const XF86XK_Documents = &h1008FF5B
const XF86XK_Excel = &h1008FF5C
const XF86XK_Explorer = &h1008FF5D
const XF86XK_Game = &h1008FF5E
const XF86XK_Go = &h1008FF5F
const XF86XK_iTouch = &h1008FF60
const XF86XK_LogOff = &h1008FF61
const XF86XK_Market = &h1008FF62
const XF86XK_Meeting = &h1008FF63
const XF86XK_MenuKB = &h1008FF65
const XF86XK_MenuPB = &h1008FF66
const XF86XK_MySites = &h1008FF67
const XF86XK_New = &h1008FF68
const XF86XK_News = &h1008FF69
const XF86XK_OfficeHome = &h1008FF6A
const XF86XK_Open = &h1008FF6B
const XF86XK_Option = &h1008FF6C
const XF86XK_Paste = &h1008FF6D
const XF86XK_Phone = &h1008FF6E
const XF86XK_Q = &h1008FF70
const XF86XK_Reply = &h1008FF72
const XF86XK_Reload = &h1008FF73
const XF86XK_RotateWindows = &h1008FF74
const XF86XK_RotationPB = &h1008FF75
const XF86XK_RotationKB = &h1008FF76
const XF86XK_Save = &h1008FF77
const XF86XK_ScrollUp = &h1008FF78
const XF86XK_ScrollDown = &h1008FF79
const XF86XK_ScrollClick = &h1008FF7A
const XF86XK_Send = &h1008FF7B
const XF86XK_Spell = &h1008FF7C
const XF86XK_SplitScreen = &h1008FF7D
const XF86XK_Support = &h1008FF7E
const XF86XK_TaskPane = &h1008FF7F
const XF86XK_Terminal = &h1008FF80
const XF86XK_Tools = &h1008FF81
const XF86XK_Travel = &h1008FF82
const XF86XK_UserPB = &h1008FF84
const XF86XK_User1KB = &h1008FF85
const XF86XK_User2KB = &h1008FF86
const XF86XK_Video = &h1008FF87
const XF86XK_WheelButton = &h1008FF88
const XF86XK_Word = &h1008FF89
const XF86XK_Xfer = &h1008FF8A
const XF86XK_ZoomIn = &h1008FF8B
const XF86XK_ZoomOut = &h1008FF8C
const XF86XK_Away = &h1008FF8D
const XF86XK_Messenger = &h1008FF8E
const XF86XK_WebCam = &h1008FF8F
const XF86XK_MailForward = &h1008FF90
const XF86XK_Pictures = &h1008FF91
const XF86XK_Music = &h1008FF92
const XF86XK_Battery = &h1008FF93
const XF86XK_Bluetooth = &h1008FF94
const XF86XK_WLAN = &h1008FF95
const XF86XK_UWB = &h1008FF96
const XF86XK_AudioForward = &h1008FF97
const XF86XK_AudioRepeat = &h1008FF98
const XF86XK_AudioRandomPlay = &h1008FF99
const XF86XK_Subtitle = &h1008FF9A
const XF86XK_AudioCycleTrack = &h1008FF9B
const XF86XK_CycleAngle = &h1008FF9C
const XF86XK_FrameBack = &h1008FF9D
const XF86XK_FrameForward = &h1008FF9E
const XF86XK_Time = &h1008FF9F
const XF86XK_Select = &h1008FFA0
const XF86XK_View = &h1008FFA1
const XF86XK_TopMenu = &h1008FFA2
const XF86XK_Red = &h1008FFA3
const XF86XK_Green = &h1008FFA4
const XF86XK_Yellow = &h1008FFA5
const XF86XK_Blue = &h1008FFA6
const XF86XK_Suspend = &h1008FFA7
const XF86XK_Hibernate = &h1008FFA8
const XF86XK_TouchpadToggle = &h1008FFA9
const XF86XK_TouchpadOn = &h1008FFB0
const XF86XK_TouchpadOff = &h1008FFB1
const XF86XK_AudioMicMute = &h1008FFB2
const XF86XK_Switch_VT_1 = &h1008FE01
const XF86XK_Switch_VT_2 = &h1008FE02
const XF86XK_Switch_VT_3 = &h1008FE03
const XF86XK_Switch_VT_4 = &h1008FE04
const XF86XK_Switch_VT_5 = &h1008FE05
const XF86XK_Switch_VT_6 = &h1008FE06
const XF86XK_Switch_VT_7 = &h1008FE07
const XF86XK_Switch_VT_8 = &h1008FE08
const XF86XK_Switch_VT_9 = &h1008FE09
const XF86XK_Switch_VT_10 = &h1008FE0A
const XF86XK_Switch_VT_11 = &h1008FE0B
const XF86XK_Switch_VT_12 = &h1008FE0C
const XF86XK_Ungrab = &h1008FE20
const XF86XK_ClearGrab = &h1008FE21
const XF86XK_Next_VMode = &h1008FE22
const XF86XK_Prev_VMode = &h1008FE23
const XF86XK_LogWindowTree = &h1008FE24
const XF86XK_LogGrabInfo = &h1008FE25
