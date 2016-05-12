#ifndef FONCTIONS_H
#define FONCTIONS_H

#include <stdio.h>

struct fonction {
  char * nom;
  int nb_params;
  int depth;
  int ligne;
} ;

struct fonction table_fonctions[512];

int initTableFonctions(FILE * fichier);

int ajouterFonction(char * name, int nb_params, int profondeur, int ligne);

struct fonction trouverFonction(char * name, int * err);

void printfonctions();

#endif
