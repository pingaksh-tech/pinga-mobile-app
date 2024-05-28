

mixin ValidationMixin {
  String? houseOrFlatValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please Enter House/Flat Number';
    } else {
      return null;
    }
  }

  String? phoneOREmailValidator(String? value) {
    if (value == null) {
      return 'Please enter a valid email or phone number';
    }

    // Check if the input is a valid email address
    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return null; // Return null if it's a valid email
    }

    // Check if the input is a valid phone number
    if (RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return null; // Return null if it's a valid phone number
    }

    // If neither email nor phone, return an error message
    return 'Please enter Email or Phone number';
  }

  String? phoneValidator(String? value) {
    RegExp regExp = RegExp(r'^[+]*[(]?[0-9]{1,4}[)]?[-\s./0-9]*$');
    bool isMatched = value != null ? regExp.hasMatch(value) : false;

    if (value?.isNotEmpty ?? false) {
      if (isMatched) {
        return null;
      } else {
        return 'Please enter a valid mobile number';
      }
    } else {
      return 'Please enter your mobile number';
    }
  }

  bool _isEmailValid(String? email) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return email != null ? regex.hasMatch(email) : false;
  }

  String? emailValidator(String? email) {
    if (email?.isNotEmpty ?? false) {
      if (_isEmailValid(email)) {
        return null;
      } else {
        return 'Please enter a valid email address';
      }
    } else {
      return 'Please enter your email address';
    }
  }

  ///Password validation
  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.startsWith(' ')) {
      return 'No leading white spaces allowed.';
    }

    // Check if the password length is at least 8 characters
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check if the password contains at least one letter, one number, one symbol, and one capital letter
    RegExp letterRegex = RegExp(r'[a-z]');
    RegExp capitalRegex = RegExp(r'[A-Z]');
    RegExp numberRegex = RegExp(r'[0-9]');
    RegExp symbolRegex = RegExp(r'[!@#\$%^&*()_+{}|:<>?~-]');

    if (!letterRegex.hasMatch(password)) {
      return 'Password must contain at least one letter';
    }
    if (!capitalRegex.hasMatch(password)) {
      return 'Password must contain at least one capital letter';
    }
    if (!numberRegex.hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    if (!symbolRegex.hasMatch(password)) {
      return 'Password must contain at least one symbol';
    }

    // Return null if the password meets all requirements
    return null;
  }

  String? newPasswordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.startsWith(' ')) {
      return 'No leading white spaces allowed.';
    }

    // Check if the password length is at least 8 characters
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check if the password contains at least one letter, one number, one symbol, and one capital letter
    RegExp letterRegex = RegExp(r'[a-z]');
    RegExp capitalRegex = RegExp(r'[A-Z]');
    RegExp numberRegex = RegExp(r'[0-9]');
    RegExp symbolRegex = RegExp(r'[!@#\$%^&*()_+{}|:<>?~-]');

    if (!letterRegex.hasMatch(password)) {
      return 'Password must contain at least one letter';
    }
    if (!capitalRegex.hasMatch(password)) {
      return 'Password must contain at least one capital letter';
    }
    if (!numberRegex.hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    if (!symbolRegex.hasMatch(password)) {
      return 'Password must contain at least one symbol';
    }

    // Return null if the password meets all requirements
    return null;
  }

  String? nameValidator(String? name) {
    final validCharacters = RegExp(r'^[a-zA-Z\s]+$');

    if (name != null) {
      if (name.isEmpty) {
        return 'Please enter your name.';
      } else if (name.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else if (name.contains('  ')) {
        return 'Only one space allowed after the name.';
      } else if (!validCharacters.hasMatch(name)) {
        return 'Name should only be in alphabets';
      } else {
        return null;
      }
    } else {
      return 'Please enter your name';
    }
  }

  String? userDesignationValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter your designation';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter your designation';
    }
  }

  String? companyAddressValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter company address';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter company address';
    }
  }

  String? addressValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter your address';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter your address';
    }
  }

  String? confirmPasswordValidator(
    String? value,
    String password,
  ) {
    if (value?.isNotEmpty ?? false) {
      if (password == value) {
        return null;
      }
      return 'Password and confirm Password doesn\'t match';
    } else {
      return 'Please enter confirm password';
    }
  }

  String? confirmPasswordValidatorForForgotPassword(
    String? value,
    String password,
  ) {
    if (value?.isNotEmpty ?? false) {
      if (password == value) {
        return null;
      }
      return 'New Password and Re-Enter Password doesn\'t \nmatch';
    } else {
      return 'Please Re-Enter New password';
    }
  }

  String? notNullValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter value';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter value';
    }
  }

  String? enterMessage(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter your message';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter your message';
    }
  }

  String? companyNameValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter company name';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter company name';
    }
  }


  String? gstValidator(String? value) {
    // Regular expression to match GST format
    RegExp gstRegex = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[A-Z]{1}[0-9A-Z]{1}$');

    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter GST number';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else if (!gstRegex.hasMatch(value)) {
        return 'Invalid GST number';
      } else {
        return null;
      }
    } else {
      return 'Please enter GST number';
    }
  }

  // Function to validate CIN number
  String? validateCIN(String? value) {
    // Regular expression to match CIN format
    RegExp cinRegex = RegExp(r'^([LUu]{1})([0-9]{5})([A-Za-z]{2})([0-9]{4})([A-Za-z]{3})([0-9]{6})$');

    if (value?.isEmpty ?? true) {
      return 'Please enter CIN number';
    } else if (!cinRegex.hasMatch(value!)) {
      return 'Invalid CIN number';
    }
    return null;
  }

  //Function to validate PAN number
  String? validatePAN(String? value) {
    // Regular expression to match PAN format
    RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter PAN number';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else if (!panRegex.hasMatch(value)) {
        return 'Invalid PAN number';
      } else {
        return null;
      }
    } else {
      return 'Please enter PAN number';
    }
  }

  ///Change password
  String? currentPassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.startsWith(' ')) {
      return 'No leading white spaces allowed.';
    }

    // Check if the password length is at least 8 characters
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check if the password contains at least one letter, one number, one symbol, and one capital letter
    RegExp letterRegex = RegExp(r'[a-z]');
    RegExp capitalRegex = RegExp(r'[A-Z]');
    RegExp numberRegex = RegExp(r'[0-9]');
    RegExp symbolRegex = RegExp(r'[!@#\$%^&*()_+{}|:<>?~-]');

    if (!letterRegex.hasMatch(password)) {
      return 'Password must contain at least one letter';
    }
    if (!capitalRegex.hasMatch(password)) {
      return 'Password must contain at least one capital letter';
    }
    if (!numberRegex.hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    if (!symbolRegex.hasMatch(password)) {
      return 'Password must contain at least one symbol';
    }

    // Return null if the password meets all requirements
    return null;
  }

  String? aadhaarValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Aadhaar number';
    }

    value = value.replaceAll(' ', '');

    // Condition 1: Check if it has 12 digits
    if (value.length != 12) {
      return 'It should have exactly 12 digits';
    }

    // Condition 2: Check if it does not start with 0 or 1
    if (value.startsWith('0') || value.startsWith('1')) {
      return 'It should not start with 0 or 1';
    }

    // Condition 3: Check if it does not contain any alphabet or special characters
    if (!RegExp(r'^[0-9 ]+$').hasMatch(value)) {
      return 'It should only contain digits and spaces';
    }

    // If all conditions pass, return null
    return null;
  }

  ///Product Validation
  String? countValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter Count';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter Count';
    }
  }

  String? qualityValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter Quality';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter Quality';
    }
  }

  String? cspValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter CSP';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter CSP';
    }
  }

  String? rateValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter Rate/KG';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter Rate/KG';
    }
  }

  String? quantityValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter quantity in Kgs';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter quantity in Kgs';
    }
  }

  String? deliveryRatePerKgValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter Deliver Rate/KG';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter Deliver Rate/KG';
    }
  }

  String? aboutValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter About';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter About';
    }
  }

  String? offerToSellerValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter Amount Per KG';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }
    } else {
      return 'Please enter Amount Per KG';
    }
  }

  String? utrValidator(String? value) {
    // RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    if (value != null) {
      if (value.isEmpty) {
        return 'Please enter UTR number';
      } else if (value.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else {
        return null;
      }

      //  else if (!panRegex.hasMatch(value)) {
      //   return 'Invalid UTR number';
      // }
    } else {
      return 'Please enter UTR number';
    }
  }

  String? deliveryDateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select expected delivery date';
    }
    return null;
  }
}

