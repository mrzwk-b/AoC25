import '../util.dart';

List<List<int>> getData([String? inputFileName]) =>
  readInput(inputFileName).map(
    (line) => line.split('').map(
      (char) => int.parse(char)
    ).toList()
  ).toList()
;

int indexOfFirstMaximum(List<int> list) {
  int maxIndex = 0;
  for (int i = 0; i < list.length; i += 1) {
    if (list[i] > list[maxIndex]) {
      maxIndex = i;
    }
  }
  return maxIndex;
}

int maxJoltage(List<int> bank) {
  int firstDigitIndex = indexOfFirstMaximum(bank);
  return (firstDigitIndex == bank.length - 1) 
    ? (
      (10 * bank[indexOfFirstMaximum(bank.sublist(0, bank.length - 1))]) +
      bank[bank.length - 1]
    )
    : (
      (10 * bank[firstDigitIndex]) +
      bank[indexOfFirstMaximum(bank.sublist(firstDigitIndex + 1)) + firstDigitIndex + 1]
    )
  ;
}

void main() {
  List<List<int>> powerBanks = getData();
  Stopwatch stopwatch = Stopwatch()..start();
  
  int total = powerBanks.map((bank) => maxJoltage(bank)).reduce((a, b) => a + b);
  
  stopwatch.stop();
  print(total);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
  while (true);
}