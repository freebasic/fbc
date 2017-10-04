dxe3gen -o libfb.dxe --whole-archive -U libfb.a
dxe3gen --show-exp libfb.dxe > libfblst.txt
maksymbr -o symb_reg.txt libfblst.txt
del libfb.dxe
del libfblst.txt
