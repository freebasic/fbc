defint a-z
'''$include: 'win\crtdll.bi'

#ifdef FB__WIN32
'$include: 'win\user32.bi'
#endif

'$include: 'crt.bi'

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

  x = (x / CLOCKS_PER_SEC) * 1000
  
#ifdef FB__WIN32
  MessageBox 0, "msecs taken: " + str$( x ), "SIEVE", MB_ICONASTERISK
#else
  print "msecs taken: " + str$( x )

  sleep
#endif