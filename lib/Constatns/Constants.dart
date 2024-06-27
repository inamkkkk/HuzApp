import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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




var cnicMask = MaskTextInputFormatter(
    mask: '#####-#######-#',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var nameMask = MaskTextInputFormatter(
    mask: '################################',
    filter: {"#": RegExp(r'[a-zA-Z\.\-\s]')},
    type: MaskAutoCompletionType.lazy);

var emailMask = MaskTextInputFormatter(
  mask: '#######################################', // Adjust the mask length as needed
  filter: {"#": RegExp(r'[a-zA-Z0-9\.\_\-@]')}, // Include characters typically found in emails
  type: MaskAutoCompletionType.lazy,
);
var websiteMask = MaskTextInputFormatter(
  mask: '#######################################', // Adjust as needed
  filter: {"#": RegExp(r'[a-zA-Z0-9\.\-\_]')}, // Include characters typically found in URLs
  type: MaskAutoCompletionType.lazy,
);
var phoneMask = MaskTextInputFormatter(
  mask: '(###) ###-####', // US phone number format
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
var titlemask = MaskTextInputFormatter(
    mask: '#########################',
    filter: {"#": RegExp(r'[a-zA-Z\.\-\s]')},
    type: MaskAutoCompletionType.lazy);