

dynamic valueOrNull(dynamic value) {
  return value is! bool ? value : null;
}