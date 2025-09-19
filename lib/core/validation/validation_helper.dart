class ValidatorHelper {
  static final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static String? validateEmailId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    } else if (!_emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? loginValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'please enter your password';
    } else if (password.length < 6 || password.length > 15) {
      return 'Oops! That password doesn’t look right.';
    }
    return null;
  }

  static String? textFieldValidation(String? data, String? label) {
    if (data == null || data.trim().isEmpty) {
      return "Please enter $label";
    } else if (data.startsWith(' ')) {
      return "$label cannot start with a space";
    }
    return null;
  }
}
