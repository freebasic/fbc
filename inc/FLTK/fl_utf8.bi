#include once "fl_types.bi"

extern "c"
declare function fl_utf8bytes(ucs as unsigned long) as long
declare function fl_utf8len(c as byte) as long
declare function fl_utf8len1(c as byte) as long
declare function fl_utf_nb_char(buf as const unsigned byte ptr, len_ as long) as long
declare function fl_utf8decode(p as const zstring ptr, end as const zstring ptr, len_ as long ptr) as unsigned long
declare function fl_utf8encode(ucs as unsigned long, buf as zstring ptr) as long
declare function fl_utf8fwd(p as const zstring ptr, start as const zstring ptr, end_ as const zstring ptr) as const zstring ptr
declare function fl_utf8back(p as const zstring ptr, start as const zstring ptr, end_ as const zstring ptr) as const zstring ptr
declare function fl_ucs_to_Utf16(ucs as const unsigned long, dst as unsigned short ptr, dstlen as const unsigned long) as unsigned long
declare function fl_utf8toUtf16(src as const zstring ptr, srclen as unsigned long, dst as unsigned short ptr, dstlen as unsigned long) as unsigned long
declare function fl_utf8towc(src as const zstring ptr, srclen as unsigned long, dst as const wstring ptr, dstlen as unsigned long) as unsigned long
declare function fl_utf8fromwc(dst as const zstring ptr, dstlen as unsigned long, src as const wstring ptr, srclen as unsigned long) as unsigned long
declare function fl_utf8toa (src as const zstring ptr, srclen as unsigned long, dst as zstring ptr, dstlen as unsigned long) as unsigned long
declare function fl_utf8froma (dst as zstring ptr, dstlen as unsigned long, src as const zstring ptr, srclen as unsigned long) as unsigned long
declare function fl_utf8locale() as long
declare function fl_utf8test(src as const zstring ptr, len_ as unsigned long) as long
declare function fl_wcwidth_(ucs as unsigned long) as long
declare function fl_wcwidth(src as const zstring ptr) as long
declare function fl_nonspacing(ucs as unsigned long) as unsigned long
declare function fl_utf8to_mb(src as const zstring ptr, srclen as unsigned long, dst as zstring ptr, dstlen as unsigned long) as unsigned long
declare function fl_utf2mbcs(src as const zstring ptr) as zstring ptr
declare function fl_utf8from_mb(dst as zstring ptr, dstlen as unsigned long, src as const zstring ptr, srclen as unsigned long) as unsigned long
#ifdef __FB_WIN32__
declare function fl_utf8_to_locale(s as const zstring ptr, len_ as long, codepage as unsigned long) as zstring ptr
declare function fl_locale_to_utf8(s as const zstring ptr, len_ as long, codepage as unsigned long) as zstring ptr
#endif
declare function fl_utf_strncasecmp(s1 as const zstring ptr, s2 as const zstring ptr, n as long) as long
declare function fl_utf_strcasecmp(s1 as const zstring ptr, s2 as const zstring ptr) as long
declare function fl_tolower(ucs as unsigned long) as long
declare function fl_toupper(ucs as unsigned long) as long
declare function fl_utf_tolower(str_ as const unsigned byte ptr, len_ as long, buf as zstring ptr) as long
declare function fl_utf_toupper(str_ as const unsigned byte ptr, len_ as long, buf as zstring ptr) as long
declare function fl_chmod(f as const zstring ptr, mode as long) as long
declare function fl_access(f as const zstring ptr, mode as long) as long
'declare function fl_stat(path as const zstring ptr, buffer as stat ptr ) as long
declare function fl_stat(path as const zstring ptr, buffer as any ptr ) as long
declare function fl_getcwd(buf as zstring ptr, maxlen as long) as zstring ptr
declare function fl_fopen(f as const zstring ptr, mode as const zstring ptr) as FILE ptr
declare function fl_system(f as const zstring ptr) as long
declare function fl_execvp(file as const zstring ptr, argv as zstring ptr const ptr) as long
declare function fl_open(f as const zstring ptr, o as long, ...) as long
declare function fl_unlink(f as const zstring ptr) as long
declare function fl_rmdir(f as const zstring ptr) as long
declare function fl_getenv(name as const zstring ptr) as zstring ptr
declare function fl_mkdir(f as const zstring ptr, mode as long) as long
declare function fl_rename(f as const zstring ptr, t as const zstring ptr) as long
declare sub fl_make_path_for_file( path as const zstring ptr )
declare function fl_make_path( path as const zstring ptr ) as byte

end extern