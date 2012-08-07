for i as integer = 0 to 9
	print i; " ";
next
print

dim as integer i = 0

do
	print i; " ";
	i += 1
loop while i < 4

do
	print i; " ";
	i += 1
loop until i = 7

while i < 10
	print i; " ";
	i += 1
wend

print

print "press ESC to exit"
while inkey() <> chr(27)
	sleep 20, 1
wend
