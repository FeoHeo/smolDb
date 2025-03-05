#include <stdio.h>
#include <stdlib.h>

void program_intro (void) __attribute__ ((constructor));

void program_intro() {
    printf("A program to test out struct and union \n");
}

typedef struct Students {
    char name[50];
    char branch[50];
    int ID_no;
} stu;

typedef struct Node {
    union {
        int iVal;
        float fVal;
    } storedVal;
} Node;


int main(int argc , char *argv[]) {
    int num1 = 2;
    float num2 = 2.2;

    Node* node = (Node *)malloc(sizeof(Node));
    node->storedVal.iVal = num1;
    printf("Printing int %i\n" , node->storedVal.iVal);


    return 0;
}