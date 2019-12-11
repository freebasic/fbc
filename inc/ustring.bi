#ifndef __USTRING_BI__
#define __USTRING_BI__

'#include "utf_conv.bi"

'' ****************************************************************************************
'' This code is copied and adapted from WinFBX with explicit permission of José Roca 
'' Copyright (C) 2016-2019 José Roca, Paul Squires, Marc Pons & Juergen Kuehlwein.
'' JRoca (at) com.it-berater (dot) org, jk-ide (at) t-online (dot) de
''
'' License: GNU Lesser General Public License version 2.1 (or any later version)
''
'' THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
'' EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
'' MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
'' ########################################################################################

#ifndef ustring
  #define ustring FB_USTRING.DWSTR                  ''use replacement (allow for future development)
#endif

''***********************************************************************************************
'' Replacement for José Roca´s CWstr. This is mostly a clone of his code without 
'' Windows dependency and adapted to work wih Linux as well.
''***********************************************************************************************


NAMESPACE FB_USTRING                              
    const UCHAR_SIZE = sizeof(wstring)

    #if UCHAR_SIZE = 4
        type UCHAR as ulong
    #elseif UCHAR_SIZE = 2
        type UCHAR as ushort
    #elseif UCHAR_SIZE = 1
        type UCHAR as ubyte
    #else
        #error unsupported wstring size
    #endif

''***********************************************************************************************
'' DWSTR CLASS
''***********************************************************************************************
TYPE DWSTR extends wstring
  Public:
    u_data AS UBYTE PTR                               ''pointer to the buffer
    u_len AS ulong                                    ''length in bytes of the current string in the buffer
    u_size AS Ulong                                   ''the total size of the buffer

    DECLARE CONSTRUCTOR
    DECLARE CONSTRUCTOR (BYVAL pwszStr AS WSTRING PTR)
    DECLARE CONSTRUCTOR (BYREF ansiStr AS STRING)
    DECLARE CONSTRUCTOR (BYREF cws AS DWSTR)
    DECLARE CONSTRUCTOR (BYVAL n AS ULONG)            ''n = 0 don´t allocate, n > 0 allocate n chars initially

    DECLARE DESTRUCTOR

    DECLARE SUB ResizeBuffer (BYVAL nValue AS ulong)
    DECLARE FUNCTION AppendBuffer (BYVAL addrMemory AS ANY PTR, BYVAL nNumBytes AS ulong) AS BOOLEAN

    DECLARE SUB Add (BYREF cws AS DWSTR)
    DECLARE SUB Add (BYVAL pwszStr AS WSTRING PTR)
    DECLARE SUB Add (BYREF ansiStr AS STRING)

    DECLARE OPERATOR [] (BYVAL nIndex AS ulong) byref AS UCHAR

    DECLARE OPERATOR CAST () BYREF AS WSTRING
    DECLARE OPERATOR CAST () AS ANY PTR
'    DECLARE OPERATOR CAST () AS string

    DECLARE OPERATOR LET (BYREF ansiStr AS STRING)
    DECLARE OPERATOR LET (BYREF wszStr AS CONST WSTRING)
    DECLARE OPERATOR LET (BYREF pwszStr AS WSTRING PTR)
    DECLARE OPERATOR LET (BYREF cws AS DWSTR)

    DECLARE OPERATOR += (BYREF wszStr AS WSTRING)
    DECLARE OPERATOR += (BYREF cws AS DWSTR)
    DECLARE OPERATOR += (BYREF ansiStr AS STRING)

    DECLARE OPERATOR &= (BYREF wszStr AS WSTRING)
    DECLARE OPERATOR &= (BYREF cws AS DWSTR)
    DECLARE OPERATOR &= (BYREF ansiStr AS STRING)
    DECLARE OPERATOR &= (BYVAL n AS LONGINT)
    DECLARE OPERATOR &= (BYVAL n AS DOUBLE)
END TYPE

''***********************************************************************************************
'' DWSTR constructors
''***********************************************************************************************


PRIVATE CONSTRUCTOR DWSTR
  this.ResizeBuffer(260 * UCHAR_SIZE)                 ''Create the initial buffer
