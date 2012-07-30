''
''
'' XLbx -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __XLbx_bi__
#define __XLbx_bi__

#define X_LbxQueryVersion 0
#define X_LbxStartProxy 1
#define X_LbxStopProxy 2
#define X_LbxSwitch 3
#define X_LbxNewClient 4
#define X_LbxCloseClient 5
#define X_LbxModifySequence 6
#define X_LbxAllowMotion 7
#define X_LbxIncrementPixel 8
#define X_LbxDelta 9
#define X_LbxGetModifierMapping 10
#define X_LbxInvalidateTag 12
#define X_LbxPolyPoint 13
#define X_LbxPolyLine 14
#define X_LbxPolySegment 15
#define X_LbxPolyRectangle 16
#define X_LbxPolyArc 17
#define X_LbxFillPoly 18
#define X_LbxPolyFillRectangle 19
#define X_LbxPolyFillArc 20
#define X_LbxGetKeyboardMapping 21
#define X_LbxQueryFont 22
#define X_LbxChangeProperty 23
#define X_LbxGetProperty 24
#define X_LbxTagData 25
#define X_LbxCopyArea 26
#define X_LbxCopyPlane 27
#define X_LbxPolyText8 28
#define X_LbxPolyText16 29
#define X_LbxImageText8 30
#define X_LbxImageText16 31
#define X_LbxQueryExtension 32
#define X_LbxPutImage 33
#define X_LbxGetImage 34
#define X_LbxBeginLargeRequest 35
#define X_LbxLargeRequestData 36
#define X_LbxEndLargeRequest 37
#define X_LbxInternAtoms 38
#define X_LbxGetWinAttrAndGeom 39
#define X_LbxGrabCmap 40
#define X_LbxReleaseCmap 41
#define X_LbxAllocColor 42
#define X_LbxSync 43
#define LbxNumberReqs 44
#define LbxEvent 0
#define LbxQuickMotionDeltaEvent 1
#define LbxNumberEvents 2
#define LbxMasterClientIndex 0
#define LbxSwitchEvent 0
#define LbxCloseEvent 1
#define LbxDeltaEvent 2
#define LbxInvalidateTagEvent 3
#define LbxSendTagDataEvent 4
#define LbxListenToOne 5
#define LbxListenToAll 6
#define LbxMotionDeltaEvent 7
#define LbxReleaseCmapEvent 8
#define LbxFreeCellsEvent 9
#define LbxImageCompressNone 0
#define BadLbxClient 0
#define LbxNumberErrors (0+1)
#define LbxTagTypeModmap 1
#define LbxTagTypeKeymap 2
#define LbxTagTypeProperty 3
#define LbxTagTypeFont 4
#define LbxTagTypeConnInfo 5

declare function XLbxGetEventBase cdecl alias "XLbxGetEventBase" (byval dpy as Display ptr) as integer

#endif
