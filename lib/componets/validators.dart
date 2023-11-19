class CustomValidators {
  static get standardValidator => (value) {
        if (value == null || value.trim().isEmpty) {
          return "This field cannot be empty.";
        }
        return null;
      };

  static get emailValidator => (value) {
        if (value == null || !value.contains('@') || value.trim().isEmpty) {
          return "Please enter a valid email.";
        }
        return null;
      };

  static get passwordValidator => (value) {
        if (value == null || value.trim().isEmpty) {
          return "This field cannot be empty.";
        }
        if (value.toString().length < 6) {
          return "Password must be atleast 6 characters long.";
        }
        return null;
      };

  static get numberValidator => (value) {
        if (value == null ||
            !RegExp(r'^[0-9]+$').hasMatch(value) ||
            value.trim().isEmpty) {
          return "Only numbers are allowed.";
        }
        return null;
      };

  static get doubleValidator => (value) {
        if (value == null ||
            !RegExp(r'^([+-]?(?=\.\d|\d)(?:\d+)?(?:\.?\d*))(?:[Ee]([+-]?\d+))?$')
                .hasMatch(value) ||
            value.trim().isEmpty) {
          return "Only numbers and decimal numbers allowed.";
        }
        return null;
      };
}
