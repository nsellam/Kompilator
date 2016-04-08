#include "symbol.h"

int pointeur;
FILE * pFile;
nb_lignes = 0;

int initTable() {
  pFile=fopen("outAssembleur","w");
  pointeur = 1;
  return 0;
}

int getTemp(int i) {
  if (i>=pointeur) {
    return -1;
  } else {
  return pointeur-i;
  }
}

int finalizeTable() {
  fclose (pFile);
  return 0;
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
  int i = 1;
  int pindex = -1;
  int trouve = 0;
  while (i < pointeur && !trouve) {
      if (table[i].name == NULL) {
          return -1;
      }
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

int suppTemp(int i) {
  if (i>=pointeur) {
    return -1;
  } else {
    pointeur-=i;
    return 0;
  }
}

int ass_add(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "1 %d %d %d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_mul(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "2 %d %d %d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_sou(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "3 %d %d %d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_div(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "4 %d %d %d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_cop(int adr_result, int adr_op) {
    fprintf(pFile, "5 %d %d\n", adr_result, adr_op);
    nb_lignes++;
    return 0;
}

int ass_afc(int adr_result, int val) {
    fprintf(pFile, "6 %d %d\n", adr_result, val);
    nb_lignes++;
    return 0;
}

int ass_jmp(int num_instruct) {
    fprintf(pFile, "7 %d\n", num_instruct);
    nb_lignes++;
    return 0;
}

int ass_jmf(int adr_x, int num_instruct) {
    fprintf(pFile, "8 %d %d\n", adr_x, num_instruct);
    nb_lignes++;
    return 0;
}

int ass_inf(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "9 %d %d %d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_sup(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "A %d %d %d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_equ(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "B %d %d %d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_pri(int adr_result) {
    fprintf(pFile, "C %d\n", adr_result);
    nb_lignes++;
    return 0;
}
