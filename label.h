#ifndef LABEL_H
#define LABEL_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct label {
    char * nom;
    int ligne_debut_corrrespondante;
    int ligne_fin_corrrespondante;
};

struct label table_labels[512];

int initTableLabels();

int ajouterLabelIf(int ligne_debut);

int ajouterLabelWhile(int ligne_debut);

int ajouterLabelFonction(char * nom_fonction, int ligne_debut);

int ajouterLigneFin(char * nom_label, int ligne_fin);

#endif
