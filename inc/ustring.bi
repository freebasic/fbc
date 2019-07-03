
#pragma once




#IFDEF __FB_DOS__
  TYPE DWSTR AS STRING
  #define ustring STRING

  #Print ======>
  #Print ======> Warning, Compiled under DOS : DWSTR type is only an Alias for String!
  #Print ======>

#ELSE
  #ifndef ustring
	#ifdef afx                                          
	  #ifndef cwstr                                     
		#define ustring jk.DWSTR                        

	  #else
		#define ustring afx.CWSTR                       

	  #endif

	#else
	  #define ustring jk.DWSTR                          
	#endif
  #endif
#endif


#ifdef unicode   
  #ifndef dstr                                        
	#define dstr ustring                              
  #endif  
  #ifndef zstr                                        
	#define zstr wstring
  #endif  
#ELSE
  #ifndef dstr                                        
	#define dstr string
  #endif  
  #ifndef zstr                                        
	#define zstr zstring
  #endif  
#ENDIF





#IFNDEF __FB_DOS__


NAMESPACE JK                                          
TYPE DWSTR_ AS DWSTR                                  



#if sizeof(wstring) = 2
TYPE DWSTR extends wstring
  Private:
	m_Capacity AS Ulong                               
	m_GrowSize AS LONG = 260 * SizeOf(WSTRING)        

  Public:
	m_pBuffer AS UBYTE PTR                            
	m_BufferLen AS ulong                              
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

TYPE DWSTR extends wstring
  Private:
	m_Capacity AS Ulong                               
	m_GrowSize AS LONG = 260 * SizeOf(WSTRING)        

  Public:
	m_pBuffer AS UBYTE PTR                            
	m_BufferLen AS ulong                              
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




PRIVATE CONSTRUCTOR DWSTR
  this.ResizeBuffer(m_GrowSize)                       
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYVAL nChars AS ulong, BYVAL nCodePage AS ulong)
  IF nChars = 0 THEN nChars = m_GrowSize \ u_size
  this.ResizeBuffer(nChars * u_size)                  
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYVAL pwszStr AS WSTRING PTR)
  IF pwszStr = 0 THEN
	 this.ResizeBuffer(m_GrowSize)                    
  ELSE
	 this.Add(pwszStr)                                
  END IF
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYREF ansiStr AS STRING, BYVAL nCodePage AS ulong = 0)
  IF .LEN(ansiStr) THEN
	 this.Add(ansiStr, nCodePage)                     
  ELSE
	 this.ResizeBuffer(m_GrowSize)                    
  END IF
END CONSTRUCTOR

PRIVATE CONSTRUCTOR DWSTR (BYREF cws AS DWSTR)
  IF cws.m_BufferLen THEN
	 this.Add(cws)                                    
  ELSE
	 this.ResizeBuffer(m_GrowSize)                    
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




PRIVATE DESTRUCTOR DWSTR
  IF m_pBuffer THEN Deallocate(m_pBuffer)
  m_pBuffer = 0
END DESTRUCTOR






PRIVATE OPERATOR * (BYREF cws AS DWSTR) AS WSTRING PTR
  OPERATOR = cast(WSTRING PTR, cws.m_pBuffer)
END OPERATOR




PRIVATE OPERATOR LEN (BYREF cws AS DWSTR) AS ulong    
  OPERATOR = cws.m_BufferLen \ cws.u_size
END OPERATOR

PRIVATE OPERATOR DWSTR.CAST () AS ANY PTR             
  OPERATOR = cast(ANY PTR, m_pBuffer)
END OPERATOR

PRIVATE OPERATOR DWSTR.CAST () BYREF AS WSTRING       
  OPERATOR = *cast(WSTRING PTR, m_pBuffer)
END OPERATOR


#if sizeof(wstring) = 2
PRIVATE OPERATOR DWSTR.[] (BYVAL nIndex AS ulong) byref AS USHORT
static zero as ushort                                 

  IF nIndex > (m_BufferLen \ u_size) THEN
	zero = &HFFFF
	OPERATOR = zero                                   
	exit operator
  end if
  
  OPERATOR = *cast(USHORT ptr, m_pBuffer + (nIndex * u_size))
