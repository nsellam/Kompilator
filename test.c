int main()
{ int i,j,k,r;
    i = 3;
    j = 4;
    k = 8;
    printf(i); // -> 3
    r = i + j * i + (k - j)/j;
    printf(r); // -> 16
    j = k;
    printf(j); // -> 8
    r = r / j;
    printf(r); // -> 4
/*  if (0 == 0) {
    j = 0;
    }
    
    /*
    int i,j,k,r;
        i = 3;
        j = 4;
        k = 8;
        printf(i);
        r = (i + j)* (i + k / j);
        printf(r);
    */

}
