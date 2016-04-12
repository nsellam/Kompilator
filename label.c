#include "label.h"

int nb_labels;
FILE * pFile;

int initTableLabels(FILE * fichier) {
  pFile = fichier;
  nb_labels = 0;
  nb_if = 0;
  nb_while = 0;
  return 0;
}

int ajouterLabelIf(int ligne) {
    char * nom = "IF";
    char nomLabel[10];
    sprintf(nomLabel,"%s%d",nom, nb_if);
    table_labels[nb_labels].nom = malloc(sizeof(nomLabel));
    strcpy(table_labels[nb_labels].nom,nomLabel);
    table_labels[nb_labels].ligne = ligne;
    //fprintf(pFile, "%s\n", nomLabel);
    nb_labels++;
    nb_if++;
    return 0;
}

int ajouterLabelWhile(int ligne) {
    char * nom = "WHILE";
    char nomLabel[10];
    sprintf(nomLabel,"%s%d",nom,nb_while);
    table_labels[nb_labels].nom = malloc(sizeof(nomLabel));
    strcpy(table_labels[nb_labels].nom,nomLabel);
    table_labels[nb_labels].ligne = ligne;
    //fprintf(pFile, "%s\n", nomLabel);
    nb_labels++;
    nb_while++;
    return 0;
}

int getLabelLine(char * nomLabel) {
    int i = 0;
    int trouve = 0;
    while (i < nb_labels && !trouve) {
        if (!strcmp(nomLabel, table_labels[i].nom)) {
            trouve = table_labels[i].ligne;
        }
        i++;
    }
    return trouve;
}

int ajouterLabelFonction(char * nom_fonction, int ligne) {
    char * nomLabel = ".";
    strcat(nomLabel,nom_fonction);
    int i;
    for (i = 0; i < nb_labels; i++) {
        if (strcmp(table_labels[i].nom,nomLabel) == 0) {
            printf("La fonction \"%s\" a été défini plus d'une fois !\n", nom_fonction);
            return -1;
        }
    }
    strcpy(table_labels[nb_labels].nom,nom_fonction);
    table_labels[nb_labels].ligne = ligne;
    nb_labels++;
    return 0;
}

int remplacerLabels(FILE * fichier) {
    char carac;
    char nomLabel[10];
    int nb_char_ligne_actuelle = 0;
    for (carac = 0; carac != EOF; carac = fgetc(fichier)) {
        nb_char_ligne_actuelle = SEEK_CUR - nb_char_ligne_actuelle;
        if (carac == '.') {
            fscanf(fichier, "%s", nomLabel);
            fseek(fichier, -strlen(nomLabel)-1, SEEK_CUR);
            fprintf(fichier, "%*d\n", (int)(strlen(nomLabel)+1), getLabelLine(nomLabel)+1);
        }
        //printf("Ligne actuelle : %s, nb-char : %d\n", ligne, nb_char_ligne_actuelle);
    }
}
