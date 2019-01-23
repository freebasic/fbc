
#pragma once

' ****************************************************************************************
' This code is copied and adapted from WinFBX with explicit permission of José Roca 
' under the condition that the original copyright applies (see below). 
' All changes and additions are Copyright (c) 2019 Juergen Kuehlwein
' Freeware. Use at your own risk.
' THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
' EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
' MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
' ****************************************************************************************

' ########################################################################################
' Microsoft Windows
' Implements a dynamic data type for null terminated unicode strings.
' Compiler: Free Basic 32 & 64 bit
' Copyright (c) 2016 Paul Squires & José Roca, with the collaboration of Marc Pons.
' Freeware. Use at your own risk.
' THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
' EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
' MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
' ########################################################################################


#pragma USTRING                                       'set compiler for dynamic wide string


#IFDEF __FB_DOS__
  TYPE DWSTR AS STRING
  #define ustring STRING

  #Print ======>
  #Print ======> Warning, Compiled under DOS : DWSTR type is only an Alias for String!
  #Print ======>

#ELSE
  #ifndef ustring
    #ifdef afx                                          'if WinFBX is present
      #ifndef cwstr                                     'if WinFBX is not used
        #define ustring jk.DWSTR                        'use replacement

      #else
        #define ustring afx.CWSTR                       'use WinFBX´s dynamic Unicode string

      #endif

    #else
      #define ustring jk.DWSTR                          'use replacement
    #endif
  #endif
#endif


#ifdef unicode   
  #ifndef dstr                                        'dynamic unicode string
    #define dstr ustring                              '(DSTR)
  #endif  
  #ifndef zstr                                        'zero terminated unicode string (* bytes)
    #define zstr wstring
  #endif  
#ELSE
  #ifndef dstr                                        'dynamic ansi string
    #define dstr string
  #endif  
  #ifndef zstr                                        'zero terminated ansi string (* bytes)
    #define zstr zstring
  #endif  
#ENDIF



'***********************************************************************************************
' replacement for José Roca´s CWstr, if WinFBX is not present or is not used.
' this is mostly a clone of his code without Windows dependency and adapted to
' work wih Linux as well.
'***********************************************************************************************


#ifdef  __FB_64BIT__
private sub ustring_mcpy(byval dest as any ptr, byval src as any ptr, byval count as Uinteger)
'***********************************************************************************************
' memcpy replacement
'***********************************************************************************************

asm
  mov rdi, [dest]                                     'destination
  mov rsi, [src]                                      'source
  mov rcx, [count]                                    '# of byte to copy

  shr rcx, 3                                          '/4
  cld
  
  rep movsq                                           'copy qwords

  mov rcx, [count]
  and rcx, 7                                          'mod 8

  rep movsb                                           'copy bytes

end asm


end sub


#else


private sub ustring_mcpy(byval dest as any ptr, byval src as any ptr, byval count as Ulong) 
'***********************************************************************************************
' memcpy replacement
'***********************************************************************************************

asm
  mov edi, [dest]                                     'destination
  mov esi, [src]                                      'source
  mov ecx, [count]                                    '# of bytes to copy

  shr ecx, 2                                          '/4 -> # of dwords to copy
  cld
  
  rep movsd                                           'copy dwords

  mov ecx, [count]
  and ecx, 3                                          'mod 4

  rep movsb                                           'copy remaining bytes

end asm


end sub
#endif


'***********************************************************************************************
'***********************************************************************************************

#IFNDEF __FB_DOS__


NAMESPACE JK                                          'obviously i cannot use "AFX" here
TYPE DWSTR_ AS DWSTR                                  'Forward reference


'***********************************************************************************************
' DWSTR CLASS
'***********************************************************************************************

