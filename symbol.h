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
  int nb_valeurs;
} ;

struct symbole table[512];
int nb_lignes;

// Doit être invoqué avant le parsing afin d'avoir accès au fichier outAssembleur
int initTable(FILE * fichier);

// Renvoie les adresses des variables temporaires précédentes
int getTemp(int i);

int putInTable(char * pname, int pinit, int pconst, int nb_valeurs);

int getNbVals(char * pname);

int getFromTable(char * pname);

char * getFromTableByAddr(int adresse);

int addTemp();

int suppTemp();

int ass_add(int adr_result, int adr_op1, int adr_op2);

int ass_mul(int adr_result, int adr_op1, int adr_op2);

int ass_sou(int adr_result, int adr_op1, int adr_op2);

int ass_div(int adr_result, int adr_op1, int adr_op2);

int ass_cop(int adr_result, int adr_op);

int ass_afc(int adr_result, int val);

int ass_jmp(int num_instruct);

int ass_jmf(int adr_x, char * symbole_ou_sauter);

int ass_inf(int adr_result, int adr_op1, int adr_op2);

int ass_sup(int adr_result, int adr_op1, int adr_op2);

int ass_equ(int adr_result, int adr_op1, int adr_op2);

int ass_pri(int adr_result);

#endif
