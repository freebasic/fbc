'' FreeBASIC binding for inputproto-2.3.1
''
'' based on the C header files:
''   **********************************************************
''
''   Copyright 1989, 1998  The Open Group
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
''   Copyright 1989 by Hewlett-Packard Company, Palo Alto, California.
''
''   			All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Hewlett-Packard not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   HEWLETT-PACKARD DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   HEWLETT-PACKARD BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

'' The following symbols have been renamed:
''     constant Relative => XRelative
''     constant Absolute => XAbsolute

#define _XI_H_
const sz_xGetExtensionVersionReq = 8
const sz_xGetExtensionVersionReply = 32
const sz_xListInputDevicesReq = 4
const sz_xListInputDevicesReply = 32
const sz_xOpenDeviceReq = 8
const sz_xOpenDeviceReply = 32
const sz_xCloseDeviceReq = 8
const sz_xSetDeviceModeReq = 8
const sz_xSetDeviceModeReply = 32
const sz_xSelectExtensionEventReq = 12
const sz_xGetSelectedExtensionEventsReq = 8
const sz_xGetSelectedExtensionEventsReply = 32
const sz_xChangeDeviceDontPropagateListReq = 12
const sz_xGetDeviceDontPropagateListReq = 8
const sz_xGetDeviceDontPropagateListReply = 32
const sz_xGetDeviceMotionEventsReq = 16
const sz_xGetDeviceMotionEventsReply = 32
const sz_xChangeKeyboardDeviceReq = 8
const sz_xChangeKeyboardDeviceReply = 32
const sz_xChangePointerDeviceReq = 8
const sz_xChangePointerDeviceReply = 32
const sz_xGrabDeviceReq = 20
const sz_xGrabDeviceReply = 32
const sz_xUngrabDeviceReq = 12
const sz_xGrabDeviceKeyReq = 20
const sz_xGrabDeviceKeyReply = 32
const sz_xUngrabDeviceKeyReq = 16
const sz_xGrabDeviceButtonReq = 20
const sz_xGrabDeviceButtonReply = 32
const sz_xUngrabDeviceButtonReq = 16
const sz_xAllowDeviceEventsReq = 12
const sz_xGetDeviceFocusReq = 8
const sz_xGetDeviceFocusReply = 32
const sz_xSetDeviceFocusReq = 16
const sz_xGetFeedbackControlReq = 8
const sz_xGetFeedbackControlReply = 32
const sz_xChangeFeedbackControlReq = 12
const sz_xGetDeviceKeyMappingReq = 8
const sz_xGetDeviceKeyMappingReply = 32
const sz_xChangeDeviceKeyMappingReq = 8
const sz_xGetDeviceModifierMappingReq = 8
const sz_xSetDeviceModifierMappingReq = 8
const sz_xSetDeviceModifierMappingReply = 32
const sz_xGetDeviceButtonMappingReq = 8
const sz_xGetDeviceButtonMappingReply = 32
const sz_xSetDeviceButtonMappingReq = 8
const sz_xSetDeviceButtonMappingReply = 32
const sz_xQueryDeviceStateReq = 8
const sz_xQueryDeviceStateReply = 32
const sz_xSendExtensionEventReq = 16
const sz_xDeviceBellReq = 8
const sz_xSetDeviceValuatorsReq = 8
const sz_xSetDeviceValuatorsReply = 32
const sz_xGetDeviceControlReq = 8
const sz_xGetDeviceControlReply = 32
const sz_xChangeDeviceControlReq = 8
const sz_xChangeDeviceControlReply = 32
const sz_xListDevicePropertiesReq = 8
const sz_xListDevicePropertiesReply = 32
const sz_xChangeDevicePropertyReq = 20
const sz_xDeleteDevicePropertyReq = 12
const sz_xGetDevicePropertyReq = 24
const sz_xGetDevicePropertyReply = 32
#define INAME "XInputExtension"
#define XI_KEYBOARD "KEYBOARD"
#define XI_MOUSE "MOUSE"
#define XI_TABLET "TABLET"
#define XI_TOUCHSCREEN "TOUCHSCREEN"
#define XI_TOUCHPAD "TOUCHPAD"
#define XI_BARCODE "BARCODE"
#define XI_BUTTONBOX "BUTTONBOX"
#define XI_KNOB_BOX "KNOB_BOX"
#define XI_ONE_KNOB "ONE_KNOB"
#define XI_NINE_KNOB "NINE_KNOB"
#define XI_TRACKBALL "TRACKBALL"
#define XI_QUADRATURE "QUADRATURE"
#define XI_ID_MODULE "ID_MODULE"
#define XI_SPACEBALL "SPACEBALL"
#define XI_DATAGLOVE "DATAGLOVE"
#define XI_EYETRACKER "EYETRACKER"
#define XI_CURSORKEYS "CURSORKEYS"
#define XI_FOOTMOUSE "FOOTMOUSE"
#define XI_JOYSTICK "JOYSTICK"
const Dont_Check = 0
const XInput_Initial_Release = 1
const XInput_Add_XDeviceBell = 2
const XInput_Add_XSetDeviceValuators = 3
const XInput_Add_XChangeDeviceControl = 4
const XInput_Add_DevicePresenceNotify = 5
const XInput_Add_DeviceProperties = 6
const XI_Absent = 0
const XI_Present = 1
const XI_Initial_Release_Major = 1
const XI_Initial_Release_Minor = 0
const XI_Add_XDeviceBell_Major = 1
const XI_Add_XDeviceBell_Minor = 1
const XI_Add_XSetDeviceValuators_Major = 1
const XI_Add_XSetDeviceValuators_Minor = 2
const XI_Add_XChangeDeviceControl_Major = 1
const XI_Add_XChangeDeviceControl_Minor = 3
const XI_Add_DevicePresenceNotify_Major = 1
const XI_Add_DevicePresenceNotify_Minor = 4
const XI_Add_DeviceProperties_Major = 1
const XI_Add_DeviceProperties_Minor = 5
const DEVICE_RESOLUTION = 1
const DEVICE_ABS_CALIB = 2
const DEVICE_CORE = 3
const DEVICE_ENABLE = 4
const DEVICE_ABS_AREA = 5
const NoSuchExtension = 1
const COUNT = 0
const CREATE = 1
const NewPointer = 0
const NewKeyboard = 1
const XPOINTER = 0
const XKEYBOARD = 1
const UseXKeyboard = &hFF
const IsXPointer = 0
const IsXKeyboard = 1
const IsXExtensionDevice = 2
const IsXExtensionKeyboard = 3
const IsXExtensionPointer = 4
const AsyncThisDevice = 0
const SyncThisDevice = 1
const ReplayThisDevice = 2
const AsyncOtherDevices = 3
const AsyncAll = 4
const SyncAll = 5
const FollowKeyboard = 3
const RevertToFollowKeyboard = 3
const DvAccelNum = cast(clong, 1) shl 0
const DvAccelDenom = cast(clong, 1) shl 1
const DvThreshold = cast(clong, 1) shl 2
const DvKeyClickPercent = cast(clong, 1) shl 0
const DvPercent = cast(clong, 1) shl 1
const DvPitch = cast(clong, 1) shl 2
const DvDuration = cast(clong, 1) shl 3
const DvLed = cast(clong, 1) shl 4
const DvLedMode = cast(clong, 1) shl 5
const DvKey = cast(clong, 1) shl 6
const DvAutoRepeatMode = cast(clong, 1) shl 7
const DvString = cast(clong, 1) shl 0
const DvInteger = cast(clong, 1) shl 0
const DeviceMode = cast(clong, 1) shl 0
const XRelative = 0
const XAbsolute = 1
const ProximityState = cast(clong, 1) shl 1
const InProximity = cast(clong, 0) shl 1
const OutOfProximity = cast(clong, 1) shl 1
const AddToList = 0
const DeleteFromList = 1
const KeyClass = 0
const ButtonClass = 1
const ValuatorClass = 2
const FeedbackClass = 3
const ProximityClass = 4
const FocusClass = 5
const OtherClass = 6
const AttachClass = 7
const KbdFeedbackClass = 0
const PtrFeedbackClass = 1
const StringFeedbackClass = 2
const IntegerFeedbackClass = 3
const LedFeedbackClass = 4
const BellFeedbackClass = 5
const _devicePointerMotionHint = 0
const _deviceButton1Motion = 1
const _deviceButton2Motion = 2
const _deviceButton3Motion = 3
const _deviceButton4Motion = 4
const _deviceButton5Motion = 5
const _deviceButtonMotion = 6
const _deviceButtonGrab = 7
const _deviceOwnerGrabButton = 8
const _noExtensionEvent = 9
const _devicePresence = 0
const _deviceEnter = 0
const _deviceLeave = 1
const DeviceAdded = 0
const DeviceRemoved = 1
const DeviceEnabled = 2
const DeviceDisabled = 3
const DeviceUnrecoverable = 4
const DeviceControlChanged = 5
const XI_BadDevice = 0
const XI_BadEvent = 1
const XI_BadMode = 2
const XI_DeviceBusy = 3
const XI_BadClass = 4
type XEventClass as culong

type XExtensionVersion
	present as long
	major_version as short
	minor_version as short
end type