#if sizeof(wstring) = 2
TYPE DWSTR
  m_pBuffer AS UBYTE PTR                              'pointer to the buffer (in first place -> make strptr possible)

  Private:
    m_Capacity AS Ulong                               'the total size of the buffer
    m_GrowSize AS LONG = 260 * SizeOf(WSTRING)        'how much to grow the buffer by when required

  Public:
    m_BufferLen AS ulong                              'length in bytes of the current string in the buffer
    u_size      as long = SizeOf(WSTRING)

    DECLARE CONSTRUCTOR
    DECLARE CONSTRUCTOR (BYVAL nChars AS ulong, BYVAL nCodePage AS ulong)
    DECLARE CONSTRUCTOR (BYVAL pwszStr AS WSTRING PTR)
    DECLARE CONSTRUCTOR (BYREF ansiStr AS STRING, BYVAL nCodePage AS ulong = 0)
    DECLARE CONSTRUCTOR (BYREF cws AS DWSTR)
    DECLARE CONSTRUCTOR (BYVAL n AS LONGINT)
    DECLARE CONSTRUCTOR (BYVAL n AS DOUBLE)

    DECLARE DESTRUCTOR

    DECLARE SUB ResizeBuffer (BYVAL nValue AS ulong)
    DECLARE FUNCTION AppendBuffer (BYVAL addrMemory AS ANY PTR, BYVAL nNumBytes AS ulong) AS BOOLEAN
    DECLARE FUNCTION InsertBuffer (BYVAL addrMemory AS ANY PTR, BYVAL nIndex AS ulong, BYVAL nNumBytes AS ulong) AS BOOLEAN

    DECLARE PROPERTY Size () AS LONG
    DECLARE PROPERTY Size (BYVAL nValue AS LONG)
    DECLARE PROPERTY GrowSize () AS LONG
    DECLARE PROPERTY GrowSize (BYVAL nValue AS LONG)
    DECLARE PROPERTY Capacity () AS ulong
    DECLARE PROPERTY Capacity (BYVAL nValue AS ulong)
    DECLARE PROPERTY SizeAlloc (BYVAL nChars AS ulong)
    DECLARE PROPERTY SizeOf () AS ulong
    DECLARE PROPERTY CodePage () AS ulong
    DECLARE PROPERTY CodePage (BYVAL nCodePage AS ulong)

    DECLARE SUB Clear

    DECLARE SUB Add (BYREF cws AS DWSTR)
    DECLARE SUB Add (BYVAL pwszStr AS WSTRING PTR)
    DECLARE SUB Add (BYREF ansiStr AS STRING, BYVAL nCodePage AS ulong = 0)

    DECLARE OPERATOR [] (BYVAL nIndex AS ulong) byref AS USHORT

    DECLARE OPERATOR CAST () BYREF AS WSTRING
    DECLARE OPERATOR CAST () AS ANY PTR

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

#else

TYPE DWSTR
  m_pBuffer AS UBYTE PTR                              'pointer to the buffer (in first place -> make strptr possible)

  Private:
    m_Capacity AS Ulong                               'the total size of the buffer
    m_GrowSize AS LONG = 260 * SizeOf(WSTRING)        'how much to grow the buffer by when required

  Public:
    m_BufferLen AS ulong                              'length in bytes of the current string in the buffer
    u_size      as long = SizeOf(WSTRING)

    DECLARE CONSTRUCTOR
    DECLARE CONSTRUCTOR (BYVAL nChars AS ulong, BYVAL nCodePage AS ulong)
    DECLARE CONSTRUCTOR (BYVAL pwszStr AS WSTRING PTR)
    DECLARE CONSTRUCTOR (BYREF ansiStr AS STRING, BYVAL nCodePage AS ulong = 0)
    DECLARE CONSTRUCTOR (BYREF cws AS DWSTR)
    DECLARE CONSTRUCTOR (BYVAL n AS LONGINT)
    DECLARE CONSTRUCTOR (BYVAL n AS DOUBLE)

    DECLARE DESTRUCTOR

    DECLARE SUB ResizeBuffer (BYVAL nValue AS ulong)
    DECLARE FUNCTION AppendBuffer (BYVAL addrMemory AS ANY PTR, BYVAL nNumBytes AS ulong) AS BOOLEAN
    DECLARE FUNCTION InsertBuffer (BYVAL addrMemory AS ANY PTR, BYVAL nIndex AS ulong, BYVAL nNumBytes AS ulong) AS BOOLEAN

    DECLARE PROPERTY Size () AS LONG
    DECLARE PROPERTY Size (BYVAL nValue AS LONG)
    DECLARE PROPERTY GrowSize () AS LONG
    DECLARE PROPERTY GrowSize (BYVAL nValue AS LONG)
    DECLARE PROPERTY Capacity () AS ulong
    DECLARE PROPERTY Capacity (BYVAL nValue AS ulong)
    DECLARE PROPERTY SizeAlloc (BYVAL nChars AS ulong)
    DECLARE PROPERTY SizeOf () AS ulong
    DECLARE PROPERTY CodePage () AS ulong
    DECLARE PROPERTY CodePage (BYVAL nCodePage AS ulong)

    DECLARE SUB Clear

    DECLARE SUB Add (BYREF cws AS DWSTR)
    DECLARE SUB Add (BYVAL pwszStr AS WSTRING PTR)
    DECLARE SUB Add (BYREF ansiStr AS STRING, BYVAL nCodePage AS ulong = 0)

    DECLARE OPERATOR [] (BYVAL nIndex AS ulong) byref AS Ulong

    DECLARE OPERATOR CAST () BYREF AS WSTRING
    DECLARE OPERATOR CAST () AS ANY PTR

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
#endif


