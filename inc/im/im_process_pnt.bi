''
''
'' im_process_pnt -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_process_pnt_bi__
#define __im_process_pnt_bi__

type imUnaryPointOpFunc as function cdecl(byval as single, byval as single ptr, byval as single ptr, byval as any ptr, byval as integer, byval as integer, byval as integer) as integer

declare function imProcessUnaryPointOp cdecl alias "imProcessUnaryPointOp" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval func as imUnaryPointOpFunc, byval params as single ptr, byval userdata as any ptr, byval op_name as zstring ptr) as integer

type imUnaryPointColorOpFunc as function cdecl(byval as single ptr, byval as single ptr, byval as single ptr, byval as any ptr, byval as integer, byval as integer) as integer

declare function imProcessUnaryPointColorOp cdecl alias "imProcessUnaryPointColorOp" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval func as imUnaryPointColorOpFunc, byval params as single ptr, byval userdata as any ptr, byval op_name as zstring ptr) as integer

type imMultiPointOpFunc as function cdecl(byval as single ptr, byval as single ptr, byval as single ptr, byval as any ptr, byval as integer, byval as integer, byval as integer) as integer

declare function imProcessMultiPointOp cdecl alias "imProcessMultiPointOp" (byval src_image as imImage ptr ptr, byval src_count as integer, byval dst_image as imImage ptr, byval func as imMultiPointOpFunc, byval params as single ptr, byval userdata as any ptr, byval op_name as zstring ptr) as integer

type imMultiPointColorOpFunc as function cdecl(byval as single ptr, byval as single ptr, byval as single ptr, byval as any ptr, byval as integer, byval as integer) as integer

declare function imProcessMultiPointColorOp cdecl alias "imProcessMultiPointColorOp" (byval src_image as imImage ptr ptr, byval src_count as integer, byval dst_image as imImage ptr, byval func as imMultiPointColorOpFunc, byval params as single ptr, byval userdata as any ptr, byval op_name as zstring ptr) as integer

enum imUnaryOp
	IM_UN_EQL
	IM_UN_ABS
	IM_UN_LESS
	IM_UN_INV
	IM_UN_SQR
	IM_UN_SQRT
	IM_UN_LOG
	IM_UN_EXP
	IM_UN_SIN
	IM_UN_COS
	IM_UN_CONJ
	IM_UN_CPXNORM
	IM_UN_POSITIVES
	IM_UN_NEGATIVES
end enum

declare sub imProcessUnArithmeticOp cdecl alias "imProcessUnArithmeticOp" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval op as integer)

enum imBinaryOp
	IM_BIN_ADD
	IM_BIN_SUB
	IM_BIN_MUL
	IM_BIN_DIV
	IM_BIN_DIFF
	IM_BIN_POW
	IM_BIN_MIN
	IM_BIN_MAX
end enum

declare sub imProcessArithmeticOp cdecl alias "imProcessArithmeticOp" (byval src_image1 as imImage ptr, byval src_image2 as imImage ptr, byval dst_image as imImage ptr, byval op as integer)
declare sub imProcessArithmeticConstOp cdecl alias "imProcessArithmeticConstOp" (byval src_image as imImage ptr, byval src_const as single, byval dst_image as imImage ptr, byval op as integer)
declare sub imProcessBlendConst cdecl alias "imProcessBlendConst" (byval src_image1 as imImage ptr, byval src_image2 as imImage ptr, byval dst_image as imImage ptr, byval alpha as single)
declare sub imProcessBlend cdecl alias "imProcessBlend" (byval src_image1 as imImage ptr, byval src_image2 as imImage ptr, byval alpha_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessCompose cdecl alias "imProcessCompose" (byval src_image1 as imImage ptr, byval src_image2 as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessSplitComplex cdecl alias "imProcessSplitComplex" (byval src_image as imImage ptr, byval dst_image1 as imImage ptr, byval dst_image2 as imImage ptr, byval polar as integer)
declare sub imProcessMergeComplex cdecl alias "imProcessMergeComplex" (byval src_image1 as imImage ptr, byval src_image2 as imImage ptr, byval dst_image as imImage ptr, byval polar as integer)
declare sub imProcessMultipleMean cdecl alias "imProcessMultipleMean" (byval src_image_list as imImage ptr ptr, byval src_image_count as integer, byval dst_image as imImage ptr)
declare sub imProcessMultipleStdDev cdecl alias "imProcessMultipleStdDev" (byval src_image_list as imImage ptr ptr, byval src_image_count as integer, byval mean_image as imImage ptr, byval dst_image as imImage ptr)
declare function imProcessAutoCovariance cdecl alias "imProcessAutoCovariance" (byval src_image as imImage ptr, byval mean_image as imImage ptr, byval dst_image as imImage ptr) as integer
declare sub imProcessMultiplyConj cdecl alias "imProcessMultiplyConj" (byval src_image1 as imImage ptr, byval src_image2 as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessQuantizeRGBUniform cdecl alias "imProcessQuantizeRGBUniform" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval do_dither as integer)
declare sub imProcessQuantizeGrayUniform cdecl alias "imProcessQuantizeGrayUniform" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval grays as integer)
declare sub imProcessExpandHistogram cdecl alias "imProcessExpandHistogram" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval percent as single)
declare sub imProcessEqualizeHistogram cdecl alias "imProcessEqualizeHistogram" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessSplitYChroma cdecl alias "imProcessSplitYChroma" (byval src_image as imImage ptr, byval y_image as imImage ptr, byval chroma_image as imImage ptr)
declare sub imProcessSplitHSI cdecl alias "imProcessSplitHSI" (byval src_image as imImage ptr, byval h_image as imImage ptr, byval s_image as imImage ptr, byval i_image as imImage ptr)
declare sub imProcessMergeHSI cdecl alias "imProcessMergeHSI" (byval h_image as imImage ptr, byval s_image as imImage ptr, byval i_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessSplitComponents cdecl alias "imProcessSplitComponents" (byval src_image as imImage ptr, byval dst_image_list as imImage ptr ptr)
declare sub imProcessMergeComponents cdecl alias "imProcessMergeComponents" (byval src_image_list as imImage ptr ptr, byval dst_image as imImage ptr)
declare sub imProcessNormalizeComponents cdecl alias "imProcessNormalizeComponents" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessReplaceColor cdecl alias "imProcessReplaceColor" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval src_color as single ptr, byval dst_color as single ptr)
declare sub imProcessSetAlphaColor cdecl alias "imProcessSetAlphaColor" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval src_color as single ptr, byval dst_alpha as single)

