/*int fonction(int * a) {
    *a = 5;
    return 0;
}*/

int main() {
    int a;
    a = 42;
    a = a + 1;
    int * j;
    int tab[10];
    //fonction(&a);
    j = &a;
    if (0 == 0) {
        printf(a);
    }
    int i = 0;
    while (i < *j) {
        printf(i);
        i = i + 1;
    }
}

/*{ int i,j,k,r;
    i = 3;
    j = 4;
    k = 8;
    printf(i);
    r = i + j * i + (k - j)/j;
    printf(r);
    j = k;
    printf(j);
    r = r / j;
    printf(r);
}*/
    /*
    { int i,j,k,r;
        i = 3;
        j = 4;
        k = 8;
        printf(i);
        r = (i + j)* (i + k / j);
        printf(r);
    }
    */
