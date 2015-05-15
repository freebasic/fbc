'' FreeBASIC binding for xproto-7.0.27
''
'' based on the C header files:
''   ****************************************************************
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
''   This software is not subject to any license of the American
''   Telephone and Telegraph Company or of the Regents of the
''   University of California.
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

const apXK_LineDel = &h1000FF00
const apXK_CharDel = &h1000FF01
const apXK_Copy = &h1000FF02
const apXK_Cut = &h1000FF03
const apXK_Paste = &h1000FF04
const apXK_Move = &h1000FF05
const apXK_Grow = &h1000FF06
const apXK_Cmd = &h1000FF07
const apXK_Shell = &h1000FF08
const apXK_LeftBar = &h1000FF09
const apXK_RightBar = &h1000FF0A
const apXK_LeftBox = &h1000FF0B
const apXK_RightBox = &h1000FF0C
const apXK_UpBox = &h1000FF0D
const apXK_DownBox = &h1000FF0E
const apXK_Pop = &h1000FF0F
const apXK_Read = &h1000FF10
const apXK_Edit = &h1000FF11
const apXK_Save = &h1000FF12
const apXK_Exit = &h1000FF13
const apXK_Repeat = &h1000FF14
const apXK_KP_parenleft = &h1000FFA8
const apXK_KP_parenright = &h1000FFA9
