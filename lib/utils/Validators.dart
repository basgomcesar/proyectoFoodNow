bool isValidEmail(String email) {
  return email.contains('@');
}

bool isValidPassword(String password) {
  return password.length > 6;
}