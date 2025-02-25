import re
import sys
import json

class Lexer:
    def __init__(self, input_text):
        self.tokens = self.tokenize(input_text)
        self.position = 0

    def tokenize(self, input_text):
        token_specification = [
            ('NIL', r'\bnil\b'),
            ('BOOL', r'\b(true|false)\b'),
            ('INT', r'\b\d+(?:_\d+)*\b'),
            ('STRING', r"'([^'\\]*(?:\\.[^'\\]*)*)'"),  
            ('LBRACKET', r'\['),
            ('RBRACKET', r'\]'),
            ('LBRACE', r'\{'),
            ('RBRACE', r'\}'),
            ('LPAREN', r'\('),
            ('RPAREN', r'\)'),
            ('COMMA', r','),
            ('HASHROCKET', r'=>'),
            ('RANGE', r'\.\.\.?'),
            ('WHITESPACE', r'[ \t]+'),
            ('COMMENT', r'#.*'),
            ('UNKNOWN', r'.')
        ]
        token_regex = '|'.join(f'(?P<{pair[0]}>{pair[1]})' for pair in token_specification)
        
        tokens = []
        for match in re.finditer(token_regex, input_text):
            kind = match.lastgroup
            value = match.group()
            if kind in ('WHITESPACE', 'COMMENT'):
                continue
            if kind == 'UNKNOWN':
                raise SyntaxError(f'Unexpected token: {value}')
            tokens.append((kind, value))
        return tokens

    def peek(self):
        return self.tokens[self.position] if self.position < len(self.tokens) else ('EOF', '')

    def consume(self, expected_kind):
        kind, value = self.peek()
        if kind == expected_kind:
            self.position += 1
            return value
        raise SyntaxError(f'Expected {expected_kind}, but got {kind}')

class Parser:
    def __init__(self, lexer):
        self.lexer = lexer

    def parse(self):
        result = []
        while self.lexer.peek()[0] != 'EOF':
            result.append(self.parse_literal())
        return result

    def parse_literal(self):
        kind, value = self.lexer.peek()
        if kind == 'NIL':
            self.lexer.consume('NIL')
            return {"tag": "nil", "val": None}
        elif kind == 'BOOL':
            self.lexer.consume('BOOL')
            return {"tag": "bool", "val": value == 'true'}
        elif kind == 'INT':
            self.lexer.consume('INT')
            return {"tag": "int", "val": int(value.replace('_', ''))}
        elif kind == 'STRING':
            self.lexer.consume('STRING')
            return {"tag": "str", "val": self.unescape_string(value)}
        elif kind == 'LBRACKET':
            return self.parse_array()
        elif kind == 'LBRACE':
            return self.parse_hash()
        elif kind == 'LPAREN':
            return self.parse_range()
        raise SyntaxError(f'Unexpected token: {value}')
    
    def unescape_string(self, value):
        return value[1:-1].replace('\\\n', '\n').replace('\\\\', '\\')

    def parse_array(self):
        self.lexer.consume('LBRACKET')
        elements = []
        requires_trailing_comma = False  
        while self.lexer.peek()[0] != 'RBRACKET':
            elements.append(self.parse_literal())

            if self.lexer.peek()[0] == 'COMMA':
                self.lexer.consume('COMMA')
                requires_trailing_comma = True  
            else:
                requires_trailing_comma = False  

        if not requires_trailing_comma and elements:
            raise SyntaxError("Array must end with a trailing comma before closing bracket.")

        self.lexer.consume('RBRACKET')
        return {"tag": "array", "val": elements}


    def parse_hash(self):
        self.lexer.consume('LBRACE')
        elements = []
        requires_trailing_comma = False  

        while self.lexer.peek()[0] != 'RBRACE':
            key = self.parse_literal()
            self.lexer.consume('HASHROCKET')
            value = self.parse_literal()
            elements.append({"key": key, "val": value})

            if self.lexer.peek()[0] == 'COMMA':
                self.lexer.consume('COMMA')
                requires_trailing_comma = True  
            else:
                requires_trailing_comma = False  
                
        if not requires_trailing_comma and elements:
            raise SyntaxError("Hash must end with a trailing comma before closing brace.")

        self.lexer.consume('RBRACE')
        return {"tag": "hash", "val": elements}

    def parse_range(self):
        self.lexer.consume('LPAREN')
        low = self.parse_literal()
        operator = self.lexer.consume('RANGE')
        high = self.parse_literal()
        self.lexer.consume('RPAREN')

        # Ensure both elements in the range are the same type
        if low["tag"] != high["tag"]:
            raise SyntaxError("Mixed-type range is invalid.")

        return {"tag": "closed_range" if operator == '..' else "half_open_range", "val": [low, high]}

if __name__ == '__main__':
    input_text = sys.stdin.read()
    lexer = Lexer(input_text)
    parser = Parser(lexer)
    try:
        result = parser.parse()
        print(json.dumps(result, separators=(',', ':')))
    except SyntaxError as e:
        print(f"Error: {e}", file=sys.stderr)  
        sys.exit(1)  

