export default class Lexer {
  constructor(table) {
    this._nextToken = tableMatcher(table);
  }

  scan(text) {
    const tokens = [];
    while (text.length > 0) {
      const token = this._nextToken(text);
      text = text.substring(token.lexeme.length);
      if (token.kind !== '$Ignore') {
	tokens.push(token);
      }
    } //while
    return tokens;
  }

}


function tableMatcher(table) {
 const reString =
    Object.entries(table)
    .map(([t, re]) => `(?<${t}>^${re.toString().slice(1, -1)})`)
    .join('|');
  const re = new RegExp(`${reString}`);
  return text => {
    let m;
    m = text.match(re);
    if (!m) {
      return new Token('$err', text.substring(0, 1), text.coord);
    }
    else {
      const [ [type, lexeme ] ] =
        Object.entries(m.groups).
        filter(([t, v]) => v !== undefined);
      return new Token(type, text.substring(0, lexeme.length));
    }
  };
}
    
class Token {
  constructor(kind, lexeme) {
    Object.assign(this, {kind, lexeme});
  }
}

