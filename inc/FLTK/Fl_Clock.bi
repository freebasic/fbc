#include once "Fl_Widget.bi"

extern "c++"
type Fl_Clock_Output extends Fl_Widget 
private:
	as long hour_, minute_, second_
	value_ as unsigned integer

	declare sub drawhands(as Fl_Color, as Fl_Color)
protected:
	declare constructor (byref b as const Fl_Clock_Output)
	declare operator let (byref b as const Fl_Clock_Output)

	declare virtual sub draw()
	declare sub draw(x as long, y as long, w as long, h as long)
public:

	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)

	declare sub value(v as uinteger)
	declare sub value(h as long, m as long, s as long)
	declare const function value() as uinteger

	declare const function hour() as long
	declare const function minute() as long
	declare const function second() as long

end type
end extern

private const function Fl_Clock_Output.value() as uinteger
	return this.value_
end function

private const function Fl_Clock_Output.hour() as long
	return this.hour_
end function

private const function Fl_Clock_Output.minute() as long
	return this.minute_
end function

private const function Fl_Clock_Output.second() as long
	return this.second_
end function


extern "c++"
type Fl_Clock extends Fl_Clock_Output
protected:
	declare constructor (byref b as const Fl_Clock)
	declare operator let (byref b as const Fl_Clock)
public:
	declare virtual function handle(h as long) as long
	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)
	declare constructor(t as uinteger, x as long, y as long, w as long, h as long, title as const zstring ptr)
	declare destructor
end type
end extern

