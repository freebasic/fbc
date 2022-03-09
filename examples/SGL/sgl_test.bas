''MIT License

''Copyright (c) 2020 ruanjiaxing

''Copyright (c) 2020 3oheicrw

''Permission is hereby granted, free of charge, to any person obtaining a copy
''of this software and associated documentation files (the "Software"), to deal
''in the Software without restriction, including without limitation the rights
''to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''copies of the Software, and to permit persons to whom the Software is
''furnished to do so, subject to the following conditions:
''
''The above copyright notice and this permission notice shall be included in all
''copies or substantial portions of the Software.

''THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
''SOFTWARE.

#include once "SGL.bi"

#inclib "sgl64"

function WinMain (byval hInst as HINSTANCE, byval hPInst as HINSTANCE, byval cmdLine as PSTR, byval cmdShow as long) as long

   Dim as HWND panel, btn
   
   SGL_Init(hInst, NULL)

   panel = SGL_New(0, SGL_PANEL, 0, "SGL", -1, -1)

   btn   = SGL_New(panel, SGL_CTRL_BUTTON, 0, "Hello!", 0, 0)

   SGL_Layout(panel)

   SGL_VisibleSet(panel, 1)

   SGL_Run()

   SGL_Exit()
   
   return 0

end function

WinMain(GetModuleHandle(NULL), 0, "sgl_test", 0)
