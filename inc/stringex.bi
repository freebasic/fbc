#include once "ustring.bi"


' This code is copied and adapted from WinFBX with explicit permission of José Roca 
' under the condition that the original copyright applies (see below). 
' All changes and additions are Copyright (c) 2018 Juergen Kuehlwein
' Freeware. Use at your own risk.
' THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
' EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
' MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
' ****************************************************************************************

' ########################################################################################
' Microsoft Windows
' File: AfxStr.inc
' Contents: String wrapper functions.
' Compiler: FreeBasic 32 & 64-bit, Unicode.
' Copyright (c) 2016 Paul Squires and José Roca. Freeware. Use at your own risk.
' THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
' EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
' MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
' ########################################################################################


'***********************************************************************************************
' string handling functions (work for ZSTRING, WSTRING, STRING and USTRING)
'***********************************************************************************************

' acode_
' ucode_
' strreverse_
' pathname_
' rset_
' lset_
' left_
' right_
' mid_
' tally
' parsecount
' parse_
' shrink_
' insert_
' extract_
' remain_
' repeat_
' remove_
' replace_


'***********************************************************************************************
' 1.) wrappers for left/right/mid in order to enable a consistent syntax ($ suffix in jk-ide)
'***********************************************************************************************


#define left_ left
#define right_ right
#define mid_ mid


'***********************************************************************************************
' 2.) new functions for string manipulation
'***********************************************************************************************


'***********************************************************************************************
' no conversion takes place, the data is just copied. This is necessary to avoid automatic 
' conversion when passing wide data in a STRING to an unicode string.
'***********************************************************************************************


PRIVATE FUNCTION Ucode_ (BYREF ansiStr AS CONST STRING) AS ustring
'***********************************************************************************************
' convert string to ustring using ncodepage, default is CP_ACP (0 = default Windows ANSI code page) 
'***********************************************************************************************
DIM u     AS ustring
DIM dwLen AS long


  if len(ansiStr) = 0 then return ""                  'nothing to do

  dwLen = LEN(ansiStr)
  u = SPACE(dwLen)
  ustring_mcpy(*u, cptr(any ptr, strptr(ansiStr)), dwLen)


  IF dwLen THEN RETURN u
  RETURN ""


END FUNCTION


'***********************************************************************************************
' no conversion takes place, the data is just copied. This is necessary to avoid automatic 
' conversion when passing wide data in a wide string to a STRING data type.
'***********************************************************************************************


PRIVATE FUNCTION Acode_ (BYref w AS USTRING) AS STRING
'***********************************************************************************************
' convert ustring to string using nCodePage, if < 0 pass data without conversion
'***********************************************************************************************
DIM ansiStr AS STRING 
DIM dwLen   AS long


  if len(w) = 0 then return ""                        'nothing to do

  dwLen = LEN(w) * sizeof(wstring)
  ansiStr = SPACE(dwLen)
  ustring_mcpy(cptr(any ptr, strptr(ansiStr)), cptr(any ptr, *w), dwLen)


  IF dwLen THEN RETURN ansiStr
  RETURN ""


END FUNCTION


'***********************************************************************************************
' Inserts a string at a specified position within another string expression.
' Returns a string consisting of w with the string i inserted at position n. 
' If is greater than the length of w or <= zero then  i is appended to w. 
' The first character in the string is position 1

' Syntax: Insert_(string to insert in. string to insert, position)
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


'***********************************************************************************************
' Within w replace all occurrences of one string with another string or all occurrences of 
' any of the individual characters specified in the m string with r
' The replacement can cause w to grow or condense in size. When a match is found, the 
' scan for the next match begins at the position immediately following the prior match.
' r can be a single character or a word. This function can be made case insensitive.
' The default is case sensitive and no "ANY" -> m is handled "as string"

' Syntax: Replace_(string to replace in, [any$,] char(s) to be replaced, replacement string [, case in/sensitive])
'***********************************************************************************************


PRIVATE FUNCTION Replace_ OVERLOAD (BYREF w AS WSTRING, byval anyflag as long = 0, BYREF m AS WSTRING, _
                                    BYREF r AS WSTRING, byval iflag as long = 0) AS ustring