END CONSTRUCTOR


PRIVATE CONSTRUCTOR DWSTR (BYVAL pwszStr AS WSTRING PTR)
  IF pwszStr = 0 THEN
     this.ResizeBuffer(260 * UCHAR_SIZE)              ''Create the initial buffer
  ELSE
     this.Add(pwszStr)                                ''Add the passed WSTRING
  END IF
END CONSTRUCTOR


PRIVATE CONSTRUCTOR DWSTR (BYREF ansiStr AS STRING)
  IF .LEN(ansiStr) THEN
     this.Add(ansiStr)                                ''Add the passed ansi string
  ELSE
     this.ResizeBuffer(260 * UCHAR_SIZE)              ''Create the initial buffer
  END IF
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYREF cws AS DWSTR)
  IF cws.u_len THEN
     this.Add(cws)                                    ''Add the passed DWSTR
  ELSE
     this.ResizeBuffer(260 * UCHAR_SIZE)              ''Create the initial buffer
  END IF
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYVAL n AS ULONG)
  if n > 0 then
     this.ResizeBuffer(n * UCHAR_SIZE)                ''Create the initial buffer, n chars

  else                                                ''don´t construct, need this for RTL functions
  end if  
END CONSTRUCTOR


''***********************************************************************************************
'' Destructor
''***********************************************************************************************


PRIVATE DESTRUCTOR DWSTR
  IF u_data THEN Deallocate(u_data)
  u_data = 0
END DESTRUCTOR


''***********************************************************************************************
'' operators
''***********************************************************************************************

PRIVATE OPERATOR LEN (BYREF cws AS DWSTR) AS ulong    ''returns the length, in characters, of the DWSTR.
  OPERATOR = cws.u_len \ UCHAR_SIZE
END OPERATOR

PRIVATE OPERATOR DWSTR.CAST () AS ANY PTR             ''returns a pointer to the DWSTR buffer.
  OPERATOR = cast(ANY PTR, u_data)
END OPERATOR

PRIVATE OPERATOR DWSTR.CAST () BYREF AS WSTRING       ''returns the string data (same as **).
  OPERATOR = *cast(WSTRING PTR, u_data)
END OPERATOR

'PRIVATE OPERATOR DWSTR.CAST () AS STRING              ''returns the converted string data
'dim s as string
'dim n as integer
'dim i as integer
'
'type mystring
'  d as zstring ptr
'  l as integer
'  s as integer
'end type
'
'dim p as mystring ptr = cast(mystring ptr, varptr(s))
'dim z as zstring ptr
'dim w as wstring ptr
'
'  n = u_len \ UCHAR_SIZE
'  
'  p->d = callocate(n+1)
'  z = p->d
'  w = cast(wstring ptr, u_data)
'  
'  for i = 0 to n - 1                                  'cannot use UTFtoChar here, because doesn´t handle embedded nulls, stops a first null
'    z[i] = w[i]
'  next i
'  
'  z[n] = 0
'
'  p->l = n
'  p->s = n
'
'  OPERATOR = s
'
'END OPERATOR


PRIVATE OPERATOR DWSTR.[] (BYVAL nIndex AS ulong) byref AS UCHAR
''***********************************************************************************************
'' Returns the corresponding ASCII or Unicode integer representation of the character at the
'' zerobased position specified by the nIndex parameter. Can be used to change a value too.
''***********************************************************************************************
static zero as UCHAR                                 ''fallback for nIndex outside valid data

  IF nIndex > (u_len \ UCHAR_SIZE) THEN
    zero = not 0
    OPERATOR = zero                                   ''return error
    exit operator
  end if
  
  OPERATOR = *cast(UCHAR ptr, u_data + (nIndex * UCHAR_SIZE ))
END OPERATOR

''***********************************************************************************************
'' Assigns new text to the DWSTR.
''***********************************************************************************************

