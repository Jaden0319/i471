#!/usr/bin/env node

import fs from 'fs';
import Path from 'path';

import Lexer from './table-lexer.mjs';

function usage() {
  const prog = Path.basename(process.argv[1])
  console.error(`usage: ${prog} RE_TABLE_FILE INPUT_FILE`);
  process.exit(1);
}

const CHAR_SET = 'utf8';
async function main() {
  if (process.argv.length !== 4) usage();
  const [tableFile, dataFile] = process.argv.slice(2);
  const fileSpec = tableFile.startsWith('.') ? tableFile : `./${tableFile}`;
  const table = (await import(fileSpec)).default;
  const lexer = new Lexer(table);
  const text = fs.readFileSync(dataFile, CHAR_SET);
  for (const token of lexer.scan(text)) {
    console.log(JSON.stringify(token));
  }
}


main().catch(err => console.error(err));