'***********************************************************************************************
' return a string (originally w) and replace m by r, any -> chars in m individually, as string otherwise
' iflag -> make it case insensitive
'***********************************************************************************************
DIM u AS ustring = w
DIM lr AS LONG = LEN(r)
DIM lm AS LONG = LEN(m)
DIM nPos AS LONG = 1
DIM wu AS USTRING
DIM mu AS wstring ptr


  if lm = 0 then return u
  if len(w) = 0 then return ""


  if anyflag = 0 then
    if iflag = 0 then
      DO
        nPos = INSTR(nPos, u, m)
        IF nPos = 0 THEN EXIT DO

        u = MID(u, 1, nPos - 1) + r + MID(u, nPos + lm)    'replace m with r (as string, case sensitive)

        nPos += lr
      LOOP

    else
      mu = allocate(len(m) * sizeof(wstring) + 4) 

      wu = ucase(w)
      *mu = ucase(m)

      DO
        nPos = INSTR(npos, wu, *mu)
        IF nPos = 0 THEN EXIT DO

        wu = MID(wu, 1, nPos - 1) + r + MID(wu, nPos + lm) 'must do this in parallel to the original
        u = MID(u, 1, nPos - 1) + r + MID(u, nPos + lm)    'replace m with r (as string, case insensitive)

        nPos += lr
      LOOP

      deallocate mu
    end if

  else
    if iflag = 0 then
      DO
        nPos = INSTR(nPos, u, any m)
        IF nPos = 0 THEN EXIT DO
        u = MID(u, 1, nPos - 1) + r + MID(u, nPos + 1)     'replace any char of m in w individually with r as string

        nPos += lr
      LOOP

    else
      mu = allocate(len(m) * sizeof(wstring) + 4) 

      wu = ucase(w)
      *mu = ucase(m)

      DO
        nPos = INSTR(npos, wu, any *mu)
        IF nPos = 0 THEN EXIT DO

        wu = MID(wu, 1, nPos - 1) + r + MID(wu, nPos + 1)  'must do this in parallel to the original
        u = MID(u, 1, nPos - 1) + r + MID(u, nPos + 1)     'replace any char of m in w individually with r as string

        nPos += lr
      LOOP

      deallocate mu
    end if
  end if  


  RETURN u


END FUNCTION


'***********************************************************************************************


PRIVATE FUNCTION Replace_ OVERLOAD (BYREF w AS WSTRING, BYREF m AS WSTRING, _
                                    BYREF r AS WSTRING, byval iflag as long = 0) AS ustring
'***********************************************************************************************
' no any
'***********************************************************************************************


  function = Replace_(w, 0, m, r, iflag)


end function


'***********************************************************************************************


PRIVATE FUNCTION Replace_ OVERLOAD (BYREF w AS uSTRING, BYREF m AS uSTRING, _
                                    BYREF r AS uSTRING, byval iflag as long = 0) AS ustring
'***********************************************************************************************
' no any
'***********************************************************************************************


  function = Replace_(w, 0, m, r, iflag)


end function


'***********************************************************************************************
' Reverses the contents of a string expression.

' Syntax: Reverse_("xyz")
'***********************************************************************************************


PRIVATE FUNCTION StrReverse_ overload (BYREF w AS WSTRING) AS ustring
'***********************************************************************************************
' reverse char order in w
'***********************************************************************************************
dim i        as Ulong
DIM r        AS ustring
DIM wszChar  AS WSTRING * 2
DIM wszChar2 AS WSTRING * 2
DIM nLen     AS LONG = LEN(w)


  r = wspace(nlen)

  FOR i = 1 TO nLen 
    wszChar = MID(w, i, 1)

    if (asc(wszchar) >= &HD800) and (asc(wszchar) <= &HDBFF) then         'surrogate first char ?
      wszChar2 = MID(w, i+1, 1)

      if (asc(wszchar2) >= &HDC00) and (asc(wszchar2) <= &HDFFF) then     'surrogate second char ?
        MID(**r, nlen - i, 2) = wszchar + wszChar2    'keep byte order for surrogate
        i = i + 1

      else
        MID(**r, nlen - i + 1, 1) = wszchar
      end if

    else
      MID(**r, nlen - i + 1, 1) = wszchar
    end if  
  NEXT i


  RETURN r


