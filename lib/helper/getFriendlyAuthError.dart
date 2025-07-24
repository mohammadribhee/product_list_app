String getFriendlyAuthError(String error) {
  if (error.contains('invalid-credential')) {
    return 'The email or password is incorrect. Please try again.';
  } else if (error.contains('user-not-found')) {
    return 'No account found for this email.';
  } else if (error.contains('wrong-password')) {
    return 'Incorrect password. Please try again.';
  } else if (error.contains('network-request-failed')) {
    return 'Network error. Please check your internet connection.';
  } else {
    return 'An unexpected error occurred. Please try again.';
  }
}
