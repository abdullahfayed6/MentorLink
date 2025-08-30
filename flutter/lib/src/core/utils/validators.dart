class Validators {
  static String? requiredField(String? v, {String fieldName = 'This field'}) {
    if (v == null || v.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  static final _emailReg = RegExp(r'^\S+@\S+\.\S+$');
  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    if (!_emailReg.hasMatch(v.trim())) return 'Enter a valid email';
    return null;
  }

  static final _phoneReg = RegExp(r'^\d{10,15}$');
  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Phone is required';
    if (!_phoneReg.hasMatch(v.trim()))
      return 'Enter a valid phone (10-15 digits)';
    return null;
  }

  static String? emailOrPhone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email or phone is required';
    final s = v.trim();
    if (s.contains('@')) {
      return email(s);
    } else {
      return phone(s);
    }
  }

  static final _strongPw = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$%^&*()_+\-={}\[\]|;:\"<>,.?/]).{8,}$',
  );
  static String? strongPassword(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (!_strongPw.hasMatch(v)) return 'Min 8 chars with number & special char';
    return null;
  }

  static String? confirmPassword(String? v, String pw) {
    if (v == null || v.isEmpty) return 'Confirm your password';
    if (v != pw) return 'Passwords do not match';
    return null;
  }

  static String? code(String? v, {int length = 5}) {
    if (v == null || v.isEmpty) return 'Code is required';
    if (v.length != length) return 'Enter $length-digit code';
    return null;
  }
}
