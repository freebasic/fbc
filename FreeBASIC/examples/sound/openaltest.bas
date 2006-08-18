' OpenAL Example Program
' ----------------------
' Written by Chris Davies <c.g.davies@gmail.com>
' 15th February, 2005
'
'
' An example program demonstrating how to use OpenAL through FreeBASIC.
' This program is based on the C/C++ version written by Jesse Maurais
' (http://www.devmaster.net/articles/openal-tutorials/lesson1.php).
'
' The sample WAV file was taken from one of Nightbeat's MODs... :)
'
'
' For more FreeBASIC: http://www.freebasic.net/
'
' ============================================================================
'

#include "al/al.bi"
#include "al/alut.bi"

declare sub UnloadResources()


dim shared Buffer as ALuint   ' buffer to hold audio data.
dim shared Source as ALuint   ' source for the sound to come from.
dim SourcePos(3) as ALfloat   ' 3D position of the sound source.
dim SourceVel(3) as ALfloat   ' 3D velocity of the sound source.
dim ListenerPos(3) as ALfloat ' 3D position of the listener.
dim ListenerVel(3) as ALfloat ' 3D velocity of the listener.
dim ListenerOri(6) as ALfloat ' Listener orientation.

dim wavFormat as ALenum
dim wavSize as ALsizei
dim wavFreq as ALsizei
dim wavData as any ptr
dim wavLoop as ALboolean

dim curPitch as ALfloat

dim done as integer
dim y as integer
dim tmr as single
dim kbin as string



'--- Initialisation ----------------------------------------------------------
color 7,0
cls

print "Initialising OpenAL... ";
alutInit(0, 0)
print "done."

print "Generating buffers... ";
alGenBuffers(1, @Buffer)
if alGetError <> AL_NO_ERROR then
   print "failed!"
   alutExit
   end
end if
print "done."

print "Loading the WAV resource into audio buffer... ";
alutLoadWAVFile("data/prodigy.wav", @wavFormat, @wavData, @wavSize, @wavFreq, @wavLoop)
alBufferData(Buffer, wavFormat, wavData, wavSize, wavFreq)
alutUnloadWAV(wavFormat, wavData, wavSize, wavFreq)

if alGetError <> AL_NO_ERROR then
   print "failed!"
   alutExit
   end
end if

print "done."

print "Generating sources... ";
alGenSources(1, @Source)
if alGetError <> AL_NO_ERROR then
   print "failed!"
   alutExit
   end
end if
print "done."


print "Setting source options... ";

' configure source and listener 3-d info.
SourcePos(0) = 0.0      ' x
SourcePos(1) = 0.0      ' y
SourcePos(2) = 0.0      ' z

SourceVel(0) = 0.0      ' x
SourceVel(1) = 0.0      ' y
SourceVel(2) = 0.0      ' z

curPitch = 1.0
alSourcei (Source,   AL_BUFFER,     Buffer)
alSourcef (Source,   AL_PITCH,      curPitch)
alSourcef (Source,   AL_GAIN,       1.0)
alSourcefv(Source,   AL_POSITION,   @SourcePos(0))
alSourcefv(Source,   AL_VELOCITY,   @SourceVel(0))
alSourcei (Source,   AL_LOOPING,    wavLoop)


if alGetError <> AL_NO_ERROR then
   print "failed!"
   UnloadResources
   alutExit
   end
end if

print "done."


print "Setting listener options... ";

ListenerPos(0) = 0.0    ' x
ListenerPos(1) = 0.0    ' y
ListenerPos(2) = 0.0    ' z

ListenerVel(0) = 0.0    ' x
ListenerVel(1) = 0.0    ' y
ListenerVel(2) = 0.0    ' z

ListenerOri(0) = 0.0    ' at(x)
ListenerOri(1) = 0.0    ' at(y)
ListenerOri(2) = -1.0   ' at(z)
ListenerOri(3) = 0.0    ' up(x)
ListenerOri(4) = 0.0    ' up(y)
ListenerOri(5) = 1.0    ' up(z)

