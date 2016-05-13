#include "interpreteur.h"

int init_interp() {
    nb_instructions = 0;
    ip = 0;
    return 0;
}

int add_instruct(COP, res, op1, op2) {
    instructions[nb_instructions].COP = COP;
    instructions[nb_instructions].res = res;
    instructions[nb_instructions].op1 = op1;
    instructions[nb_instructions].op2 = op2;
    nb_instructions++;
    return 0;
}

int interprete() {
    int ret = 0;
    struct instruction instruc = instructions[ip];
    int i = 0;
    while (i < 400 && instruc.COP != 13) {
        i++;
        //printf("%d\n",ip);
        switch (instruc.COP) {
            case 1: printf("ip:%d ADD memoire[%d]%d = memoire[%d]%d + memoire[%d]%d\n",ip,instruc.res,memoire[instruc.op1] + memoire[instruc.op2],instruc.op1,memoire[instruc.op1],instruc.op2  ,memoire[instruc.op2]);
                    memoire[instruc.res] = memoire[instruc.op1] + memoire[instruc.op2];
                    ip++;
                    break;
            case 2: memoire[instruc.res] = memoire[instruc.op1] * memoire[instruc.op2];
                    ip++;
                    break;
            case 3: memoire[instruc.res] = memoire[instruc.op1] - memoire[instruc.op2];
                    ip++;
                    break;
            case 4: memoire[instruc.res] = memoire[instruc.op1] / memoire[instruc.op2];
                    ip++;
                    break;
            case 5: printf("ip:%d COP memoire[%d]%d = memoire[%d]%d\n",ip,instruc.res,memoire[instruc.res],instruc.op1,memoire[instruc.op1]);
                    memoire[instruc.res] = memoire[instruc.op1];
                    ip++;
                    break;
            case 6: printf("ip:%d AFC memoire[%d]%d = %d\n",ip,instruc.res,memoire[instruc.res],instruc.op1);
                    memoire[instruc.res] = instruc.op1;
                    ip++;
                    break;
            case 7: printf("ip:%d JMP %d\n",ip,instruc.res);
                    ip = instruc.res;
                    break;
            case 8: printf("ip:%d JMF memoire[%d]%d vers %d\n",ip,instruc.res,memoire[instruc.res],instruc.op1);
                    if (memoire[instruc.res] == 0) {
                        ip = instruc.op1;
                    }
                    else {
                        ip++;
                    }
                    break;
            case 9: printf("ip:%d, INF memoire[%d]%d = (memoire[%d]%d < memoire[%d]%d) ? 1 : 0\n",ip,instruc.res,(memoire[instruc.op1] < memoire[instruc.op2]) ? 1 : 0,instruc.op1,memoire[instruc.op1],instruc.op2,memoire[instruc.op2]);
                    memoire[instruc.res] = (memoire[instruc.op1] < memoire[instruc.op2]) ? 1 : 0;
                    ip++;
                    break;
            case 10: memoire[instruc.res] = (memoire[instruc.op1] > memoire[instruc.op2]) ? 1 : 0;
                    ip++;
                    break;
            case 11:printf("ip:%d, EQU memoire[%d]%d = (memoire[%d]%d == memoire[%d]%d) ? 1 : 0\n",ip,instruc.res,(memoire[instruc.op1] == memoire[instruc.op2]) ? 1 : 0,instruc.op1,memoire[instruc.op1],instruc.op2,memoire[instruc.op2]);
                    memoire[instruc.res] = (memoire[instruc.op1] == memoire[instruc.op2]) ? 1 : 0;
                    ip++;
                    break;
            case 12: printf("ip:%d, print mem[%d]: %d\n",ip,instruc.res,memoire[instruc.res]);
                    ip++;
                    break;
            case 13: printf("Normalement ce cas n'existe pas\n");
                    ret = -2;
                    break;
            default: printf("ERREUR Votre code assembleur n'est pas valide ! COP : %d\n",instruc.COP);
                     ret = -1;
        }
        instruc = instructions[ip];
    }
    return ret;
}
