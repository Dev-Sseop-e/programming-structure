#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <assert.h>

enum DFAState {out, in, cmt_out, cmt_in, cmt1, cmt2};
int main(void){
    int get = 0;
    int error = 0;
    int l = 0; int w = 0; int c = 0;
    enum DFAState state = out;

    while(get != EOF) {
        get = getchar();
        switch(state) {
            case out:
                if(get == '\n') {l++; c++; state = out;}
                else if(get == ' ') {c++; state = out;}
                else if(get == '/') state = cmt_out;
                else if(get == EOF) {fprintf(stdout, "%d %d %d\n" , l, w, c); return EXIT_SUCCESS;}
                else {w++; c++; state = in;}
                if(c == 1 || c == 0) l++;
                break;

            case in:
                if(get == '\n') {l++; c++; state = out;}
                else if(get == ' ') {c++; state = out;}
                else if(get == '/') state = cmt_in;
                else if(get == EOF) {fprintf(stdout, "%d %d %d\n" , l, w, c); return EXIT_SUCCESS;}
                else {c++; state = in;}
                break;

            case cmt_out:
                if(get == '/') {c++; state = cmt_out;}
                else if(get == '\n') {c+=2; w++; l++; state = out;}
                else if(get == ' ') {c+=2; w++; state = out;}
                else if(get == '*') {error = l; state = cmt1;}
                else if(get == EOF) {c++; fprintf(stdout, "%d %d %d\n" , l, w, c); return EXIT_SUCCESS;}
                else {c+=2; w++; state = in;}
                break;

            case cmt_in:
                if(get == '/') {c++; state = cmt_in;}
                else if(get == '\n') {c+=2; l++; state = out;}
                else if(get == ' ') {c+=2; state = out;}
                else if(get == '*') {error = l; state = cmt1;}
                else if(get == EOF) {c++; fprintf(stdout, "%d %d %d\n" , l, w, c); return EXIT_SUCCESS;}
                else {c+=2; state = in;}
                break;
                
            case cmt1:
                if(get == '\n') {c++; l++; state = cmt1;}
                else if(get == '*') state = cmt2;
                else if(get == EOF) {fprintf(stderr, "Error: line %d: unterminated comment\n", error); return EXIT_FAILURE;}
                else state = cmt1;
                break;

            case cmt2:
                if(get == '\n') {c++; l++; state = cmt1;}
                else if(get == '/') {c++; state = out;}
                else if(get == '*') state = cmt2;
                else if(get == EOF) {fprintf(stderr, "Error: line %d: unterminated comment\n", error); return EXIT_FAILURE;}
                else state = cmt1;
                break;

        }
    }
}