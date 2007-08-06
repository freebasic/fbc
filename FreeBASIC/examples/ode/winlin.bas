/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001,2002 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy) http://www.freebasic.eu     *
 *                                                                       *
 ************************************************************************'/
#include "fbgfx.bi"
#include "GL/gl.bi"
#include "internal.bi"

' error and message handling
private _
sub errorBox(title as string , _
             msg   as string)
  dim as integer hFile=freefile
  if open cons(for output as #hFile)=0 then
    print #hFile, title,msg
    close #hFile
  end if
end sub

private _
sub dsWarning (msg as string)
  errorBox ("Warning: ",msg)
end sub

sub dsError (msg as string) export
  errorBox ("Error:   ",msg)
  beep:sleep:end 1
end sub

sub dsDebug (msg as string) export
  errorBox ("Debug:   ",msg)
end sub

sub dsPrint(msg as string) export
  dim as integer hFile=freefile
  if open cons(for output as #hFile)=0 then
    print #hFile,msg
    close #hFile
  else
    beep
  end if
end sub

' globals used to communicate with rendering thread
dim shared as any ptr hThread         = 0
dim shared as integer window_loop     = 0
dim shared as integer renderer_run    = 0
dim shared as integer renderer_pause  = 0 ' 0=run, 1=pause
dim shared as integer renderer_ss     = 0 ' single step command
dim shared as integer renderer_width  = 640
dim shared as integer renderer_height = 480
dim shared as dsFunctions ptr renderer_fn = 0

dim shared as integer keybuffer(31)      ' fifo ring buffer for keypresses
dim shared as integer keybuffer_head = 0 ' index of next key to put in (modified by GUI)
dim shared as integer keybuffer_tail = 0 ' index of next key to take out (modified by renderer)

private _
sub setupRendererGlobals() static
  renderer_run    = 0
  renderer_pause  = 0
  renderer_ss     = 0
  renderer_width  = 0
  renderer_height = 0
  renderer_fn     = 0
  keybuffer_head  = 0
  keybuffer_tail  = 0
end sub


sub renderingThread (lpParam as integer)
  ' test openGL capabilities
  dim as integer maxtsize
  
  Screenres renderer_width,renderer_height,32,,FB.GFX_OPENGL
  Windowtitle "ODE FreeBASIC test environment."
  dsStartGraphics (renderer_width,renderer_height,renderer_fn)
  if (renderer_fn<>0) then 
    if (renderer_fn->_start<>0) then renderer_fn->_start() 
  end if
  'dsDebug("rederingThread: test gl texturesize")
  glGetIntegerv (GL_MAX_TEXTURE_SIZE,@maxtsize)
  if (maxtsize < 128) then 
    dsDebug("max texture size [" & maxtsize & " too small!")
  end if
 
  renderer_run=1
  while (renderer_run)
    ' need to make local copy of renderer_ss to help prevent races
    dim as integer ss = renderer_ss
    dsDrawFrame(renderer_width , _
                renderer_height, _
                renderer_fn, _
                renderer_pause and (not ss))
    if (ss) then renderer_ss = 0

    ' read keys out of ring buffer and feed them to the command function
    while (keybuffer_head <> keybuffer_tail) 
      if (renderer_fn<>NULL) then
        if (renderer_fn->_command<>NULL) then 
          renderer_fn->_command(keybuffer(keybuffer_tail))
        end if
      end if
      keybuffer_tail = (keybuffer_tail+1) and 31
    wend
    flip:' swap buffers
  wend
  dsStop
  if (renderer_fn->_stop<>0) then renderer_fn->_stop()
  dsStopGraphics()
end sub

' the main window loop
sub MainWindowLoop()
  static as integer button=0,textured=1,shadows=1,fog=0
  dim    as fb.EVENT   e
  window_loop=1
  while window_loop<>0
    if screenevent(@e) then
      select case e.type
        case fb.EVENT_MOUSE_BUTTON_PRESS
          select case e.button
            case fb.BUTTON_LEFT : button or= 1
            case fb.BUTTON_RIGHT: button or= 4
            case else        : button or= 2
          end select

        case fb.EVENT_MOUSE_BUTTON_RELEASE
          select case e.button
            case fb.BUTTON_LEFT : button and= not 1
            case fb.BUTTON_RIGHT: button and= not 4
            case else        : button and= not 2
          end select

        case fb.EVENT_MOUSE_MOVE
          if (button) and (e.x>0) and (e.y>0) then 
            dsMotion(button,e.dx,e.dy)
          end if

        case fb.EVENT_KEY_PRESS, fb.EVENT_KEY_REPEAT
          if (e.scancode = fb.SC_ESCAPE) then dsStop()
          if e.ascii=asc("T") then 
            Textured xor=1
            dsSetTextures(Textured)
          elseif e.ascii=asc("F") then 
            fog xor=1
            dsSetFog(Fog)
          elseif e.ascii=asc("S") then 
            shadows xor=1
            dsSetShadows(shadows)
          elseif (e.ascii >= 32) and (e.ascii <= 126) then
            dim as integer nexth = (keybuffer_head+1) and 31
            if (nexth <> keybuffer_tail) then
              keybuffer(keybuffer_head) = e.ascii
              keybuffer_head = nexth
            end if
          end if
        case fb.EVENT_WINDOW_CLOSE
          dsStop()
      end select
    else
      sleep 5,1 ' no waiting event
    end if
  wend
end sub


sub dsPlatformSimLoop (window_width  as integer, _
                       window_height as integer, _
                       fn as dsFunctions ptr, _
                       initial_pause as integer)
  setupRendererGlobals()
  renderer_pause = initial_pause
  renderer_width  = window_width
  renderer_height = window_height
  renderer_fn     = fn
  
  renderer_run=0
  hThread = ThreadCreate(@renderingThread,0)
  if (hThread=NULL) then dsError ("Could not create rendering thread")
  ' wait on thread creation
  while renderer_run=0:sleep 10,0:wend
  
  MainWindowLoop
  ' terminate rendering thread
  renderer_run = 0
  ThreadWait(hThread)
end sub

sub dsStop() export
  window_loop=0
end sub

function dsElapsedTime() as double export
  static as double prev=0.0
  dim    as double curr= timer
  if (prev=0.0) then prev=curr
  dim as double retval = curr-prev
  prev=curr
  if (retval>1.0) then 
    retval=1.0
  elseif (retval<dEpsilon) then 
    retval=dEpsilon
  end if
  return retval
end function
