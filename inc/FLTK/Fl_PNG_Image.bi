#include once "Fl_Image.bi"

extern "c++"
type Fl_PNG_Image extends Fl_RGB_Image 
private:
	declare operator let (byref w as const Fl_PNG_Image)
	declare constructor (byref w as const Fl_PNG_Image)
public:
	declare constructor(filename as const zstring ptr)
	declare constructor(name_png as const zstring ptr, buffer as const unsigned byte ptr, datasize as long)
private:
	declare sub load_png_(name_png as const zstring ptr, buffer_png as const unsigned byte ptr, datasize as long)
end type

end extern