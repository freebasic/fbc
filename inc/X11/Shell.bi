'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1988, 1994, 1998  The Open Group
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
''
''   Copyright 1987, 1988 by Digital Equipment Corporation, Maynard, Massachusetts.
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
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/SM/SMlib.bi"
#include once "X11/Intrinsic.bi"

'' The following symbols have been renamed:
''     #define XtNwaitforwm => XtNwaitforwm_
''     #define XtCWaitforwm => XtCWaitforwm_

extern "C"

#define _XtShell_h
extern __XtShellStrings alias "XtShellStrings" as const byte
#define XtShellStrings (*cptr(const zstring ptr, @__XtShellStrings))
#define XtNiconName cptr(zstring ptr, @XtShellStrings[0])
#define XtCIconName cptr(zstring ptr, @XtShellStrings[9])
#define XtNiconPixmap cptr(zstring ptr, @XtShellStrings[18])
#define XtCIconPixmap cptr(zstring ptr, @XtShellStrings[29])
#define XtNiconWindow cptr(zstring ptr, @XtShellStrings[40])
#define XtCIconWindow cptr(zstring ptr, @XtShellStrings[51])
#define XtNiconMask cptr(zstring ptr, @XtShellStrings[62])
#define XtCIconMask cptr(zstring ptr, @XtShellStrings[71])
#define XtNwindowGroup cptr(zstring ptr, @XtShellStrings[80])
#define XtCWindowGroup cptr(zstring ptr, @XtShellStrings[92])
#define XtNvisual cptr(zstring ptr, @XtShellStrings[104])
#define XtCVisual cptr(zstring ptr, @XtShellStrings[111])
#define XtNtitleEncoding cptr(zstring ptr, @XtShellStrings[118])
#define XtCTitleEncoding cptr(zstring ptr, @XtShellStrings[132])
#define XtNsaveUnder cptr(zstring ptr, @XtShellStrings[146])
#define XtCSaveUnder cptr(zstring ptr, @XtShellStrings[156])
#define XtNtransient cptr(zstring ptr, @XtShellStrings[166])
#define XtCTransient cptr(zstring ptr, @XtShellStrings[176])
#define XtNoverrideRedirect cptr(zstring ptr, @XtShellStrings[186])
#define XtCOverrideRedirect cptr(zstring ptr, @XtShellStrings[203])
#define XtNtransientFor cptr(zstring ptr, @XtShellStrings[220])
#define XtCTransientFor cptr(zstring ptr, @XtShellStrings[233])
#define XtNiconNameEncoding cptr(zstring ptr, @XtShellStrings[246])
#define XtCIconNameEncoding cptr(zstring ptr, @XtShellStrings[263])
#define XtNallowShellResize cptr(zstring ptr, @XtShellStrings[280])
#define XtCAllowShellResize cptr(zstring ptr, @XtShellStrings[297])
#define XtNcreatePopupChildProc cptr(zstring ptr, @XtShellStrings[314])
#define XtCCreatePopupChildProc cptr(zstring ptr, @XtShellStrings[335])
#define XtNtitle cptr(zstring ptr, @XtShellStrings[356])
#define XtCTitle cptr(zstring ptr, @XtShellStrings[362])
#define XtRAtom cptr(zstring ptr, @XtShellStrings[368])
#define XtNargc cptr(zstring ptr, @XtShellStrings[373])
#define XtCArgc cptr(zstring ptr, @XtShellStrings[378])
#define XtNargv cptr(zstring ptr, @XtShellStrings[383])
#define XtCArgv cptr(zstring ptr, @XtShellStrings[388])
#define XtNiconX cptr(zstring ptr, @XtShellStrings[393])
#define XtCIconX cptr(zstring ptr, @XtShellStrings[399])
#define XtNiconY cptr(zstring ptr, @XtShellStrings[405])
#define XtCIconY cptr(zstring ptr, @XtShellStrings[411])
#define XtNinput cptr(zstring ptr, @XtShellStrings[417])
#define XtCInput cptr(zstring ptr, @XtShellStrings[423])
#define XtNiconic cptr(zstring ptr, @XtShellStrings[429])
#define XtCIconic cptr(zstring ptr, @XtShellStrings[436])
#define XtNinitialState cptr(zstring ptr, @XtShellStrings[443])
#define XtCInitialState cptr(zstring ptr, @XtShellStrings[456])
#define XtNgeometry cptr(zstring ptr, @XtShellStrings[469])
#define XtCGeometry cptr(zstring ptr, @XtShellStrings[478])
#define XtNbaseWidth cptr(zstring ptr, @XtShellStrings[487])
#define XtCBaseWidth cptr(zstring ptr, @XtShellStrings[497])
#define XtNbaseHeight cptr(zstring ptr, @XtShellStrings[507])
#define XtCBaseHeight cptr(zstring ptr, @XtShellStrings[518])
#define XtNwinGravity cptr(zstring ptr, @XtShellStrings[529])
#define XtCWinGravity cptr(zstring ptr, @XtShellStrings[540])
#define XtNminWidth cptr(zstring ptr, @XtShellStrings[551])
#define XtCMinWidth cptr(zstring ptr, @XtShellStrings[560])
#define XtNminHeight cptr(zstring ptr, @XtShellStrings[569])
#define XtCMinHeight cptr(zstring ptr, @XtShellStrings[579])
#define XtNmaxWidth cptr(zstring ptr, @XtShellStrings[589])
#define XtCMaxWidth cptr(zstring ptr, @XtShellStrings[598])
#define XtNmaxHeight cptr(zstring ptr, @XtShellStrings[607])
#define XtCMaxHeight cptr(zstring ptr, @XtShellStrings[617])
#define XtNwidthInc cptr(zstring ptr, @XtShellStrings[627])
#define XtCWidthInc cptr(zstring ptr, @XtShellStrings[636])
#define XtNheightInc cptr(zstring ptr, @XtShellStrings[645])
#define XtCHeightInc cptr(zstring ptr, @XtShellStrings[655])
#define XtNminAspectY cptr(zstring ptr, @XtShellStrings[665])
#define XtCMinAspectY cptr(zstring ptr, @XtShellStrings[676])
#define XtNmaxAspectY cptr(zstring ptr, @XtShellStrings[687])
#define XtCMaxAspectY cptr(zstring ptr, @XtShellStrings[698])
#define XtNminAspectX cptr(zstring ptr, @XtShellStrings[709])
#define XtCMinAspectX cptr(zstring ptr, @XtShellStrings[720])
#define XtNmaxAspectX cptr(zstring ptr, @XtShellStrings[731])
#define XtCMaxAspectX cptr(zstring ptr, @XtShellStrings[742])
#define XtNwmTimeout cptr(zstring ptr, @XtShellStrings[753])
#define XtCWmTimeout cptr(zstring ptr, @XtShellStrings[763])
#define XtNwaitForWm cptr(zstring ptr, @XtShellStrings[773])
#define XtCWaitForWm cptr(zstring ptr, @XtShellStrings[783])
#define XtNwaitforwm_ cptr(zstring ptr, @XtShellStrings[793])
#define XtCWaitforwm_ cptr(zstring ptr, @XtShellStrings[803])
#define XtNclientLeader cptr(zstring ptr, @XtShellStrings[813])
#define XtCClientLeader cptr(zstring ptr, @XtShellStrings[826])
#define XtNwindowRole cptr(zstring ptr, @XtShellStrings[839])
#define XtCWindowRole cptr(zstring ptr, @XtShellStrings[850])
#define XtNurgency cptr(zstring ptr, @XtShellStrings[861])
#define XtCUrgency cptr(zstring ptr, @XtShellStrings[869])
#define XtNcancelCallback cptr(zstring ptr, @XtShellStrings[877])
#define XtNcloneCommand cptr(zstring ptr, @XtShellStrings[892])
#define XtCCloneCommand cptr(zstring ptr, @XtShellStrings[905])
#define XtNconnection cptr(zstring ptr, @XtShellStrings[918])
#define XtCConnection cptr(zstring ptr, @XtShellStrings[929])
#define XtNcurrentDirectory cptr(zstring ptr, @XtShellStrings[940])
#define XtCCurrentDirectory cptr(zstring ptr, @XtShellStrings[957])
#define XtNdieCallback cptr(zstring ptr, @XtShellStrings[974])
#define XtNdiscardCommand cptr(zstring ptr, @XtShellStrings[986])
#define XtCDiscardCommand cptr(zstring ptr, @XtShellStrings[1001])
#define XtNenvironment cptr(zstring ptr, @XtShellStrings[1016])
#define XtCEnvironment cptr(zstring ptr, @XtShellStrings[1028])
#define XtNinteractCallback cptr(zstring ptr, @XtShellStrings[1040])
#define XtNjoinSession cptr(zstring ptr, @XtShellStrings[1057])
#define XtCJoinSession cptr(zstring ptr, @XtShellStrings[1069])
#define XtNprogramPath cptr(zstring ptr, @XtShellStrings[1081])
#define XtCProgramPath cptr(zstring ptr, @XtShellStrings[1093])
#define XtNresignCommand cptr(zstring ptr, @XtShellStrings[1105])
#define XtCResignCommand cptr(zstring ptr, @XtShellStrings[1119])
#define XtNrestartCommand cptr(zstring ptr, @XtShellStrings[1133])
#define XtCRestartCommand cptr(zstring ptr, @XtShellStrings[1148])
#define XtNrestartStyle cptr(zstring ptr, @XtShellStrings[1163])
#define XtCRestartStyle cptr(zstring ptr, @XtShellStrings[1176])
#define XtNsaveCallback cptr(zstring ptr, @XtShellStrings[1189])
#define XtNsaveCompleteCallback cptr(zstring ptr, @XtShellStrings[1202])
#define XtNsessionID cptr(zstring ptr, @XtShellStrings[1223])
#define XtCSessionID cptr(zstring ptr, @XtShellStrings[1233])
#define XtNshutdownCommand cptr(zstring ptr, @XtShellStrings[1243])
#define XtCShutdownCommand cptr(zstring ptr, @XtShellStrings[1259])
#define XtNerrorCallback cptr(zstring ptr, @XtShellStrings[1275])

type ShellWidgetClass as _ShellClassRec ptr
type OverrideShellWidgetClass as _OverrideShellClassRec ptr
type WMShellWidgetClass as _WMShellClassRec ptr
type TransientShellWidgetClass as _TransientShellClassRec ptr
type TopLevelShellWidgetClass as _TopLevelShellClassRec ptr
type ApplicationShellWidgetClass as _ApplicationShellClassRec ptr
type SessionShellWidgetClass as _SessionShellClassRec ptr

extern shellWidgetClass as WidgetClass
extern overrideShellWidgetClass as WidgetClass
extern wmShellWidgetClass as WidgetClass
extern transientShellWidgetClass as WidgetClass
extern topLevelShellWidgetClass as WidgetClass
extern applicationShellWidgetClass as WidgetClass
extern sessionShellWidgetClass as WidgetClass

end extern
