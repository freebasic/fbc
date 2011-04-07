

declare function winmmCreate as integer
declare function winmmRelease as integer
declare function winmmInitMidi as integer
declare function winmmEndMidi as integer
declare function winmmPlayMidi( byval filename as string ) as integer
declare function winmmStopMidi( ) as integer

declare function winmmInitWave as integer
declare function winmmEndWave as integer
declare function winmmPlayWave( byval filename as string ) as integer
declare function winmmStopWave as integer
