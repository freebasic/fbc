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

#include once "im_image.bi"

extern "C"

#define __IM_PROCESS_PNT_H
type imUnaryPointOpFunc as function(byval src_value as single, byval dst_value as single ptr, byval params as single ptr, byval userdata as any ptr, byval x as long, byval y as long, byval d as long) as long
declare function imProcessUnaryPointOp(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval func as imUnaryPointOpFunc, byval params as single ptr, byval userdata as any ptr, byval op_name as const zstring ptr) as long
type imUnaryPointColorOpFunc as function(byval src_value as const single ptr, byval dst_value as single ptr, byval params as single ptr, byval userdata as any ptr, byval x as long, byval y as long) as long
declare function imProcessUnaryPointColorOp(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval func as imUnaryPointColorOpFunc, byval params as single ptr, byval userdata as any ptr, byval op_name as const zstring ptr) as long
type imMultiPointOpFunc as function(byval src_value as const single ptr, byval dst_value as single ptr, byval params as single ptr, byval userdata as any ptr, byval x as long, byval y as long, byval d as long, byval src_count as long) as long
declare function imProcessMultiPointOp(byval src_image as const imImage ptr ptr, byval src_count as long, byval dst_image as imImage ptr, byval func as imMultiPointOpFunc, byval params as single ptr, byval userdata as any ptr, byval op_name as const zstring ptr) as long
type imMultiPointColorOpFunc as function(byval src_value as single ptr, byval dst_value as single ptr, byval params as single ptr, byval userdata as any ptr, byval x as long, byval y as long, byval src_count as long, byval src_depth as long, byval dst_depth as long) as long
declare function imProcessMultiPointColorOp(byval src_image as const imImage ptr ptr, byval src_count as long, byval dst_image as imImage ptr, byval func as imMultiPointColorOpFunc, byval params as single ptr, byval userdata as any ptr, byval op_name as const zstring ptr) as long

type imUnaryOp as long
enum
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

declare sub imProcessUnArithmeticOp(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval op as long)

type imBinaryOp as long
enum
	IM_BIN_ADD
	IM_BIN_SUB
	IM_BIN_MUL
	IM_BIN_DIV
	IM_BIN_DIFF
	IM_BIN_POW
	IM_BIN_MIN
	IM_BIN_MAX
end enum

