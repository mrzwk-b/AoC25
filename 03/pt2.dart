import '../util.dart';
import 'pt1.dart';

DecimalInt greatestNDigitNumber(int numDigits, List<int> digitPool) {
  if (numDigits == 1) {
    return DecimalInt.fromValue(digitPool[indexOfFirstMaximum(digitPool)]);
  }
  else {
    int firstDigitIndex = 
      indexOfFirstMaximum(digitPool.sublist(0, digitPool.length - (numDigits - 1)))
    ;
    return DecimalInt.fromDigits(
      [digitPool[firstDigitIndex]] +
      greatestNDigitNumber(numDigits - 1, digitPool.sublist(firstDigitIndex + 1)).digits
    );
  }
}

int maxJoltage(List<int> bank) => greatestNDigitNumber(12, bank).value;

void main() {
  List<List<int>> powerBanks = getData();
  int total = powerBanks.map((bank) => maxJoltage(bank)).reduce((a, b) => a + b);
  print(total);
}