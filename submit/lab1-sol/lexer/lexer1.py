#!/usr/bin/env python3

import re
import sys
from collections import namedtuple

#scan() function uses the `:=` walrus operator introduced recently in
#Python 3.8.  In fact, this kind of use is precisely the rationale
#provided in the PEP.
#<https://www.python.org/dev/peps/pep-0572/#the-importance-of-real-code>


# modify this function
def scan(text):
    tokens = []
    while (len(text) > 0):

        if (m := re.compile(r'\s+').match(text)) :
            pass  # ignore whitespace
        elif (m := re.compile(r'\d+').match(text)) :
            tokens.append(Token('INT', m.group()))
        else :
            #must be last: match any char
            m = re.compile(r'.').match(text)
            tokens.append(Token(m.group(), m.group()))

        lexeme = m.group() #m.group() provides the matching text
        text = text[len(lexeme):] #remove lexeme prefix of text
    return tokens

def main():
    if (len(sys.argv) != 2): usage();
    contents = readFile(sys.argv[1]);
    tokens = scan(contents)
    for t in tokens: print(t)

def readFile(path):
    with open(path, 'r') as file:
        content = file.read()
    return content

Token = namedtuple('Token', ['kind', 'lexeme'])
Token.__str__ = lambda t : f'{{"kind":"{t.kind}","lexeme":"{t.lexeme}"}}'

def usage():
    print(f'usage: {sys.argv[0]} DATA_FILE')
    sys.exit(1)

if __name__ == "__main__":
    main()
