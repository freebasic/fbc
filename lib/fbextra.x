/* This linker script snippet is passed to ld as an implicit linker script that
   should augment the linker's default linker script. It's supposed to drop the
   objinfo section (FB compile time information) that may be added to some/all
   objects if objinfo was enabled in fbc, since this information is just bloat
   in the final binary. */
SECTIONS
{
  /DISCARD/ :
  {
    *(.fbctinf)
  }
}
INSERT AFTER .data;
