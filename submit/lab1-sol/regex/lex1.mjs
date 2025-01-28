export default {
  $Ignore: /\s+/,  // \s matches whitespace; \s+ matches one-or-more whitespace
                   // $Ignore means that any whitespace will be ignored.
  INT: /\d+/,      // \d matches a digit, hence one-or-more digits for
                   // token with kind INT        
  CHAR: /./,       // single char: must be last;
                   // . is a regex which matches any char other than '\n'
};