'***********************************************************************************************
' DWSTR constructors
'***********************************************************************************************


PRIVATE CONSTRUCTOR DWSTR
  this.ResizeBuffer(m_GrowSize)                       'Create the initial buffer
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYVAL nChars AS ulong, BYVAL nCodePage AS ulong)
  IF nChars = 0 THEN nChars = m_GrowSize \ u_size
  this.ResizeBuffer(nChars * u_size)                  'Create the initial buffer
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYVAL pwszStr AS WSTRING PTR)
  IF pwszStr = 0 THEN
     this.ResizeBuffer(m_GrowSize)                    'Create the initial buffer
  ELSE
     this.Add(pwszStr)                                'Add the passed WSTRING
  END IF
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYREF ansiStr AS STRING, BYVAL nCodePage AS ulong = 0)
  IF .LEN(ansiStr) THEN
     this.Add(ansiStr, nCodePage)                     'Add the passed ansi string
  ELSE
     this.ResizeBuffer(m_GrowSize)                    'Create the initial buffer
  END IF
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYREF cws AS DWSTR)
  IF cws.m_BufferLen THEN
     this.Add(cws)                                    'Add the passed DWSTR
  ELSE
     this.ResizeBuffer(m_GrowSize)                    'Create the initial buffer
  END IF
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYVAL n AS LONGINT)
  DIM wsz AS WSTRING * 260 = .WSTR(n)
  this.Add(wsz)
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYVAL n AS DOUBLE)
  DIM wsz AS WSTRING * 260 = .WSTR(n)
  this.Add(wsz)
END CONSTRUCTOR


'***********************************************************************************************
' Destructor
'***********************************************************************************************


PRIVATE DESTRUCTOR DWSTR
  IF m_pBuffer THEN Deallocate(m_pBuffer)
  m_pBuffer = 0
END DESTRUCTOR


'***********************************************************************************************
' operators
'***********************************************************************************************


'***********************************************************************************************
' One * returns the address of the DWSTR buffer.
' Two ** deferences the string data.
' We may use **cws (notice the double indirection) with these functions.
'***********************************************************************************************


PRIVATE OPERATOR * (BYREF cws AS DWSTR) AS WSTRING PTR
  OPERATOR = cast(WSTRING PTR, cws.m_pBuffer)
END OPERATOR


'***********************************************************************************************


PRIVATE OPERATOR LEN (BYREF cws AS DWSTR) AS ulong    'returns the length, in characters, of the DWSTR.
  OPERATOR = cws.m_BufferLen \ cws.u_size
END OPERATOR

PRIVATE OPERATOR DWSTR.CAST () AS ANY PTR             'returns a pointer to the DWSTR buffer.
  OPERATOR = cast(ANY PTR, m_pBuffer)
END OPERATOR

PRIVATE OPERATOR DWSTR.CAST () BYREF AS WSTRING       'returns the string data (same as **).
  OPERATOR = *cast(WSTRING PTR, m_pBuffer)
END OPERATOR


#if sizeof(wstring) = 2
PRIVATE OPERATOR DWSTR.[] (BYVAL nIndex AS ulong) byref AS USHORT
'***********************************************************************************************
' Returns the corresponding ASCII or Unicode integer representation of the character at the
' zerobased position specified by the nIndex parameter. Can be used to change a value too.
'***********************************************************************************************
static zero as ushort                                 'fallback for nIndex outside valid data

  IF nIndex > (m_BufferLen \ u_size) THEN
    zero = &HFFFF
    OPERATOR = zero                                   'return 0
    exit operator
  end if
  
  OPERATOR = *cast(USHORT ptr, m_pBuffer + (nIndex * u_size))
