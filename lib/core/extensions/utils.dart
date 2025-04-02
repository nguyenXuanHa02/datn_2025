bool notEmpty(dynamic value) {
  if (value == null) return false;
  if (value.toString().isEmpty) return false;
  return true;
}
