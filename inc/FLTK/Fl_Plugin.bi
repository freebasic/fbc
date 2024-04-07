#include once "Fl_Preferences.bi"

extern "c++"
type Fl_Plugin extends object
private:
	id as ID_
public:
	declare constructor(klass as const zstring ptr, name as const zstring ptr)
	declare virtual destructor()
end type

type Fl_Plugin_Manager extends Fl_Preferences
public:
	declare constructor(klass as const zstring ptr)
	declare destructor()

	declare function plugins() as long
	declare function plugin(index as long) as Fl_Plugin ptr
	declare function plugin(name as const zstring ptr) as Fl_Plugin ptr
	declare function addPlugin(name as const zstring ptr, plugin as Fl_Plugin ptr) as ID_
  
	declare static sub removePlugin(id as ID_)
	declare static function load(filename as const zstring ptr) as long
	declare static function loadAll(filepath as const zstring ptr, pattern as const zstring ptr=0) as long
end type

private function Fl_Plugin_Manager.plugins() as long
	return groups()
end function


end extern
