#!/usr/bin/env node

import fs from 'fs';
import Path from 'path';


/* 
program
  : expr ';' program
  | #empty
  ;
expr
  : term ( ( '+' | '-' ) term )*
  ;
term
  : '-' term
  | factor
  ;
factor
  : INT
  | '(' expr ')'
  ;
*/

function parse(text) {
  const tokens = scan(text);
  let index = 0;
  let lookahead = nextToken();
  const value = program();
  return value;
  
  function peek(kind) { return lookahead.kind === kind; }
  function consume(kind) {
    if (peek(kind)) {
      lookahead = nextToken();
    }
    else {
      console.error(`expecting ${kind} at ${lookahead.kind}`);
      process.exit(1);
    }
  }
  function nextToken() {
    return (
      (index >=  tokens.length) ? new Token('EOF', '<EOF>') : tokens[index++]
    );
  }

  function program() {
    const values = [];
    while (!peek('EOF')) {
      values.push(expr());
      consume(';');
    }
    return values;
  }

  function expr() {
    let t = term();
    while (peek('+') || peek('-')) {
      const kind = lookahead.kind;
      consume(kind);   
      const t1 = term();
      t += (kind === '+') ? t1 : -t1;
    }
    return t;
  }

  function term() {
    if (peek('-')) {
      consume('-');
      return - term();
    }
    else {
      return factor();
    }
  }

  function factor() {
    if (peek('INT')) {
      const value = parseInt(lookahead.lexeme);
      consume('INT');
      return value;
    }
    else {
      consume('(');
      const value = expr();
      consume(')');
      return value;
    }
  }
}


function scan(text) {
  const tokens = [];
  while (text.length > 0) {
    let m;
    if ((m = text.match(/^\s+/))) {
    }
    else if ((m = text.match(/^\d+/))) {
      tokens.push(new Token('INT', m[0]));
    }
    else {
      m = text.match(/^./);
      tokens.push(new Token(m[0], m[0]));
    }
    text = text.substring(m[0].length);
  }
  return tokens;
}


const CHAR_SET = 'utf8';
function main() {
  if (process.argv.length !== 3) usage();
  const file = process.argv[2];
  const text = fs.readFileSync(file === '-' ? 0 : file, CHAR_SET);
  const value = parse(text);
  console.log(JSON.stringify(value));
}

function usage() {
  const prog = Path.basename(process.argv[1])
  console.error(`usage: ${prog} INPUT_FILE`);
  process.exit(1);
}

class Token {
  constructor(kind, lexeme) {
    Object.assign(this, {kind, lexeme});
  }
}

main();

