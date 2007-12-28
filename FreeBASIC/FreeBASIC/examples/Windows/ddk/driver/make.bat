@echo off
set drvname=driver

fbc %drvname%.bas -c

link %drvname%.o /DRIVER /align:0x80 /FULLBUILD /base:0x10000 /release /osversion:5.1 /version:5.1 /OPT:ICF /OPT:REF /SECTION:INIT,d /MERGE:_PAGE=PAGE /MERGE:.data=PAGE /MERGE:.ctors=PAGE /MERGE:_INIT=INIT /MERGE:_TEXT=.text /subsystem:native,5.01 /entry:GsDriverEntry@8 bufferoverflowk.lib ntoskrnl.lib /OUT:%drvname%.sys