alListenerfv(AL_POSITION, @ListenerPos(0))
alListenerfv(AL_VELOCITY, @ListenerVel(0))
alListenerfv(AL_ORIENTATION, @ListenerOri(0))


if alGetError <> AL_NO_ERROR then
   print "failed!"
   UnloadResources
   alutExit
   end
end if

print "done."



print "Press any key to continue... "
while inkey = "": wend



'--- Main Loop ---------------------------------------------------------------
color 7, 0
cls

color 15, 0
print "FreeBASIC OpenAL Demo"
color 8, 0
print "Written by Chris Davies [shiftLynx]"

print string(80, 196)

color 7,0
print " Welcome to the OpenAL demonstration program.  This program will demonstrate"
print " FreeBASIC using the OpenAL advanced sound library."
print
print " See the comments at the top of the source code for this demo for more"
print " information, including where to find a good OpenAL tutorial. :)"
print
print string(80, 196)
color 15, 0
print " Menu"
color 7, 0
print
print "      1. Play Sample                     5. Increase Pitch"
print "      2. Play Sample (Looping)           6. Decrease Pitch"
print "      3. Pause Sample                    7. Increase Source Distance"
print "      4. Stop Sample                     8. Decrease Source Distance"
print
print "      9. Exit"
print
print " Option: ";

done = 0
while done = 0
   
   ' check for input.
   kbin = inkey
   if kbin <> "" then
      select case kbin
         case "1"
            ' play the sample.
            locate 22, 10: color 15, 0: print "1";: color 7, 0
            
            ' make sure it doesn't loop
            alSourcei(Source, AL_LOOPING, AL_FALSE)
            
            ' play.
            alSourcePlay(Source)
         
         case "2"
            ' play the sample (looping).
            locate 22, 10: color 15, 0: print "2";: color 7, 0
            
            ' enable looping.
            alSourcei(Source, AL_LOOPING, AL_TRUE)
            
            ' play.
            alSourcePlay(Source)
         
         case "3"
            ' pause the sample.
            locate 22, 10: color 15, 0: print "3";: color 7, 0
            
            ' pause the sample.
            alSourcePause(Source)
         
         case "4"
            ' stop the sample.
            locate 22, 10: color 15, 0: print "4";: color 7, 0
            
            ' stop the sample.
            alSourceStop(Source)
         
         case "5"
            ' increase the pitch
            curPitch = curPitch + 0.1
            alSourcef(Source, AL_PITCH, curPitch)
         
         case "6"
            ' decrease the pitch
            curPitch = curPitch - 0.1
            if curPitch < 0.1 then curPitch = 0.1
            alSourcef(Source, AL_PITCH, curPitch)
            
         case "7"
            ' increase the source distance.
            SourcePos(2) = SourcePos(2) + 0.1
            alSourcefv(Source, AL_POSITION, @SourcePos(0))
         
         case "8"
            ' decrease the source distance.
            SourcePos(2) = SourcePos(2) - 0.1
            
            ' make sure that "increasing" doesn't make it quieter. :>
            if SourcePos(2) < 0.0 then SourcePos(2) = 0.0
               
            alSourcefv(Source, AL_POSITION, @SourcePos(0))
         
         case "9"
            ' exit.
            done = 1
            locate 22, 10: color 15, 0: print "5";: color 7, 0
            
      end select
   end if
   
   sleep 25

wend


'--- Shutdown ----------------------------------------------------------------
color 7, 0
cls

print "Unloading OpenAL... ";
alutExit
print "done."

' allow the user to read the message.
sleep 1000

end



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' UnloadResources
'
sub UnloadResources()
   
   alDeleteBuffers(1, @Buffer)
   alDeleteSources(1, @Source)
   
end sub
