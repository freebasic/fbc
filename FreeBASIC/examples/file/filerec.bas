' Read a name and a test score from the console.
' Store each name and score as a record in a
' random-access file.

' Define record fields.
TYPE TestRecord field=1
   NameField  AS STRING * 20
   ScoreField AS SINGLE
END TYPE

' Open the test data file.
DIM FileBuffer AS TestRecord

OPEN "TESTDAT.DAT" FOR RANDOM AS #1 LEN = LEN(FileBuffer)

' Read pairs of names and scores from the console.


FOR i = 1 TO 10
   FileBuffer.NameField = "name" + LTRIM$(STR$(i))
   FileBuffer.ScoreField = i
   PUT #1, i, FileBuffer
NEXT i

PRINT i; " records written."

CLOSE #1



OPEN "TESTDAT.DAT" FOR RANDOM AS #1 LEN = LEN(FileBuffer)

' Read pairs of names and scores from the console.


FOR i = 1 TO 10
   geT #1, i, FileBuffer
   PRINT i, FileBuffer.NameField, str$( FileBuffer.ScoreField ), FileBuffer.ScoreField
NEXT i

CLOSE #1

