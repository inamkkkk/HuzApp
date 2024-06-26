String formatCurrency(int amount) {
  // Convert the integer to a string
  String amountStr = amount.toString();

  // Use a buffer to build the formatted string
  StringBuffer buffer = StringBuffer();

  // Iterate over the string from end to start
  for (int i = amountStr.length - 1, j = 1; i >= 0; i--, j++) {
    buffer.write(amountStr[i]);
    // Add a comma after every 3 digits, except at the end
    if (j % 3 == 0 && i != 0) {
      buffer.write(',');
    }
  }

  // Reverse the string to get the correct order
  return buffer.toString().split('').reversed.join('');
}