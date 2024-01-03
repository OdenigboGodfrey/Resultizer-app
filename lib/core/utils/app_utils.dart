int countWordOccurrences(String text, String word) {
  List<String> words = text.split(''); // Split the text into words
  int occurrences = 0;

  for (String w in words) {
    if (w == word) {
      occurrences++;
    }
  }

  return occurrences;
}