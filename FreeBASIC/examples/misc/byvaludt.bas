''
'' UDT's passed by value test
''

type BAR
    a as byte
    b as byte
    c as byte
end type

declare sub foo( byval bar as BAR ) 

    dim bar as BAR

    bar.a = 1
    bar.b = 2
    bar.c = 3
    
    foo bar
    sleep
    
sub foo( byval bar as BAR ) 

    print bar.a, bar.b, bar.c

end sub
