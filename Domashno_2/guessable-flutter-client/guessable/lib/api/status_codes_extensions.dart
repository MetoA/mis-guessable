extension IntStatusCategories on int {
  bool get isInformational => this >= 100 && this < 200;

  bool get isSuccessful => this >= 200 && this < 300;

  bool get isRedirection => this >= 300 && this < 400;

  bool get isError => this >= 400 && this < 500;

  bool get isServerError => this >= 500 && this < 600;
}