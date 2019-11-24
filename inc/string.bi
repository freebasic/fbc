#ifndef __STRING_BI__
#define __STRING_BI__

#include once "ustring.bi"


declare function format    alias "fb_StrFormat" _
          ( byval value as double, _
            byref mask as const string="" ) as string


'***********************************************************************************************
' wrappers for existing and new functions to enable a consistent syntax ($ suffix in jk-ide)
'***********************************************************************************************


#define left_ left
#define right_ right
#define mid_ mid
#define copy_ copy
#define pathname_ pathname
#define repeat_ repeat
#define invert_ invert
#define insert_ insert
#define extract_ extract
#define remain_ remain
#define parse_ outparse
#define shrink_ shrink
#define remove_ removeme
#define replace_ replace


'***********************************************************************************************
' new functions for string manipulation
'***********************************************************************************************


'***********************************************************************************************
' no conversion takes place, the data is just copied. This is necessary to avoid automatic 
' conversion when passing wide data in a STRING to a wide string and vice versa.

' Syntax: [z]string = Copy(wstring)
'         w/ustring = Copy([z]string)
'***********************************************************************************************


namespace string_


extern "rtlib"                                                                     
declare function fb_wcharfromstr alias "fb_WcharFromStr" ( byref z as zstring, byref n as uinteger ) as wstring ptr
declare function fb_strfromwchar alias "fb_StrFromWchar" ( byref w as wstring, byval n as uinteger ) as string
end extern


private function copy_str overload( byref s as string ) as ustring
dim n as uinteger
dim u as ustring = 0

    n = len(s)                                        'pass length
    u.u_data = cast(ubyte ptr, fb_wcharfromstr(s, n))
    u.u_len = n * sizeof(wstring)                     'set returned length
    return u
end function

private function copy_str overload( byref w as wstring ) as string
    return fb_strfromwchar(w, len(w))
end function
  
private function copy_str overload( byref u as ustring ) as string
    return fb_strfromwchar(u, len(u))
end function


#macro copy(a)
    string_.##copy_str(a)
#endmacro


'***********************************************************************************************
' Parses a path or file name to extract component parts and returns the requested part
' These are the options for specifying the requested part:
' PATH    Returns the path portion of the path/file Name. That is the text up to and
'         including the last (back)slash (\/) or colon (:).
'
' NAME    Returns the name portion of the path or file Name. That is the text to the right
'         of the last (back)slash (\/) or colon (:), ending just before the last period (.).
'
' EXTN    Returns the extension portion of the path or file name. That is the last
'         period (.) in the string plus the text to the right of it.
'
' NAMEX   Returns the name and the EXTN parts combined.

' Syntax: resultstring = Pathname(PATH|NAME|NAMEX|EXTN, filespec)
'***********************************************************************************************


extern "rtlib"                                                                     
declare function pathname_path  overload alias "fb_StrPath_path" (byref z as zstring) as string
declare function pathname_path  overload alias "fb_WstrPath_path" (byref w as wstring) as wstring
declare function pathname_name  overload alias "fb_StrPath_name" (byref z as zstring) as string
declare function pathname_name  overload alias "fb_WstrPath_name" (byref w as wstring) as wstring
declare function pathname_namex overload alias "fb_StrPath_namex" (byref z as zstring) as string
declare function pathname_namex overload alias "fb_WstrPath_namex" (byref w as wstring) as wstring
declare function pathname_extn  overload alias "fb_StrPath_extn" (byref z as zstring) as string
declare function pathname_extn  overload alias "fb_WstrPath_extn" (byref w as wstring) as wstring
end extern


#macro pathname(what, p)
    string_.pathname_##what(p)
#endmacro    


'***********************************************************************************************
' Returns a string consisting of multiple copies of the specified string.
' This function is a similar to STRING/WSTRING functions, but allows for
' strings of arbitrary length to be concatenated.

' Syntax: resultstring = Repeat(5, "xyz")
'***********************************************************************************************


