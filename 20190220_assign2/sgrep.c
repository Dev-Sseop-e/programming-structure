#include <stdio.h>
#include <stdlib.h>
#include <string.h> /* for skeleton code */
#include <unistd.h> /* for getopt */
#include "str.h"

#define MAX_STR_LEN 1023

#define FALSE 0
#define TRUE  1

/*
 * Fill out your own functions here (If you need) 
 */

// My recursive function
int
/* SegBuf : Segment of the buf, SegPattern : Segment of the pattern */
recursion (char *SegBuf, char *SegPattern) {
  // Distinguish by the '*'
  if(*SegPattern == '*') {
    while(*SegPattern == '*') SegPattern++;
  }
  // If the SegPattern arrive to the NULL (It matches)
  if(*SegPattern == '\0') return 1;

  // SegBuf move to next char if it doesn't match
  while(*SegBuf != *SegPattern) {
    SegBuf++;
    if(*SegBuf == '\n') return 0;
  }
  
  for(int i=0; *SegPattern != '*'; i++){
    if(*SegPattern == '\0') return 1;   // Totally match
    if(*SegBuf != *SegPattern)
      return recursion(SegBuf+1-i, SegPattern-i); // set the value back
    SegBuf++; SegPattern++;   // It matches with the SegBuf
  }
  return recursion(SegBuf, SegPattern); // Recall of the recursion
}

/*--------------------------------------------------------------------*/
/* PrintUsage()
   print out the usage of the Simple Grep Program                     */
/*--------------------------------------------------------------------*/
void 
PrintUsage(const char* argv0) 
{
  const static char *fmt = 
	  "Simple Grep (sgrep) Usage:\n"
	  "%s pattern [stdin]\n";

  printf(fmt, argv0);
}
/*-------------------------------------------------------------------*/
/* SearchPattern()
   Your task:
   1. Do argument validation 
   - String or file argument length is no more than 1023
   - If you encounter a command-line argument that's too long, 
   print out "Error: argument is too long"
   
   2. Read the each line from standard input (stdin)
   - If you encounter a line larger than 1023 bytes, 
   print out "Error: input line is too long" 
   - Error message should be printed out to standard error (stderr)
   
   3. Check & print out the line contains a given string (search-string)
      
   Tips:
   - fgets() is an useful function to read characters from file. Note 
   that the fget() reads until newline or the end-of-file is reached. 
   - fprintf(sderr, ...) should be useful for printing out error
   message to standard error

   NOTE: If there is any problem, return FALSE; if not, return TRUE  */
/*-------------------------------------------------------------------*/

int
SearchPattern(const char *pattern)
{
  char buf[MAX_STR_LEN + 2]; 
  int len;
  /* 
   *  TODO: check if pattern is too long
   */
  if (StrGetLength(pattern) > MAX_STR_LEN) {
    fprintf(stderr, "Error: argument is too long\n");
    return FALSE;   // Argument error
  }

  /* Read one line at a time from stdin, and process each line */
  while (fgets(buf, sizeof(buf), stdin)) {
	  
    /* check the length of an input line */
    if ((len = StrGetLength(buf)) > MAX_STR_LEN) {
      fprintf(stderr, "Error: input line is too long\n");
      return FALSE;
    }
    /* TODO: fill out this function */
    if (*pattern == '\0') fprintf(stdout, "%s", buf);

    /* Case of pattern including the char '*' */
    else if (StrFindChr(pattern, '*')) {
      char *s1 = buf; char *s2 = (char*) pattern;
      if(recursion(s1,s2))
        fprintf(stdout, "%s", buf);
    }
    /* Pattern doesn't include the '*' */
    else {
      if(StrFindStr(buf, pattern))
        fprintf(stdout, "%s", buf);
    }
  }
  return TRUE;
}

/*-------------------------------------------------------------------*/
int 
main(const int argc, const char *argv[]) 
{
  /* Do argument check and parsing */
  if (argc < 2) {
	  fprintf(stderr, "Error: argument parsing error\n");
	  PrintUsage(argv[0]);
	  return (EXIT_FAILURE);
  }

  return SearchPattern(argv[1]) ? EXIT_SUCCESS:EXIT_FAILURE;
}
