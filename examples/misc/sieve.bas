''
'' A somewhat optimized Sieve of Eratosthenes.
'' Written by Michael Webster

dim as integer i,j,k,count
dim as double s

const as integer n = 7919                      ' 1000th prime
redim as byte flags(2 to n)   ' byte array to save space

for i = 2 to sqr(n)
  if flags(i) = 0 then
    j = i shl 1
    do while j <= n
      flags(j) = 1
      j += i
    loop
  end if
next

for i = 2 to N
  if flags(i) = 0 then
    print i,
    count += 1
  end if
next
print
print "number of primes ="; count
print
print "finding first 1000000 primes..."

const as integer n2 = 15485863 
redim as byte flags(2 to n2)

s = timer

for i = 2 to sqr(n2)
  if flags(i) = 0 then
    j = i shl 1
    do while j <= n2
      flags(j) = 1
      j += i
    loop
  end if
next

print using "#.### seconds"; timer - s

sleep
