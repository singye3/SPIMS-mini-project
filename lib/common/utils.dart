String convertToSentenceCase(String input) {
  if (input.isEmpty) {
    return '';
  }

  final lowercaseInput = input.toLowerCase();
  final sentenceCaseText = lowercaseInput.substring(0, 1).toUpperCase() +
      lowercaseInput.substring(1);

  return sentenceCaseText;
}

String convertToLowerCaseWithUnderscores(String input) {
  // Convert the string to lowercase
  String lowercaseString = input.toLowerCase();

  // Replace whitespace with underscores
  String stringWithUnderscores = lowercaseString.replaceAll(' ', '_');

  return stringWithUnderscores;
}

String removeUnderscores(String input) {
  String str = input.replaceAll('_', ' ');
  String lowercaseString = _capitalize(str);

  return lowercaseString;
}

String _capitalize(String text) {
  final words = text.split(' ');
  final capitalizedWords = words.map((word) {
    return word[0].toUpperCase() + word.substring(1);
  });
  return capitalizedWords.join(' ');
}
