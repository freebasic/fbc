'' FreeBASIC binding for im-3.9.1
''
'' based on the C header files:
''   Copyright (C) 1994-2014 Tecgraf, PUC-Rio.                                
''                                                                            
''   Permission is hereby granted, free of charge, to any person obtaining    
''   a copy of this software and associated documentation files (the          
''   "Software"), to deal in the Software without restriction, including      
''   without limitation the rights to use, copy, modify, merge, publish,      
''   distribute, sublicense, and/or sell copies of the Software, and to       
''   permit persons to whom the Software is furnished to do so, subject to    
''   the following conditions:                                                
''                                                                            
''   The above copyright notice and this permission notice shall be           
''   included in all copies or substantial portions of the Software.          
''                                                                            
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,          
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF       
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY     
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,     
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE        
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                   
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "C"

#define __IM_CAPTURE_H
#define IM_DECL
type imVideoCapture as _imVideoCapture
declare function imVideoCaptureDeviceCount() as long
declare function imVideoCaptureDeviceDesc(byval device as long) as const zstring ptr
declare function imVideoCaptureDeviceExDesc(byval device as long) as const zstring ptr
declare function imVideoCaptureDevicePath(byval device as long) as const zstring ptr
declare function imVideoCaptureDeviceVendorInfo(byval device as long) as const zstring ptr
declare function imVideoCaptureReloadDevices() as long
declare sub imVideoCaptureReleaseDevices()
declare function imVideoCaptureCreate() as imVideoCapture ptr
declare sub imVideoCaptureDestroy(byval vc as imVideoCapture ptr)
declare function imVideoCaptureConnect(byval vc as imVideoCapture ptr, byval device as long) as long
declare sub imVideoCaptureDisconnect(byval vc as imVideoCapture ptr)
declare function imVideoCaptureDialogCount(byval vc as imVideoCapture ptr) as long
declare function imVideoCaptureShowDialog(byval vc as imVideoCapture ptr, byval dialog as long, byval parent as any ptr) as long
declare function imVideoCaptureSetInOut(byval vc as imVideoCapture ptr, byval input as long, byval output as long, byval cross as long) as long
declare function imVideoCaptureDialogDesc(byval vc as imVideoCapture ptr, byval dialog as long) as const zstring ptr
declare function imVideoCaptureFormatCount(byval vc as imVideoCapture ptr) as long
declare function imVideoCaptureGetFormat(byval vc as imVideoCapture ptr, byval format as long, byval width as long ptr, byval height as long ptr, byval desc as zstring ptr) as long
declare function imVideoCaptureSetFormat(byval vc as imVideoCapture ptr, byval format as long) as long
declare sub imVideoCaptureGetImageSize(byval vc as imVideoCapture ptr, byval width as long ptr, byval height as long ptr)
declare function imVideoCaptureSetImageSize(byval vc as imVideoCapture ptr, byval width as long, byval height as long) as long
declare function imVideoCaptureFrame(byval vc as imVideoCapture ptr, byval data as ubyte ptr, byval color_mode as long, byval timeout as long) as long
declare function imVideoCaptureOneFrame(byval vc as imVideoCapture ptr, byval data as ubyte ptr, byval color_mode as long) as long
declare function imVideoCaptureLive(byval vc as imVideoCapture ptr, byval live as long) as long
declare function imVideoCaptureResetAttribute(byval vc as imVideoCapture ptr, byval attrib as const zstring ptr, byval fauto as long) as long
declare function imVideoCaptureGetAttribute(byval vc as imVideoCapture ptr, byval attrib as const zstring ptr, byval percent as single ptr) as long
declare function imVideoCaptureSetAttribute(byval vc as imVideoCapture ptr, byval attrib as const zstring ptr, byval percent as single) as long
declare function imVideoCaptureGetAttributeList(byval vc as imVideoCapture ptr, byval num_attrib as long ptr) as const zstring ptr ptr

end extern
