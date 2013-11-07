/* dl-parse.y --- 
 *
 * Filename: dl-parse.y
 * Description: The grammer for deadlocker configuration files
 * Author: Jordon Biondo
 * Created: Wed Nov  6 21:53:39 2013 (-0500)
 * Last-Updated: Wed Nov  6 22:12:34 2013 (-0500)
 *           By: Jordon Biondo
 *     Update #: 17
 */

/* Commentary: 
 * 
 * The grammer for deadlocker configuration files
 * 
 * Uses yacc for compiling the parser. 
 * Each line of the config much match: p[digit] owns|requests r[digit]
 *
 * During parsing, resource requests and ownership are setup in procs
 * and resources found in deadlocker.h
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
  int yylex(void);
  #include <stdio.h>     
  #include <stdlib.h>
  #include "deadlocker.h"
%}


%union {int num;}
%start line		// config starts with a line
%token <num> proc_id;	//proc id is an int
%token <num> res_id;	// res is is an int
%token own_stmt;	// 'owns' token
%token req_stmt;	// 'requests' token
%token end;		// EOF
%%

/**
 * A process is requesting a resource (Px requests Ry)
 */
request:
proc_id req_stmt res_id {
  request_ownership($1 - 1, $3 - 1);
}


/**
 * A process owns a resource (Px owns Ry)
 */
ownership:
proc_id own_stmt res_id {
  assign_owner($1 - 1, $3 - 1);
}


/**
 * A configuration file line
 * ownership or request followed by another line
 * EOF is the terminator
 */
line : 
request line {;}	|
ownership line {;}	|
end {
  YYACCEPT;
}

%%

/**
 * On error
 */
void yyerror (char *s) {
  fprintf (stderr, "%s\n", s);
}


/**
 * Main
 */
int main(int argc, char* argv[]) {
  // initialize simulation data
  init_procs(); 
  init_resources();

  // parse from stdin
  yyparse();
  
  // run the simulation
  run_simulation(argc, argv);
  
  // clean up data and memory before exit
  clean_procs();
  pthread_exit(NULL);
}

/* dl-parse.y ends here */