END FUNCTION


'***********************************************************************************************
' Returns a string consisting of multiple copies of the specified string.
' This function is similar to STRING/WSTRING (which makes multiple copies of a single character).

' Syntax: Repeat_(5, "xyz")
'***********************************************************************************************


PRIVATE FUNCTION Repeat_ (BYVAL n AS LONG, BYREF w AS WSTRING) AS ustring
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


'***********************************************************************************************
' Complement to the Remain_ function. Extracts characters from a string up to a character
' or group of characters. Returns a substring of w starting with its first character 
' (or the character specified by nStart) and up to (but not including) the first occurrence
' of m. If m is not present in w (or is null) then all of w is returned from the nStart position.
' nStart is an optional starting position to begin searching and extracting. If nStart is not 
' specified, position 1 will be used. If nStart is zero, a nul string is returned. If nStart is 
' negative, ' the starting position is counted from right to left: if -1, the search begins at the
' last character; if -2, the second to last, and so forth. This function can be made case insensitive.
' The default is case sensitive and no "ANY" -> m is handled "as string"

' Syntax: Extract_([nStart,] string to be searched, [any$,] char(s) to be searched for [, case in/sensitive])
'***********************************************************************************************


PRIVATE FUNCTION Extract_ overload (BYVAL nStart AS LONG = 1, BYREF w AS WSTRING, byval anyflag as long = 0, _
                                    BYREF m AS WSTRING, byval iflag as long = 0) AS ustring
'***********************************************************************************************
' return all of w before m (not including m), any -> chars in m individually, as string otherwise
' iflag -> make it case insensitive
'***********************************************************************************************
DIM nPos AS LONG


  IF LEN(w) = 0 THEN RETURN ""
  IF nStart = 0 OR nStart > LEN(w) THEN RETURN ""
  IF nStart < 0 THEN nStart = LEN(w) + nStart + 1


  if anyflag = 0 then
    if iflag = 0 then
      nPos = INSTR(nStart, w, m)
    else
      nPos = INSTR(nStart, UCASE(w), UCASE(m))
    end if

    IF nPos THEN RETURN MID(w, nStart, nPos - nStart )
    RETURN MID(w, nStart)

  else
    if iflag = 0 then
      nPos = INSTR(nStart, w, any m)
    else
      nPos = INSTR(nStart, UCASE(w), any UCASE(m))
    end if

    IF nPos THEN RETURN MID(w, nStart, nPos - nStart )
    RETURN MID(w, nStart)
  end if


END FUNCTION


'***********************************************************************************************


PRIVATE FUNCTION Extract_ overload (BYREF w AS WSTRING, byval anyflag as long = 0, BYREF m AS WSTRING, _
                                   byval iflag as long = 0) AS ustring
'***********************************************************************************************
' no nStart
'***********************************************************************************************


  function = Extract_ (1, w, anyflag, m, iflag)


end function


'***********************************************************************************************


PRIVATE FUNCTION Extract_ overload (BYREF w AS WSTRING, BYREF m AS WSTRING, byval iflag as long = 0) AS ustring
'***********************************************************************************************
' no nStart, no any
'***********************************************************************************************


  function = Extract_ (1, w, 0, m, iflag)


end function


'***********************************************************************************************


PRIVATE FUNCTION Extract_ overload (BYVAL nStart AS LONG, BYREF w AS WSTRING, BYREF m AS WSTRING, byval iflag as long = 0) AS ustring
'***********************************************************************************************
' no any
'***********************************************************************************************


  function = Extract_ (nStart, w, 0, m, iflag)


end function


'***********************************************************************************************
' Complement to the Extract_ function. Returns the portion of a string following the
' first occurrence of a character or group of characters.
' w is searched for the string specified in m If found, all characters
' after m are returned. If m is not present in w (or is null) then
' a zero-length empty string is returned.
' nStart is an optional starting position to begin searching. If nStart is not specified,
' position 1 will be used. If nStart is zero, a nul string is returned. If nStart is negative,
' the starting position is counted from right to left: if -1, the search begins at the last
' character; if -2, the second to last, and so forth. This function can be made case insensitive.
' The default is case sensitive and no "ANY" -> m is handled "as string"

