List<T> getRandomSubset<T>(List<T> inputList, int itemLength) {
  if (itemLength >= inputList.length) {
    // If the item length is greater than or equal to the input list length,
    // return a shuffled copy of the input list.
    List<T> shuffledList = List.from(inputList)..shuffle();
    return shuffledList;
  } else {
    // Otherwise, randomly select a subset of items from the input list.
    List<T> shuffledList = List.from(inputList)..shuffle();
    return shuffledList.sublist(0, itemLength);
  }
}