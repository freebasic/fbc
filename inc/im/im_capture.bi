''
''
'' im_capture -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_capture_bi__
#define __im_capture_bi__

type imVideoCapture as _imVideoCapture

declare function imVideoCaptureDeviceCount cdecl alias "imVideoCaptureDeviceCount" () as integer
declare function imVideoCaptureDeviceDesc cdecl alias "imVideoCaptureDeviceDesc" (byval device as integer) as zstring ptr
declare function imVideoCaptureDeviceExDesc cdecl alias "imVideoCaptureDeviceExDesc" (byval device as integer) as zstring ptr
declare function imVideoCaptureDevicePath cdecl alias "imVideoCaptureDevicePath" (byval device as integer) as zstring ptr
declare function imVideoCaptureDeviceVendorInfo cdecl alias "imVideoCaptureDeviceVendorInfo" (byval device as integer) as zstring ptr
declare function imVideoCaptureReloadDevices cdecl alias "imVideoCaptureReloadDevices" () as integer
declare sub imVideoCaptureReleaseDevices cdecl alias "imVideoCaptureReleaseDevices" ()
declare function imVideoCaptureCreate cdecl alias "imVideoCaptureCreate" () as imVideoCapture ptr
declare sub imVideoCaptureDestroy cdecl alias "imVideoCaptureDestroy" (byval vc as imVideoCapture ptr)
declare function imVideoCaptureConnect cdecl alias "imVideoCaptureConnect" (byval vc as imVideoCapture ptr, byval device as integer) as integer
declare sub imVideoCaptureDisconnect cdecl alias "imVideoCaptureDisconnect" (byval vc as imVideoCapture ptr)
declare function imVideoCaptureDialogCount cdecl alias "imVideoCaptureDialogCount" (byval vc as imVideoCapture ptr) as integer
declare function imVideoCaptureShowDialog cdecl alias "imVideoCaptureShowDialog" (byval vc as imVideoCapture ptr, byval dialog as integer, byval parent as any ptr) as integer
declare function imVideoCaptureSetInOut cdecl alias "imVideoCaptureSetInOut" (byval vc as imVideoCapture ptr, byval input as integer, byval output as integer, byval cross as integer) as integer
declare function imVideoCaptureDialogDesc cdecl alias "imVideoCaptureDialogDesc" (byval vc as imVideoCapture ptr, byval dialog as integer) as zstring ptr
declare function imVideoCaptureFormatCount cdecl alias "imVideoCaptureFormatCount" (byval vc as imVideoCapture ptr) as integer
declare function imVideoCaptureGetFormat cdecl alias "imVideoCaptureGetFormat" (byval vc as imVideoCapture ptr, byval format as integer, byval width as integer ptr, byval height as integer ptr, byval desc as zstring ptr) as integer
declare function imVideoCaptureSetFormat cdecl alias "imVideoCaptureSetFormat" (byval vc as imVideoCapture ptr, byval format as integer) as integer
declare sub imVideoCaptureGetImageSize cdecl alias "imVideoCaptureGetImageSize" (byval vc as imVideoCapture ptr, byval width as integer ptr, byval height as integer ptr)
declare function imVideoCaptureSetImageSize cdecl alias "imVideoCaptureSetImageSize" (byval vc as imVideoCapture ptr, byval width as integer, byval height as integer) as integer
declare function imVideoCaptureFrame cdecl alias "imVideoCaptureFrame" (byval vc as imVideoCapture ptr, byval data as ubyte ptr, byval color_mode as integer, byval timeout as integer) as integer
declare function imVideoCaptureOneFrame cdecl alias "imVideoCaptureOneFrame" (byval vc as imVideoCapture ptr, byval data as ubyte ptr, byval color_mode as integer) as integer
declare function imVideoCaptureLive cdecl alias "imVideoCaptureLive" (byval vc as imVideoCapture ptr, byval live as integer) as integer
declare function imVideoCaptureResetAttribute cdecl alias "imVideoCaptureResetAttribute" (byval vc as imVideoCapture ptr, byval attrib as zstring ptr, byval fauto as integer) as integer
declare function imVideoCaptureGetAttribute cdecl alias "imVideoCaptureGetAttribute" (byval vc as imVideoCapture ptr, byval attrib as zstring ptr, byval percent as single ptr) as integer
declare function imVideoCaptureSetAttribute cdecl alias "imVideoCaptureSetAttribute" (byval vc as imVideoCapture ptr, byval attrib as zstring ptr, byval percent as single) as integer
declare function imVideoCaptureGetAttributeList cdecl alias "imVideoCaptureGetAttributeList" (byval vc as imVideoCapture ptr, byval num_attrib as integer ptr) as byte ptr ptr

#endif
