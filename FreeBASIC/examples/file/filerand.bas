dim i as long

 OPEN "TEST.DAT" FOR RANDOM AS #1
 FOR i = 1 TO 10
     PUT #1, , i
 NEXT i
 
 SEEK #1, 2
 GET #1, , i
 
 PRINT "Data: "; i; " Current record: "; LOC(1); " Next: "; SEEK(1)
 

