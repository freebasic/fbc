''
'' ordinary sieve test
''

defint a-z

const INTERATIONS = 1000

dim done = 1

  Dim Flags(0 to 8190)
  dim iter 
  dim count 
  dim prime 
  dim k 
  dim i
  dim x as double
  
  x = timer
  
  For Iter = 1 To INTERATIONS
    Count = 0 
    
    For I = 0 To 8190 
      Flags(I) = 1 
    Next  
    
    For I = 0 To 8190 
      If Flags(I)=1 Then 
        Prime = (I shl 1) + 3 
        if (prime > done) then
        	print prime
        	done shl= 1
        end if
        K = I + Prime 
        While K <= 8190 
          Flags(K) = 0 
          K = K + Prime 
        Wend 
        Count = Count + 1 
      End If 
    Next  
  Next
  
  x = timer - x
  
  print "msecs taken: " + str$( x )
  sleep