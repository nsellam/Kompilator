#ifndef INTERPRETEUR_H
#define INTERPRETEUR_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct instruction {
    int COP;
    int res;
    int op1;
    int op2;
};

int nb_instructions;
struct instruction instructions[2048];
int memoire [4096];
int ip;

int add_instruct(int COP, int res, int op1, int op2);

int interprete();

#endif
