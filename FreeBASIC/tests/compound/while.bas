option explicit 

dim as string s
dim as integer i 

i = 0 
while i < 10     
    if i = 5 then 
         s = str(i)
         i += 1 
         continue while 
    end if 
    i += 1 
wend 

assert( s = "5" )
