#ifndef LABEL_H
#define LABEL_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct label {
    char * nom;
    int ligne;
};

int nb_if;
int nb_while;

struct label table_labels[512];

int initTableLabels(FILE * fichier);

int ajouterLabelIf(int ligne);

int ajouterLabelWhile(int ligne);

int ajouterLabelFonction(char * nom_fonction, int ligne);

#endif
