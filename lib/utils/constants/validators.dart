import 'package:get/get.dart';

class Validators {
  static String? checkFieldEmpty(String? fieldContent) {
    fieldContent!.trim();
    if (fieldContent.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static bool isValidStart(String phone) {
    return phone.startsWith("98") || phone.startsWith("97");
  }

  static String? checkPhoneField(String? fieldContent) {
    if (fieldContent == null) {
      return 'This field is required';
    }

    fieldContent = fieldContent.trim();

    if (fieldContent.isEmpty) {
      return 'This field is required';
    } else if (fieldContent.length != 10 || !fieldContent.isNumericOnly) {
      return 'Invalid phone number length';
    } else if (!isValidStart(fieldContent)) {
      return 'Invalid phone number';
    }

    return null;
  }

  static String? checkPANField(String? fieldContent) {
    fieldContent!.trim();
    if (fieldContent.isEmpty) {
      return 'This field is required';
    } else if (!(fieldContent.isNumericOnly && fieldContent.length == 9)) {
      return 'The legal number must be 9 digits';
    }

    return null;
  }

  // static String? checkPasswordField(String? fieldContent) {
  //   fieldContent!.trim();
  //   if (fieldContent.isEmpty) {
  //     return 'This field is required';
  //   } else if (fieldContent.length < 8) {
  //     return 'The password should be at least 8 digits';
  //   }

  //   return null;
  // }

  static String? checkPasswordField(String? fieldContent) {
    if (fieldContent == null) {
      return 'This field is required';
    }

    fieldContent = fieldContent.trim();

    if (fieldContent.isEmpty) {
      return 'This field is required';
    }

    if (fieldContent.length < 8) {
      return 'The password must be at least 8 characters long';
    }

    final RegExp hasUppercase = RegExp(r'[A-Z]');
    final RegExp hasLowercase = RegExp(r'[a-z]');
    final RegExp hasNumber = RegExp(r'[0-9]');
    final RegExp hasSpecialCharacter = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    if (!hasUppercase.hasMatch(fieldContent)) {
      return 'The password must contain at least one uppercase letter';
    }

    if (!hasLowercase.hasMatch(fieldContent)) {
      return 'The password must contain at least one lowercase letter';
    }

    if (!hasNumber.hasMatch(fieldContent)) {
      return 'The password must contain at least one number';
    }

    if (!hasSpecialCharacter.hasMatch(fieldContent)) {
      return 'The password must contain at least one special character';
    }

    return null;
  }

  // static String? checkConfirmPassword(String? password, String? fieldContent) {
  //   var checkPassword = checkPasswordField(fieldContent);
  //   if (checkPassword != null) {
  //     return checkPassword;
  //   }

  //   if (password != fieldContent!) {
  //     return "Password does not match";
  //   }
  //   return null;
  // }
  static String? checkConfirmPassword(String? password, String? fieldContent) {
    if (password != fieldContent) {
      return "Password does not match";
    }
    return null;
  }

  static String? checkEmailField(String? fieldContent) {
    fieldContent!.trim();
    if (fieldContent.isEmpty) {
      return 'This field is required';
    } else if (!GetUtils.isEmail(fieldContent.trim())) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? checkOptionalEmailField(String? fieldContent) {
    fieldContent!.trim();
    if ((fieldContent.isNotEmpty) && !GetUtils.isEmail(fieldContent)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? checkPinField(String? fieldContent) {
    fieldContent!.trim();
    if (fieldContent.isEmpty) {
      return 'This field is required';
    } else if (!(fieldContent.isNumericOnly && fieldContent.length == 5)) {
      return 'Invalid OTP';
    }
    return null;
  }

  static String? checkMrpisGreater(String? price, String? secondPrice) {
    // Convert prices to numeric values
    int? priceValue = int.tryParse(price.toString());
    int? secondPriceValue = int.tryParse(secondPrice.toString());

    // Check if conversion was successful
    if (priceValue == null || secondPriceValue == null) {
      return 'Invalid price format';
    }

    // Check if second price is greater than the first price
    if (secondPriceValue <= priceValue) {
      return 'Mrp price must be greater than the  price';
    }

    return null; // Indicates validation passed
  }
}
