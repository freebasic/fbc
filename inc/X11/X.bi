'' FreeBASIC binding for xproto-7.0.27
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1998  The Open Group
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
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

'' The following symbols have been renamed:
''     typedef Atom => XAtom

#define X_H
const X_PROTOCOL = 11
const X_PROTOCOL_REVISION = 0
#define _XTYPEDEF_XID
type XID as culong
#define _XTYPEDEF_MASK
type Mask as culong
#define _XTYPEDEF_ATOM

type XAtom as culong
type VisualID as culong
type Time as culong
type Window as XID
type Drawable as XID
#define _XTYPEDEF_FONT
type Font as XID
type Pixmap as XID
type Cursor as XID
type Colormap as XID
type GContext as XID
type KeySym as XID
type KeyCode as ubyte

const None = cast(clong, 0)
const ParentRelative = cast(clong, 1)
const CopyFromParent = cast(clong, 0)
const PointerWindow = cast(clong, 0)
const InputFocus = cast(clong, 1)
const PointerRoot = cast(clong, 1)
const AnyPropertyType = cast(clong, 0)
const AnyKey = cast(clong, 0)
const AnyButton = cast(clong, 0)
const AllTemporary = cast(clong, 0)
const CurrentTime = cast(clong, 0)
const NoSymbol = cast(clong, 0)
const NoEventMask = cast(clong, 0)
const KeyPressMask = cast(clong, 1) shl 0
const KeyReleaseMask = cast(clong, 1) shl 1
const ButtonPressMask = cast(clong, 1) shl 2
const ButtonReleaseMask = cast(clong, 1) shl 3
const EnterWindowMask = cast(clong, 1) shl 4
const LeaveWindowMask = cast(clong, 1) shl 5
const PointerMotionMask = cast(clong, 1) shl 6
const PointerMotionHintMask = cast(clong, 1) shl 7
const Button1MotionMask = cast(clong, 1) shl 8
const Button2MotionMask = cast(clong, 1) shl 9
const Button3MotionMask = cast(clong, 1) shl 10
const Button4MotionMask = cast(clong, 1) shl 11
const Button5MotionMask = cast(clong, 1) shl 12
const ButtonMotionMask = cast(clong, 1) shl 13
const KeymapStateMask = cast(clong, 1) shl 14
const ExposureMask = cast(clong, 1) shl 15
const VisibilityChangeMask = cast(clong, 1) shl 16
const StructureNotifyMask = cast(clong, 1) shl 17
const ResizeRedirectMask = cast(clong, 1) shl 18
const SubstructureNotifyMask = cast(clong, 1) shl 19
const SubstructureRedirectMask = cast(clong, 1) shl 20
const FocusChangeMask = cast(clong, 1) shl 21
const PropertyChangeMask = cast(clong, 1) shl 22
const ColormapChangeMask = cast(clong, 1) shl 23
const OwnerGrabButtonMask = cast(clong, 1) shl 24
const KeyPress = 2
const KeyRelease = 3
const ButtonPress = 4
const ButtonRelease = 5
const MotionNotify = 6
const EnterNotify = 7
const LeaveNotify = 8
const FocusIn = 9
const FocusOut = 10
const KeymapNotify = 11
const Expose = 12
const GraphicsExpose = 13
const NoExpose = 14
const VisibilityNotify = 15
const CreateNotify = 16
const DestroyNotify = 17
const UnmapNotify = 18
const MapNotify = 19
const MapRequest = 20
const ReparentNotify = 21
const ConfigureNotify = 22
const ConfigureRequest = 23
const GravityNotify = 24
const ResizeRequest = 25
const CirculateNotify = 26
const CirculateRequest = 27
const PropertyNotify = 28
const SelectionClear = 29
const SelectionRequest = 30
const SelectionNotify = 31
const ColormapNotify = 32
const ClientMessage = 33
const MappingNotify = 34
const GenericEvent = 35
const LASTEvent = 36
const ShiftMask = 1 shl 0
const LockMask = 1 shl 1
const ControlMask = 1 shl 2
const Mod1Mask = 1 shl 3
const Mod2Mask = 1 shl 4
const Mod3Mask = 1 shl 5
const Mod4Mask = 1 shl 6
const Mod5Mask = 1 shl 7
const ShiftMapIndex = 0
const LockMapIndex = 1
const ControlMapIndex = 2
const Mod1MapIndex = 3
const Mod2MapIndex = 4
const Mod3MapIndex = 5
const Mod4MapIndex = 6
const Mod5MapIndex = 7
const Button1Mask = 1 shl 8
const Button2Mask = 1 shl 9
const Button3Mask = 1 shl 10
const Button4Mask = 1 shl 11
const Button5Mask = 1 shl 12
const AnyModifier = 1 shl 15
const Button1 = 1
const Button2 = 2
const Button3 = 3
const Button4 = 4
const Button5 = 5
const NotifyNormal = 0
const NotifyGrab = 1
const NotifyUngrab = 2
const NotifyWhileGrabbed = 3
const NotifyHint = 1
const NotifyAncestor = 0
const NotifyVirtual = 1
const NotifyInferior = 2
const NotifyNonlinear = 3
const NotifyNonlinearVirtual = 4
const NotifyPointer = 5
const NotifyPointerRoot = 6
const NotifyDetailNone = 7
const VisibilityUnobscured = 0
const VisibilityPartiallyObscured = 1
const VisibilityFullyObscured = 2
const PlaceOnTop = 0
const PlaceOnBottom = 1
const FamilyInternet = 0
const FamilyDECnet = 1
const FamilyChaos = 2
const FamilyInternet6 = 6
const FamilyServerInterpreted = 5
const PropertyNewValue = 0
const PropertyDelete = 1
const ColormapUninstalled = 0
const ColormapInstalled = 1
const GrabModeSync = 0
const GrabModeAsync = 1
const GrabSuccess = 0
const AlreadyGrabbed = 1
const GrabInvalidTime = 2
const GrabNotViewable = 3
const GrabFrozen = 4
const AsyncPointer = 0
const SyncPointer = 1
const ReplayPointer = 2
const AsyncKeyboard = 3
const SyncKeyboard = 4
const ReplayKeyboard = 5
const AsyncBoth = 6
const SyncBoth = 7
const RevertToNone = clng(None)
const RevertToPointerRoot = clng(PointerRoot)
const RevertToParent = 2
const Success = 0
const BadRequest = 1
const BadValue = 2
const BadWindow = 3
const BadPixmap = 4
const BadAtom = 5
const BadCursor = 6
const BadFont = 7
const BadMatch = 8
const BadDrawable = 9
const BadAccess = 10
const BadAlloc = 11
const BadColor = 12
const BadGC = 13
const BadIDChoice = 14
const BadName = 15
const BadLength = 16
const BadImplementation = 17
const FirstExtensionError = 128
const LastExtensionError = 255
const InputOutput = 1
const InputOnly = 2
const CWBackPixmap = cast(clong, 1) shl 0
const CWBackPixel = cast(clong, 1) shl 1
const CWBorderPixmap = cast(clong, 1) shl 2
const CWBorderPixel = cast(clong, 1) shl 3
const CWBitGravity = cast(clong, 1) shl 4
const CWWinGravity = cast(clong, 1) shl 5
const CWBackingStore = cast(clong, 1) shl 6
const CWBackingPlanes = cast(clong, 1) shl 7
const CWBackingPixel = cast(clong, 1) shl 8
const CWOverrideRedirect = cast(clong, 1) shl 9
const CWSaveUnder = cast(clong, 1) shl 10
const CWEventMask = cast(clong, 1) shl 11
const CWDontPropagate = cast(clong, 1) shl 12
const CWColormap = cast(clong, 1) shl 13
const CWCursor = cast(clong, 1) shl 14
const CWX = 1 shl 0
const CWY = 1 shl 1
const CWWidth = 1 shl 2
const CWHeight = 1 shl 3
const CWBorderWidth = 1 shl 4
const CWSibling = 1 shl 5
const CWStackMode = 1 shl 6
const ForgetGravity = 0
const NorthWestGravity = 1
const NorthGravity = 2
const NorthEastGravity = 3
const WestGravity = 4
const CenterGravity = 5
const EastGravity = 6
const SouthWestGravity = 7
const SouthGravity = 8
const SouthEastGravity = 9
const StaticGravity = 10
const UnmapGravity = 0
const NotUseful = 0
const WhenMapped = 1
const Always = 2
const IsUnmapped = 0
const IsUnviewable = 1
const IsViewable = 2
const SetModeInsert = 0
const SetModeDelete = 1
const DestroyAll = 0
const RetainPermanent = 1
const RetainTemporary = 2
const Above = 0
const Below = 1
const TopIf = 2
const BottomIf = 3
const Opposite = 4
const RaiseLowest = 0
const LowerHighest = 1
const PropModeReplace = 0
const PropModePrepend = 1
const PropModeAppend = 2
const GXclear = &h0
const GXand = &h1
const GXandReverse = &h2
const GXcopy = &h3
const GXandInverted = &h4
const GXnoop = &h5
const GXxor = &h6
const GXor = &h7
const GXnor = &h8
const GXequiv = &h9
const GXinvert = &ha
const GXorReverse = &hb
const GXcopyInverted = &hc
const GXorInverted = &hd
const GXnand = &he
const GXset = &hf
const LineSolid = 0
const LineOnOffDash = 1
const LineDoubleDash = 2
const CapNotLast = 0
const CapButt = 1
const CapRound = 2
const CapProjecting = 3
const JoinMiter = 0
const JoinRound = 1
const JoinBevel = 2
const FillSolid = 0
const FillTiled = 1
const FillStippled = 2
const FillOpaqueStippled = 3
const EvenOddRule = 0
const WindingRule = 1
const ClipByChildren = 0
const IncludeInferiors = 1
const Unsorted = 0
const YSorted = 1
const YXSorted = 2
const YXBanded = 3
const CoordModeOrigin = 0
const CoordModePrevious = 1
const Complex = 0
const Nonconvex = 1
const Convex = 2
const ArcChord = 0
const ArcPieSlice = 1
const GCFunction = cast(clong, 1) shl 0
const GCPlaneMask = cast(clong, 1) shl 1
const GCForeground = cast(clong, 1) shl 2
const GCBackground = cast(clong, 1) shl 3
const GCLineWidth = cast(clong, 1) shl 4
const GCLineStyle = cast(clong, 1) shl 5
const GCCapStyle = cast(clong, 1) shl 6
const GCJoinStyle = cast(clong, 1) shl 7
const GCFillStyle = cast(clong, 1) shl 8
const GCFillRule = cast(clong, 1) shl 9
const GCTile = cast(clong, 1) shl 10
const GCStipple = cast(clong, 1) shl 11
const GCTileStipXOrigin = cast(clong, 1) shl 12
const GCTileStipYOrigin = cast(clong, 1) shl 13
const GCFont = cast(clong, 1) shl 14
const GCSubwindowMode = cast(clong, 1) shl 15
const GCGraphicsExposures = cast(clong, 1) shl 16
const GCClipXOrigin = cast(clong, 1) shl 17
const GCClipYOrigin = cast(clong, 1) shl 18
const GCClipMask = cast(clong, 1) shl 19
const GCDashOffset = cast(clong, 1) shl 20
const GCDashList = cast(clong, 1) shl 21
const GCArcMode = cast(clong, 1) shl 22
const GCLastBit = 22
const FontLeftToRight = 0
const FontRightToLeft = 1
const FontChange = 255
const XYBitmap = 0
const XYPixmap = 1
const ZPixmap = 2
const AllocNone = 0
const AllocAll = 1
const DoRed = 1 shl 0
const DoGreen = 1 shl 1
const DoBlue = 1 shl 2
const CursorShape = 0
const TileShape = 1
const StippleShape = 2
const AutoRepeatModeOff = 0
const AutoRepeatModeOn = 1
const AutoRepeatModeDefault = 2
const LedModeOff = 0
const LedModeOn = 1
const KBKeyClickPercent = cast(clong, 1) shl 0
const KBBellPercent = cast(clong, 1) shl 1
const KBBellPitch = cast(clong, 1) shl 2
const KBBellDuration = cast(clong, 1) shl 3
const KBLed = cast(clong, 1) shl 4
const KBLedMode = cast(clong, 1) shl 5
const KBKey = cast(clong, 1) shl 6
const KBAutoRepeatMode = cast(clong, 1) shl 7
const MappingSuccess = 0
const MappingBusy = 1
const MappingFailed = 2
const MappingModifier = 0
const MappingKeyboard = 1
const MappingPointer = 2
const DontPreferBlanking = 0
const PreferBlanking = 1
const DefaultBlanking = 2
const DisableScreenSaver = 0
const DisableScreenInterval = 0
const DontAllowExposures = 0
const AllowExposures = 1
const DefaultExposures = 2
const ScreenSaverReset = 0
const ScreenSaverActive = 1
const HostInsert = 0
const HostDelete = 1
const EnableAccess = 1
const DisableAccess = 0
const StaticGray = 0
const GrayScale = 1
const StaticColor = 2
const PseudoColor = 3
const TrueColor = 4
const DirectColor = 5
const LSBFirst = 0
const MSBFirst = 1
