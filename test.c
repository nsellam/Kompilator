int fonction(int * a) {
    *a = 5;
    return 0;
}

int main() {
    int a = 42;
    int * j;
    j = &a;
    if (0 == 0) {
        printf(a);
    }
    int i = 0;
    while (i < a) {
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