enum imLogicOp
	IM_BIT_AND
	IM_BIT_OR
	IM_BIT_XOR
end enum

declare sub imProcessBitwiseOp cdecl alias "imProcessBitwiseOp" (byval src_image1 as imImage ptr, byval src_image2 as imImage ptr, byval dst_image as imImage ptr, byval op as integer)
declare sub imProcessBitwiseNot cdecl alias "imProcessBitwiseNot" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessBitMask cdecl alias "imProcessBitMask" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval mask as ubyte, byval op as integer)
declare sub imProcessBitPlane cdecl alias "imProcessBitPlane" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval plane as integer, byval do_reset as integer)

type imRenderFunc as function cdecl(byval as integer, byval as integer, byval as integer, byval as single ptr) as single
type imRenderCondFunc as function cdecl(byval as integer, byval as integer, byval as integer, byval as integer ptr, byval as single ptr) as single

declare function imProcessRenderOp cdecl alias "imProcessRenderOp" (byval image as imImage ptr, byval render_func as imRenderFunc, byval render_name as zstring ptr, byval params as single ptr, byval plus as integer) as integer
declare function imProcessRenderCondOp cdecl alias "imProcessRenderCondOp" (byval image as imImage ptr, byval render_cond_func as imRenderCondFunc, byval render_name as zstring ptr, byval params as single ptr) as integer
declare function imProcessRenderAddSpeckleNoise cdecl alias "imProcessRenderAddSpeckleNoise" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval percent as single) as integer
declare function imProcessRenderAddGaussianNoise cdecl alias "imProcessRenderAddGaussianNoise" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval mean as single, byval stddev as single) as integer
declare function imProcessRenderAddUniformNoise cdecl alias "imProcessRenderAddUniformNoise" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval mean as single, byval stddev as single) as integer
declare function imProcessRenderRandomNoise cdecl alias "imProcessRenderRandomNoise" (byval image as imImage ptr) as integer
declare function imProcessRenderConstant cdecl alias "imProcessRenderConstant" (byval image as imImage ptr, byval value as single ptr) as integer
declare function imProcessRenderWheel cdecl alias "imProcessRenderWheel" (byval image as imImage ptr, byval internal_radius as integer, byval external_radius as integer) as integer
declare function imProcessRenderCone cdecl alias "imProcessRenderCone" (byval image as imImage ptr, byval radius as integer) as integer
declare function imProcessRenderTent cdecl alias "imProcessRenderTent" (byval image as imImage ptr, byval tent_width as integer, byval tent_height as integer) as integer
declare function imProcessRenderRamp cdecl alias "imProcessRenderRamp" (byval image as imImage ptr, byval start as integer, byval end as integer, byval vert_dir as integer) as integer
declare function imProcessRenderBox cdecl alias "imProcessRenderBox" (byval image as imImage ptr, byval box_width as integer, byval box_height as integer) as integer
declare function imProcessRenderSinc cdecl alias "imProcessRenderSinc" (byval image as imImage ptr, byval x_period as single, byval y_period as single) as integer
declare function imProcessRenderGaussian cdecl alias "imProcessRenderGaussian" (byval image as imImage ptr, byval stddev as single) as integer
declare function imProcessRenderLapOfGaussian cdecl alias "imProcessRenderLapOfGaussian" (byval image as imImage ptr, byval stddev as single) as integer
declare function imProcessRenderCosine cdecl alias "imProcessRenderCosine" (byval image as imImage ptr, byval x_period as single, byval y_period as single) as integer
declare function imProcessRenderGrid cdecl alias "imProcessRenderGrid" (byval image as imImage ptr, byval x_space as integer, byval y_space as integer) as integer
declare function imProcessRenderChessboard cdecl alias "imProcessRenderChessboard" (byval image as imImage ptr, byval x_space as integer, byval y_space as integer) as integer

