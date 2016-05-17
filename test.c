/*** TEST TABLE DES SYMBOLES ***/
/*int main() {
    int i,j,k,r;
    i = 3;
    j = 4;
    k = 8;
    printf(i); // Attendu : 3
    r = i + j * i + (k - j)/j;
    printf(r); // Attendu : 16
    j = k;
    printf(j); // Attendu : 8
    r = r / j;
    printf(r); // Attendu : 2
}*/

/*** TEST TABLE DES LABELS ***/
/*int main() {
    int a;
    a = 4;
    a = a + 1;
    int b = 42;
    if (0 == 0) {
        printf(a); // Affiche 5
    }
    if (0 == 1) {
      printf(b); // N'est pas exécuté
    }
    int i = 0;
    while (i < a) {
        i = i + 1;
        printf(i); // Afficher de 1 jusqu'à 5
    }
    printf(a); // Affiche 5
}*/

/*** TEST POINTEURS ***/
/*int main() {
    int a;
    a = 42;
    a = a + 1;
    int * j;
    j = &a;
    printf(*j); // Affiche 43
    *j = 8;
    printf(*j); // Affiche 8
}*/

/*** TEST TABLEAUX ***/
/*int main() {
  int tab[10];
  tab[0] = 1994;
  tab[9] = 2000;
  tab[1] = tab[0] + 1;
  printf(tab[1]); // Affiche 1995
}*/