' Syntax: Remain_([nStart,] string to be searched, [any$,] char(s) to be searched for [, case in/sensitive])
'***********************************************************************************************


PRIVATE FUNCTION Remain_ overload (BYVAL nStart AS LONG = 1, BYREF w AS WSTRING, byval anyflag as long = 0, _
                                   BYREF m AS WSTRING, byval iflag as long = 0) AS ustring
'***********************************************************************************************
' return all of w after m (not including m), any -> chars in m individually, as string otherwise
' iflag -> make it case insensitive
'***********************************************************************************************
DIM nPos AS LONG


  IF LEN(w) = 0 OR LEN(m) = 0 THEN RETURN ""
  IF nStart = 0 OR nStart > LEN(w) THEN RETURN ""
  IF nStart < 0 THEN nStart = LEN(w) + nStart + 1


  if anyflag = 0 then
    if iflag = 0 then
      nPos = INSTR(nStart, w, m)
    else
      nPos = INSTR(nStart, UCASE(w), UCASE(m))
    end if


    IF nPos THEN RETURN MID(w, nPos + LEN(m))
    RETURN ""

  else
    if iflag = 0 then
      nPos = INSTR(nStart, w, any m)
    else
      nPos = INSTR(nStart, UCASE(w), any UCASE(m))
    end if

    IF nPos THEN RETURN MID(w, nPos + 1)
    RETURN ""
  end if


END FUNCTION


'***********************************************************************************************


PRIVATE FUNCTION Remain_ overload (BYREF w AS WSTRING, byval anyflag as long = 0, BYREF m AS WSTRING, _
                                   byval iflag as long = 0) AS ustring
'***********************************************************************************************
' no nStart
'***********************************************************************************************


  function = Remain_ (1, w, anyflag, m, iflag)


end function


'***********************************************************************************************


PRIVATE FUNCTION Remain_ overload (BYREF w AS WSTRING, BYREF m AS WSTRING, byval iflag as long = 0) AS ustring
'***********************************************************************************************
' no nStart, no any
'***********************************************************************************************


  function = Remain_ (1, w, 0, m, iflag)


end function


'***********************************************************************************************


PRIVATE FUNCTION Remain_ overload (BYVAL nStart AS LONG, BYREF w AS WSTRING, BYREF m AS WSTRING, byval iflag as long = 0) AS ustring
'***********************************************************************************************
' no any
'***********************************************************************************************


  function = Remain_ (nStart, w, 0, m, iflag)


end function


'***********************************************************************************************
' Returns a copy of string w with substrings m removed individually or in total.
' If m is not present in w, all of w is returned intact. This function can be made case insensitive.
' The default is case sensitive and no "ANY" -> m is handled "as string"

' Syntax: Remove_(string to remove from [,[any$,] string to remove] [, case in/sensitive])
'***********************************************************************************************


PRIVATE FUNCTION Remove_ overload (BYREF w AS WSTRING, byval anyflag as long = 0, BYREF m AS WSTRING, _
                                   byval iflag as long = 0) AS ustring
