#ifndef LABEL_H
#define LABEL_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct label {
    char * nom;
    int ligne;
    int ligne_debut_while;
};

int nb_if;
int nb_while;

struct label table_labels[512];

int initTableLabels(FILE * fichier);

int ajouterLabelIf(int ligne);

int ajouterLabelWhile(char * nomLabel,int ligne);

int ajouterFinWhile(char* nomLabel, int ligne);

int getLigneDebutWhile(char* nomLabel);

int ajouterLabelFonction(char * nom_fonction, int ligne);

#endif
