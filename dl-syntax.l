%{
  void yyerror (char *s);  
  #include "y.tab.h"
  #include <string.h>
%}

%option nounput
%option noinput

%%
[pP][1-9][0-9]*  {
  yylval.num = atoi(yytext + 1);
  return proc_id;
}

[rR][1-9][0-9]*  {
  yylval.num = atoi(&(yytext[1]));
  return res_id;
}

"requests" {
  return req_stmt;
}

"owns" {
  return own_stmt;
}

[ \t\n\r] {
  ; //skip all whitespace
}


<<EOF>> {
  return end;
}

. {
  ECHO;
  yyerror ("unexpected character in config file!\n");
}

%%

int yywrap (void) {
  return 1;
}

/* dl-scratch.c ends here */