END OPERATOR


#else
PRIVATE OPERATOR DWSTR.[] (BYVAL nIndex AS ulong) byref AS Ulong
'***********************************************************************************************
' Returns the corresponding ASCII or Unicode integer representation of the character at the
' zerobased position specified by the nIndex parameter. Can be used to change a value too.
'***********************************************************************************************
static zero as ulong                                  'fallback for nIndex outside valid data

  IF nIndex > (m_BufferLen \ u_size) THEN
    zero = &HFFFFFFFF
    OPERATOR = zero                                   'return 0
    exit operator
  end if
  
  OPERATOR = *cast(Ulong ptr, m_pBuffer + (nIndex * u_size))
END OPERATOR
#endif


'***********************************************************************************************
' Assigns new text to the DWSTR.
'***********************************************************************************************


PRIVATE OPERATOR DWSTR.Let (BYREF wszStr AS CONST WSTRING)
  this.Clear
  this.Add(wszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.Let (BYREF ansiStr AS STRING)
  this.Clear
  this.Add(ansiStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.Let (BYREF pwszStr AS WSTRING PTR)
  this.Clear
  IF pwszStr = 0 THEN EXIT OPERATOR
  this.Add(*pwszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.Let (BYREF cws AS DWSTR)
  IF m_pBuffer = cws.m_pBuffer THEN EXIT OPERATOR   ' // Ignore cws = cws
  this.Clear
  this.Add(cws)
END OPERATOR


'***********************************************************************************************
' Appends a string to the DWSTR
'***********************************************************************************************


PRIVATE OPERATOR DWSTR.+= (BYREF wszStr AS WSTRING)   'appends a wstring to the DWSTR
  this.Add(wszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.+= (BYREF ansiStr AS STRING)   'appends a string to the DWSTR
  this.Add(ansiStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.+= (BYREF cws AS DWSTR)        'appends a DWSTR to the DWSTR
  this.Add(cws)
END OPERATOR



PRIVATE OPERATOR DWSTR.&= (BYREF wszStr AS WSTRING)   'appends a wstring to the DWSTR
  this.Add(wszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.&= (BYREF ansiStr AS STRING)   'appends a string to the DWSTR
  this.Add(ansiStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.&= (BYREF cws AS DWSTR)        'appends a DWSTR to the DWSTR
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


'***********************************************************************************************
' ResizeBuffer - Increases the size of the internal buffer capacity
'***********************************************************************************************


PRIVATE SUB DWSTR.ResizeBuffer (BYVAL nValue AS ulong)
  ' // If it is an odd value, make it even.
  IF (nValue MOD u_size) <> 0 THEN nValue += 1
  ' Increase the size of the existing buffer by creating a new buffer copying
  ' the existing data into it and then finally deleting the original buffer.
  DIM pNewBuffer AS UBYTE PTR = Allocate(nValue + u_size)   ' // +2 to make room for the double null terminator.

  IF m_pBuffer THEN
     IF nValue < m_BufferLen THEN m_BufferLen = nValue
     ustring_mcpy(pNewBuffer, m_pBuffer, m_BufferLen)
     Deallocate m_pBuffer
  END IF
  m_pBuffer = pNewBuffer
  m_Capacity = nValue

  m_pBuffer[m_BufferLen] = 0                          'mark the end of the string with a double null
  m_pBuffer[m_BufferLen + 1] = 0

  if u_size > 2 then
    m_pBuffer[m_BufferLen + 2] = 0
    m_pBuffer[m_BufferLen + 3] = 0
  end if

END SUB


'***********************************************************************************************
' Appends the specified number of bytes from the specified memory address to the end of the buffer.
'***********************************************************************************************


PRIVATE FUNCTION DWSTR.AppendBuffer (BYVAL addrMemory AS ANY PTR, BYVAL nNumBytes AS ulong) AS BOOLEAN

  IF m_GrowSize < 0 THEN
     IF (m_BufferLen + nNumBytes) > m_Capacity THEN this.ResizeBuffer((m_BufferLen + nNumBytes) * u_size)
  ELSE
     IF (m_BufferLen + nNumBytes) > m_Capacity THEN this.ResizeBuffer(m_BufferLen + nNumBytes + m_GrowSize)
  END IF
  IF m_pBuffer = 0 THEN RETURN FALSE

  ustring_mcpy(m_pBuffer + m_BufferLen, addrMemory, nNumBytes)

  m_BufferLen += nNumBytes

  m_pBuffer[m_BufferLen] = 0                          'mark the end of the string with a double null
  m_pBuffer[m_BufferLen + 1] = 0

  if u_size > 2 then
    m_pBuffer[m_BufferLen + 2] = 0
    m_pBuffer[m_BufferLen + 3] = 0
  end if

  RETURN TRUE

END FUNCTION


'***********************************************************************************************
' The string parameter is appended to the string held in the class. If the internal string
' buffer overflows, the class will automatically extend it to an appropriate size.
'***********************************************************************************************


PRIVATE SUB DWSTR.Add (BYREF cws AS DWSTR)
  ' Incoming string is already in wide format, simply copy it to the buffer.
  DIM nLenString AS ulong = cws.m_BufferLen   ' // Length in bytes
  IF nLenString = 0 THEN RETURN

  this.AppendBuffer(cast(ANY PTR, cws), nLenString)   'copy the string into the buffer and update the length

END SUB

PRIVATE SUB DWSTR.Add (BYVAL pwszStr AS WSTRING PTR)

  IF pwszStr = 0 THEN RETURN
  ' Incoming string is already in wide format
  DIM nLenString AS ulong = .LEN(*pwszStr)   ' // Length in characters
  IF nLenString = 0 THEN RETURN

  this.AppendBuffer(cast(ANY PTR, pwszStr), nLenString * u_size)              'copy the string into the buffer and update the length

END SUB


PRIVATE SUB DWSTR.Add (BYREF ansiStr AS STRING, BYVAL nCodePage AS ulong = 0)

  IF LEN(ansiStr) = 0 THEN RETURN
  ' Create the wide string from the incoming ansi string

  DIM dwLen AS ulong, pbuffer AS wstring PTR

  dwlen = len(ansistr) * 5                           'enough even, if each byte converts to a surrogate pair
  pbuffer = Allocate(dwLen)

  *pbuffer = ansistr                                 'let FB´s intrinsic conversion do the job
  dwlen = len(*pbuffer) * u_size

  IF pbuffer THEN

    this.AppendBuffer(pbuffer, dwLen)                 'copy the string into the buffer and update the length
    Deallocate(pbuffer)
  END IF

END SUB


'***********************************************************************************************
' All data in the class object is erased. Actually, we only set the buffer length to zero,
' indicating no string in the buffer. The allocated memory for the buffer is deallocated
' when the class is destroyed.
'***********************************************************************************************


PRIVATE SUB DWSTR.Clear
  m_BufferLen = 0

  m_pBuffer[m_BufferLen] = 0                         'mark the end of the string with a double null
  m_pBuffer[m_BufferLen + 1] = 0

  if u_size > 2 then
    m_pBuffer[m_BufferLen + 2] = 0
    m_pBuffer[m_BufferLen + 3] = 0
  end if

END SUB


'***********************************************************************************************
' Properties
'***********************************************************************************************


PRIVATE PROPERTY DWSTR.Size() AS LONG
  PROPERTY = u_size
END PROPERTY

PRIVATE PROPERTY DWSTR.Size (BYVAL nChars AS LONG)
  IF nChars > -1 THEN u_size = nChars ELSE u_size = -1
END PROPERTY


'***********************************************************************************************
' Number of characters to preallocate to minimize multiple allocations when doing multiple
' concatenations. A value of less than 0 indicates that it must double the capacity each
' time that the buffer needs to be resized.
'***********************************************************************************************


PRIVATE PROPERTY DWSTR.GrowSize() AS LONG
  IF m_GrowSize > -1 THEN PROPERTY = m_GrowSize \ u_size ELSE PROPERTY = m_GrowSize
END PROPERTY

PRIVATE PROPERTY DWSTR.GrowSize (BYVAL nChars AS LONG)
  IF nChars > -1 THEN m_GrowSize = nChars * u_size ELSE m_GrowSize = -1
END PROPERTY


'***********************************************************************************************
' The size of the internal string buffer is retrieved and returned to the caller. The size
' is the number of bytes which can be stored without further expansion.
'***********************************************************************************************


PRIVATE PROPERTY DWSTR.Capacity() AS ulong
  PROPERTY = m_Capacity
END PROPERTY


'***********************************************************************************************
' The internal string buffer is expanded to the specified number of bytes. If the new
' capacity is smaller or equal to the current capacity, no operation is performed. If it is
' smaller, the buffer is shortened and the contents that exceed the new capacity are lost.
'***********************************************************************************************


PRIVATE PROPERTY DWSTR.Capacity (BYVAL nValue AS ulong)
  ' // If the new capacity is the same that the current capacity, do nothing.
  IF nValue = m_Capacity THEN EXIT PROPERTY
  ' // Make sure that the number is odd (ResizeBuffer already does it)
  this.ResizeBuffer(nValue)
END PROPERTY


'***********************************************************************************************
' The internal string buffer is expanded to the specified number of byyes.
' Sets the capacity of the buffer in characters. If the new capacity is equal to the
' current capacity, no operation is performed. If it is smaller, the buffer is shortened
' and the contents that exceed the new capacity are lost.
'***********************************************************************************************


PRIVATE PROPERTY DWSTR.SizeAlloc (BYVAL nChars AS ulong)
  ' // If the new capacity is the same that the current capacity, do nothing.
  IF nChars = m_Capacity \ u_size THEN EXIT PROPERTY
  this.ResizeBuffer(nChars * u_size)
END PROPERTY

PRIVATE PROPERTY DWSTR.SizeOf() AS ulong              'returns the capacity of the buffer in characters.
  PROPERTY = m_Capacity \ u_size
END PROPERTY


END NAMESPACE


'***********************************************************************************************
' GLOBAL OPERATORS (Outside a namespace because they are global)
'***********************************************************************************************


PRIVATE OPERATOR & (BYREF cws1 AS JK.DWSTR, BYREF cws2 AS JK.DWSTR) AS JK.DWSTR
DIM cwsRes AS JK.DWSTR = cws1
  cwsRes.Add(cws2)
  OPERATOR = cwsRes
END OPERATOR


'***********************************************************************************************
' overloaded LEFT, RIGHT
'***********************************************************************************************


PRIVATE FUNCTION Left OVERLOAD (BYREF cws AS JK.DWSTR, BYVAL nChars AS INTEGER) AS JK.DWSTR
  RETURN LEFT(*cast(WSTRING PTR, cws.m_pBuffer), nChars)
END FUNCTION

PRIVATE FUNCTION Right OVERLOAD (BYREF cws AS JK.DWSTR, BYVAL nChars AS INTEGER) AS JK.DWSTR
  RETURN RIGHT(*cast(WSTRING PTR, cws.m_pBuffer), nChars)
END FUNCTION


'***********************************************************************************************
' overloaded VAL... functions
'***********************************************************************************************


PRIVATE FUNCTION Val OVERLOAD (BYREF cws AS JK.DWSTR) AS DOUBLE
  RETURN .VAL(*cast(WSTRING PTR, cws.m_pBuffer))
END FUNCTION

PRIVATE FUNCTION Valint OVERLOAD (BYREF cws AS jk.DWSTR) AS long 
   RETURN .VALINT(*cast(WSTRING PTR, cws.m_pBuffer))
END FUNCTION

PRIVATE FUNCTION ValLNG OVERLOAD (BYREF cws AS jk.DWSTR) AS longint 
   RETURN .VALLNG(*cast(WSTRING PTR, cws.m_pBuffer))
END FUNCTION

PRIVATE FUNCTION ValUint OVERLOAD (BYREF cws as jk.DWSTR) AS ulong 
   RETURN .VALUINT(*cast(WSTRING PTR, cws.m_pBuffer))
END FUNCTION

PRIVATE FUNCTION ValULNG OVERLOAD (BYREF cws AS jk.DWSTR) AS ulongint 
   RETURN .VALULNG(*cast(WSTRING PTR, cws.m_pBuffer))
END FUNCTION


'***********************************************************************************************
'***********************************************************************************************
'***********************************************************************************************
#ENDIF   'IFNDEF __FB_DOS__
