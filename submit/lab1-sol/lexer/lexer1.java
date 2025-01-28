import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.nio.file.Files;
import java.nio.file.Path;

public class Lexer {

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

  // make changes in this method.
  private static List<Token> scan(String text) {
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

  public static void main(String[] args) {
    if (args.length != 1) usage();
    try {
      var text = Files.readString(Path.of(args[0]));
      for (var t : scan(text)) { System.out.println(t); }
    }
    catch (Exception e) {
      throw new RuntimeException(e);
    }
  }

  private static void usage() {
    System.err.println("usage: java lexer1.java FILE_NAME");
    System.exit(1);
  }


  record Token(String kind, String lexeme) {
    public String toString() {
      return String.format("{\"kind\":\"%s\",\"lexeme\":\"%s\"}",
                           this.kind, this.lexeme);
    }
  }
  /*
  static record Token {
    final String kind;
    final String lexeme;

    Token(String kind, String lexeme) {
      this.kind = kind; this.lexeme = lexeme;
    }
    public String toString() {
      return String.format("{kind:\"%s\", lexeme:\"%s\"}",
                           this.kind, this.lexeme);
    }
  }
  */

}
