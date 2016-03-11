#ifndef SYMBOL_H
#define SYMBOL_H

int total;

int putInTable(char * pname, int pinit, int pconst);

int getFromTable(char * pname);

int addTemp();

int suppTemp();

struct symbole {
  char * name;
  int index;
  int init;
  int isConst;
  int depth;
} ;

struct symbole table[512];

#endif
