#!/usr/bin/env python3

import re
import sys
from collections import namedtuple
import json

"""
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
"""

def parse(text):

    def peek(kind): return lookahead.kind == kind
    def consume(kind):
        nonlocal lookahead
        if (lookahead.kind == kind):
            lookahead = nextToken()
        else:
            print(f'expecting {kind} at {lookahead.lexeme}',
                  file=sys.stderr)
            sys.exit(1)
    def nextToken():
        nonlocal index
        if (index >= len(tokens)):
            return Token('EOF', '<EOF>')
        else:
            tok = tokens[index]
            index += 1
            return tok

    def program():
        asts = []
        while (not peek('EOF')):
            asts.append(expr())
            consume(';')
        return asts

    def expr():
        t = term()
        while (peek('+') or (peek('-'))):
            kind = lookahead.kind
            consume(kind)
            t1 = term()
            t = Ast(kind, t, t1)
        return t

    def term():
        if (peek('-')):
            consume('-')
            return Ast('-', term())
        else:
            return factor()

    def factor():
        if (peek('INT')):
            value = int(lookahead.lexeme)
            consume('INT')
            ast = Ast('INT')
            ast['value'] = value
            return ast
        else:
            consume('(')
            value = expr()
            consume(')')
            return value

    #begin parse()
    tokens = scan(text)
    index = 0
    lookahead = nextToken()
    value = program()
    if (not peek('EOF')):
        print(f'expecting <EOF>, got {lookahead.lexeme}', file=sys.stderr)
        sys.exit(1)
    return value

def scan(text):
    SPACE_RE = re.compile(r'\s+')
    INT_RE = re.compile(r'\d+')
    CHAR_RE = re.compile(r'.')
    def next_match(text):
        m = SPACE_RE.match(text)
        if (m): return (m, None)
        m = INT_RE.match(text)
        if (m): return (m, 'INT')
        m = CHAR_RE.match(text)  #must be last: match any char
        if (m): return (m, m.group())

    tokens = []
    while (len(text) > 0):
        (match, kind) = next_match(text)
        lexeme = match.group()
        if (kind): tokens.append(Token(kind, lexeme))
        text = text[len(lexeme):]
    return tokens

def main():
    if (len(sys.argv) != 2): usage();
    contents = readFile(sys.argv[1]);
    asts = parse(contents)
    print(json.dumps(asts, separators=(',', ':'))) #no whitespace

def readFile(path):
    with open(path, 'r') as file:
        content = file.read()
    return content


def usage():
    print(f'usage: {sys.argv[0]} DATA_FILE')
    sys.exit(1)

#use a dict so that we can add attributes dynamically
def Ast(tag, *kids):
    return { 'tag': tag, } if len(kids) == 0 else { 'tag': tag, 'kids': kids }

Token = namedtuple('Token', ['kind', 'lexeme'])

if __name__ == "__main__":
    main()