declare sub imProcessArithmeticOp(byval src_image1 as const imImage ptr, byval src_image2 as const imImage ptr, byval dst_image as imImage ptr, byval op as long)
declare sub imProcessArithmeticConstOp(byval src_image as const imImage ptr, byval src_const as single, byval dst_image as imImage ptr, byval op as long)
declare sub imProcessBlendConst(byval src_image1 as const imImage ptr, byval src_image2 as const imImage ptr, byval dst_image as imImage ptr, byval alpha as single)
declare sub imProcessBlend(byval src_image1 as const imImage ptr, byval src_image2 as const imImage ptr, byval alpha_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessCompose(byval src_image1 as const imImage ptr, byval src_image2 as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessSplitComplex(byval src_image as const imImage ptr, byval dst_image1 as imImage ptr, byval dst_image2 as imImage ptr, byval polar as long)
declare sub imProcessMergeComplex(byval src_image1 as const imImage ptr, byval src_image2 as const imImage ptr, byval dst_image as imImage ptr, byval polar as long)
declare sub imProcessMultipleMean(byval src_image_list as const imImage ptr ptr, byval src_image_count as long, byval dst_image as imImage ptr)
declare sub imProcessMultipleStdDev(byval src_image_list as const imImage ptr ptr, byval src_image_count as long, byval mean_image as const imImage ptr, byval dst_image as imImage ptr)
declare function imProcessMultipleMedian(byval src_image_list as const imImage ptr ptr, byval src_image_count as long, byval dst_image as imImage ptr) as long
declare function imProcessAutoCovariance(byval src_image as const imImage ptr, byval mean_image as const imImage ptr, byval dst_image as imImage ptr) as long
declare sub imProcessMultiplyConj(byval src_image1 as const imImage ptr, byval src_image2 as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessQuantizeRGBUniform(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval do_dither as long)
declare sub imProcessQuantizeGrayUniform(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval grays as long)
declare sub imProcessExpandHistogram(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval percent as single)
declare sub imProcessEqualizeHistogram(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessSplitYChroma(byval src_image as const imImage ptr, byval y_image as imImage ptr, byval chroma_image as imImage ptr)
declare sub imProcessSplitHSI(byval src_image as const imImage ptr, byval h_image as imImage ptr, byval s_image as imImage ptr, byval i_image as imImage ptr)
declare sub imProcessMergeHSI(byval h_image as const imImage ptr, byval s_image as const imImage ptr, byval i_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessSplitComponents(byval src_image as const imImage ptr, byval dst_image_list as imImage ptr ptr)
declare sub imProcessMergeComponents(byval src_image_list as const imImage ptr ptr, byval dst_image as imImage ptr)
declare sub imProcessNormalizeComponents(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessReplaceColor(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval src_color as single ptr, byval dst_color as single ptr)
declare sub imProcessSetAlphaColor(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval src_color as single ptr, byval dst_alpha as single)

type imLogicOp as long
enum
	IM_BIT_AND
	IM_BIT_OR
	IM_BIT_XOR
end enum

declare sub imProcessBitwiseOp(byval src_image1 as const imImage ptr, byval src_image2 as const imImage ptr, byval dst_image as imImage ptr, byval op as long)
declare sub imProcessBitwiseNot(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessBitMask(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval mask as ubyte, byval op as long)
declare sub imProcessBitPlane(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval plane as long, byval do_reset as long)
type imRenderFunc as function(byval x as long, byval y as long, byval d as long, byval params as single ptr) as single
type imRenderCondFunc as function(byval x as long, byval y as long, byval d as long, byval cond as long ptr, byval params as single ptr) as single
declare function imProcessRenderOp(byval image as imImage ptr, byval render_func as imRenderFunc, byval render_name as const zstring ptr, byval params as single ptr, byval plus as long) as long
declare function imProcessRenderCondOp(byval image as imImage ptr, byval render_cond_func as imRenderCondFunc, byval render_name as const zstring ptr, byval params as single ptr) as long
declare function imProcessRenderAddSpeckleNoise(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval percent as single) as long
declare function imProcessRenderAddGaussianNoise(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval mean as single, byval stddev as single) as long
declare function imProcessRenderAddUniformNoise(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval mean as single, byval stddev as single) as long
declare function imProcessRenderRandomNoise(byval image as imImage ptr) as long
declare function imProcessRenderConstant(byval image as imImage ptr, byval value as single ptr) as long
declare function imProcessRenderWheel(byval image as imImage ptr, byval internal_radius as long, byval external_radius as long) as long
declare function imProcessRenderCone(byval image as imImage ptr, byval radius as long) as long
declare function imProcessRenderTent(byval image as imImage ptr, byval tent_width as long, byval tent_height as long) as long
declare function imProcessRenderRamp(byval image as imImage ptr, byval start as long, byval end as long, byval vert_dir as long) as long
declare function imProcessRenderBox(byval image as imImage ptr, byval box_width as long, byval box_height as long) as long
declare function imProcessRenderSinc(byval image as imImage ptr, byval x_period as single, byval y_period as single) as long
declare function imProcessRenderGaussian(byval image as imImage ptr, byval stddev as single) as long
declare function imProcessRenderLapOfGaussian(byval image as imImage ptr, byval stddev as single) as long
declare function imProcessRenderCosine(byval image as imImage ptr, byval x_period as single, byval y_period as single) as long
declare function imProcessRenderGrid(byval image as imImage ptr, byval x_space as long, byval y_space as long) as long
declare function imProcessRenderChessboard(byval image as imImage ptr, byval x_space as long, byval y_space as long) as long

type imToneGamut as long
enum
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

type imToneGamutFlags as long
enum
	IM_GAMUT_MINMAX = &h0100
end enum

declare sub imProcessToneGamut(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval op as long, byval params as single ptr)
declare sub imProcessUnNormalize(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessDirectConv(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessNegative(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare function imProcessCalcAutoGamma(byval image as const imImage ptr) as single
declare sub imProcessShiftHSI(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval h_shift as single, byval s_shift as single, byval i_shift as single)
declare sub imProcessThreshold(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval level as single, byval value as long)
declare sub imProcessThresholdByDiff(byval src_image1 as const imImage ptr, byval src_image2 as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessHysteresisThreshold(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval low_thres as long, byval high_thres as long)
declare sub imProcessHysteresisThresEstimate(byval image as const imImage ptr, byval low_level as long ptr, byval high_level as long ptr)
declare function imProcessUniformErrThreshold(byval src_image as const imImage ptr, byval dst_image as imImage ptr) as long
declare sub imProcessDifusionErrThreshold(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval level as long)
declare function imProcessPercentThreshold(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval percent as single) as long
declare function imProcessOtsuThreshold(byval src_image as const imImage ptr, byval dst_image as imImage ptr) as long
declare function imProcessMinMaxThreshold(byval src_image as const imImage ptr, byval dst_image as imImage ptr) as single
declare sub imProcessLocalMaxThresEstimate(byval image as const imImage ptr, byval level as long ptr)
declare sub imProcessSliceThreshold(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval start_level as single, byval end_level as single)
declare sub imProcessPixelate(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval box_size as long)
declare sub imProcessPosterize(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval level as long)
declare sub imProcessNormDiffRatio(byval image1 as const imImage ptr, byval image2 as const imImage ptr, byval dst_image as imImage ptr)
declare sub imProcessAbnormalHyperionCorrection(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval threshold_consecutive as long, byval threshold_percent as long, byval image_abnormal as imImage ptr)
declare function imProcessConvertDataType(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval cpx2real as long, byval gamma as single, byval abssolute as long, byval cast_mode as long) as long
declare function imProcessConvertColorSpace(byval src_image as const imImage ptr, byval dst_image as imImage ptr) as long
declare function imProcessConvertToBitmap(byval src_image as const imImage ptr, byval dst_image as imImage ptr, byval cpx2real as long, byval gamma as single, byval abssolute as long, byval cast_mode as long) as long

#macro imImageGamma(_image, _gamma)
	scope
		dim params(0 to 0) as single
		params[0] = _gamma
		imProcessToneGamut(_image, _image, IM_GAMUT_POW, params)
	end scope
#endmacro
#macro imImageBrightnessContrast(_image, _bright_shift, _contrast_factor)
	scope
		dim _params(0 to 1) as single
		_params[0] = bright_shift
		_params[1] = contrast_factor
		imProcessToneGamut(_image, _image, IM_GAMUT_BRIGHTCONT, _params)
	end scope
#endmacro
#macro imImageLevel(_image, _start, _end)
	scope
		dim _params(0 to 1) as single
		_params[0] = _start
		_params[1] = _end
		imProcessToneGamut(_image, _image, IM_GAMUT_EXPAND, _params)
	end scope
#endmacro
#define imImageEqualize(_image) imProcessEqualizeHistogram(_image, _image)
#define imImageNegative(_image) imProcessNegative(_image, _image)
#define imImageAutoLevel(_image, _percent) imProcessExpandHistogram(_image, _image, _percent)

end extern
