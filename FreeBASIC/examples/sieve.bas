defint a-z
'$include: 'win\crtdll.bi'
'$include: 'win\user32.bi'

const INTERATIONS = 1000

  Dim Flags(0 to 8190)
  dim iter 
  dim count 
  dim prime 
  dim k 
  dim i
  dim x as integer
  
  x = clock
  
  For Iter = 1 To INTERATIONS
    Count = 0 
    
    For I = 0 To 8190 
      Flags(I) = 1 
    Next  
    
    For I = 0 To 8190 
      If Flags(I)=1 Then 
        Prime = (I shl 1) + 3 
        K = I + Prime 
        While K <= 8190 
          Flags(K) = 0 
          K = K + Prime 
        Wend 
        Count = Count + 1 
      End If 
    Next  
  Next
  
  x = clock - x
  
  MessageBox 0, "msecs taken: " + str$( x ), "SIEVE", MB_ICONASTERISK