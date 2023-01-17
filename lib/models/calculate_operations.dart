class CalculateOperations {
  static double calculate(String operations) {
    List<double> numbers = [];
    List<String> signs = [];

    // Fill the numbers and sign arrays
    while (operations.isNotEmpty) {
      // Get the number by extracting character from operation string until the character is a sign
      String subOperation = "";
      while (!isSign(operations[0])) {
        subOperation += operations[0];
        operations = operations.substring(1);

        if (operations.isEmpty) break;
      }

      numbers.add(double.parse(subOperation));

      // the next operation will either be nothing or a sign, so just add the next operation as a sign if there are any more left
      if (operations.isNotEmpty) {
        signs.add(operations[0]);
        operations = operations.substring(1);
      }
    }

    // loop thru each of the possible signs in the order of precedence
    for (int i = 0; i < 5; i++) {
      String currentSign = _setCurrentSign(i);

      // if the current sign is up then do it's operation on the number before and after it
      // this will loop thru all the operations of the math problem. The last number left will be the sum
      for (int j = signs.length - 1; j >= 0; j--) {
        if (signs[j] == currentSign) {
          if (currentSign == "+") {
            numbers[j] += numbers[j + 1];
          } else if (currentSign == "-") {
            numbers[j] -= numbers[j + 1];
          } else if (currentSign == "x") {
            numbers[j] *= numbers[j + 1];
          } else if (currentSign == "/") {
            numbers[j] /= numbers[j + 1];
          } else if (currentSign == "%") {
            numbers[j] %= numbers[j + 1];
          }

          // Remove the sign and the proceeding number as they will not be used anymore
          signs.removeAt(j);
          numbers.removeAt(j + 1);
        }
      }
    }

    // This is the final number remaining which is the answer to the problem
    return numbers[0];
  }

  static String _setCurrentSign(int index) {
    String currentSign = "";
    switch (index) {
      case 0:
        {
          currentSign = "x";
        }
        break;
      case 1:
        {
          currentSign = "/";
        }
        break;
      case 2:
        {
          currentSign = "+";
        }
        break;
      case 3:
        {
          currentSign = "-";
        }
        break;
      case 4:
        {
          currentSign = "%";
        }
        break;
    }

    return currentSign;
  }

  static bool isSign(String operation) {
    if (operation == "x" ||
        operation == "/" ||
        operation == "+" ||
        operation == "-" ||
        operation == "%") {
      return true;
    }

    return false;
  }
}
