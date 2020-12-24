class FormatHelper {
  static String replaceCommonChars(String str) {
    return str
        .replaceAll("à", "a")
        .replaceAll("á", "a")
        .replaceAll("è", "e")
        .replaceAll("é", "e")
        .replaceAll("í", "i")
        .replaceAll("ò", "o")
        .replaceAll("ó", "o")
        .replaceAll("ú", "u");
  }

  static bool checkEmailFormat(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}