extension StringExtension on String {
  String shrink(value) {
    return length > value ? '${substring(0, value)}...' : this;
  }
}
