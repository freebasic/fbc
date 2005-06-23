#ifdef FIXME
'' It works without '$dynamic with QB .. do we want to keep it this way?
'$dynamic
#endif

option explicit
option private

defint a-z

common shared ext_array() as integer

dim shared ext_array(1 to 21, 1 to 2) as integer
