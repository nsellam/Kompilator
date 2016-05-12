#ifndef FONCTIONS_H
#define FONCTIONS_H

#include <stdio.h>

//TODO : Ne marche pas encore trop bien, saute à la mauvaise ligne et ne reviens pas à la suite de l'appel

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
