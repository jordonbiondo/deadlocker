%{
void yyerror (char *s);
#include <stdio.h>     
#include <stdlib.h>
#include "deadlocker.h"
%}

%union {int num; char* id;}
%start line
%token <num> proc_id;
%token <num> res_id;
%token own_stmt;
%token req_stmt;
%token end;
%%


request
:proc_id req_stmt res_id {
  //printf("proc%d requesting resource%d\n", $1, $3);
  request_ownership($1 - 1, $3 - 1);
 }

ownership 
: proc_id own_stmt res_id {
  //printf("proc%d owns resource%d\n", $1, $3);
  assign_owner($1 - 1, $3 - 1);
 }

line 
: request line {;}
| ownership line {;}
| end {
  printf("end of config file!\n");
  YYACCEPT;
  }

%%

int main(int argc, char* argv[]) {
  init_procs();
  init_resources();
  
  yyparse();
  
  printf("done with input!\n");
  entrypoint(argc, argv);
  exit(0);
}

void yyerror (char *s) {
  fprintf (stderr, "%s\n", s);
} 

