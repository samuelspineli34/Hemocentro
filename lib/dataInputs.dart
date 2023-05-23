import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String formattedText = newValue.text;

    if (formattedText.length >= 4 && formattedText[3] != '.') {
      formattedText = formattedText.substring(0, 3) +
          '.' +
          formattedText.substring(3, formattedText.length);
    }

    if (formattedText.length >= 8 && formattedText[7] != '.') {
      formattedText = formattedText.substring(0, 7) +
          '.' +
          formattedText.substring(7, formattedText.length);
    }

    if (formattedText.length >= 12 && formattedText[11] != '-') {
      formattedText = formattedText.substring(0, 11) +
          '-' +
          formattedText.substring(11, formattedText.length);
    }

    return newValue.copyWith(text: formattedText, selection: _updateCursorPosition(formattedText));
  }

  TextSelection _updateCursorPosition(String value) {
    final cursorPosition = value.length;
    return TextSelection.fromPosition(TextPosition(offset: cursorPosition));
  }
}

class CnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String formattedText = newValue.text;

    if (formattedText.length >= 3 && formattedText[2] != '.') {
      formattedText = formattedText.substring(0, 2) +
          '.' +
          formattedText.substring(2, formattedText.length);
    }

    if (formattedText.length >= 7 && formattedText[6] != '.') {
      formattedText = formattedText.substring(0, 6) +
          '.' +
          formattedText.substring(6, formattedText.length);
    }

    if (formattedText.length >= 11 && formattedText[10] != '/') {
      formattedText = formattedText.substring(0, 10) +
          '/' +
          formattedText.substring(10, formattedText.length);
    }

    if (formattedText.length >= 16 && formattedText[15] != '-') {
      formattedText = formattedText.substring(0, 15) +
          '-' +
          formattedText.substring(15, formattedText.length);
    }

    return newValue.copyWith(
      text: formattedText,
      selection: _updateCursorPosition(formattedText),
    );
  }

  TextSelection _updateCursorPosition(String value) {
    final cursorPosition = value.length;
    return TextSelection.fromPosition(TextPosition(offset: cursorPosition));
  }
}


class WeightInputFormatter extends TextInputFormatter {
@override
TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
  String cleanedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
  int textLength = cleanedText.length;

  if (textLength <= 3) {
    return TextEditingValue(
      text: cleanedText,
      selection: TextSelection.collapsed(offset: textLength),
    );
  }

  int decimalIndex = textLength - 2;
  String formattedText =
      cleanedText.substring(0, decimalIndex) + ',' + cleanedText.substring(decimalIndex);

  return TextEditingValue(
    text: formattedText,
    selection: TextSelection.collapsed(offset: formattedText.length),
  );
}
}