'***********************************************************************************************
' return w with m removed, any -> remove chars in m individually, as string otherwise
' iflag -> make it case insensitive
'***********************************************************************************************
DIM u    AS ustring = w
DIM nLen AS LONG = LEN(m)
DIM nPos AS LONG = 1
dim wu   as wstring ptr
dim mu   as wstring ptr


  if anyflag = 0 then
    if iflag = 0 then
      if w = m then 
        u = ""
        return u
      end if

      DO
        nPos = INSTR(npos, u, m)
        IF nPos = 0 THEN EXIT DO

        u = mid(u, 1, npos-1) + mid(u, npos+nlen)
      LOOP

    else
      wu = allocate(len(w) * sizeof(wstring) + 4) 
      mu = allocate(len(m) * sizeof(wstring) + 4) 

      *wu = ucase(w)
      *mu = ucase(m)

      if *wu = *mu then
        deallocate wu
        deallocate mu

        u = ""
        return u
      end if

      DO
        nPos = INSTR(npos, *wu, *mu)
        IF nPos = 0 THEN EXIT DO

        *wu = mid(*wu, 1, npos-1) + mid(*wu, npos+nlen)                   'must do this in parallel
        u = mid(u, 1, npos-1) + mid(u, npos+nlen)                         'to the original
      LOOP

      deallocate wu
      deallocate mu
      
    end if  

  else                                                'any
    if iflag = 0 then
      DO
        nPos = INSTR(npos, u, any m)
        IF nPos = 0 THEN
          EXIT DO

        elseif nPos = 1 then
          if len(u) = 1 then
            u = ""
            exit do
          else
            u = mid(u, 2)
          end if  

        else
          u = mid(u, 1, npos-1) + mid(u, npos+1)
        end if  
      LOOP

    else
      wu = allocate(len(w) * sizeof(wstring) + 4) 
      mu = allocate(len(m) * sizeof(wstring) + 4) 

      *wu = ucase(w)
      *mu = ucase(m)

      DO
        nPos = INSTR(npos, *wu, any *mu)
        IF nPos = 0 then
          EXIT DO

        elseif nPos = 1 then
          if len(u) = 1 then
            u = ""
            exit do
          else
            *wu = mid(*wu, 2)
            u = mid(u, 2)
          end if  
        else
          *wu = mid(*wu, 1, npos-1) + mid(*wu, npos+1)
          u = mid(u, 1, npos-1) + mid(u, npos+1)
        end if  
      LOOP
      
      deallocate wu
      deallocate mu
      
    end if  
    
  end if  


  return u


END FUNCTION


'***********************************************************************************************


PRIVATE FUNCTION Remove_ overload (BYREF w AS WSTRING, BYREF m AS WSTRING, byval iflag as long = 0) AS ustring
'***********************************************************************************************
' no any
'***********************************************************************************************


  function = Remove_(w, 0, m, iflag)


end function


'***********************************************************************************************


PRIVATE FUNCTION Remove_ overload (BYREF w AS WSTRING, byval iflag as long = 0) AS ustring
'***********************************************************************************************
' no any
'***********************************************************************************************


  function = Remove_(w, 0, " ", iflag)


end function


'***********************************************************************************************
' Returns a delimited field from a string expression.
' m contains a string of one or more characters that must be individually or fully matched to 
' be successful dependig on "IsAny". If n evaluates to zero or is outside of the actual field 
' count, an empty string is returned. If n is negative then fields are searched from the right 
' to left in w. M is case-sensitive.

' Syntax: dim u as ustring = parse_(string to parse, [[any,] delimiter string,] position)
'***********************************************************************************************


PRIVATE FUNCTION Parse_ OVERLOAD (BYREF w AS WSTRING, BYVAL IsAny AS long = 0, BYREF m AS WSTRING = ",", BYVAL n AS LONG) AS ustring
'***********************************************************************************************
' returns the n-th substring (one based) in w with m as delimiter (one or more char)
'***********************************************************************************************
DIM nCount   AS LONG
dim nStart   AS LONG
DIM nPos     AS LONG = 1
DIM fReverse AS BOOLEAN = IIF(n < 0, TRUE, FALSE)
n = ABS(n)
DIM u        AS ustring = ""
dim l        as long


  IF IsAny THEN
    l = 1                                             'chars one by one
  ELSE
    l = len(m)                                        'entire string
  END IF


  IF fReverse THEN                                    'reverse search
    IF IsAny THEN
      nPos = InstrRev(w, ANY m)
    ELSE
      nPos = InstrRev(w, m)
    END IF

    DO WHILE nPos > 0                                'if not found loop will be skipped
      nStart = nPos + l
      nCount += 1
      nPos = nPos - l
      IF nCount = n THEN EXIT DO
      IF IsAny THEN
        nPos = InStrRev(w, ANY m, nPos)
      ELSE
        nPos = InStrRev(w, m, nPos)
      END IF
    LOOP

    IF nPos = 0 THEN nStart = 1                       'now continue forward to get the end of the token

    IF IsAny THEN
      nPos = INSTR(nStart, w, ANY m)
    ELSE
      nPos = INSTR(nStart, w, m)
    END IF

    IF nPos > 0 OR nCount = n THEN
      IF nPos = 0 THEN
        u = MID(w, nStart)
      ELSE
        u = MID(w, nStart, nPos - nStart)
      END IF
    END IF

  ELSE                                                'forward search
    DO
      nStart = nPos
      IF IsAny THEN
        nPos = INSTR(nPos, w, ANY m)
      ELSE
        nPos = INSTR(nPos, w, m)
      END IF

      IF nPos THEN
        nCount += 1
        nPos += l
      END IF
    LOOP UNTIL nPos = 0 OR nCount = n

    IF nPos > 0 OR nCount = n - 1 THEN
      IF nPos = 0 THEN
        u = MID(w, nStart)
      ELSE
        u = MID(w, nStart, nPos - l - nStart)
      END IF
    END IF
  END IF


  RETURN u


