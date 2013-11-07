/* dl-syntax.l --- 
 * 
 * Filename: dl-syntax.l
 * Description: Syntax token definitions for deadlocker
 * Author: Jordon Biondo
 * Created: Wed Nov  6 21:53:39 2013 (-0500)
 * Last-Updated: Thu Nov  7 10:17:14 2013 (-0500)
 *           By: Jordon Biondo
 *     Update #: 22
 */

/* Commentary:
 * 
 * Syntax token definitions for deadlocker
 */

/* This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 3, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth
 * Floor, Boston, MA 02110-1301, USA.
 */

/* Code: */

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
