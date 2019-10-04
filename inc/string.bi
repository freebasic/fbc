#ifndef __STRING_BI__
#define __STRING_BI__

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


#endif
