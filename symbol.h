#ifndef SYMBOL_H
#define SYMBOL_H

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

struct symbole {
  char * name;
  int index;
  int init;
  int isConst;
  int depth;
} ;

struct symbole table[512];
int nb_lignes;

// Doit être invoqué avant le parsing afin d'ouvrir le fichier outAssembleur
int initTable();

// Renvoie les adresses des variables temporaires précédentes
int getTemp(int i);

// Doit être invoqué à la fin du parsing pour fermer le fichier outAssembleur
int finalizeTable();

int putInTable(char * pname, int pinit, int pconst);

int getFromTable(char * pname);

int addTemp();

int suppTemp();

int ass_add(int adr_result, int adr_op1, int adr_op2);

int ass_mul(int adr_result, int adr_op1, int adr_op2);

int ass_sou(int adr_result, int adr_op1, int adr_op2);

int ass_div(int adr_result, int adr_op1, int adr_op2);

int ass_cop(int adr_result, int adr_op);

int ass_afc(int adr_result, int val);

int ass_jmp(int num_instruct);

int ass_jmf(int adr_x, int num_instruct);

int ass_inf(int adr_result, int adr_op1, int adr_op2);

int ass_sup(int adr_result, int adr_op1, int adr_op2);

int ass_equ(int adr_result, int adr_op1, int adr_op2);

int ass_pri(int adr_result);

#endif
