mkdir -p -m 0755 /usr/share/freebasic/bin
mkdir -p -m 0755 /usr/share/freebasic/inc
mkdir -p -m 0755 /usr/share/freebasic/lib

cp lib/* /usr/share/freebasic/lib
cp -r inc/* /usr/share/freebasic/inc
cp fbc /usr/share/freebasic/bin
(cd /usr/bin; ln -s /usr/share/freebasic/bin/fbc fbc)
