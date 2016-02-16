#include "symbol.h"

typedef struct table {
  struct symbole id;
  struct table * next;
};

typedef struct symbole {
  char * nom;
  void * address;
  int init;
  int constante;
  int depth;
};

