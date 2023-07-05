#include once "Fl_Image.bi"

extern "c++"
type Fl_JPEG_Image extends Fl_RGB_Image 
private:
	declare operator let (byref w as const Fl_JPEG_Image)
	declare constructor (byref w as const Fl_JPEG_Image)
public:
	declare constructor(filename as const zstring ptr)
	declare constructor(filename as const zstring ptr, data_ as const unsigned byte ptr)
end type

end extern