extern "rtlib"                                                                     
declare function fb_repeat_str alias "fb_StrRepeat" ( byval n as integer, byref z as zstring, byval l as uinteger ) as string
declare function fb_repeat_wstr alias "fb_WstrRepeat" ( byval n as integer, byref w as wstring, byref l as uinteger ) as wstring ptr
end extern


private function repeat_str overload( byval n as integer, byref o as ustring ) as ustring
dim x as uinteger = len(o)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_repeat_wstr(n, o, x))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function repeat_str overload( byval n as integer, byref w as wstring ) as ustring
dim x as uinteger = len(w)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_repeat_wstr(n, w, x))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function repeat_str overload( byval n as integer, byref s as string ) as string
    return fb_repeat_str(n, s, len(s))
end function


#macro repeat(a, b)
    string_.repeat_str(a, b)
#endmacro


'***********************************************************************************************
' Count the number of occurrences of specified characters strings within a string.
' W is the string expression in which to count characters. M is a list of single characters 
' to be searched for individually or in total. A match on any one of which  or a match in total
' will cause the count to be incremented for each occurrence. Note that repeated characters in m 
' will not increase the count, if characters a searched individually. If m is not present in w, 
' zero is returned. If "ANY" is not specified, m is handled "as string"

' Syntax: n = tally(w <string to count in>, [any] m <string to find>)
'***********************************************************************************************


extern "rtlib"                                                                     
declare function fb_strtally alias "fb_StrTally" ( byref z as zstring, byval lz as uinteger, byval i as long, byref t as zstring, byval lt as uinteger ) as uinteger
declare function fb_wstrtally alias "fb_WstrTally" ( byref w as wstring, byval lw as uinteger, byval i as long, byref t as wstring, byval lt as uinteger ) as uinteger
end extern


private function tally_str overload( byref o as ustring, byval n as long, byref t as ustring ) as uinteger
    return fb_wstrtally(o, len(o), n, t, len(t))
end function

private function tally_str overload( byref o as ustring, byval n as long, byref t as zstring ) as uinteger
    return fb_wstrtally(o, len(o), n, t, len(t))
end function

private function tally_str overload( byref w as wstring, byval n as long, byref t as wstring ) as uinteger
    return fb_wstrtally(w, len(w), n, t, len(t))
end function
  
private function tally_str overload( byref s as string, byval n as long, byref t as string ) as uinteger
    return fb_strtally(s, len(s), n, t, len(t))
end function

private function tally_str overload( byref s as string, byval n as long, byref t as ustring ) as uinteger
    return fb_strtally(s, len(s), n, t, len(t))
end function


#macro tally(s, t)
    string_.tally_str(s, #?t)
#endmacro    


'***********************************************************************************************
' Returns the count of delimited fields from a string expression.
' If w is empty (a null string) or contains no delimiter character(s), the string
' is considered to contain exactly one sub-field. In this case, ParseCount returns the value 1.
' m contains a string (one or more characters) that are seached individually or must be fully 
' matched. If "ANY" is not specified, m is handled "as string". If m is not specified, it
' defaults to ",".

' Syntax: n = parsecount(w <string to count in>, [any] m <separating string>)
'***********************************************************************************************


extern "rtlib"                                                                     
declare function fb_strparsecount alias "fb_StrParsecount" ( byref z as zstring, byval lz as uinteger, byval i as long, byref t as zstring, byval lt as uinteger ) as uinteger
declare function fb_wstrparsecount alias "fb_WstrParsecount" ( byref w as wstring, byval lw as uinteger, byval i as long, byref t as wstring, byval lt as uinteger ) as uinteger
end extern


private function parsecount_str overload( byref o as ustring, byval n as long = 0, byref t as ustring = "," ) as uinteger
    return fb_wstrparsecount(o, len(o), n, t, len(t))
end function

private function parsecount_str overload( byref o as ustring, byval n as long = 0, byref t as zstring = "," ) as uinteger
    return fb_wstrparsecount(o, len(o), n, t, len(t))
end function

private function parsecount_str overload( byref w as wstring, byval n as long = 0, byref t as wstring = "," ) as uinteger
    return fb_wstrparsecount(w, len(w), n, t, len(t))
end function
  
private function parsecount_str overload( byref s as string, byval n as long = 0, byref t as string = "," ) as uinteger
    return fb_strparsecount(s, len(s), n, t, len(t))
end function

private function parsecount_str overload( byref s as string, byval n as long = 0, byref t as ustring = "," ) as uinteger
    return fb_strparsecount(s, len(s), n, t, len(t))
end function


#macro parsecount(s, t...)
    string_.parsecount_str(s, #?t)
#endmacro    


'***********************************************************************************************
' Inverts the contents of a string.

' Syntax: resultstring = invert("xyz")
'***********************************************************************************************


extern "rtlib"                                                                     
declare function fb_strinvert alias "fb_StrInvert" ( byref z as zstring, byval lz as uinteger ) as string
declare function fb_wstrinvert alias "fb_WstrInvert" ( byref w as wstring, byval lw as uinteger ) as wstring ptr
end extern


private function invert_str overload( byref o as ustring) as ustring
dim x as uinteger = len(o)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrinvert(o, x))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function invert_str overload( byref w as wstring) as ustring
dim x as uinteger = len(w)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrinvert(w, x))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function invert_str overload( byref s as string) as string
    return fb_strinvert(s, len(s))
