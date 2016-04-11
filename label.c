#include "label.h"

int nb_labels;
int nb_if;
int nb_while;
FILE * pFile;

int initTableLabels() {
  pFile=fopen("outAssembleur","w");
  nb_labels = 0;
  nb_if = 0;
  nb_while = 0;
  return 0;
}

int finalizeTableLabels() {
  fclose (pFile);
  return 0;
}

char * ajouterLabelIf(int ligne_debut) {
    char * nomLabel = ".IF";
    sprintf(nomLabel,"%d",nb_if);
    printf("NOM_LABEL : %s\n", nomLabel);
    /*strcpy(table_labels[nb_labels].nom,nomLabel);
    table_labels[nb_labels].ligne_debut_corrrespondante = ligne_debut;
    fprintf(pFile, "%s ", nomLabel);
    nb_labels++;
    nb_if++;*/
    return nomLabel;
}

char * ajouterLabelWhile(int ligne_debut) {
    char * nomLabel = ".WHILE";
    sprintf(nomLabel,"%d",nb_while);
    strcpy(table_labels[nb_labels].nom,nomLabel);
    table_labels[nb_labels].ligne_debut_corrrespondante = ligne_debut;
    nb_labels++;
    nb_if++;
    return nomLabel;
}

int ajouterLabelFonction(char * nom_fonction, int ligne_debut) {
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
    table_labels[nb_labels].ligne_debut_corrrespondante = ligne_debut;
    nb_labels++;
    return 0;
}

int ajouterLigneFin(char * nom_label, int ligne_fin) {
    int i;
    for (i = 0; i < nb_labels; i++) {
        if (strcmp(table_labels[i].nom,nom_label) == 0) {
            table_labels[nb_labels].ligne_fin_corrrespondante = ligne_fin;
            return 0;
        }
    }
    return -1;
}
