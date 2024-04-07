#include once "Fl_Image.bi"

extern "c++"
type Fl_PNM_Image extends Fl_RGB_Image 
private:
	declare operator let (byref w as const Fl_PNM_Image)
	declare constructor (byref w as const Fl_PNM_Image)
public:
	declare constructor(filename as const zstring ptr)
end type

end extern