#include "symbol.h"

int pointeur; //compteur qui indique le 'haut de la pile'
FILE * pFile;
int nb_lignes = 0;

int initTable(FILE * fichier) {
  pFile = fichier;
  pointeur = 1;
  return 0;
}

int getTemp(int i) {
  if (i>=pointeur) {
    return -1; //retourner une erreur plutot
  } else {
    return pointeur-i;
  }
}

int putInTable(char * pname, int pinit, int pconst, int nb_valeurs) {
    printf("\nPointeur avant ajout : %d\n", pointeur);
  table[pointeur].name = pname;
  table[pointeur].index = pointeur;
  table[pointeur].init = pinit;
  table[pointeur].isConst = pconst;
  table[pointeur].depth = 0;
  table[pointeur].nb_valeurs = nb_valeurs;
  pointeur+=nb_valeurs;
  printf("\nPointeur après ajout : %d\n", pointeur);
  return 0;
}

//TODO: A débugger depuis l'ajout des tableaux
int getFromTable(char * pname) {
  int i = 1;
  int pindex = -1;
  int trouve = 0, null = 0;
  while (i <= pointeur && !trouve && !null) {
      if (table[i].name == NULL) {
          printf("\nOOOOOOOOOOOOOMMMMMMMMMMMMGGGGGGGGGGGGG\n");
          null = 1;
          pindex = -1;
      }
    if (!strcmp((table[i].name),pname)) {
      pindex = i;
      trouve = 1;
    }
    i++;
  }
  return pindex;
}

int getNbVals(char * pname) {
    int trouve = 0, null = 0, i = 0;
    while (i <= pointeur && !trouve && !null) {
        if (table[i].name == NULL) {
            null = 1;
        }
      if (!strcmp((table[i].name),pname)) {
        trouve = table[i].nb_valeurs;
      }
      i++;
    }
    return trouve;
}

char * getFromTableByAddr(int adresse) {
    return table[adresse].name;
}

int addTemp() {
  // On ajoute le caractère 0 dans la table des symboles pour les variables
  //temporaire, car une variable ne peut pas être un 0 et qu'il ne doit pas y
  //avoir de null dans la table.
  table[pointeur].name = "0";
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
    fprintf(pFile, "ADD @%d @%d @%d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_mul(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "MUL @%d @%d @%d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_sou(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "SUB @%d @%d @%d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_div(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "DIV @%d @%d @%d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_cop(int adr_result, int adr_op) {
    fprintf(pFile, "COP @%d @%d\n", adr_result, adr_op);
    nb_lignes++;
    return 0;
}

int ass_afc(int adr_result, int val) {
    fprintf(pFile, "AFC @%d %d\n", adr_result, val);
    nb_lignes++;
    return 0;
}

int ass_jmp(int num_instruct) {
    fprintf(pFile, "JMP instruc:%d\n", num_instruct);
    nb_lignes++;
    return 0;
}

int ass_jmf(int adr_x, char * symbole_ou_sauter) {
    fprintf(pFile, "JMF @%d %s\n", adr_x, symbole_ou_sauter);
    nb_lignes++;
    return 0;
}

int ass_inf(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "INF @%d @%d @%d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_sup(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "SUP @%d @%d @%d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_equ(int adr_result, int adr_op1, int adr_op2) {
    fprintf(pFile, "EQU @%d @%d @%d\n", adr_result, adr_op1, adr_op2);
    nb_lignes++;
    return 0;
}

int ass_pri(int adr_result) {
    fprintf(pFile, "PRI @%d\n", adr_result);
    nb_lignes++;
    return 0;
}
