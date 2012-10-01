dim i as long

open "test.dat" for random as #1
for i = 1 to 10
	put #1, , i
next

seek #1, 2
get #1, , i

print "data: "; i; " current record: "; loc(1); " next: "; seek(1)
