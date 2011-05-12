/* Extra ld script parts used by fbc when linking */
/* Drop the objinfo section (FB compile time information) that was added if
   objinfo was enabled in fbc */
SECTIONS
{
  /DISCARD/ :
  {
    *(.fbctinf)
  }
}
