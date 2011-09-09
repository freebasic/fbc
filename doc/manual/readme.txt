Using the makefile to package an FB manual release:

    If needed, clean out current stuff:
        $ make clean

    If needed, update the cache (i.e. download the current online wiki)
        $ make refresh

    Build the .zip's, passing HHC=<Path to HTML Help Compiler> if needed:
        $ make HHC=C:\htmlhelp\hhc.exe

    (Check the makefile for other variables)


Manually packaging an FB manual release:

  Pull the current wiki and generate html/text/etc from it:
    $ ../fbdoc/fbdoc -refresh -useweb -chm -fbhelp -txt


  o chm

    Compile html/fbdoc.hhp with the Microsoft HTML Help Compiler.
    Then rename the generated fbdoc.chm to something like FB-manual-0.21.1.chm
    and package it.


  o fbhelp (special format for fbhelp program)

    $ mkfbhelpfile
    $ cd fbhelp
    $ gzip fbhelp.dat
    $ cp fbhelp.dat.gz fbhelp.daz
    Then package the fbhelp.daz file.


  o html (clean offline HTML version of the wiki, useful e.g. for Linux users)

    In html/: Copy DocToc.html to 00index.html (just helps the user),
    then package all *.html files, the style.css and the images/ sub-directory.


  o txt (for actually printing out the manual on paper)

    Rename txt/fbdoc.txt to something like FB-manual-0.21.1.txt, then
    package it.


  o wakka

    Package all cache/*.wakka files.
