extern "c++"
type Fl_Native_File_Chooser extends object
public:
	enum Type_
		BROWSE_FILE = 0
		BROWSE_DIRECTORY
		BROWSE_MULTI_FILE
		BROWSE_MULTI_DIRECTORY
		BROWSE_SAVE_FILE
		BROWSE_SAVE_DIRECTORY
	end enum

	enum Option
		NO_OPTIONS     = &h0000
		SAVEAS_CONFIRM = &h0001
		NEW_FOLDER     = &h0002
		PREVIEW        = &h0004
		USE_FILTER_EXT = &h0008
	end enum
	static file_exists_message as const zstring ptr
  
public:
	declare constructor(val_ as long=BROWSE_FILE)
	declare destructor()

	declare sub type_ alias "type" (t as long)
	declare const function type_ alias "type" () as long
	declare sub options(o as long)
	declare const function options() as long
	declare const function count() as long
	declare const function filename() as const zstring ptr
	declare const function filename(i as long) as const zstring ptr
	declare sub directory(val_ as const zstring ptr)
	declare const function directory() as const zstring ptr
	declare sub title(t as const zstring ptr)
	declare const function title() as const zstring ptr
	declare const function filter() as const zstring ptr
	declare sub filter(f as const zstring ptr)
	declare const function filters() as long
	declare sub filter_value(i as long)
	declare const function filter_value() as long
	declare sub preset_file(f as const zstring ptr)
	declare const function preset_file() as const zstring ptr
	declare const function errmsg() as const zstring ptr

	declare function show() as long
private:
	platform_specific_data (13) as long	'temporary, can be replaced with platform-specific fields
end type
end extern