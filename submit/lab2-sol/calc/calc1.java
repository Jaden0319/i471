import java.util.ArrayList;
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

  private List<Integer> parse() {
    var value = program();
    return value;
  }

  private boolean peek(String kind) { return lookahead.kind().equals(kind); }
  private void consume(String kind) {
    if (peek(kind)) {
      lookahead = nextToken();
    }
    else {
      System.err.format("expecting %s at %s", kind, lookahead.kind());
      System.exit(1);
    }
  }

  private Token nextToken() {
    return (index >=  tokens.size())
      ? new Token("EOF", "<EOF>")
      : tokens.get(index++);
  }

  private List<Integer> program() {
    var values = new ArrayList<Integer>();
    while (!peek("EOF")) {
      values.add(expr());
      consume(";");
    }
    return values;
  }

  private int expr() {
    var t = term();
    while (peek("+") || peek("-")) {
      var kind = lookahead.kind();
      consume(kind);
      var t1 = term();
      t += (kind.equals("+")) ? t1 : -t1;
    }
    return t;
  }

  private int term() {
    if (peek("-")) {
      consume("-");
      return - term();
    }
    else {
      return factor();
    }
  }

  private int factor() {
    if (peek("INT")) {
      var value = Integer.parseInt(lookahead.lexeme());
      consume("INT");
      return value;
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
        .map(Object::toString)
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

record Token(String kind, String lexeme) {
  public String toString() {
    return String.format("{\"kind\":\"%s\",\"lexeme\":\"%s\"}",
                         this.kind, this.lexeme);
  }
}

class Lexer {

  //it is imperative that each regex starts with a  ^ to anchor
  //the match to the start of the string
  private static final Pattern WS_RE = Pattern.compile("^\\s+");
  private static final Pattern INT_RE = Pattern.compile("^\\d+");
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
      else {
        lexeme = match(CHAR_RE, text);
        tokens.add(new Token(lexeme, lexeme));
      }
      text = text.substring(lexeme.length());
    }
    return tokens;
  }

}