END FUNCTION


'***********************************************************************************************


PRIVATE FUNCTION Parse_ OVERLOAD (BYREF w AS WSTRING, BYREF m AS WSTRING = ",", BYVAL n AS LONG) AS ustring
'***********************************************************************************************
' overload - no any
'***********************************************************************************************


  RETURN Parse_(w, 0, m, n)


END FUNCTION


'***********************************************************************************************


PRIVATE FUNCTION Parse_ OVERLOAD (BYREF w AS WSTRING, BYVAL n AS LONG) AS ustring
'***********************************************************************************************
' overload - no any, no delimiter
'***********************************************************************************************


  RETURN Parse_(w, 0, ",", n)


END FUNCTION


'***********************************************************************************************


PRIVATE FUNCTION LSet_ (BYREF w AS WSTRING, BYVAL n AS ULONG, BYref pad AS WSTRING = " ") AS ustring
'***********************************************************************************************
' return the n leftmost chars of w padded to the right with spaces the first char of pad
'***********************************************************************************************
dim u as ustring
dim l as ulong = len(w)


  if l >= n then                                      'no need to pad
    u = left(w, n)

  else  
    if len(pad) then
      u = wstring(n, pad)
    else                                              'if an empty string is passed -> use the default
      u = wstring(n, wchr(32))
    end if

    MID(u, 1, l) = w                                'mid is faster than conctenation + left
  end if


  RETURN u

                  
END FUNCTION


'***********************************************************************************************


PRIVATE FUNCTION RSet_ (BYREF w AS WSTRING, BYVAL n AS ULONG, BYref pad AS WSTRING = " ") AS ustring
'***********************************************************************************************
' return the n right chars of w padded to the left with spaces or the first char of pad
'***********************************************************************************************
dim u as ustring
dim l as ulong = len(w)


  if l >= n then                                      'no need to pad
    u = right(w, n)

  else
    if len(pad) then
      u = wstring(n, pad)
    else                                              'if an empty string is passed -> use the default
      u = wstring(n, wchr(32)) 
    end if

    MID(u, n-l+1, l) = w                            'mid is faster than conctenation + right
  end if


  RETURN u


END FUNCTION


'***********************************************************************************************
' Parses a path/file name to extract component parts.
' This function evaluates a text path/file text name, and returns a requested part of the
' name. The functionality is strictly one of string parsing alone.
' Oflag is one of the following options which is used to specify the requested part:
' PATH$   Returns the path portion of the path/file Name. That is the text up to and
'         including the last backslash (\) or colon (:).
'
' NAME$   Returns the name portion of the path/file Name. That is the text to the right
'         of the last backslash (\) or colon (:), ending just before the last period (.).
'
' EXTN$   Returns the extension portion of the path/file name. That is the last
'         period (.) in the string plus the text to the right of it.
'
' NAMEX$  Returns the name and the EXTN parts combined.

' Syntax: Pathname_(PATH$|NAME$|NAMEX$|EXTN$, filespec)
'***********************************************************************************************


