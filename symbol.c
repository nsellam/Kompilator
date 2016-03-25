#include "symbol.h"

int pointeur;
FILE * pFile;

int initTable() {
  pFile=fopen("outAssembleur","w");
  pointeur = 1;
  return 0;
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
  int i = 0;
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

int suppTemp() {
  pointeur--;
  return 0;
}

int ass_add(int adr_result, int adr_op1, int adr_op2) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "1 %d %d %d\n", adr_result, adr_op1, adr_op2);
    fclose (pFile);
    return 0;
}

int ass_mul(int adr_result, int adr_op1, int adr_op2) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "2 %d %d %d\n", adr_result, adr_op1, adr_op2);
    fclose (pFile);
    return 0;
}

int ass_sou(int adr_result, int adr_op1, int adr_op2) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "3 %d %d %d\n", adr_result, adr_op1, adr_op2);
    fclose (pFile);
    return 0;
}

int ass_div(int adr_result, int adr_op1, int adr_op2) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "4 %d %d %d\n", adr_result, adr_op1, adr_op2);
    fclose (pFile);
    return 0;
}

int ass_cop(int adr_result, int adr_op) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "5 %d %d\n", adr_result, adr_op);
    fclose (pFile);
    return 0;
}

int ass_afc(int adr_result, int val) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "6 %d %d\n", adr_result, val);
    fclose (pFile);
    return 0;
}

int ass_jmp(int num_instruct) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "7 %d\n", num_instruct);
    fclose (pFile);
    return 0;
}

int ass_jmf(int adr_x, int num_instruct) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "8 %d %d\n", adr_x, num_instruct);
    fclose (pFile);
    return 0;
}

int ass_inf(int adr_result, int adr_op1, int adr_op2) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "9 %d %d %d\n", adr_result, adr_op1, adr_op2);
    fclose (pFile);
    return 0;
}

int ass_sup(int adr_result, int adr_op1, int adr_op2) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "A %d %d %d\n", adr_result, adr_op1, adr_op2);
    fclose (pFile);
    return 0;
}

int ass_equ(int adr_result, int adr_op1, int adr_op2) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "B %d %d %d\n", adr_result, adr_op1, adr_op2);
    fclose (pFile);
    return 0;
}

int ass_pri(int adr_result) {
    FILE * pFile;
    pFile=fopen("outAssembleur","a");
    fprintf(pFile, "C %d\n", adr_result);
    fclose (pFile);
    return 0;
}
