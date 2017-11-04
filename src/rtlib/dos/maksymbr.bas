
'$LANG: "fblite"

DIM InputFiles$(1 TO 100)
r% = 1: NextOutput% = 0: OutputFile$ = "": InputCount% = 0: OutHelp% = 0: OutBasic% = 0
DO
 c$ = TRIM$(COMMAND$(r%))
 IF LEN(c$) = 0 THEN EXIT DO
 SELECT CASE UCASE$(c$)
  CASE "-H", "-HELP": OutHelp% = 1
  CASE "-O": NextOutput% = 1
  CASE "-B": OutBasic% = 1
  CASE ELSE
   IF NextOutput% = 1 THEN
    OutputFile$ = c$: NextOutput% = 0
   ELSE
    InputCount% = InputCount% + 1: InputFiles$(InputCount%) = c$
   END IF
 END SELECT
 r% = r% + 1
LOOP
IF OutHelp% = 1 THEN
 PRINT "Command format: MAKSYMBR -o output.c input.txt [input2.txt ...]"
 PRINT "output.c – output filename, input.txt – input file names"
 END
END IF
IF (LEN(OutputFile$) = 0) OR (InputCount% <= 0) THEN
 PRINT "Invalid program call format."
 PRINT "For assistance, use the option -h": END 254
END IF
ERR = 0: OPEN OutputFile$ FOR OUTPUT AS #1
IF ERR <> 0 THEN
 PRINT "Error creating output file": END 253
END IF
ErrCode% = 0
FOR r% = 1 TO InputCount% 'in this cycle we form lines of the extern_asm(name)
 ERR = 0: OPEN InputFiles$(r%) FOR INPUT AS #2
 IF ERR <> 0 THEN
  PRINT "Error opening input file "; InputFiles$(r%); "in the first cycle"
  ErrCode% = 252: EXIT FOR
 END IF
 WHILE NOT EOF(2)
  ERR = 0: LINE INPUT #2, InLin$ 'counted the name of the next file
  IF ERR <> 0 THEN
   PRINT "Error reading input file "; InputFiles$(r%) ; "in the first cycle": ErrCode% = 251: EXIT FOR
  END IF
  InLin$ = TRIM$(InLin$)
  PRINT #1, "extern_asm(" + InLin$ + ");"
  IF ERR <> 0 THEN
   PRINT "Error writing to the output file in the first loop": ErrCode% = 250: EXIT FOR
  END IF
 WEND
 CLOSE #2
NEXT r%
IF ErrCode% <> 0 THEN CLOSE: END ErrCode%
ERR = 0: PRINT #1,
PRINT #1 , "DXE_EXPORT_TABLE (libfb_symbol_table)"
IF ERR <> 0 THEN
 PRINT "Error while writing to the output file": CLOSE: END 249
END IF
FOR r% = 1 TO InputCount% 'in this cycle we form lines of the form DXE_EXPORT_ASM (name)
 ERR = 0: OPEN InputFiles$(r%) FOR INPUT AS #2
 IF ERR <> 0 THEN
  PRINT "Error opening input file "; InputFiles$(r%); "in the second cycle"
  ErrCode% = 248: EXIT FOR
 END IF
 WHILE NOT EOF(2)
  ERR = 0: LINE INPUT #2, InLin$ 'counted the name of the next file
  IF ERR <> 0 THEN
   PRINT "Error reading input file "; InputFiles$(r%) ; "in the second cycle"
   ErrCode% = 247: EXIT FOR
  END IF
  InLin$ = TRIM$(InLin$)
  PRINT #1, "    DXE_EXPORT_ASM (" + InLin$ + ")"
  IF ERR <> 0 THEN
   PRINT "Error writing to the output file in the second loop": ErrCode% = 246: EXIT FOR
  END IF
 WEND
 CLOSE #2
NEXT r%
IF ErrCode% = 0 THEN
 ERR = 0: PRINT #1, "DXE_EXPORT_END"
 IF ERR <> 0 THEN
  PRINT "Error while writing to the output file": ErrCode% = 245
 END IF
END IF
CLOSE: END ErrCode%
