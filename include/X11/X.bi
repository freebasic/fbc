''
''
'' X -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __X_bi__
#define __X_bi__

#define X_PROTOCOL 11
#define X_PROTOCOL_REVISION 0

type XID as uinteger
type Mask as uinteger
type Atom as uinteger
type VisualID as uinteger
type Time as uinteger
type Window as XID
type Drawable as XID
type Font as XID
type Pixmap as XID
type Cursor as XID
type Colormap as XID
type GContext as XID
type KeySym as XID
type KeyCode as ubyte

#define None 0L
#define ParentRelative 1L
#define CopyFromParent 0L
#define PointerWindow 0L
#define InputFocus 1L
#define PointerRoot 1L
#define AnyPropertyType 0L
#define AnyKey 0L
#define AnyButton 0L
#define AllTemporary 0L
#define CurrentTime 0L
#define NoSymbol 0L
#define NoEventMask 0L
#define KeyPressMask (1L shl 0)
#define KeyReleaseMask (1L shl 1)
#define ButtonPressMask (1L shl 2)
#define ButtonReleaseMask (1L shl 3)
#define EnterWindowMask (1L shl 4)
#define LeaveWindowMask (1L shl 5)
#define PointerMotionMask (1L shl 6)
#define PointerMotionHintMask (1L shl 7)
#define Button1MotionMask (1L shl 8)
#define Button2MotionMask (1L shl 9)
#define Button3MotionMask (1L shl 10)
#define Button4MotionMask (1L shl 11)
#define Button5MotionMask (1L shl 12)
#define ButtonMotionMask (1L shl 13)
#define KeymapStateMask (1L shl 14)
#define ExposureMask (1L shl 15)
#define VisibilityChangeMask (1L shl 16)
#define StructureNotifyMask (1L shl 17)
#define ResizeRedirectMask (1L shl 18)
#define SubstructureNotifyMask (1L shl 19)
#define SubstructureRedirectMask (1L shl 20)
#define FocusChangeMask (1L shl 21)
#define PropertyChangeMask (1L shl 22)
#define ColormapChangeMask (1L shl 23)
#define OwnerGrabButtonMask (1L shl 24)
#define KeyPress 2
#define KeyRelease 3
#define ButtonPress 4
#define ButtonRelease 5
#define MotionNotify 6
#define EnterNotify 7
#define LeaveNotify 8
#define FocusIn 9
#define FocusOut 10
#define KeymapNotify 11
#define Expose 12
#define GraphicsExpose 13
#define NoExpose 14
#define VisibilityNotify 15
#define CreateNotify 16
#define DestroyNotify 17
#define UnmapNotify 18
#define MapNotify 19
#define MapRequest 20
#define ReparentNotify 21
#define ConfigureNotify 22
#define ConfigureRequest 23
#define GravityNotify 24
#define ResizeRequest 25
#define CirculateNotify 26
#define CirculateRequest 27
#define PropertyNotify 28
#define SelectionClear 29
#define SelectionRequest 30
#define SelectionNotify 31
#define ColormapNotify 32
#define ClientMessage 33
#define MappingNotify 34
#define GenericEvent 35
#define LASTEvent 36
#define ShiftMask (1 shl 0)
#define LockMask (1 shl 1)
#define ControlMask (1 shl 2)
#define Mod1Mask (1 shl 3)
#define Mod2Mask (1 shl 4)
#define Mod3Mask (1 shl 5)
#define Mod4Mask (1 shl 6)
#define Mod5Mask (1 shl 7)
#define ShiftMapIndex 0
#define LockMapIndex 1
#define ControlMapIndex 2
#define Mod1MapIndex 3
#define Mod2MapIndex 4
#define Mod3MapIndex 5
#define Mod4MapIndex 6
#define Mod5MapIndex 7
#define Button1Mask (1 shl 8)
#define Button2Mask (1 shl 9)
#define Button3Mask (1 shl 10)
#define Button4Mask (1 shl 11)
#define Button5Mask (1 shl 12)
#define AnyModifier (1 shl 15)
#define Button1 1
#define Button2 2
#define Button3 3
#define Button4 4
#define Button5 5
#define NotifyNormal 0
#define NotifyGrab 1
#define NotifyUngrab 2
#define NotifyWhileGrabbed 3
#define NotifyHint 1
#define NotifyAncestor 0
#define NotifyVirtual 1
#define NotifyInferior 2
#define NotifyNonlinear 3
#define NotifyNonlinearVirtual 4
#define NotifyPointer 5
#define NotifyPointerRoot 6
#define NotifyDetailNone 7
#define VisibilityUnobscured 0
#define VisibilityPartiallyObscured 1
#define VisibilityFullyObscured 2
#define PlaceOnTop 0
#define PlaceOnBottom 1
#define FamilyInternet 0
#define FamilyDECnet 1
#define FamilyChaos 2
#define FamilyInternet6 6
#define FamilyServerInterpreted 5
#define PropertyNewValue 0
#define PropertyDelete 1
#define ColormapUninstalled 0
#define ColormapInstalled 1
#define GrabModeSync 0
#define GrabModeAsync 1
#define GrabSuccess 0
#define AlreadyGrabbed 1
#define GrabInvalidTime 2
#define GrabNotViewable 3
#define GrabFrozen 4
#define AsyncPointer 0
#define SyncPointer 1
#define ReplayPointer 2
#define AsyncKeyboard 3
#define SyncKeyboard 4
#define ReplayKeyboard 5
#define AsyncBoth 6
#define SyncBoth 7
#define RevertToParent 2
#define Success 0
#define BadRequest 1
#define BadValue 2
#define BadWindow 3
#define BadPixmap 4
#define BadAtom 5
#define BadCursor 6
#define BadFont 7
#define BadMatch 8
#define BadDrawable 9
#define BadAccess 10
#define BadAlloc 11
#define BadColor 12
#define BadGC 13
#define BadIDChoice 14
#define BadName 15
#define BadLength 16
#define BadImplementation 17
#define FirstExtensionError 128
#define LastExtensionError 255
#define InputOutput 1
#define InputOnly 2
#define CWBackPixmap (1L shl 0)
#define CWBackPixel (1L shl 1)
#define CWBorderPixmap (1L shl 2)
#define CWBorderPixel (1L shl 3)
#define CWBitGravity (1L shl 4)
#define CWWinGravity (1L shl 5)
#define CWBackingStore (1L shl 6)
#define CWBackingPlanes (1L shl 7)
#define CWBackingPixel (1L shl 8)
#define CWOverrideRedirect (1L shl 9)
#define CWSaveUnder (1L shl 10)
#define CWEventMask (1L shl 11)
#define CWDontPropagate (1L shl 12)
#define CWColormap (1L shl 13)
#define CWCursor (1L shl 14)
#define CWX (1 shl 0)
#define CWY (1 shl 1)
#define CWWidth (1 shl 2)
#define CWHeight (1 shl 3)
#define CWBorderWidth (1 shl 4)
#define CWSibling (1 shl 5)
#define CWStackMode (1 shl 6)
#define ForgetGravity 0
#define NorthWestGravity 1
#define NorthGravity 2
#define NorthEastGravity 3
#define WestGravity 4
#define CenterGravity 5
#define EastGravity 6
#define SouthWestGravity 7
#define SouthGravity 8
#define SouthEastGravity 9
#define StaticGravity 10
#define UnmapGravity 0
#define NotUseful 0
#define WhenMapped 1
#define Always 2
#define IsUnmapped 0
#define IsUnviewable 1
#define IsViewable 2
#define SetModeInsert 0
#define SetModeDelete 1
#define DestroyAll 0
#define RetainPermanent 1
#define RetainTemporary 2
#define Above 0
#define Below 1
#define TopIf 2
#define BottomIf 3
#define Opposite 4
#define RaiseLowest 0
#define LowerHighest 1
#define PropModeReplace 0
#define PropModePrepend 1
#define PropModeAppend 2
#define GXclear &h0
#define GXand &h1
#define GXandReverse &h2
#define GXcopy &h3
#define GXandInverted &h4
#define GXnoop &h5
#define GXxor &h6
#define GXor &h7
#define GXnor &h8
#define GXequiv &h9
#define GXinvert &ha
#define GXorReverse &hb
#define GXcopyInverted &hc
#define GXorInverted &hd
#define GXnand &he
#define GXset &hf
#define LineSolid 0
#define LineOnOffDash 1
#define LineDoubleDash 2
#define CapNotLast 0
#define CapButt 1
#define CapRound 2
#define CapProjecting 3
#define JoinMiter 0
#define JoinRound 1
#define JoinBevel 2
#define FillSolid 0
#define FillTiled 1
#define FillStippled 2
#define FillOpaqueStippled 3
#define EvenOddRule 0
#define WindingRule 1
#define ClipByChildren 0
#define IncludeInferiors 1
#define Unsorted 0
#define YSorted 1
#define YXSorted 2
#define YXBanded 3
#define CoordModeOrigin 0
#define CoordModePrevious 1
#define Complex 0
#define Nonconvex 1
#define Convex 2
#define ArcChord 0
#define ArcPieSlice 1
#define GCFunction (1L shl 0)
#define GCPlaneMask (1L shl 1)
#define GCForeground (1L shl 2)
#define GCBackground (1L shl 3)
#define GCLineWidth (1L shl 4)
#define GCLineStyle (1L shl 5)
#define GCCapStyle (1L shl 6)
#define GCJoinStyle (1L shl 7)
#define GCFillStyle (1L shl 8)
#define GCFillRule (1L shl 9)
#define GCTile (1L shl 10)
#define GCStipple (1L shl 11)
#define GCTileStipXOrigin (1L shl 12)
#define GCTileStipYOrigin (1L shl 13)
#define GCFont (1L shl 14)
#define GCSubwindowMode (1L shl 15)
#define GCGraphicsExposures (1L shl 16)
#define GCClipXOrigin (1L shl 17)
#define GCClipYOrigin (1L shl 18)
#define GCClipMask (1L shl 19)
#define GCDashOffset (1L shl 20)
#define GCDashList (1L shl 21)
#define GCArcMode (1L shl 22)
#define GCLastBit 22
#define FontLeftToRight 0
#define FontRightToLeft 1
#define FontChange 255
#define XYBitmap 0
#define XYPixmap 1
#define ZPixmap 2
#define AllocNone 0
#define AllocAll 1
#define DoRed (1 shl 0)
#define DoGreen (1 shl 1)
#define DoBlue (1 shl 2)
#define CursorShape 0
#define TileShape 1
#define StippleShape 2
#define AutoRepeatModeOff 0
#define AutoRepeatModeOn 1
#define AutoRepeatModeDefault 2
#define LedModeOff 0
#define LedModeOn 1
#define KBKeyClickPercent (1L shl 0)
#define KBBellPercent (1L shl 1)
#define KBBellPitch (1L shl 2)
#define KBBellDuration (1L shl 3)
#define KBLed (1L shl 4)
#define KBLedMode (1L shl 5)
#define KBKey (1L shl 6)
#define KBAutoRepeatMode (1L shl 7)
#define MappingSuccess 0
#define MappingBusy 1
#define MappingFailed 2
#define MappingModifier 0
#define MappingKeyboard 1
#define MappingPointer 2
#define DontPreferBlanking 0
#define PreferBlanking 1
#define DefaultBlanking 2
#define DisableScreenSaver 0
#define DisableScreenInterval 0
#define DontAllowExposures 0
#define AllowExposures 1
#define DefaultExposures 2
#define ScreenSaverReset 0
#define ScreenSaverActive 1
#define HostInsert 0
#define HostDelete 1
#define EnableAccess 1
#define DisableAccess 0
#define StaticGray 0
#define GrayScale 1
#define StaticColor 2
#define PseudoColor 3
#define TrueColor 4
#define DirectColor 5
#define LSBFirst 0
#define MSBFirst 1

#endif