END OPERATOR


#else
PRIVATE OPERATOR DWSTR.[] (BYVAL nIndex AS ulong) byref AS Ulong
static zero as ulong                                  

  IF nIndex > (m_BufferLen \ u_size) THEN
	zero = &HFFFFFFFF
	OPERATOR = zero                                   
	exit operator
  end if
  
  OPERATOR = *cast(Ulong ptr, m_pBuffer + (nIndex * u_size))
END OPERATOR
#endif




PRIVATE OPERATOR DWSTR.Let (BYREF wszStr AS CONST WSTRING)
  this.Clear
  this.Add(wszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.Let (BYREF ansiStr AS STRING)
  this.Clear
  this.Add(ansiStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.Let (BYREF pwszStr AS WSTRING PTR)
  IF m_pBuffer = cast(ubyte ptr, pwszStr) THEN EXIT OPERATOR              
  this.Clear
  IF pwszStr = 0 THEN EXIT OPERATOR
  this.Add(*pwszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.Let (BYREF cws AS DWSTR)
  IF m_pBuffer = cws.m_pBuffer THEN EXIT OPERATOR   
  this.Clear
  this.Add(cws)
END OPERATOR




PRIVATE OPERATOR DWSTR.+= (BYREF wszStr AS WSTRING)   
  this.Add(wszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.+= (BYREF ansiStr AS STRING)   
  this.Add(ansiStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.+= (BYREF cws AS DWSTR)        
  this.Add(cws)
END OPERATOR



PRIVATE OPERATOR DWSTR.&= (BYREF wszStr AS WSTRING)   
  this.Add(wszStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.&= (BYREF ansiStr AS STRING)   
  this.Add(ansiStr)
END OPERATOR

PRIVATE OPERATOR DWSTR.&= (BYREF cws AS DWSTR)        
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




PRIVATE SUB DWSTR.ResizeBuffer (BYVAL nValue AS ulong)
  IF (nValue MOD u_size) <> 0 THEN nValue += 1
  DIM pNewBuffer AS UBYTE PTR = Allocate(nValue + u_size)   

  IF m_pBuffer THEN
	 IF nValue < m_BufferLen THEN m_BufferLen = nValue
	 fb_hStrCopy(byval pNewBuffer, byval m_pBuffer, m_BufferLen)
	 Deallocate m_pBuffer
  END IF
  m_pBuffer = pNewBuffer
  m_Capacity = nValue

  m_pBuffer[m_BufferLen] = 0                          
  m_pBuffer[m_BufferLen + 1] = 0

  if u_size > 2 then
	m_pBuffer[m_BufferLen + 2] = 0
	m_pBuffer[m_BufferLen + 3] = 0
  end if

END SUB




PRIVATE FUNCTION DWSTR.AppendBuffer (BYVAL addrMemory AS ANY PTR, BYVAL nNumBytes AS ulong) AS BOOLEAN

  IF m_GrowSize < 0 THEN
	 IF (m_BufferLen + nNumBytes) > m_Capacity THEN this.ResizeBuffer((m_BufferLen + nNumBytes) * u_size)
  ELSE
	 IF (m_BufferLen + nNumBytes) > m_Capacity THEN this.ResizeBuffer(m_BufferLen + nNumBytes + m_GrowSize)
  END IF
  IF m_pBuffer = 0 THEN RETURN FALSE

  fb_hStrCopy(byval (m_pBuffer + m_BufferLen), byval addrMemory, nNumBytes)
  m_BufferLen += nNumBytes

  m_pBuffer[m_BufferLen] = 0                          
  m_pBuffer[m_BufferLen + 1] = 0

  if u_size > 2 then
	m_pBuffer[m_BufferLen + 2] = 0
	m_pBuffer[m_BufferLen + 3] = 0
  end if

  RETURN TRUE

END FUNCTION




PRIVATE SUB DWSTR.Add (BYREF cws AS DWSTR)
  DIM nLenString AS ulong = cws.m_BufferLen   
  IF nLenString = 0 THEN RETURN

  this.AppendBuffer(cast(ANY PTR, cws), nLenString)   

END SUB

PRIVATE SUB DWSTR.Add (BYVAL pwszStr AS WSTRING PTR)

  IF pwszStr = 0 THEN RETURN
  DIM nLenString AS ulong = .LEN(*pwszStr)   
  IF nLenString = 0 THEN RETURN

  this.AppendBuffer(cast(ANY PTR, pwszStr), nLenString * u_size)              

END SUB


PRIVATE SUB DWSTR.Add (BYREF ansiStr AS STRING, BYVAL nCodePage AS ulong = 0)

  IF LEN(ansiStr) = 0 THEN RETURN

  DIM dwLen AS ulong, pbuffer AS wstring PTR

  dwlen = len(ansistr) * 5                           
  pbuffer = Allocate(dwLen)

  *pbuffer = ansistr                                 
  dwlen = len(*pbuffer) * u_size

  IF pbuffer THEN

	this.AppendBuffer(pbuffer, dwLen)                 
	Deallocate(pbuffer)
  END IF

END SUB




PRIVATE SUB DWSTR.Clear
  m_BufferLen = 0

  m_pBuffer[m_BufferLen] = 0                         
  m_pBuffer[m_BufferLen + 1] = 0

  if u_size > 2 then
	m_pBuffer[m_BufferLen + 2] = 0
	m_pBuffer[m_BufferLen + 3] = 0
  end if

END SUB




PRIVATE PROPERTY DWSTR.Size() AS LONG
  PROPERTY = u_size
END PROPERTY

PRIVATE PROPERTY DWSTR.Size (BYVAL nChars AS LONG)
  IF nChars > -1 THEN u_size = nChars ELSE u_size = -1
END PROPERTY




PRIVATE PROPERTY DWSTR.GrowSize() AS LONG
  IF m_GrowSize > -1 THEN PROPERTY = m_GrowSize \ u_size ELSE PROPERTY = m_GrowSize
END PROPERTY

PRIVATE PROPERTY DWSTR.GrowSize (BYVAL nChars AS LONG)
  IF nChars > -1 THEN m_GrowSize = nChars * u_size ELSE m_GrowSize = -1
END PROPERTY




PRIVATE PROPERTY DWSTR.Capacity() AS ulong
  PROPERTY = m_Capacity
END PROPERTY




PRIVATE PROPERTY DWSTR.Capacity (BYVAL nValue AS ulong)
  IF nValue = m_Capacity THEN EXIT PROPERTY
  this.ResizeBuffer(nValue)
END PROPERTY




PRIVATE PROPERTY DWSTR.SizeAlloc (BYVAL nChars AS ulong)
  IF nChars = m_Capacity \ u_size THEN EXIT PROPERTY
  this.ResizeBuffer(nChars * u_size)
END PROPERTY

PRIVATE PROPERTY DWSTR.SizeOf() AS ulong              
  PROPERTY = m_Capacity \ u_size
END PROPERTY


END NAMESPACE




PRIVATE OPERATOR & (BYREF cws1 AS JK.DWSTR, BYREF cws2 AS JK.DWSTR) AS JK.DWSTR
DIM cwsRes AS JK.DWSTR = cws1
  cwsRes.Add(cws2)
  OPERATOR = cwsRes
END OPERATOR




PRIVATE FUNCTION Left OVERLOAD (BYREF cws AS JK.DWSTR, BYVAL nChars AS INTEGER) AS JK.DWSTR
  RETURN LEFT(*cast(WSTRING PTR, cws.m_pBuffer), nChars)
END FUNCTION

PRIVATE FUNCTION Right OVERLOAD (BYREF cws AS JK.DWSTR, BYVAL nChars AS INTEGER) AS JK.DWSTR
  RETURN RIGHT(*cast(WSTRING PTR, cws.m_pBuffer), nChars)
END FUNCTION




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


#ENDIF   
