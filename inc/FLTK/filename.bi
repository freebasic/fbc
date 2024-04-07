#define FL_PATH_MAX 2048

extern "c"
declare function fl_filename_name(filename as const zstring ptr) as const zstring ptr
declare function fl_filename_ext(buf as const zstring ptr) as const zstring ptr
declare function fl_filename_setext(to_ as zstring ptr, tolen as long, ext as const zstring ptr) as zstring ptr
declare function fl_filename_expand(to_ as zstring ptr, tolen as long, from as const zstring ptr) as long
declare function fl_filename_absolute(to_ as zstring ptr, tolen as long, from as const zstring ptr) as long
declare function fl_filename_relative(to_ as zstring ptr, tolen as long, from as const zstring ptr) as long
declare function fl_filename_match(name as const zstring ptr, pattern as const zstring ptr) as long
declare function fl_filename_isdir(name as const zstring ptr) as long

type dirent
	d_name as zstring *1
end type

declare function fl_alphasort(as dirent ptr ptr, as dirent ptr ptr) as long
declare function fl_casealphasort(as dirent ptr ptr, as dirent ptr ptr) as long
declare function fl_casenumericsort(as dirent ptr ptr, as dirent ptr ptr) as long
declare function fl_numericsort(as dirent ptr ptr, as dirent ptr ptr) as long


type Fl_File_Sort_F as function(as dirent ptr ptr, as dirent ptr ptr) as long

end extern

extern "c++"

declare function fl_filename_list(d as const zstring ptr, l as dirent ptr ptr ptr, s as Fl_File_Sort_F = @fl_numericsort) as long
declare sub fl_filename_free_list(l as dirent ptr ptr ptr, n as long)

declare function fl_open_uri(uri as const zstring ptr, msg as zstring ptr = 0, msglen as long = 0) as long

declare sub fl_decode_uri(uri as zstring ptr)

declare function _fl_filename_isdir_quick(name as const zstring ptr) as long

end extern