PRIVATE OPERATOR DWSTR.Let (BYREF wszStr AS CONST WSTRING)
  u_len = 0
  poke UCHAR, u_data, 0
  this.Add(wszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.Let (BYREF ansiStr AS STRING)
  u_len = 0
  poke UCHAR, u_data, 0
  this.Add(ansiStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.Let (BYREF pwszStr AS WSTRING PTR)
  IF u_data = cast(ubyte ptr, pwszStr) THEN EXIT OPERATOR                 ''ignore self assign

  u_len = 0
  poke UCHAR, u_data, 0
  IF pwszStr = 0 THEN EXIT OPERATOR
  this.Add(*pwszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.Let (BYREF cws AS DWSTR)
  IF u_data = cws.u_data THEN EXIT OPERATOR           '' Ignore cws = cws
  u_len = 0
  poke UCHAR, u_data, 0
  this.Add(cws)
END OPERATOR


''***********************************************************************************************
'' Appends a string to the DWSTR
''***********************************************************************************************


PRIVATE OPERATOR DWSTR.+= (BYREF wszStr AS WSTRING)   ''appends a wstring to the DWSTR
  this.Add(wszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.+= (BYREF ansiStr AS STRING)   ''appends a string to the DWSTR
  this.Add(ansiStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.+= (BYREF cws AS DWSTR)        ''appends a DWSTR to the DWSTR
  this.Add(cws)
END OPERATOR

PRIVATE OPERATOR DWSTR.&= (BYREF wszStr AS WSTRING)   ''appends a wstring to the DWSTR
  this.Add(wszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.&= (BYREF ansiStr AS STRING)   ''appends a string to the DWSTR
  this.Add(ansiStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.&= (BYREF cws AS DWSTR)        ''appends a DWSTR to the DWSTR
  this.Add(cws)
END OPERATOR

PRIVATE OPERATOR DWSTR.&= (BYVAL n AS LONGINT)
  DIM wsz AS WSTRING * 260 = .WSTR(n)
  this.Add(wsz)
END OPERATOR

PRIVATE OPERATOR DWSTR.&= (BYVAL n AS DOUBLE)
  DIM wsz AS WSTRING * 260 = .WSTR(n)
  this.Add(wsz)
END OPERATOR


''***********************************************************************************************
'' ResizeBuffer - Increases the size of the internal buffer capacity
''***********************************************************************************************


PRIVATE SUB DWSTR.ResizeBuffer (BYVAL nValue AS ulong)
  '' If it is an odd value, make it even.
  IF (nValue MOD UCHAR_SIZE) <> 0 THEN nValue += 1
  '' Increase the size of the existing buffer by creating a new buffer copying
  '' the existing data into it and then finally deleting the original buffer.
  DIM pNewBuffer AS UBYTE PTR = Allocate(nValue + UCHAR_SIZE)  '' + UCHAR_SIZE = make room for the double null terminator.

  IF u_data THEN
    IF nValue < u_len THEN u_len = nValue
    shift(byval pNewBuffer, byval u_data, u_len)
    Deallocate u_data
  END IF
  u_data = pNewBuffer
  u_size = nValue

  poke UCHAR, u_data + u_len, 0                       'mark the end of a string with null

END SUB


''***********************************************************************************************
'' Appends the specified number of bytes from the specified memory address to the end of the buffer.
''***********************************************************************************************


PRIVATE FUNCTION DWSTR.AppendBuffer (BYVAL addrMemory AS ANY PTR, BYVAL nNumBytes AS ulong) AS BOOLEAN

  IF (u_len + nNumBytes) > u_size THEN 
    if u_size > 260 then
      this.ResizeBuffer(u_len + nNumBytes + u_size * 0.125)               'add new + 12.5%
    else
      this.ResizeBuffer(u_len + nNumBytes + 64 * UCHAR_SIZE)              '42 and lower fails - why ?
    end if
  end if

  IF u_data = 0 THEN RETURN FALSE

  shift(byval (u_data + u_len), byval addrMemory, nNumBytes)
  u_len += nNumBytes

  poke UCHAR, u_data + u_len, 0                       'mark the end of a string with null
  RETURN TRUE

END FUNCTION


''***********************************************************************************************
'' The string parameter is appended to the string held in the class. If the internal string
'' buffer overflows, the class will automatically extend it to an appropriate size.
''***********************************************************************************************


PRIVATE SUB DWSTR.Add (BYREF cws AS DWSTR)
  '' Incoming string is already in wide format, simply copy it to the buffer.
  DIM nLenString AS ulong = cws.u_len                 '' Length in bytes
  IF nLenString = 0 THEN RETURN

  ''copy the string into the buffer and update the length
  this.AppendBuffer(cast(ANY PTR, cws), nLenString)   

END SUB

PRIVATE SUB DWSTR.Add (BYVAL pwszStr AS WSTRING PTR)

  IF pwszStr = 0 THEN RETURN
  '' Incoming string is already in wide format
  DIM nLenString AS ulong = .LEN(*pwszStr)            '' Length in characters
  IF nLenString = 0 THEN RETURN

  ''copy the string into the buffer and update the length
  this.AppendBuffer(cast(ANY PTR, pwszStr), nLenString * UCHAR_SIZE)      

END SUB


PRIVATE SUB DWSTR.Add (BYREF ansiStr AS STRING)

  IF LEN(ansiStr) = 0 THEN RETURN
  '' Create the wide string from the incoming ansi string

  DIM dwLen AS ulong, pbuffer AS wstring PTR

  dwlen = len(ansistr) * 5                            ''enough even, if each byte converts to a surrogate pair
  pbuffer = Allocate(dwLen)

  *pbuffer = ansistr                                  ''let FB´s intrinsic conversion do the job
  dwlen = len(*pbuffer) * UCHAR_SIZE

  IF pbuffer THEN
    ''copy the string into the buffer and update the length
    this.AppendBuffer(pbuffer, dwLen)          
    Deallocate(pbuffer)
  END IF

END SUB

'***********************************************************************************************
'***********************************************************************************************

'PRIVATE SUB DWSTR.Add (BYREF ansiStr AS STRING)       'as expected, this is faster
'
'  IF LEN(ansiStr) = 0 THEN RETURN
'  '' Create the wide string from the incoming ansi string
'
'  DIM dwLen AS ulong, pbuffer AS wstring PTR, n as integer
'
'  '' implicit conversion stops at embedded nulls, therefore use explicit conversion
'  #if UCHAR_SIZE = 4
'    pbuffer = CharToUtf(UTF_ENCOD_UTF32, strptr(ansistr), len(ansistr), 0, @n)
'  #elseif UCHAR_SIZE = 2
'    pbuffer = CharToUtf(UTF_ENCOD_UTF16, strptr(ansistr), len(ansistr), 0, @n)
'  #elseif UCHAR_SIZE = 1
'    *pbuffer = ansistr
'    n = len(ansistr)
'  #endif
'
'  IF pbuffer THEN
'    ''copy the string into the buffer and update the length
'    dwLen = n
'    this.AppendBuffer(pbuffer, dwLen)          
'    Deallocate(pbuffer)
'  END IF
'
'end sub

'***********************************************************************************************
'***********************************************************************************************

'PRIVATE SUB DWSTR.Add (BYREF ansiStr AS STRING)       'makes utf_conv.bi obsolete, but slower
'
'  IF LEN(ansiStr) = 0 THEN RETURN
'  '' Create the wide string from the incoming ansi string
'
'  DIM dwLen AS ulong, pbuffer AS wstring PTR, n as integer
'
'dim i as integer
'
'dim z as zstring ptr
'
'  dwLen = len(ansistr) *  UCHAR_SIZE
'  pbuffer = Allocate(dwLen)
'  
'  z = strptr(ansistr)
'
'  for i = 0 to len(ansistr) - 1
'    pbuffer[i] = z[i]
'  next i
'  
'  IF pbuffer THEN
'    ''copy the string into the buffer and update the length
'    this.AppendBuffer(pbuffer, dwLen)          
'    Deallocate(pbuffer)
'  END IF
'
'END SUB


END NAMESPACE


''***********************************************************************************************
'' GLOBAL OPERATORS (Outside a namespace because they are global)
''***********************************************************************************************


PRIVATE OPERATOR & (BYREF cws1 AS FB_USTRING.DWSTR, BYREF cws2 AS FB_USTRING.DWSTR) AS FB_USTRING.DWSTR
DIM cwsRes AS FB_USTRING.DWSTR = cws1
  cwsRes.Add(cws2)
  OPERATOR = cwsRes
END OPERATOR

PRIVATE OPERATOR & overload (BYREF cws1 AS FB_USTRING.DWSTR, BYVAL n AS LONGINT) AS FB_USTRING.DWSTR
DIM cwsRes AS FB_USTRING.DWSTR = cws1
DIM wsz AS WSTRING * 260 = .WSTR(n)
  cwsRes.Add(wsz)
  OPERATOR = cwsRes
END OPERATOR

PRIVATE OPERATOR & overload (BYREF cws1 AS FB_USTRING.DWSTR, BYVAL n AS double) AS FB_USTRING.DWSTR
DIM cwsRes AS FB_USTRING.DWSTR = cws1
DIM wsz AS WSTRING * 260 = .WSTR(n)
  cwsRes.Add(wsz)
  OPERATOR = cwsRes
END OPERATOR

PRIVATE OPERATOR & overload (BYREF cws1 AS FB_USTRING.DWSTR, byref w as wstring) AS FB_USTRING.DWSTR
DIM cwsRes AS FB_USTRING.DWSTR = cws1
  cwsRes.Add(w)
  OPERATOR = cwsRes
END OPERATOR


''***********************************************************************************************
'' overloaded LEFT, RIGHT
''***********************************************************************************************


PRIVATE FUNCTION Left OVERLOAD (BYREF cws AS FB_USTRING.DWSTR, BYVAL nChars AS INTEGER) AS FB_USTRING.DWSTR
dim ret as FB_USTRING.DWSTR = 0
dim n   as integer

  n = nChars * sizeof(wstring)

  if n > cws.u_len then
    n = cws.u_len
  end if

  ret.u_data = Allocate(n + 4)                        '' + 4 = make room for the null terminator.

  IF ret.u_data THEN
    shift(byval ret.u_data, byval cws.u_data, n)
  else
    err = 4
    return ret
  END IF

  ret.u_len = n

  poke long, ret.u_data + n, 0                        'add 4 nulls (covers all possible WSTRING sizes
  return ret

END FUNCTION

PRIVATE FUNCTION Right OVERLOAD (BYREF cws AS FB_USTRING.DWSTR, BYVAL nChars AS INTEGER) AS FB_USTRING.DWSTR
dim ret as FB_USTRING.DWSTR = 0
dim n   as integer

  n = nChars * sizeof(wstring)

  if n > cws.u_len then
    n = cws.u_len
  end if

  ret.u_data = Allocate(n + 4)                        '' + 4 = make room for the null terminator.

  IF ret.u_data THEN
    shift(byval ret.u_data, byval cws.u_data + cws.u_len - n, n)
  else
    err = 4
    return ret
  END IF

  ret.u_len = n

  poke long, ret.u_data + n, 0                        'add 4 nulls (covers all possible WSTRING sizes
  return ret

END FUNCTION


''***********************************************************************************************
'' overloaded VAL... functions
''***********************************************************************************************


PRIVATE FUNCTION Val OVERLOAD (BYREF cws AS FB_USTRING.DWSTR) AS DOUBLE
  RETURN .VAL(*cast(WSTRING PTR, cws.u_data))
END FUNCTION

PRIVATE FUNCTION Valint OVERLOAD (BYREF cws AS FB_USTRING.DWSTR) AS long 
   RETURN .VALINT(*cast(WSTRING PTR, cws.u_data))
END FUNCTION

PRIVATE FUNCTION ValLNG OVERLOAD (BYREF cws AS FB_USTRING.DWSTR) AS longint 
   RETURN .VALLNG(*cast(WSTRING PTR, cws.u_data))
END FUNCTION

PRIVATE FUNCTION ValUint OVERLOAD (BYREF cws as FB_USTRING.DWSTR) AS ulong 
   RETURN .VALUINT(*cast(WSTRING PTR, cws.u_data))
END FUNCTION

PRIVATE FUNCTION ValULNG OVERLOAD (BYREF cws AS FB_USTRING.DWSTR) AS ulongint 
   RETURN .VALULNG(*cast(WSTRING PTR, cws.u_data))
END FUNCTION


#endif