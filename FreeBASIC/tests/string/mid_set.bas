

dim test as string*3
dim i as integer
dim h as string

h="123"

print "TEST_TEMPORARY_DESCRIPTIOR: ";
for i=1 to 260
  mid(test,1)=h
  if len(str(i))=0 then print "ERROR": end 1
next
print "OK"
end 0
