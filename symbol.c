#include "symbol.h"
#include <string.h>
#include <stdlib.h>

int pointeur; 

int initTable () {
  int pointeur = 1;
}

int putInTable(char * pname, int pinit, int pconst) {
  table[pointeur].name = pname;
  table[pointeur].index = pointeur;
  table[pointeur].init = pinit;
  table[pointeur].isConst = pconst;
  table[pointeur].depth = 0;
  pointeur++;
  return 0;
}

int getFromTable(char * pname) {
  int i = 0;
  int pindex = -1;
  int trouve = 0;
  while (i < pointeur && !trouve) {
    if (!strcmp((table[i].name),pname)) {
      pindex = i;
      trouve = 1;
    }
    i++;
  }
  return pindex;
}

int addTemp() {
  //rechercher dans la table
  pointeur++;
  return pointeur-1;
}

int suppTemp() {
  pointeur--;
  return 0;
}
