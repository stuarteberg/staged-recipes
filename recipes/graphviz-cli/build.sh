#!/bin/bash

if [ `uname` == Darwin ]; then
    ./configure --prefix=$PREFIX \
                --with-quartz \
                --disable-debug \
                --disable-java \
                --disable-php \
                --disable-perl \
                --disable-tcl \
                --without-x \
                --without-qt \
                --without-gtk
else
    ./configure --prefix=$PREFIX \
                --disable-debug \
                --disable-java \
                --disable-php \
                --disable-perl \
                --disable-tcl \
                --without-x \
                --without-qt \
                --without-gtk
fi

make
# This is failing for rtest.
# Doesn't do anything for the rest
# make check

if [[ $(uname) == Darwin ]]; then
    # For some reason, libexpat.1.dylib can't be found without setting the RPATH,
    # and it even prevents 'make install' from working.
    install_name_tool -add_rpath ${PREFIX}/lib cmd/dot/.libs/dot
fi

make install

dot -c
