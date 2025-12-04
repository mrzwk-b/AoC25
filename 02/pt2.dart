import '../util.dart';
import 'pt1.dart';

DecimalInt replicateDigits(DecimalInt number, int times) {
  List<int> newDigits = [];
  for (int i = 0; i < times; i += 1) {
    newDigits.addAll(number.digits);
  }
  return DecimalInt.fromDigits(newDigits);
}

bool firstSectionGteSubsequent(DecimalInt number, int sectionSize) {
  if (number.digits.length == sectionSize) {
    return true;
  }
  else {
    DecimalInt firstSection = DecimalInt.fromDigits(number.digits.sublist(0, sectionSize));
    DecimalInt nextSection = DecimalInt.fromDigits(number.digits.sublist(sectionSize, 2 * sectionSize));
    if (firstSection > nextSection) {
      return true;
    }
    else if (firstSection < nextSection) {
      return false;
    }
    else {
      return firstSectionGteSubsequent(
        DecimalInt.fromDigits(number.digits.sublist(sectionSize)),
        sectionSize
      );
    }
  }
}

List<DecimalInt> invalidIdsInRange(DecimalInt start, DecimalInt end) {
  List<DecimalInt> invalidIds = [];
  for (int i = 2; i <= end.digits.length; i += 1) {
    for (
      DecimalInt current = start.digits.length % i == 0
        ? () {
          int sectionSize = start.digits.length ~/ i;
          DecimalInt firstSection = 
            DecimalInt.fromDigits(start.digits.sublist(0, sectionSize))
          ;
          return firstSectionGteSubsequent(start, sectionSize)
            ? firstSection
            : firstSection + DecimalInt.fromValue(1)
          ;
        } ()
        : DecimalInt.fromDigits([1, for (int j = 0; j < start.digits.length ~/ i; j++) 0])
      ;
      replicateDigits(current, i) <= end;
      current += DecimalInt.fromValue(1)
    ) {
      DecimalInt id = replicateDigits(current, i);
      if (! invalidIds.contains(id)) {
        invalidIds.add(id);
      }
    }
  }
  return invalidIds;
}

void main() {
  List<String> input = readInput();
  Stopwatch stopwatch = Stopwatch()..start();
  
  final List<DecimalInt> invalidIds = [];
  for ((DecimalInt, DecimalInt) range in formatData(input)) {
    invalidIds.addAll(invalidIdsInRange(range.$1, range.$2));
  }
  DecimalInt total = invalidIds.reduce((a, b) => a + b);

  stopwatch.stop();
  print(total);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
}