enum imToneGamut
	IM_GAMUT_NORMALIZE
	IM_GAMUT_POW
	IM_GAMUT_LOG
	IM_GAMUT_EXP
	IM_GAMUT_INVERT
	IM_GAMUT_ZEROSTART
	IM_GAMUT_SOLARIZE
	IM_GAMUT_SLICE
	IM_GAMUT_EXPAND
	IM_GAMUT_CROP
	IM_GAMUT_BRIGHTCONT
end enum

enum imToneGamutFlags
	IM_GAMUT_MINMAX = &h0100
end enum

declare sub imProcessToneGamut cdecl alias "imProcessToneGamut" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval op as integer, byval params as single ptr)
declare sub imProcessUnNormalize cdecl alias "imProcessUnNormalize" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessDirectConv cdecl alias "imProcessDirectConv" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessNegative cdecl alias "imProcessNegative" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare function imProcessCalcAutoGamma cdecl alias "imProcessCalcAutoGamma" (byval image as imImage ptr) as single
declare sub imProcessShiftHSI cdecl alias "imProcessShiftHSI" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval h_shift as single, byval s_shift as single, byval i_shift as single)
declare sub imProcessThreshold cdecl alias "imProcessThreshold" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval level as single, byval value as integer)
declare sub imProcessThresholdByDiff cdecl alias "imProcessThresholdByDiff" (byval src_image1 as imImage ptr, byval src_image2 as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessHysteresisThreshold cdecl alias "imProcessHysteresisThreshold" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval low_thres as integer, byval high_thres as integer)
declare sub imProcessHysteresisThresEstimate cdecl alias "imProcessHysteresisThresEstimate" (byval image as imImage ptr, byval low_level as integer ptr, byval high_level as integer ptr)
declare function imProcessUniformErrThreshold cdecl alias "imProcessUniformErrThreshold" (byval src_image as imImage ptr, byval dst_image as imImage ptr) as integer
declare sub imProcessDifusionErrThreshold cdecl alias "imProcessDifusionErrThreshold" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval level as integer)
declare function imProcessPercentThreshold cdecl alias "imProcessPercentThreshold" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval percent as single) as integer
declare function imProcessOtsuThreshold cdecl alias "imProcessOtsuThreshold" (byval src_image as imImage ptr, byval dst_image as imImage ptr) as integer
declare function imProcessMinMaxThreshold cdecl alias "imProcessMinMaxThreshold" (byval src_image as imImage ptr, byval dst_image as imImage ptr) as single
declare sub imProcessLocalMaxThresEstimate cdecl alias "imProcessLocalMaxThresEstimate" (byval image as imImage ptr, byval level as integer ptr)
declare sub imProcessSliceThreshold cdecl alias "imProcessSliceThreshold" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval start_level as single, byval end_level as single)
declare sub imProcessPixelate cdecl alias "imProcessPixelate" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval box_size as integer)
declare sub imProcessPosterize cdecl alias "imProcessPosterize" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval level as integer)
declare sub imProcessNormDiffRatio cdecl alias "imProcessNormDiffRatio" (byval image1 as imImage ptr, byval image2 as imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessAbnormalHyperionCorrection cdecl alias "imProcessAbnormalHyperionCorrection" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval threshold_consecutive as integer, byval threshold_percent as integer, byval image_abnormal as imImage ptr)
declare function imProcessConvertDataType cdecl alias "imProcessConvertDataType" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval cpx2real as integer, byval gamma as single, byval abssolute as integer, byval cast_mode as integer) as integer
declare function imProcessConvertColorSpace cdecl alias "imProcessConvertColorSpace" (byval src_image as imImage ptr, byval dst_image as imImage ptr) as integer
declare function imProcessConvertToBitmap cdecl alias "imProcessConvertToBitmap" (byval src_image as imImage ptr, byval dst_image as imImage ptr, byval cpx2real as integer, byval gamma as single, byval abssolute as integer, byval cast_mode as integer) as integer

#endif
