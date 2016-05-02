#include "fonctions.h"

int nb_fonctions;
FILE * pFile;

int initTableFonctions(FILE * fichier) {
    nb_fonctions = 0;
    pFile = fichier;
    return 0;
}

int ajouterFonction(char * name, int nb_params, int profondeur, int ligne) {
    int i;
    for (i = 0; i < nb_fonctions; i++) {
        if (strcmp(table_fonctions[i].nom,name) == 0) {
            printf("La fonction \"%s\" a été défini plus d'une fois !\n", name);
            return -1;
        }
    }
    table_fonctions[nb_fonctions].nom = name;
    table_fonctions[nb_fonctions].nb_params = nb_params;
    table_fonctions[nb_fonctions].depth = profondeur;
    table_fonctions[nb_fonctions].ligne = ligne;
    nb_fonctions++;
    return 0;
}

// TODO : Trouver une bonne valeur à renvoyer par défaut, ou alors en faire différentes sous fonctions suivant ce qui est recherché
struct fonction trouverFonction(char * name) {
    int i;
    for (i = 0; i < nb_fonctions; i++) {
        if (strcmp(table_fonctions[i].nom,name) == 0) {
            return table_fonctions[i];
        }
    }
    return ;
}

void printfonctions() {
    int i;
    for (i = 0; i < nb_fonctions; i++) {
        printf("Nom : %s, Nb parametres : %d, Profondeur : %d, Ligne : %d\n", table_fonctions[i].nom, table_fonctions[i].nb_params, table_fonctions[i].depth, table_fonctions[i].ligne);
    }
}
