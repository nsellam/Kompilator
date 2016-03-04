#include "symbol.h"
#include <string.h>

struct table *T = NULL;
total = 0;

int putInTable(char * pname, int pinit, int pconst) {
  //rechercher dans la table
  int pindex = 0;
  int trouve = 0;
  struct table * aux = T;
  if (T != NULL) {
    while (!trouve && aux->next != NULL) {
      // si égal, on met à jour la variable
      if (!strcmp(aux->name,pname)) {
	aux->entry.init = pinit;
	trouve = 1;
      }
      pindex++;
      aux = aux->next;
    }
  }
  if (!trouve) {
    struct table * new = malloc(sizeof(struct table));
    new->entry.name = pname;
    new->entry.index = pindex;
    new->entry.init = pinit;
    new->entry.isConst = pconst;
    new->entry.depth = 0;
    total++;
    new->next = NULL;
    aux->next = new;
  }
  return 0;
}

int getFromTable(char * pname) {
  int pindex = -1;
  int trouve = 0;
  struct table * aux = T;
  if (T != NULL) {
    while (!trouve && aux->next != NULL) {
      // si égal, on a gagné
      if (!strcmp(aux->name,pname)) {
	aux->entry.init = pinit;
	pindex = aux->entry.index;
	trouve = 1;
      }
      aux = aux->next;
    }
  }
  return pindex;
}
