Tools
=====

Miscellaneous tools for fbc


check-whitespace.bas (fbc sources)
----------------------------------
  Tool to sanitize white space in fbc .bas|.bi sources.  Used occasionaly
  when committing changes to fbc source repository (jeffm)

    Compile with:
      fbc check-whitespace.bas.bas

  Place on PATH and run without any arguments to see options.


emcc.bas (emscripten / Windows)
-------------------------------
  Binary to launch emscipten on Windows.

    Compile with:
      fbc emcc.bas
    Copy to ./bin/js-asmjs/

  fbc expects supporting tools to be executable but the emscripten
  font-end on windows uses 'emcc.bat' (plus python in the background) and fbc 
  can't directly call a .BAT file. This tool is a cheap hack to make it work.
  Compile the source and copy 'emcc.exe' to 'd:/fb.git/bin/js-asmjs/emcc.exe'.
  This should allow fbc to find emcc.exe when launching tools.
  See https://www.freebasic.net/wiki/DevBuildEmscripten