end function


#macro invert(a)
    string_.invert_str(a)
#endmacro    


'***********************************************************************************************
' Inserts a string at a specified position within another string expression.
' Returns a string consisting of w with the string i inserted at position n. 
' The first character in the string is position 1
' If n is greater than the length of w then i is appended to w. If n is negative
' counting starts from right to left, -1 means the last character , -2 the last 
' but one, and so on

' Syntax: resultstring = Insert(w <string to insert in>, i <string to insert>, n)
'***********************************************************************************************


extern "rtlib"                                                                     
declare function fb_strinsert alias "fb_StrInsert"( byref z as zstring, byval lz as integer, byref z as zstring, byval lz1 as integer, byval n as integer ) as string
declare function fb_wstrinsert alias "fb_WstrInsert" ( byref w as wstring, byref lw as integer, byref w1 as wstring, byval lw1 as integer, byval n as integer ) as wstring ptr
end extern


private function insert_str overload(byref o as ustring, byref o1 as ustring, byval n as integer) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrinsert(o, x, o1, y, n))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function insert_str overload(byref o as ustring, byref o1 as zstring, byval n as integer) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrinsert(o, x, o1, y, n))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function insert_str overload(byref w as wstring, byref w1 as wstring, byval n as integer) as ustring
dim x as uinteger = len(w)
dim y as uinteger = len(w1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrinsert(w, x, w1, y, n))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function insert_str overload(byref s as string, byref s1 as string, byval n as integer) as string
    return fb_strinsert(s, len(s), s1, len(s1), n)
end function

private function insert_str overload(byref s as string, byref s1 as ustring, byval n as integer) as string
    return fb_strinsert(s, len(s), s1, len(s1), n)
end function


#macro insert(a, b, n)
    string_.insert_str(a, b, n)
#endmacro    


'***********************************************************************************************
' Complement to the Remain function. Extracts characters from a string up to a character
' or group of characters. Returns a substring of w starting with its first character 
' (or the character specified by nStart) and up to (but not including) the first occurrence
' of m. If m is not present in w (or is null) then all of w is returned from the nStart position.
' nStart is an optional starting position to begin searching and extracting. If nStart is not 
' specified, position 1 will be used. If nStart is zero, a null string is returned. If nStart is 
' negative, the starting position is counted from right to left: if -1, the search begins at the
' last character; if -2, the second to last, and so forth. If "ANY" is not specified, m is
' m is handled "as string"

' Syntax: resultstring = Extract([nStart,] w <string to be searched>, [any] m <char(s) to be searched for>)
'***********************************************************************************************
                                                                                   

