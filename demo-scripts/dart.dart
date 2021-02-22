void main() {
  int number = 42;
  int anotherNumber = 12;

  printInteger(number);
  subtract(number, anotherNumber);
  howManyTacos(1, hungry: false);

  Person anthony = Person('Anthony');

  print(anthony.isHungry);

  howManyTacos(6, hungry: anthony.isHungry);

  anthony.favoriteColors = <String, String>{'Purple': 'FFA267F5'};
  print(anthony.favoriteColors);
}

void printInteger(int aNumber) {
  print('The number is $aNumber.');
}

void subtract(int aNumber, int secondNumber) {
  print(
      'The difference between $aNumber and $secondNumber is ${aNumber - secondNumber}.');
}

int howManyTacos(int tacosWanted, {bool hungry: true}) {
  int numTacos;
  final int minTacos = 2;

  switch (hungry) {
    case true:
      if (tacosWanted < minTacos) {
        numTacos = tacosWanted + 2;
      } else if (tacosWanted <= 4) {
        numTacos = tacosWanted;
      } else {
        numTacos = tacosWanted - 2;
      }
      break;
    case false:
      numTacos = 0;
      break;
    default:
      throw "This will never be thrown.";
  }

  print('I should definitely eat $numTacos 🌮s');
  return numTacos;
}

class Person {
  String name;
  bool _isHungry;
  bool hadSnack = false;
  var _favoriteColors = <String, String>{};

  var normalMealTimes = <int>[7, 8, 11, 12, 17, 18];

  Person(this.name);

  bool get isHungry {
    if (name == 'Anthony') {
      _isHungry = true; // 😂
    } else {
      var now = DateTime.now();
      if (normalMealTimes.contains(now.hour) && hadSnack == false) {
        _isHungry = true;
      } else {
        _isHungry = false;
      }
    }

    return _isHungry;
  }

  Map<String, String> get favoriteColors => _favoriteColors;

  void set favoriteColors(Map<String, String> color) =>
      _favoriteColors.addEntries(color.entries);
}
