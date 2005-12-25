#define FALSE 0
#define TRUE NOT FALSE

#define FOO TRUE

#if defined(FOO) and defined(BAR)
# error 
#elseif not defined(FOO) and defined(BAR)
# error 
#elseif defined(FOO) and not defined(BAR)
#elseif not defined(FOO) or not defined(BAR)
# error 
#endif

#if FOO = TRUE
#else
# error 
#endif

#if FOO <> FALSE and not defined(BAR)
#else
# error 
#endif