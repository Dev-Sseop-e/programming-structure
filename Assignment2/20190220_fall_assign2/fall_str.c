#include <assert.h> /* to use assert() */
#include <stdio.h>
#include "str.h"

/* Your task is: 
   1. Rewrite the body of "Part 1" functions - remove the current
      body that simply calls the corresponding C standard library
      function.
   2. Write appropriate comment per each function
*/

/* Part 1 */
/*------------------------------------------------------------------------*/
size_t StrGetLength(const char* pcSrc)
{
  const char *pcEnd;
  assert(pcSrc); /* NULL address, 0, and FALSE are identical. */
  pcEnd = pcSrc;
	
  while (*pcEnd) /* null character and FALSE are identical. */
    pcEnd++;

  return (size_t)(pcEnd - pcSrc);
}

/*------------------------------------------------------------------------*/
char *StrCopy(char *pcDest, const char* pcSrc)
{ assert(pcDest);
  assert(pcSrc);

  char *result = pcDest;

  if (*pcSrc == '\0') return "";

  while (*pcSrc){
    *pcDest = *pcSrc;
    pcSrc++;
    pcDest++;
    if(*pcSrc == '\0') *pcDest = *pcSrc;
  }

  return result;
}

/*------------------------------------------------------------------------*/
int StrCompare(const char* pcS1, const char* pcS2)
{ 
  assert(pcS1);
  assert(pcS2);

  while (*pcS1 == *pcS2) {
    pcS1++; pcS2++;
    if(*pcS1 == '\0' && *pcS2 == '\0') return 0;
  }
 
  return (int) (*pcS1 - *pcS2);
}
/*------------------------------------------------------------------------*/
char *StrSearch(const char* pcHaystack, const char *pcNeedle)
{
  assert(pcHaystack);
  assert(pcNeedle);
  if(*pcNeedle == '\0') return (char*) pcHaystack;
  size_t count = StrGetLength(pcNeedle);

  while (*pcHaystack){
    if(*pcHaystack == *pcNeedle){
      size_t i=0;

      for(; i<=count; i++){
        if(i==count) return (char*) pcHaystack - i;
        if(*pcHaystack == *pcNeedle){
          pcHaystack++;
          pcNeedle++;
        }
        else break;
      }

      pcNeedle = pcNeedle - i;
    }
    pcHaystack++;
  }
  return '\0';
}
/*------------------------------------------------------------------------*/
char *StrConcat(char *pcDest, const char* pcSrc)
{
  assert(pcDest);
  assert(pcSrc);

  size_t i = 0;

  while(*pcDest) {pcDest++; i++;}
  while(*pcSrc) {
    *pcDest = *pcSrc;
    pcDest++; pcSrc++;
    i++;
  }

  for(; i>0; i--) pcDest--;  
  
  return pcDest;
}