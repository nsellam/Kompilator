#!/bin/sh
echo
echo "--------- Reconaissance syntaxique ---------"
echo
cat test.c | ./exe
echo
echo
echo "--------- Interprétation ---------"
echo
cat outAssembleur | ./interpreteur
