#include once "Fl_Image.bi"

extern "c++"
type Fl_BMP_Image extends Fl_RGB_Image 
private:
	declare operator let (byref w as const Fl_BMP_Image)
	declare constructor (byref w as const Fl_BMP_Image)
public:
	declare constructor(filename as const zstring ptr)
end type

end extern