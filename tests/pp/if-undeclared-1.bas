' TEST_MODE : COMPILE_ONLY_FAIL

'' There is no point allowing this,
'' usually it's a mistake and #ifdef should be used instead
#if undeclaredid
#endif