/**
  /// Validate email format
  static bool emailValidator(String email) {
    RegExp regExp = RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regExp.hasMatch(email);
  }

  /// Validate phone number format
  static bool phoneValidator(String contact) {
    RegExp regExp = RegExp(r'^[+]*[(]?[0-9]{1,4}[)]?[-\s./0-9]*$');
    return regExp.hasMatch(contact);
  }

  /// Validate password format
  static bool passwordValidator(String contact) {
    RegExp regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$0&*~]).{8,}$');
    return regExp.hasMatch(contact);
  }

  /// Check if a value is empty or null
  static bool isValidationEmpty(dynamic value) {
    String val = value.toString();
    return (val.isEmpty || val == "null" || val == "" || val == "NULL");
  }

**/

// Adharcard number
// 1. It should have 12 digits.
// 2. It should not start with 0 and 1.
// 3. It should not contain any alphabet and special characters.
// 4. It should have white space after every 4 digits.

// Examples:
// Input: str = “3675 9834 6012”
// Output: true

// CIN Number
// CIN is a 21 digits alpha-numeric code.
// 1. It starts with either alphabet letter U or L.
// 2. Next five characters are reserved for digits (0-9).
// 3. Next two places are occupied by alphabet letters(A-Z-a-z).
// 4. Next four places are taken by digits(0-9).
// 5. Next three characters are reserved for alphabet letters (A-Za-z).
// 6. Next six characters are digits(0-9).
// 7. It should not contain any special character or whitespaces.

// Examples:
// Input: str= ”U12345AB6784CDE123456”
// Output: True

// GST Number
// 1. It should be 15 characters long.
// 2. The first 2 characters should be a number.
// 3. The next 10 characters should be the PAN number of the taxpayer.
// 4. The 13th character (entity code) should be a number from 1-9 or an alphabet.
// 5. The 14th character should be Z.
// 6. The 15th character should be an alphabet or a number.

// Examples:
// Input: str = “06BZAHM6385P6Z2”;
// Output: true

// PAN Card number
// 1. It should be ten characters long.
// 2.The first five characters should be any upper case alphabets.
// 3.The next four-characters should be any number from 0 to 9.
// 4.The last(tenth) character should be any upper case alphabet.
// 5.It should not contain any white spaces.

// Examples:
// Input: str = “BNZAA2318J”
// Output: true
