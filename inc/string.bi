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
#define ucode_ ucode
#define acode_ acode
#define pathname_ pathname
#define repeat_ repeat
#define strreverse_ strreverse
#define insert_ insert


'***********************************************************************************************
' new functions for string manipulation
'***********************************************************************************************

'***********************************************************************************************
' no conversion takes place, the data is just copied. This is necessary to avoid automatic 
' conversion when passing wide data in a STRING to a wide string and vice versa.

' Syntax: [z]string = Acode(wstring)
'         w/ustring = Ucode([z]string)
'***********************************************************************************************


'declare function ucode alias "fb_WcharFromStr" (z as Zstring) as wstring
'declare function acode alias "fb_StrFromWchar" (w as wstring) as string


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


'declare function pathname_path  overload alias "fb_StrPath_path" (byref z as zstring) as string
'declare function pathname_path  overload alias "fb_WstrPath_path" (byref w as wstring) as wstring
'declare function pathname_name  overload alias "fb_StrPath_name" (byref z as zstring) as string
'declare function pathname_name  overload alias "fb_WstrPath_name" (byref w as wstring) as wstring
'declare function pathname_namex overload alias "fb_StrPath_namex" (byref z as zstring) as string
'declare function pathname_namex overload alias "fb_WstrPath_namex" (byref w as wstring) as wstring
'declare function pathname_extn  overload alias "fb_StrPath_extn" (byref z as zstring) as string
'declare function pathname_extn  overload alias "fb_WstrPath_extn" (byref w as wstring) as wstring


#macro pathname(what, p)
    pathname_##what(p)
#endmacro    


'***********************************************************************************************
' Returns a string consisting of multiple copies of the specified string.
' This function is a similar to STRING/WSTRING functions, but allows for
' strings of arbitrary length to be conatenated.

' Syntax: resultstring = Repeat(5, "xyz")
'***********************************************************************************************


'declare function repeat overload( byval n as integer, byref z as zstring ) as string
'declare function repeat overload( byval n as integer, byref w as wstring ) as wstring


'***********************************************************************************************
' Count the number of occurrences of specified characters strings within a string.
' W is the string expression in which to count characters. M is a list of single characters 
' to be searched for individually or in total. A match on any one of which  or a match in total
' will cause the count to be incremented for each occurrence. Note that repeated characters in m 
' will not increase the count, if characters a searched individually. If m is not present in w, 
' zero is returned.

' Syntax: n = tally(w <string to count in>, [any] m <string to find>)
' default: count entire string, any -> count each character separately
'***********************************************************************************************


'declare function tally overload( byref z as zstring, byval i as long, byref t as zstring ) as zstring
'declare function tally overload( byref w as wstring, byval i as long, byref t as wstring ) as wstring


#macro tally(s, t)
    fb_tally(s, #?t)
#endmacro    


'***********************************************************************************************
' Returns the count of delimited fields from a string expression.
' If w is empty (a null string) or contains no delimiter character(s), the string
' is considered to contain exactly one sub-field. In this case, ParseCount returns the value 1.
' m contains a string (one or more characters) that are seached individually or must be fully 
' matched.

' Syntax: n = parsecount(w <string to count in>, [any] m <separating string>)
' default: entire separating string, any -> count each character separately
'***********************************************************************************************


'declare function parsecount overload( byref z as zstring, byval i as long, byref t as zstring ) as zstring
'declare function parsecount overload( byref w as wstring, byval i as long, byref t as wstring ) as wstring


#macro parsecount(s, t)
    fb_parsecount(s, #?t)
#endmacro    


'***********************************************************************************************
' Reverses the contents of a string.

' Syntax: resultstring = strreverse("xyz")
'***********************************************************************************************


'declare function strreverse overload( byref z as zstring ) as string
'declare function strreverse overload( byref w as wstring ) as wstring


'***********************************************************************************************
' Inserts a string at a specified position within another string expression.
' Returns a string consisting of w with the string i inserted at position n. 
' If n is greater than the length of w or <= zero then i is appended to w. 
' The first character in the string is position 1

' Syntax: resultstring = Insert(w <string to insert in>, i <string to insert>, n)
'***********************************************************************************************


PRIVATE FUNCTION Insert_ (BYREF w AS WSTRING, BYREF i AS WSTRING, BYVAL n AS LONG) AS ustring
'***********************************************************************************************
' return w with i inserted at position n
'***********************************************************************************************
DIM u AS ustring = w


  IF n <= 0 THEN RETURN u                             'nothing to do

  IF n > LEN(w) THEN                                  'just append
    u += i

  ELSEIF n = 1 THEN                                   'prepend
    u = i + MID(w, 1)

  ELSE                                                'insert
    u = MID(w, 1, n - 1) + i + MID(w, n)
  END IF


  RETURN u


END FUNCTION

#endif
