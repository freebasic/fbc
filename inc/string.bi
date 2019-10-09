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


'***********************************************************************************************
' new functions for string manipulation
'***********************************************************************************************

'***********************************************************************************************
' no conversion takes place, the data is just copied. This is necessary to avoid automatic 
' conversion when passing wide data in a STRING to a wide string and vice versa.
'***********************************************************************************************


'declare function acode alias "fb_WcharFromStr" (z as Zstring) as wstring
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

' Syntax: Pathname(PATH|NAME|NAMEX|EXTN, filespec)
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

' Syntax: Repeat(5, "xyz")
'***********************************************************************************************


PRIVATE FUNCTION Repeat overload (BYVAL n AS LONG, BYREF w AS WSTRING) AS ustring
'***********************************************************************************************
' return w concatenated n times
'***********************************************************************************************
DIM u    AS ustring
DIM nLen AS LONG = LEN(w)


  IF n <= 0 THEN RETURN ""                            'nothing to do
  u = SPACE(n * nLen)                                 'create a buffer and insert the strings into it

  FOR i AS LONG = 0 TO n - 1
    MID(u, (i * nLen) + 1, nLen) = w                  'this avoids pysical concatenation
  NEXT


  RETURN u


END FUNCTION

PRIVATE FUNCTION Repeat overload (BYVAL n AS LONG, BYREF z AS ZSTRING) AS string
'***********************************************************************************************
' return w concatenated n times
'***********************************************************************************************
DIM s    AS string
DIM nLen AS LONG = LEN(s)


  IF n <= 0 THEN RETURN ""                            'nothing to do
  s = SPACE(n * nLen)                                 'create a buffer and insert the strings into it

  FOR i AS LONG = 0 TO n - 1
    MID(s, (i * nLen) + 1, nLen) = z                  'this avoids pysical concatenation
  NEXT


  RETURN s


END FUNCTION


#endif
