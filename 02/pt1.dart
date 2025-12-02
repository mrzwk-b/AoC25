import '../util.dart';

class DecimalInt {
  final int value;
  final List<int> digits;

  DecimalInt.fromDigits(this.digits): value = digits.reduce((a, b) => (10 * a) + b);
  DecimalInt.fromValue(this.value): 
    digits = ((int value) {
      List<int> digits = [];
      while (value > 0) {
        digits.insert(0, value % 10);
        value ~/= 10;
      }
      return digits;
    }) (value)
  ;
  
  bool operator ==(Object other) => other is DecimalInt && value == other.value;
  bool operator <(DecimalInt other) => value < other.value;
  bool operator <=(DecimalInt other) => value <= other.value;
  bool operator >(DecimalInt other) => value > other.value;
  bool operator >=(DecimalInt other) => value >= other.value;

  DecimalInt operator +(DecimalInt other) => DecimalInt.fromValue(value + other.value);
  DecimalInt operator -(DecimalInt other) => DecimalInt.fromValue(value - other.value);
  DecimalInt operator *(DecimalInt other) => DecimalInt.fromValue(value * other.value);
  DecimalInt operator ~/(DecimalInt other) => DecimalInt.fromValue(value ~/ other.value);
  DecimalInt operator %(DecimalInt other) => DecimalInt.fromValue(value % other.value);

  @override
  String toString() => this.value.toString();
}

List<(DecimalInt, DecimalInt)> getData([final String? inputFileName]) =>
  readInput(inputFileName).single.split(',').map((range) {
    final List<String> startAndFinish = range.split('-');
    return (
      DecimalInt.fromValue(int.parse(startAndFinish[0])),
      DecimalInt.fromValue(int.parse(startAndFinish[1]))
    );
  }).toList()
;

DecimalInt duplicateDigits(DecimalInt number) => DecimalInt.fromDigits(number.digits + number.digits);

List<DecimalInt> invalidIdsInRange(DecimalInt start, DecimalInt end) => [
  for (
    DecimalInt current = start.digits.length % 2 == 0
      ? () {
        DecimalInt firstHalf = 
          DecimalInt.fromDigits(start.digits.sublist(0, start.digits.length ~/ 2))
        ;
        DecimalInt secondHalf =
          DecimalInt.fromDigits(start.digits.sublist(start.digits.length ~/ 2, start.digits.length))
        ;
        return firstHalf >= secondHalf ? firstHalf : firstHalf + DecimalInt.fromValue(1);
      } ()
      : DecimalInt.fromDigits([1, for (int i = 0; i < start.digits.length ~/ 2; i++) 0])
    ;
    duplicateDigits(current) <= end;
    current += DecimalInt.fromValue(1)
  ) duplicateDigits(current)
];

void main() {
  final List<DecimalInt> invalidIds = [];
  for ((DecimalInt, DecimalInt) range in getData()) {
    invalidIds.addAll(invalidIdsInRange(range.$1, range.$2));
  }
  print(invalidIds.reduce((a, b) => a + b));
}