import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.nio.file.Files;
import java.nio.file.Path;

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
expn
  : factor ( '**' expn )?
  ;
factor
  : INT
  | '(' expr ')'
  ;
*/


public class Calc {

  private final List<Token> tokens;
  private int index;
  private Token lookahead;

  Calc(List<Token> tokens) {
    this.tokens = tokens;
    this.index = 0;
    this.lookahead = nextToken();
  }

  private List<Ast> parse() {
    var value = program();
    return value;
  }

  private boolean peek(String kind) { return lookahead.kind().equals(kind); }
  private void consume(String kind) {
    if (peek(kind)) {
      lookahead = nextToken();
    }
    else {
      System.err.format("expecting %s at %s\n", kind, lookahead.kind());
      System.exit(1);
    }
  }

  private Token nextToken() {
    return (index >=  tokens.size())
      ? new Token("EOF", "<EOF>")
      : tokens.get(index++);
  }

  private List<Ast> program() {
    var values = new ArrayList<Ast>();
    while (!peek("EOF")) {
      values.add(expr());
      consume(";");
    }
    return values;
  }

  private Ast expr() {
    var t = term();
    while (peek("+") || peek("-")) {
      var kind = lookahead.kind();
      consume(kind);
      var t1 = term();
      t = new OpAst(kind, t, t1);
    }
    return t;
  }

  private Ast term() {
    if (peek("-")) {
      consume("-");
      return new OpAst("-", term());
    }
    else {
      return expn();
    }
  }

  private Ast expn() {
    var base = factor();
    if (peek("**")) {
        consume("**");
        var exponent = expn(); // Right-associative exponentiation
        return new OpAst("**", base, exponent);
    }
    return base;
  }

  private Ast factor() {
    if (peek("INT")) {
      var value = Integer.parseInt(lookahead.lexeme());
      consume("INT");
      return new IntAst(value);
    }
    else {
      consume("(");
      var value = expr();
      consume(")");
      return value;
    }
  }

  public static void main(String[] args) {
    if (args.length != 1) usage();
    try {
      var text = Files.readString(Path.of(args[0]));
      List<Token> toks = Lexer.scan(text);
      //for (var t : toks) { System.out.println(t); }
      var vals = new Calc(toks).parse();
      var valsStr = vals.stream()
        .map(Ast::toJson)
        .collect(Collectors.joining(","))
        .toString();
      System.out.format("[%s]\n", valsStr);;
    }
    catch (Exception e) {
      throw new RuntimeException(e);
    }
  }

  private static void usage() {
    System.err.println("usage: java calc1.java FILE_NAME");
    System.exit(1);
  }


}



abstract class Ast {
  abstract String toJson();
}

class OpAst extends Ast {
  private final String op;
  private final List<Ast> kids;

  OpAst(String op, Ast ...kids) {
    this.op = op;
    this.kids = Arrays.asList(kids);
  }
  String toJson() {
    var kidsStr = this.kids.stream()
        .map(Ast::toJson)
        .collect(Collectors.joining(","))
        .toString();
    return String.format("{\"tag\":\"%s\",\"kids\":[%s]}", this.op, kidsStr);
  }
}

class IntAst extends Ast {
  private final int val;

  IntAst(int val) { this.val = val; }
  String toJson() {
    return String.format("{\"tag\":\"INT\",\"value\":%d}", this.val);
  }
}

/******************************** Lexer ********************************/

class Lexer {

  //it is imperative that each regex starts with a  ^ to anchor
  //the match to the start of the string
  private static final Pattern WS_RE = Pattern.compile("^\\s+");
  private static final Pattern INT_RE = Pattern.compile("^\\d+");
  private static final Pattern DOUBLE_STAR_RE = Pattern.compile("^\\*\\*"); 
  private static final Pattern CHAR_RE = Pattern.compile("^.");

  /** Return lexeme which matches re in text; null if no match */
  private static String match(Pattern re, String text) {
    var matcher = re.matcher(text);
    return (matcher.lookingAt()) ? matcher.group() : null;
  }

  static List<Token> scan(String text) {
    var tokens = new ArrayList<Token>();
    while (text.length() > 0) {
      String lexeme;
      if ((lexeme = match(WS_RE, text)) != null) {
        //empty statement to ignore token
      }
      else if ((lexeme = match(INT_RE, text)) != null) {
        tokens.add(new Token("INT", lexeme));
      }
      else if ((lexeme = match(DOUBLE_STAR_RE, text)) != null) {
            tokens.add(new Token("**", lexeme));
      }
      else {
        lexeme = match(CHAR_RE, text);
        tokens.add(new Token(lexeme, lexeme));
      }
      text = text.substring(lexeme.length());
    }
    return tokens;
  }

}

record Token(String kind, String lexeme) {
  public String toString() {
    return String.format("{\"kind\":\"%s\",\"lexeme\":\"%s\"}",
                         this.kind, this.lexeme);
  }
}
