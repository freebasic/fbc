''
''
'' im_process_glo -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_process_glo_bi__
#define __im_process_glo_bi__

declare function imProcessHoughLines cdecl alias "imProcessHoughLines" (byval src_image as imImage ptr, byval dst_image as imImage ptr) as integer
declare function imProcessHoughLinesDraw cdecl alias "imProcessHoughLinesDraw" (byval src_image as imImage ptr, byval hough as imImage ptr, byval hough_points as imImage ptr, byval dst_image as imImage ptr) as integer
declare sub imProcessCrossCorrelation cdecl alias "imProcessCrossCorrelation" (byval src_image1 as imImage ptr, byval src_image2 as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessAutoCorrelation cdecl alias "imProcessAutoCorrelation" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessDistanceTransform cdecl alias "imProcessDistanceTransform" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessRegionalMaximum cdecl alias "imProcessRegionalMaximum" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessFFT cdecl alias "imProcessFFT" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessIFFT cdecl alias "imProcessIFFT" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessFFTraw cdecl alias "imProcessFFTraw" (byval image as imImage ptr, byval inverse as integer, byval center as integer, byval normalize as integer)
declare sub imProcessSwapQuadrants cdecl alias "imProcessSwapQuadrants" (byval image as imImage ptr, byval center2origin as integer)
declare function imProcessOpenMPSetMinCount cdecl alias "imProcessOpenMPSetMinCount" (byval min_count as integer) as integer
declare function imProcessOpenMPSetNumThreads cdecl alias "imProcessOpenMPSetNumThreads" (byval count as integer) as integer

#endif
