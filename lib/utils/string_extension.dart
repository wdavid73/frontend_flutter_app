String convertToTitleCase(String text) {
  if (text == null) {
    return null;
  }

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final List<String> words = text.split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    final String firstLetter = word.substring(0, 1).toUpperCase();
    final String remainingLetters = word.substring(1);

    return '$firstLetter$remainingLetters';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}

String capitalizeFirstWordCase(String text) {
  return "${text[0].toUpperCase()}${text.substring(1)}";
}

extension StringExtension on String {
  String capitalizeEachWord() {
    return convertToTitleCase(this);
  }

  String capitalizeFirstWord() {
    return capitalizeFirstWordCase(this);
  }
}

extension emailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

String verifySlash(String path) {
  if (path.endsWith("/")) {
    return path;
  } else {
    String newPath = path + "/";
    return newPath;
  }
}

extension stringEndSlash on String {
  String endSlash() {
    return verifySlash(this);
  }
}
