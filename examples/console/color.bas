locate ,,0
dim as integer oldcolor = color
dim as integer oldwidth = width

width 80, 25

view print 1 to 8
color 0, 7
cls

view print 17 to 25
color , 7
cls

locate 25,57
print "press any key to exit...";

view print 9 to 16
color 7, 1
cls

locate 13, 40 - (len( "Welcome to FreeBASIC!" ) \ 2)

print "Welcome to ";
color 15
print "FreeBASIC";
color 7
print "!"

sleep
dim as string clearkey = inkey

width oldwidth and &HFFFF, oldwidth shr 16
color oldcolor and &HFFFF, oldcolor shr 16
view print 1 to oldwidth shr 16
cls
locate ,,1
