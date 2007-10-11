
#ifdef __FB_MAIN__

private sub __exe_init constructor 
    randomize timer 
    screen 12 
end sub 

private sub __exe_end destructor 
    locate width shr 16, 1
    print "Press any key...";
    sleep 
end sub

#endif