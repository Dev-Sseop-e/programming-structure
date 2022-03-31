#include <stdio.h>
#include <stdlib.h>

enum DFAState{out,slash,in_cmt,bullet,in_str1,in_str2,backslash1,backslash2};
int main(void){
    char get = 0; int line_counter = 1; int error = 1;
    // get: input character, line_counter: counting the line, error: error line
    enum DFAState state = out;  // fundamental state is out of comment and string

    while(get != EOF){      // loop will be end if it inputs the EOF
        get = getchar();
        switch(state){
            case out:       // normal state that is outside of comment and string
                if(get == '\n') {
                    line_counter++; fprintf(stdout, "%c", get); state = out;} 
                else if(get == ' ') {fprintf(stdout, "%c", get); state = out;}
                else if(get == '/') state = slash; // appearance of slash
                else if(get==34) {fprintf(stdout, "%c", get); state = in_str1;}
                // refer to askii code, it means "
                else if(get==39) {fprintf(stdout, "%c", get); state = in_str2;}
                // refer to askii code, it means '
                else if(get == EOF) return EXIT_SUCCESS;
                else {fprintf(stdout, "%c", get); state = out;}
                // back to normal state
                break;
            case slash:     // state of appearing slash at the out-comment
                if(get == '/') {fprintf(stdout, "%c", get); state = slash;}
                // maintain this state
                else if(get == '*') {
                    error = line_counter; fprintf(stdout, " "); state = in_cmt;}
                // save the starting comment line number and print the space
                else if(get == EOF) return EXIT_SUCCESS;
                else if(get == '\n') {
                    line_counter++; fprintf(stdout, "/%c", get); state = out;}
                else {fprintf(stdout, "/%c", get); state = out;}
                // back to normal state
                break;
            case in_cmt:    // at the in-comment state, it starts /* ~
                if(get == '\n') {
                    line_counter++; fprintf(stdout, "%c", get); state = in_cmt;}
                else if(get == '*') state = bullet; // appearance of bullet point
                else if(get == EOF) {
                    fprintf(stderr, "Error: line %d: unterminated comment\n", error);
                    return EXIT_FAILURE;}
                // error line was stored by 'error'
                else state = in_cmt;    // back to in-comment state
                break;
            case bullet:    // bullet point appears at the in-comment state
                if(get == '\n') {
                    line_counter++; fprintf(stdout, "%c", get); state = in_cmt;}
                else if(get == '*') state = bullet; // maintain this state
                else if(get == '/') state = out;    // back to normal state
                else if(get == EOF) {
                    fprintf(stderr, "Error: line %d: unterminated comment\n", error);
                    return EXIT_FAILURE;}
                // error line was stored by 'error'
                else state = in_cmt;    // back to in-comment state
                break;
            case in_str1:   // in the string state (more precisely, starting ")
                if(get==34) {fprintf(stdout, "%c", get); state = out;}
                // refer to askii code, it means "
                else if(get==92) {fprintf(stdout, "%c", get); state = backslash1;}
                // refer to askii code, it means backslash
                else if(get == '\n') {
                    line_counter++; fprintf(stdout, "%c", get); state = in_str1;}
                else if(get == EOF) return EXIT_SUCCESS;
                else {fprintf(stdout, "%c", get); state = in_str1;}
                // still inside of string
                break;
            case in_str2:   // in the string state (more prrecisely, starting ')
                if(get==39) {fprintf(stdout, "%c", get); state = out;}
                // refer to askii code, it means '
                else if(get==92) {fprintf(stdout, "%c", get); state = backslash2;}
                // refer to askii code, it means backslash
                else if(get == '\n') {
                    line_counter++; fprintf(stdout, "%c", get); state = in_str2;}
                else if(get == EOF) return EXIT_SUCCESS;
                else {fprintf(stdout, "%c", get); state = in_str2;}
                // still inside of string
                break;
            case backslash1: // after the backslash at the "" string state
                if(get == '\n') {
                    line_counter++; fprintf(stdout, "%c", get); state = in_str1;}
                else if(get == EOF) return EXIT_SUCCESS;
                else {fprintf(stdout, "%c", get); state = in_str1;}
                // back to in-string state
                break;
            case backslash2: // after the backslash at the '' string state
                if(get == '\n') {
                    line_counter++; fprintf(stdout, "%c", get); state = in_str2;}
                else if(get == EOF) return EXIT_SUCCESS;
                else {fprintf(stdout, "%c", get); state = in_str2;} 
                // back to in-string state
        }
    }
}