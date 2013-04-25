''
''
'' im_process_loc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_process_loc_bi__
#define __im_process_loc_bi__

declare function imProcessReduce cdecl alias "imProcessReduce" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval order as integer) as integer
declare function imProcessResize cdecl alias "imProcessResize" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval order as integer) as integer
declare sub imProcessReduceBy4 cdecl alias "imProcessReduceBy4" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessCrop cdecl alias "imProcessCrop" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval xmin as integer, byval ymin as integer)
declare sub imProcessInsert cdecl alias "imProcessInsert" (byval src_image as imImage ptr, byval region_image as imImage ptr, byval dst_image as imImage ptr, byval xmin as integer, byval ymin as integer)
declare sub imProcessAddMargins cdecl alias "imProcessAddMargins" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval xmin as integer, byval ymin as integer)
declare sub imProcessCalcRotateSize cdecl alias "imProcessCalcRotateSize" (byval width as integer, byval height as integer, byval new_width as integer ptr, byval new_height as integer ptr, byval cos0 as double, byval sin0 as double)
declare function imProcessRotate cdecl alias "imProcessRotate" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval cos0 as double, byval sin0 as double, byval order as integer) as integer
declare function imProcessRotateRef cdecl alias "imProcessRotateRef" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval cos0 as double, byval sin0 as double, byval x as integer, byval y as integer, byval to_origin as integer, byval order as integer) as integer
declare sub imProcessRotate90 cdecl alias "imProcessRotate90" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval dir_clockwise as integer)
declare sub imProcessRotate180 cdecl alias "imProcessRotate180" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessMirror cdecl alias "imProcessMirror" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessFlip cdecl alias "imProcessFlip" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare function imProcessRadial cdecl alias "imProcessRadial" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval k1 as single, byval order as integer) as integer
declare function imProcessSwirl cdecl alias "imProcessSwirl" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval k1 as single, byval order as integer) as integer
declare sub imProcessInterlaceSplit cdecl alias "imProcessInterlaceSplit" (byval src_image as imImage ptr, byval dst_image1 as imImage ptr, byval dst_image2 as imImage ptr)
declare function imProcessGrayMorphConvolve cdecl alias "imProcessGrayMorphConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel as imImage ptr, byval ismax as integer) as integer
declare function imProcessGrayMorphErode cdecl alias "imProcessGrayMorphErode" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessGrayMorphDilate cdecl alias "imProcessGrayMorphDilate" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessGrayMorphOpen cdecl alias "imProcessGrayMorphOpen" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessGrayMorphClose cdecl alias "imProcessGrayMorphClose" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessGrayMorphTopHat cdecl alias "imProcessGrayMorphTopHat" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessGrayMorphWell cdecl alias "imProcessGrayMorphWell" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessGrayMorphGradient cdecl alias "imProcessGrayMorphGradient" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessBinMorphConvolve cdecl alias "imProcessBinMorphConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel as imImage ptr, byval hit_white as integer, byval iter as integer) as integer
declare function imProcessBinMorphErode cdecl alias "imProcessBinMorphErode" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer, byval iter as integer) as integer
declare function imProcessBinMorphDilate cdecl alias "imProcessBinMorphDilate" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer, byval iter as integer) as integer
declare function imProcessBinMorphOpen cdecl alias "imProcessBinMorphOpen" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer, byval iter as integer) as integer
declare function imProcessBinMorphClose cdecl alias "imProcessBinMorphClose" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer, byval iter as integer) as integer
declare function imProcessBinMorphOutline cdecl alias "imProcessBinMorphOutline" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer, byval iter as integer) as integer
declare sub imProcessBinMorphThin cdecl alias "imProcessBinMorphThin" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare function imProcessMedianConvolve cdecl alias "imProcessMedianConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessRangeConvolve cdecl alias "imProcessRangeConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessRankClosestConvolve cdecl alias "imProcessRankClosestConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessRankMaxConvolve cdecl alias "imProcessRankMaxConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessRankMinConvolve cdecl alias "imProcessRankMinConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessRangeContrastThreshold cdecl alias "imProcessRangeContrastThreshold" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer, byval min_range as integer) as integer
declare function imProcessLocalMaxThreshold cdecl alias "imProcessLocalMaxThreshold" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer, byval min_level as integer) as integer
declare function imProcessConvolve cdecl alias "imProcessConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel as imImage ptr) as integer
declare function imProcessConvolveSep cdecl alias "imProcessConvolveSep" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel as imImage ptr) as integer
declare function imProcessConvolveDual cdecl alias "imProcessConvolveDual" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel1 as imImage ptr, byval kernel2 as imImage ptr) as integer
declare function imProcessConvolveRep cdecl alias "imProcessConvolveRep" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel as imImage ptr, byval count as integer) as integer
declare function imProcessCompassConvolve cdecl alias "imProcessCompassConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel as imImage ptr) as integer
declare sub imProcessRotateKernel cdecl alias "imProcessRotateKernel" (byval kernel as imImage ptr)
declare function imProcessDiffOfGaussianConvolve cdecl alias "imProcessDiffOfGaussianConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval stddev1 as single, byval stddev2 as single) as integer
declare function imProcessLapOfGaussianConvolve cdecl alias "imProcessLapOfGaussianConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval stddev as single) as integer
declare function imProcessMeanConvolve cdecl alias "imProcessMeanConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessGaussianConvolve cdecl alias "imProcessGaussianConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval stddev as single) as integer
declare function imProcessBarlettConvolve cdecl alias "imProcessBarlettConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval kernel_size as integer) as integer
declare function imProcessSobelConvolve cdecl alias "imProcessSobelConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr) as integer
declare function imProcessPrewittConvolve cdecl alias "imProcessPrewittConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr) as integer
declare function imProcessSplineEdgeConvolve cdecl alias "imProcessSplineEdgeConvolve" (byval src_image as imImage ptr, byval dst_image as imImage ptr) as integer
declare sub imProcessZeroCrossing cdecl alias "imProcessZeroCrossing" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessCanny cdecl alias "imProcessCanny" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval stddev as single)
declare function imGaussianStdDev2KernelSize cdecl alias "imGaussianStdDev2KernelSize" (byval stddev as single) as integer
declare function imGaussianKernelSize2StdDev cdecl alias "imGaussianKernelSize2StdDev" (byval kernel_size as integer) as single
declare function imProcessUnsharp cdecl alias "imProcessUnsharp" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval stddev as single, byval amount as single, byval threshold as single) as integer
declare function imProcessSharp cdecl alias "imProcessSharp" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval amount as single, byval threshold as single) as integer
declare function imProcessSharpKernel cdecl alias "imProcessSharpKernel" (byval src_image as imImage ptr, byval kernel as imImage ptr, byval dst_image as imImage ptr, byval amount as single, byval threshold as single) as integer

#endif
