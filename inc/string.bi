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
' conversion when passing wide data in a STRING to a wide string.
'***********************************************************************************************


PRIVATE FUNCTION Ucode (BYREF ansiStr AS CONST STRING) AS ustring
'***********************************************************************************************
' copy string to ustring, pass data without conversion
'***********************************************************************************************
DIM u     AS ustring
DIM slen  AS long
DIM ulen  AS long


    if len(ansiStr) = 0 then return ""                  'nothing to do

    slen = LEN(ansiStr)
    ulen = int((slen + sizeof(wstring) - 1) / sizeof(wstring))

    u = space(ulen)
    u[ulen] = 0
    fb_hStrCopy(strptr(u), cast(any ptr, strptr(ansiStr)), sLen)       

    IF sLen THEN RETURN u
    RETURN ""


END FUNCTION


'***********************************************************************************************
' no conversion takes place, the data is just copied. This is necessary to avoid automatic 
' conversion when passing wide data in a wide string to a STRING data type.
'***********************************************************************************************


PRIVATE FUNCTION Acode (BYref w AS USTRING) AS STRING
'***********************************************************************************************
' copy ustring to string, pass data without conversion
'***********************************************************************************************
DIM ansiStr AS STRING 
DIM dwLen   AS long
DIM slen  AS long
DIM ulen  AS long


    if len(w) = 0 then return ""                        'nothing to do

    ulen = len(w)
    slen = ulen * sizeof(wstring)

    ansiStr = SPACE(slen)
    fb_hStrCopy(cast(any ptr, strptr(ansiStr)), cast(any ptr, strptr(w)), slen)

    IF slen THEN RETURN ansiStr
    RETURN ""


END FUNCTION


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


PRIVATE FUNCTION PathNamePath overload (BYREF w AS WSTRING) AS ustring
'***********************************************************************************************
' return path portion of a filespec
'***********************************************************************************************
DIM u  AS ustring = ""
DIM nPos AS LONG


    IF LEN(w) = 0 THEN RETURN u                         'nothing to do

    nPos = InstrRev(w, ANY ":/\")
    IF nPos THEN u = MID(w, 1, nPos)

    RETURN u


END FUNCTION

PRIVATE FUNCTION PathNamePath overload (BYREF z AS ZSTRING) AS string
'***********************************************************************************************
' return path portion of a filespec
'***********************************************************************************************
DIM s  AS string = ""
DIM nPos AS LONG


    IF LEN(z) = 0 THEN RETURN s                         'nothing to do

    nPos = InstrRev(z, ANY ":/\")
    IF nPos THEN s = MID(z, 1, nPos)

    RETURN s


END FUNCTION


PRIVATE FUNCTION PathNameName overload (BYREF w AS WSTRING) AS ustring
'***********************************************************************************************
' return name portion of a filespec
'***********************************************************************************************
DIM u  AS ustring = ""
DIM nPos AS LONG


    IF LEN(w) = 0 THEN RETURN u                       'nothing to do

    nPos = InstrRev(w, ANY ":/\")
    u = w
    IF nPos THEN u = MID(w, nPos + 1)                 'get the filename
    nPos = InstrRev(u, ".")
    IF nPos THEN u = MID(u, 1, nPos - 1)

    RETURN u


END FUNCTION

PRIVATE FUNCTION PathNameName overload (BYREF z AS ZSTRING) AS string
'***********************************************************************************************
' return name portion of a filespec
'***********************************************************************************************
DIM s  AS ustring = ""
DIM nPos AS LONG


    IF LEN(z) = 0 THEN RETURN s                       'nothing to do

    nPos = InstrRev(z, ANY ":/\")
    s = z
    IF nPos THEN s = MID(z, nPos + 1)                 'get the filename
    nPos = InstrRev(s, ".")
    IF nPos THEN s = MID(s, 1, nPos - 1)

    RETURN s


END FUNCTION


PRIVATE FUNCTION PathNameNamex overload (BYREF w AS WSTRING) AS ustring
'***********************************************************************************************
' return name + extension portion of a filespec
'***********************************************************************************************
DIM u  AS ustring = ""
DIM nPos AS LONG


    IF LEN(w) = 0 THEN RETURN u                       'nothing to do

    nPos = InstrRev(w, ANY ":/\")
    IF nPos THEN u = MID(w, nPos + 1) ELSE u = w

    RETURN u


END FUNCTION

PRIVATE FUNCTION PathNameNamex overload (BYREF z AS ZSTRING) AS string
'***********************************************************************************************
' return name + extension portion of a filespec
'***********************************************************************************************
DIM s  AS ustring = ""
DIM nPos AS LONG


    IF LEN(z) = 0 THEN RETURN s                       'nothing to do

    nPos = InstrRev(z, ANY ":/\")
    IF nPos THEN s = MID(z, nPos + 1) ELSE s = z

    RETURN s


END FUNCTION


PRIVATE FUNCTION PathNameExtn overload (BYREF w AS WSTRING) AS ustring
'***********************************************************************************************
' return extension portion of a filespec
'***********************************************************************************************
DIM u  AS ustring = ""
DIM nPos AS LONG


    IF LEN(w) = 0 THEN RETURN u                         'nothing to do

    nPos = InstrRev(w, ANY ":/\")
    IF nPos THEN u = MID(w, nPos + 1) ELSE u = w   
    nPos = InStrRev(u, ".")
    IF nPos THEN u = MID(u, nPos) ELSE u = ""      'get the extension

     RETURN u


END FUNCTION

PRIVATE FUNCTION PathNameExtn overload (BYREF z AS ZSTRING) AS string
'***********************************************************************************************
' return extension portion of a filespec
'***********************************************************************************************
DIM s  AS ustring = ""
DIM nPos AS LONG


    IF LEN(z) = 0 THEN RETURN s                       'nothing to do

    nPos = InstrRev(z, ANY ":/\")
    IF nPos THEN s = MID(z, nPos + 1) ELSE s = z   
    nPos = InStrRev(s, ".")
    IF nPos THEN s = MID(s, nPos) ELSE s = ""         'get the extension

     RETURN s


END FUNCTION


#macro pathname(what, p)
    pathname##what(p)
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
