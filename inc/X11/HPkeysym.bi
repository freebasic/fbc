'' FreeBASIC binding for xproto-7.0.27
''
'' based on the C header files:
''
''   Copyright 1987, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included
''   in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR
''   OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
''   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
''   OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall
''   not be used in advertising or otherwise to promote the sale, use or
''   other dealings in this Software without prior written authorization
''   from The Open Group.
''
''   Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts,
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the names of Hewlett Packard
''   or Digital not be
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
''   HEWLETT-PACKARD MAKES NO WARRANTY OF ANY KIND WITH REGARD
''   TO THIS SOFWARE, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
''   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
''   PURPOSE.  Hewlett-Packard shall not be liable for errors
''   contained herein or direct, indirect, special, incidental or
''   consequential damages in connection with the furnishing,
''   performance, or use of this material.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _HPKEYSYM
const hpXK_ClearLine = &h1000FF6F
const hpXK_InsertLine = &h1000FF70
const hpXK_DeleteLine = &h1000FF71
const hpXK_InsertChar = &h1000FF72
const hpXK_DeleteChar = &h1000FF73
const hpXK_BackTab = &h1000FF74
const hpXK_KP_BackTab = &h1000FF75
const hpXK_Modelock1 = &h1000FF48
const hpXK_Modelock2 = &h1000FF49
const hpXK_Reset = &h1000FF6C
const hpXK_System = &h1000FF6D
const hpXK_User = &h1000FF6E
const hpXK_mute_acute = &h100000A8
const hpXK_mute_grave = &h100000A9
const hpXK_mute_asciicircum = &h100000AA
const hpXK_mute_diaeresis = &h100000AB
const hpXK_mute_asciitilde = &h100000AC
const hpXK_lira = &h100000AF
const hpXK_guilder = &h100000BE
const hpXK_Ydiaeresis = &h100000EE
const hpXK_IO = &h100000EE
const hpXK_longminus = &h100000F6
const hpXK_block = &h100000FC
#define _OSF_Keysyms
const osfXK_Copy = &h1004FF02
const osfXK_Cut = &h1004FF03
const osfXK_Paste = &h1004FF04
const osfXK_BackTab = &h1004FF07
const osfXK_BackSpace = &h1004FF08
const osfXK_Clear = &h1004FF0B
const osfXK_Escape = &h1004FF1B
const osfXK_AddMode = &h1004FF31
const osfXK_PrimaryPaste = &h1004FF32
const osfXK_QuickPaste = &h1004FF33
const osfXK_PageLeft = &h1004FF40
const osfXK_PageUp = &h1004FF41
const osfXK_PageDown = &h1004FF42
const osfXK_PageRight = &h1004FF43
const osfXK_Activate = &h1004FF44
const osfXK_MenuBar = &h1004FF45
const osfXK_Left = &h1004FF51
const osfXK_Up = &h1004FF52
const osfXK_Right = &h1004FF53
const osfXK_Down = &h1004FF54
const osfXK_EndLine = &h1004FF57
const osfXK_BeginLine = &h1004FF58
const osfXK_EndData = &h1004FF59
const osfXK_BeginData = &h1004FF5A
const osfXK_PrevMenu = &h1004FF5B
const osfXK_NextMenu = &h1004FF5C
const osfXK_PrevField = &h1004FF5D
const osfXK_NextField = &h1004FF5E
const osfXK_Select = &h1004FF60
const osfXK_Insert = &h1004FF63
const osfXK_Undo = &h1004FF65
const osfXK_Menu = &h1004FF67
const osfXK_Cancel = &h1004FF69
const osfXK_Help = &h1004FF6A
const osfXK_SelectAll = &h1004FF71
const osfXK_DeselectAll = &h1004FF72
const osfXK_Reselect = &h1004FF73
const osfXK_Extend = &h1004FF74
const osfXK_Restore = &h1004FF78
const osfXK_Delete = &h1004FFFF
const XK_Reset = &h1000FF6C
const XK_System = &h1000FF6D
const XK_User = &h1000FF6E
const XK_ClearLine = &h1000FF6F
const XK_InsertLine = &h1000FF70
const XK_DeleteLine = &h1000FF71
const XK_InsertChar = &h1000FF72
const XK_DeleteChar = &h1000FF73
const XK_BackTab = &h1000FF74
const XK_KP_BackTab = &h1000FF75
const XK_Ext16bit_L = &h1000FF76
const XK_Ext16bit_R = &h1000FF77
const XK_mute_acute = &h100000a8
const XK_mute_grave = &h100000a9
const XK_mute_asciicircum = &h100000aa
const XK_mute_diaeresis = &h100000ab
const XK_mute_asciitilde = &h100000ac
const XK_lira = &h100000af
const XK_guilder = &h100000be
const XK_IO = &h100000ee
const XK_longminus = &h100000f6
const XK_block = &h100000fc
