''
''
'' im_image -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_image_bi__
#define __im_image_bi__

type _imImage
	width as integer
	height as integer
	color_space as integer
	data_type as integer
	has_alpha as integer
	depth as integer
	line_size as integer
	plane_size as integer
	size as integer
	count as integer
	data as any ptr ptr
	palette as integer ptr
	palette_count as integer
	attrib_table as any ptr
end type

type imImage as _imImage

declare function imImageCreate cdecl alias "imImageCreate" (byval width as integer, byval height as integer, byval color_space as integer, byval data_type as integer) as imImage ptr
declare function imImageInit cdecl alias "imImageInit" (byval width as integer, byval height as integer, byval color_mode as integer, byval data_type as integer, byval data_buffer as any ptr, byval palette as integer ptr, byval palette_count as integer) as imImage ptr
declare function imImageCreateBased cdecl alias "imImageCreateBased" (byval image as imImage ptr, byval width as integer, byval height as integer, byval color_space as integer, byval data_type as integer) as imImage ptr
declare sub imImageDestroy cdecl alias "imImageDestroy" (byval image as imImage ptr)
declare sub imImageAddAlpha cdecl alias "imImageAddAlpha" (byval image as imImage ptr)
declare sub imImageSetAlpha cdecl alias "imImageSetAlpha" (byval image as imImage ptr, byval alpha as single)
declare sub imImageRemoveAlpha cdecl alias "imImageRemoveAlpha" (byval image as imImage ptr)
declare sub imImageReshape cdecl alias "imImageReshape" (byval image as imImage ptr, byval width as integer, byval height as integer)
declare sub imImageCopy cdecl alias "imImageCopy" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imImageCopyData cdecl alias "imImageCopyData" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imImageCopyAttributes cdecl alias "imImageCopyAttributes" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imImageMergeAttributes cdecl alias "imImageMergeAttributes" (byval src_image as imImage ptr, byval dst_image as imImage ptr)
declare sub imImageCopyPlane cdecl alias "imImageCopyPlane" (byval src_image as imImage ptr, byval src_plane as integer, byval dst_image as imImage ptr, byval dst_plane as integer)
declare function imImageDuplicate cdecl alias "imImageDuplicate" (byval image as imImage ptr) as imImage ptr
declare function imImageClone cdecl alias "imImageClone" (byval image as imImage ptr) as imImage ptr
declare sub imImageSetAttribute cdecl alias "imImageSetAttribute" (byval image as imImage ptr, byval attrib as zstring ptr, byval data_type as integer, byval count as integer, byval data as any ptr)
declare function imImageGetAttribute cdecl alias "imImageGetAttribute" (byval image as imImage ptr, byval attrib as zstring ptr, byval data_type as integer ptr, byval count as integer ptr) as any ptr
declare sub imImageGetAttributeList cdecl alias "imImageGetAttributeList" (byval image as imImage ptr, byval attrib as byte ptr ptr, byval attrib_count as integer ptr)
declare sub imImageClear cdecl alias "imImageClear" (byval image as imImage ptr)
declare function imImageIsBitmap cdecl alias "imImageIsBitmap" (byval image as imImage ptr) as integer
declare sub imImageSetPalette cdecl alias "imImageSetPalette" (byval image as imImage ptr, byval palette as integer ptr, byval palette_count as integer)
declare function imImageMatchSize cdecl alias "imImageMatchSize" (byval image1 as imImage ptr, byval image2 as imImage ptr) as integer
declare function imImageMatchColor cdecl alias "imImageMatchColor" (byval image1 as imImage ptr, byval image2 as imImage ptr) as integer
declare function imImageMatchDataType cdecl alias "imImageMatchDataType" (byval image1 as imImage ptr, byval image2 as imImage ptr) as integer
declare function imImageMatchColorSpace cdecl alias "imImageMatchColorSpace" (byval image1 as imImage ptr, byval image2 as imImage ptr) as integer
declare function imImageMatch cdecl alias "imImageMatch" (byval image1 as imImage ptr, byval image2 as imImage ptr) as integer
declare sub imImageSetMap cdecl alias "imImageSetMap" (byval image as imImage ptr)
declare sub imImageSetBinary cdecl alias "imImageSetBinary" (byval image as imImage ptr)
declare sub imImageSetGray cdecl alias "imImageSetGray" (byval image as imImage ptr)
declare sub imImageMakeBinary cdecl alias "imImageMakeBinary" (byval image as imImage ptr)
declare sub imImageMakeGray cdecl alias "imImageMakeGray" (byval image as imImage ptr)
declare function imFileLoadImage cdecl alias "imFileLoadImage" (byval ifile as imFile ptr, byval index as integer, byval error as integer ptr) as imImage ptr
declare sub imFileLoadImageFrame cdecl alias "imFileLoadImageFrame" (byval ifile as imFile ptr, byval index as integer, byval image as imImage ptr, byval error as integer ptr)
declare function imFileLoadBitmap cdecl alias "imFileLoadBitmap" (byval ifile as imFile ptr, byval index as integer, byval error as integer ptr) as imImage ptr
declare function imFileLoadImageRegion cdecl alias "imFileLoadImageRegion" (byval ifile as imFile ptr, byval index as integer, byval bitmap as integer, byval error as integer ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer, byval width as integer, byval height as integer) as imImage ptr
declare sub imFileLoadBitmapFrame cdecl alias "imFileLoadBitmapFrame" (byval ifile as imFile ptr, byval index as integer, byval image as imImage ptr, byval error as integer ptr)
declare function imFileSaveImage cdecl alias "imFileSaveImage" (byval ifile as imFile ptr, byval image as imImage ptr) as integer
declare function imFileImageLoad cdecl alias "imFileImageLoad" (byval file_name as zstring ptr, byval index as integer, byval error as integer ptr) as imImage ptr
declare function imFileImageLoadBitmap cdecl alias "imFileImageLoadBitmap" (byval file_name as zstring ptr, byval index as integer, byval error as integer ptr) as imImage ptr
declare function imFileImageLoadRegion cdecl alias "imFileImageLoadRegion" (byval file_name as zstring ptr, byval index as integer, byval bitmap as integer, byval error as integer ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer, byval width as integer, byval height as integer) as imImage ptr
declare function imFileImageSave cdecl alias "imFileImageSave" (byval file_name as zstring ptr, byval format as zstring ptr, byval image as imImage ptr) as integer

#endif
