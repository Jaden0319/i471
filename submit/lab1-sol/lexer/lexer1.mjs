#!/usr/bin/env node

import fs from 'fs';
import Path from 'path';

//make changes in this function.
// *** It is imperative that each regex starts with a ^ to anchor
// the match to the start of the current string. ***
function scan(text) {
  const tokens = [];
  while (text.length > 0) {
    let m;  //m[0] will contain lexeme after successful match
    if ((m = text.match(/^\s+/))) {
      //empty statement to ignore token
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
  const text = fs.readFileSync(file, CHAR_SET);
  for (const token of scan(text)) {
    console.log(JSON.stringify(token));
  }
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

