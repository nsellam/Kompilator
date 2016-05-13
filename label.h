#ifndef LABEL_H
#define LABEL_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/**
Il existe deux types de labels, ceux pour les if et ceux pour les while.

Exemple de première passe pour un while :
JMF @x .WHILE0
AFC @t 5
COP @y @t
JMP 0
...
On ne sait pas où sera la ligne de fin du while donc on met .WHILE0, une fois la fin atteinte
(et vu que c'est un while et pas un if), on met un JMP qui nous renvoie sur la première
instrucion (0) qu'on avait sauvegardée avec la méthode ajouterLabelWhile lorsqu'on avait
détecté une insction while. En même temps que nous écrivons ce JMP, on enregistre également
sa ligne dans le tableaux de labels au label correspondant. Ainsi lors de la seconde passe
on pourra remplacer .WHILE0 par 4, la ligne suivant le bloc while.


Exemple de première passe pour un if :
JMF @x .IF0
AFC @t 5
COP @y @t
AFC @u 7
...
Imaginon que l'affectation de 7 se situe après le while. On est donc obligé de mettre
le label .IF0 pour le JMF, car on ne sait pas à quelle ligne sauter encore. Mais dans le
yacc, après le if, on enregistre la ligne suivante dans le bon label du tableau de label afin
qu'en seconde passe .IF0 soit remplacé par 3.
**/

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