extern "rtlib"                                                                     
declare function fb_strextract alias "fb_StrExtract"( byref z as zstring, byval lz as integer, byval a as long, byref z1 as zstring, byval lz1 as integer ) as string
declare function fb_wstrextract alias "fb_WstrExtract"( byref w as wstring, byref lw as integer, byval a as long, byref w1 as wstring, byval lw1 as integer ) as wstring ptr
declare function fb_strextractstart alias "fb_StrExtractStart"( byval n as integer, byval dummy as long, byref z as zstring, byval lz as integer, byval a as long, byref z1 as zstring, byval lz1 as integer ) as string
declare function fb_wstrextractstart alias "fb_WstrExtractStart"( byval n as integer, byval dummy as long, byref w as wstring, byref lw as integer, byval a as long, byref w1 as wstring, byval lw1 as integer ) as wstring ptr
end extern


private function extract_str overload(byref o as ustring, byval a as long, byref o1 as ustring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrextract(o, x, a, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function extract_str overload(byref o as ustring, byval a as long, byref o1 as zstring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrextract(o, x, a, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function extract_str overload(byref w as wstring, byval a as long, byref w1 as wstring) as ustring
dim x as uinteger = len(w)
dim y as uinteger = len(w1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrextract(w, x, a, w1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function extract_str overload(byref s as string, byval a as long, byref s1 as string) as string
    return fb_strextract(s, len(s), a, s1, len(s1))
end function

private function extract_str overload(byref s as string, byval a as long, byref s1 as ustring) as string
    return fb_strextract(s, len(s), a, s1, len(s1))
end function


private function extract_str overload(byval n as integer, byval dummy as long, byref o as ustring, byval a as long, byref o1 as ustring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrextractstart(n, dummy, o, x, a, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function extract_str overload(byval n as integer, byval dummy as long, byref o as ustring, byval a as long, byref o1 as zstring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrextractstart(n, dummy, o, x, a, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function extract_str overload(byval n as integer, byval dummy as long, byref w as wstring, byval a as long, byref w1 as wstring) as ustring
dim x as uinteger = len(w)
dim y as uinteger = len(w1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrextractstart(n, dummy, w, x, a, w1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function extract_str overload(byval n as integer, byval dummy as long, byref s as string, byval a as long, byref s1 as string) as string
    return fb_strextractstart(n, dummy, s, len(s), a, s1, len(s1))
end function

private function extract_str overload(byval n as integer, byval dummy as long, byref s as string, byval a as long, byref s1 as ustring) as string
    return fb_strextractstart(n, dummy, s, len(s), a, s1, len(s1))
end function


#macro extract(a, b, c...)                      
    string_.extract_str(a, #?b, #?c)
#endmacro    


'***********************************************************************************************
' Complement to the Extract function. Returns the portion of a string following the
' first occurrence of a character or group of characters.
' w is searched for the string specified in m, if found, all characters
' after m are returned. If m is not present in w (or is null) then
' a zero-length empty string is returned.
' nStart is an optional starting position to begin searching. If nStart is not specified,
' position 1 will be used. If nStart is zero, a null string is returned. If nStart is negative,
' the starting position is counted from right to left: if -1, the search begins at the last
' character; if -2, the second to last, and so forth. If "ANY" is not specified, m is
' handled "as string"

' Syntax: resultstring = Remain([nStart,] w <string to be searched>, [any] m <char(s) to be searched for>)
'***********************************************************************************************


extern "rtlib"                                                                     
declare function fb_strremain alias "fb_StrRemain"( byref z as zstring, byval lz as integer, byval a as long, byref z1 as zstring, byval lz1 as integer ) as string
declare function fb_wstrremain alias "fb_WstrRemain"( byref w as wstring, byref lw as integer, byval a as long, byref w1 as wstring, byval lw1 as integer ) as wstring ptr
declare function fb_strremainstart alias "fb_StrRemainStart"( byval n as integer, byval dummy as long, byref z as zstring, byval lz as integer, byval a as long, byref z1 as zstring, byval lz1 as integer ) as string
declare function fb_wstrremainstart alias "fb_WstrRemainStart"( byval n as integer, byval dummy as long, byref w as wstring, byref lw as integer, byval a as long, byref w1 as wstring, byval lw1 as integer ) as wstring ptr
end extern


private function remain_str overload(byref o as ustring, byval a as long, byref o1 as ustring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrremain(o, x, a, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function remain_str overload(byref o as ustring, byval a as long, byref o1 as zstring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrremain(o, x, a, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function remain_str overload(byref w as wstring, byval a as long, byref w1 as wstring) as ustring
dim x as uinteger = len(w)
dim y as uinteger = len(w1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrremain(w, x, a, w1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function remain_str overload(byref s as string, byval a as long, byref s1 as string) as string
    return fb_strremain(s, len(s), a, s1, len(s1))
end function

private function remain_str overload(byref s as string, byval a as long, byref s1 as ustring) as string
    return fb_strremain(s, len(s), a, s1, len(s1))
end function


private function remain_str overload(byval n as integer, byval dummy as long, byref o as ustring, byval a as long, byref o1 as ustring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrremainstart(n, dummy, o, x, a, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function remain_str overload(byval n as integer, byval dummy as long, byref o as ustring, byval a as long, byref o1 as zstring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrremainstart(n, dummy, o, x, a, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function remain_str overload(byval n as integer, byval dummy as long, byref w as wstring, byval a as long, byref w1 as wstring) as ustring
dim x as uinteger = len(w)
dim y as uinteger = len(w1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrremainstart(n, dummy, w, x, a, w1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function remain_str overload(byval n as integer, byval dummy as long, byref s as string, byval a as long, byref s1 as string) as string
    return fb_strremainstart(n, dummy, s, len(s), a, s1, len(s1))
end function

private function remain_str overload(byval n as integer, byval dummy as long, byref s as string, byval a as long, byref s1 as ustring) as string
    return fb_strremainstart(n, dummy, s, len(s), a, s1, len(s1))
end function


#macro remain(a, b, c...)                      
    string_.remain_str(a, #?b, #?c)
#endmacro    


'***********************************************************************************************
' Returns a delimited field from a string expression.
' m contains a string of one or more characters that must be individually or fully matched to 
' be successful dependig on "Any". If n evaluates to zero or is outside of the actual field 
' count, an empty string is returned. If n is negative then fields are searched from the right 
' to left in w. M is case-sensitive. If m is not specified, it defaults to ","

' Syntax: resultstring = parse(w <string to parse>, [[any] m <delimiter string>,] n <position>)
'***********************************************************************************************


extern "rtlib"                                                                     
declare function fb_strparse alias "fb_StrParse" ( byref z as zstring, byval lz as integer, byval dummy as long, byval n as integer ) as string
declare function fb_wstrparse alias "fb_WstrParse" ( byref w as wstring, byref lw as integer, byval dummy as long, byval n as integer ) as wstring ptr
declare function fb_strparseDelim alias "fb_StrParseDelim" ( byref z as zstring, byval lz as integer, byval any as long, byref z1 as zstring, byval lz1 as integer, byval dummy as long, byval n as integer ) as string
declare function fb_wstrparseDelim alias "fb_WstrParseDelim" ( byref w as wstring, byref lw as integer, byval any as long, byref w as wstring, byval lw1 as integer, byval dummy as long, byval n as integer ) as wstring ptr
end extern


private function parse_str overload(byref o as ustring, byval dummy as long, byval n as integer) as ustring
dim x as uinteger = len(o)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrparse(o, x, dummy, n))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function parse_str overload(byref w as wstring, byval dummy as long, byval n as integer) as ustring
dim x as uinteger = len(w)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrparse(w, x, dummy, n))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function parse_str overload(byref s as string, byval dummy as long, byval n as integer) as string
    return fb_strparse(s, len(s), dummy, n)
end function


private function parse_str overload(byref o as ustring, byval a as long, byref o1 as ustring, byval dummy as long, byval n as integer) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrparsedelim(o, x, a, o1, y, dummy, n))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function parse_str overload(byref o as ustring, byval a as long, byref o1 as zstring, byval dummy as long, byval n as integer) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrparsedelim(o, x, a, o1, y, dummy, n))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function parse_str overload(byref w as wstring, byval a as long, byref w1 as wstring, byval dummy as long, byval n as integer) as ustring
dim x as uinteger = len(w)
dim y as uinteger = len(w1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrparsedelim(w, x, a, w1, y, dummy, n))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function parse_str overload(byref s as string, byval a as long, byref s1 as string, byval dummy as long, byval n as integer) as string
    return fb_strparsedelim(s, len(s), a, s1, len(s1), dummy, n)
end function

private function parse_str overload(byref s as string, byval a as long, byref s1 as ustring, byval dummy as long, byval n as integer) as string
    return fb_strparsedelim(s, len(s), a, s1, len(s1), dummy, n)
end function


#macro outparse(a, b, c...)
    string_.parse_str(a, #?b, #?c)
#endmacro  


'***********************************************************************************************
' Shrinks a string to be able to use a consistent single character delimiter.
' The purpose of this function is to create a string with consecutive data items (words)
' separated by a consistent single character. This makes it very straightforward to parse
' the results as needed.
' If m is not defined then all leading spaces and trailing spaces are removed entirely.
' All occurrences of two or more spaces are changed to a single space. Therefore, the new
' string returned consists of zero or more words, each separated by a single space character.
' If m is specified, it defines one or more delimiter characters to shrink. All leading
' and trailing mask characters are removed entirely. All occurrences of one or more mask
' characters are replaced with the first character of wszMask The new string returned consists
' of zero or more words, each separated by the character found in the first position of m.
' WhiteSpace is generally defined as the four common non-printing characters:
' Space, Tab, Carriage-Return, and Line-Feed. m = (W)Chr(32,9,13,10)

' Syntax: resultstring = Shrink(w <string to shrink>, m <char to stay + chars to remove>)
'***********************************************************************************************


extern "rtlib"                                                                     
declare function fb_strshrink alias "fb_StrShrink"( byref z as zstring, byval lz as integer ) as string
declare function fb_wstrshrink alias "fb_WstrShrink"( byref w as wstring, byref lw as integer ) as wstring ptr
declare function fb_strshrinkdelim alias "fb_StrShrinkDelim"( byref z as zstring, byval lz as integer, byref z1 as zstring, byval lz1 as integer ) as string
declare function fb_wstrshrinkdelim alias "fb_WstrShrinkDelim"( byref w as wstring, byref lw as integer, byref w1 as wstring, byval lw1 as integer ) as wstring ptr
end extern


private function shrink_str overload(byref o as ustring) as ustring
dim x as uinteger = len(o)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrshrink(o, x))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function shrink_str overload(byref w as wstring) as ustring
dim x as uinteger = len(w)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrshrink(w, x))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function shrink_str overload(byref s as string) as string
    return fb_strshrink(s, len(s))
end function


private function shrink_str overload(byref o as ustring, byref o1 as ustring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrshrinkdelim(o, x, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function shrink_str overload(byref o as ustring, byref o1 as zstring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrshrinkdelim(o, x, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function shrink_str overload(byref w as wstring, byref w1 as wstring) as ustring
dim x as uinteger = len(w)
dim y as uinteger = len(w1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrshrinkdelim(w, x, w1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function shrink_str overload(byref s as string, byref s1 as string) as string
    return fb_strshrinkdelim(s, len(s), s1, len(s1))
end function

private function shrink_str overload(byref s as string, byref s1 as ustring) as string
    return fb_strshrinkdelim(s, len(s), s1, len(s1))
end function


#macro shrink(a, b...)
    string_.shrink_str(a, b)
#endmacro


'***********************************************************************************************
' Returns a copy of string w with substrings m removed individually or in total.
' If m is not present in w, all of w is returned. If "ANY" is not specified, m is
' handled "as string"

' Syntax: resultstring = Remove(me)(w <string to remove from>, [any] m <string to remove>)
'***********************************************************************************************


extern "rtlib"                                                                     
declare function fb_strremove alias "fb_StrRemove"( byref z as zstring, byval lz as integer, byval any as long, byref z1 as zstring, byval lz1 as integer ) as string
declare function fb_wstrremove alias "fb_WstrRemove"( byref w as wstring, byref lw as integer, byval any as long, byref w as wstring, byval lw1 as integer ) as wstring ptr
end extern


private function remove_str overload(byref o as ustring, byval a as long, byref o1 as ustring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrremove(o, x, a, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function remove_str overload(byref o as ustring, byval a as long, byref o1 as zstring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrremove(o, x, a, o1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function remove_str overload(byref w as wstring, byval a as long, byref w1 as wstring) as ustring
dim x as uinteger = len(w)
dim y as uinteger = len(w1)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrremove(w, x, a, w1, y))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function remove_str overload(byref s as string, byval a as long, byref s1 as string) as string
    return fb_strremove(s, len(s), a, s1, len(s1))
end function

private function remove_str overload(byref s as string, byval a as long, byref s1 as ustring) as string
    return fb_strremove(s, len(s), a, s1, len(s1))
end function


#macro removeme(a, b)
    string_.remove_str(a, #?b)
#endmacro  


'***********************************************************************************************
' Within w replace all occurrences of one string with another string or all occurrences of 
' any of the individual characters specified in the m string with r
' The replacement can cause w to grow or shrink in size. When a match is found, the 
' scan for the next match begins at the position immediately following the prior match.
' r can be a single character or a word. If "ANY" is not specified, m is
' handled "as string"

' Syntax: resultstring = Replace(w <string to replace in>, [any] m <char(s) to be replaced>, r <replacement string>)
'***********************************************************************************************


extern "rtlib"                                                                     
declare function fb_strreplace alias "fb_StrReplace" ( byref z as zstring, byval lz as integer, byval any as long, byref z1 as zstring, byval lz1 as integer, byref z2 as zstring, byval lz2 as integer ) as string
declare function fb_wstrreplace alias "fb_WstrReplace" ( byref w as wstring, byref lw as integer, byval any as long, byref w1 as wstring, byval lw1 as integer, byref w2 as wstring, byval lw2 as integer ) as wstring ptr
end extern


private function replace_str overload(byref o as ustring, byval a as long, byref o1 as ustring, byref o2 as ustring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim z as uinteger = len(o2)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrreplace(o, x, a, o1, y, o2, z))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function replace_str overload(byref o as ustring, byval a as long, byref o1 as zstring, byref o2 as ustring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim z as uinteger = len(o2)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrreplace(o, x, a, o1, y, o2, z))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function replace_str overload(byref o as ustring, byval a as long, byref o1 as ustring, byref o2 as zstring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim z as uinteger = len(o2)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrreplace(o, x, a, o1, y, o2, z))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function replace_str overload(byref o as ustring, byval a as long, byref o1 as zstring, byref o2 as zstring) as ustring
dim x as uinteger = len(o)
dim y as uinteger = len(o1)
dim z as uinteger = len(o2)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrreplace(o, x, a, o1, y, o2, z))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function

private function replace_str overload(byref w as wstring, byval a as long, byref w1 as wstring, byref w2 as wstring) as ustring
dim x as uinteger = len(w)
dim y as uinteger = len(w1)
dim z as uinteger = len(w2)
dim u as ustring = 0

    u.u_data = cast(ubyte ptr, fb_wstrreplace(w, x, a, w1, y, w2, z))
    u.u_len = x * sizeof(wstring)                     'set returned length
    return u
end function
  
private function replace_str overload(byref s as string, byval a as long, byref s1 as string, byref s2 as string) as string
    return fb_strreplace(s, len(s), a, s1, len(s1), s2, len(s2))
end function

private function replace_str overload(byref s as string, byval a as long, byref s1 as ustring, byref s2 as string) as string
    return fb_strreplace(s, len(s), a, s1, len(s1), s2, len(s2))
end function


#macro replace(a, b, c)
    string_.replace_str(a, #?b, c)
#endmacro  


end namespace


#endif