PRIVATE FUNCTION PathName_ overload (BYval oflag AS long, BYREF w AS WSTRING) AS ustring
'***********************************************************************************************
' return requested portion of a filespec
'***********************************************************************************************
DIM u  AS ustring = ""
DIM nPos AS LONG


  IF LEN(w) = 0 THEN RETURN u                         'nothing to do


  nPos = InstrRev(w, ANY ":/\")
  SELECT CASE oflag
    CASE 1                                            'returns the path portion of file spec
'    CASE PATH_                                        'returns the path portion of file spec
      IF nPos THEN u = MID(w, 1, nPos)

    CASE 2                                            'retrieve the full filename
'    CASE NAME_                                        'retrieve the full filename
       u = w
       IF nPos THEN u = MID(w, nPos + 1)              'get the filename
       nPos = InstrRev(u, ".")
       IF nPos THEN u = MID(u, 1, nPos - 1)

    CASE 3                                            'retrieve the name and extension combined
'    CASE NAMEX_                                       'retrieve the name and extension combined
       IF nPos THEN u = MID(w, nPos + 1) ELSE u = w

    CASE 4                                            'retrieve the name and extension combined
'    CASE EXTN_                                        'retrieve the name and extension combined 
       IF nPos THEN u = MID(w, nPos + 1) ELSE u = w   
       nPos = InStrRev(u, ".")
       IF nPos THEN u = MID(u, nPos) ELSE u = ""      'get the extension
   END SELECT


   RETURN u


END FUNCTION


'***********************************************************************************************


PRIVATE FUNCTION PathName_ overload (BYval oflag AS long, byval dummy as long = 0, BYREF w AS wSTRING) AS ustring
'***********************************************************************************************
' return requested portion of a filespec
' please don´t remove this function, even if it doesn´t seem to make sense !!!
'***********************************************************************************************


  function = pathname_(oflag, w)


END FUNCTION


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

' Syntax: Shrink_(string to shrink, char to stay + chars to remove)
'***********************************************************************************************


PRIVATE FUNCTION Shrink_ (BYREF w AS WSTRING, BYREF m AS WSTRING = " ") AS ustring
'***********************************************************************************************
' replace all chars of m in w, by the first char of m, remove leading and trailing m chars in w
'***********************************************************************************************
DIM u AS ustring 


  IF LEN(w) = 0 THEN RETURN w                         'nothing to do
  IF LEN(m) = 0 THEN RETURN w                         'no mask, no shrink 
   
  u = TRIM(w, ANY m)                                  'Eliminate all leading and trailing mask characters

  DIM wReplace AS WSTRING * 2 = MID(m, 1, 1)          'first char of mask = replacement schar
  DIM wdouble AS WSTRING * 3
  DIM nMaskLen AS LONG = LEN(m)
  DIM nPos AS LONG

  FOR i AS LONG = 1 TO nMaskLen                       'replace all double mask characters with wReplace
     wdouble = MID(m, i, 1) + MID(m, i, 1)            '(usually double spaces)

     nPos = 1
     DO
        nPos = INSTR(nPos, u, wdouble)
        IF nPos = 0 THEN EXIT DO
        u = MID(u, 1, nPos - 1) + wReplace + MID(u, nPos + LEN(wdouble))
     LOOP
  NEXT

  nPos = 1                                            'Replace all single mask chars with wReplace
  DO
     nPos = INSTR(nPos, u, ANY m)
     IF nPos = 0 THEN EXIT DO                       
     
     IF MID(u, nPos, 1) <> wReplace  THEN             'do the replace if the character at the position found is
                                                      'different than the character we need to replace it with.
                                                      'this helps avoiding unneeded string concatenations.
        u = MID(u, 1, nPos - 1) + wReplace + MID(u, nPos + 1)
     END IF
     nPos += 1
  LOOP


  wdouble = MID(m, 1, 1) + MID(m, 1, 1)               'replace all double occurances of wReplace
  nPos = 1                                         
  DO
     nPos = INSTR(npos, u, wdouble)
     IF nPos = 0 THEN EXIT DO
     u = MID(u, 1, nPos - 1) + wReplace + MID(u, nPos + LEN(wdouble))
  LOOP
  RETURN u


END FUNCTION


'***********************************************************************************************
' Count the number of occurrences of specified characters strings within a string.
' W is the string expression in which to count characters. M is a list of single characters 
' to be searched for individually or in total. A match on any one of which  or a match in total
' will cause the count to be incremented for each occurrence.Note that repeated characters in m 
' will not increase the count, if characters a searched individually. If m is not present in w, 
' zero is returned.

' Syntax: n = tally(string to count in, [any$,] string to find [, case in/sensitive]
' default: anyflag = 0 -> count entire string, iflag = 0 -> count case sensitive
'***********************************************************************************************


PRIVATE FUNCTION Tally overload (BYREF w AS WSTRING, byval anyflag as long = 0, BYREF m AS WSTRING = " ", byval iflag as long = 0) AS ULONG
'***********************************************************************************************
' return count of m in w, anyflag = 1/0 chars in m individually/as string 
' iflag = 1/0 case in/sensitive, default is: "as string" and ""case sensitive""
'***********************************************************************************************
DIM n AS LONG = 0
DIM nPos AS LONG = 1
dim wu as wstring ptr
dim mu as wstring ptr


  if iflag = 0 then                                   'count case sensitive
    if anyflag = 0 then                               'match string as string
      DO
         nPos = INSTR(nPos, w, m)
         IF nPos = 0 THEN EXIT DO
         n += 1
         nPos += LEN(m)
      LOOP

    else

      DO
         nPos = INSTR(nPos, w, any m)
         IF nPos = 0 THEN EXIT DO
         n += 1
         nPos += 1
      LOOP
    end if
      
  else    
    wu = allocate(len(w) * sizeof(wstring) + 4) 
    mu = allocate(len(m) * sizeof(wstring) + 4) 

    *wu = ucase(w)
    *mu = ucase(m)

    if anyflag = 0 then                               'match string as string
      DO
         nPos = INSTR(nPos, *wu, *mu)
         IF nPos = 0 THEN EXIT DO
         n += 1
         nPos += LEN(m)
      LOOP

    else
      DO
         nPos = INSTR(nPos, *wu, any *mu)
         IF nPos = 0 THEN EXIT DO
         n += 1
         nPos += 1
      LOOP
    end if  

    deallocate wu
    deallocate mu
  end if  
      

  RETURN n


END FUNCTION


'***********************************************************************************************


PRIVATE FUNCTION Tally overload (BYREF w AS WSTRING, BYREF m AS WSTRING = " ", byval iflag as long = 0) AS ULONG
'***********************************************************************************************
' return count of m in w, iflag = 1/0 case in/sensitive, default is: "case sensitive"
'***********************************************************************************************
DIM n AS LONG = 0
DIM nPos AS LONG = 1
dim wu as wstring ptr
dim mu as wstring ptr


  function = tally(w, 0, m, iflag)


end function


'***********************************************************************************************
' Returns the count of delimited fields from a string expression.
' If w is empty (a null string) or contains no delimiter character(s), the string
' is considered to contain exactly one sub-field. In this case, ParseCount returns the value 1.
' m contains a string (one or more characters) that are seached individually or must be fully 
' matched.

' Syntax: n = parsecount(string to count in, [any$,] separating string [, case in/sensitive]
' default: anyflag = 0 -> separator = entire string, iflag = 0 -> case sensitive
'***********************************************************************************************


PRIVATE FUNCTION parsecount overload (BYREF w AS WSTRING, byval anyflag as long = 0, BYREF m AS WSTRING = " ", byval iflag as long = 0) AS ULONG
'***********************************************************************************************
' return count of portions of w sparated by m, anyflag = 1/0 chars in m individually/as string 
' iflag = 1/0 case in/sensitive, default is: "as string" and ""case sensitive""
'***********************************************************************************************


  FUNCTION = Tally (w, anyflag, m, iflag) + 1


end function


'***********************************************************************************************


PRIVATE FUNCTION parsecount overload (BYREF w AS WSTRING, BYREF m AS WSTRING = " ", byval iflag as long = 0) AS ULONG
'***********************************************************************************************
' return count of portions of w sparated by m, iflag = 1/0 case in/sensitive, 
' default is: "as string"
'***********************************************************************************************


  FUNCTION = Tally (w, m, iflag) + 1


end function


'***********************************************************************************************
'***********************************************************************************************
'***********************************************************************************************
