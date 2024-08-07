String? isEvalValid(eval) {
  // Define the combined regular expression pattern with named groups
  const pattern =
      r'''(?<comparison>(and|or|==|>=|<=|>|<))\s*|\s*(?<arithmetic>[+\-*\/%])\s*|\s*(?<numbers>\d+(\.\d+)?)\s*|\s*(?<variables>[a-zA-Z_][a-zA-Z0-9_]*)\b|\s*(?<brackets>[\(\)\{\}\[\]])\s*|\s*(?<function>\$[a-zA-Z_][a-zA-Z0-9_]*)\b''';

  // Create a RegExp object with the pattern and case insensitive flag
  final regExp = RegExp(pattern, caseSensitive: false);

  // Find all matches in the input string
  final matches = regExp.allMatches(eval);

  // Iterate over the matches and print the matched groups with their ranges

  int cursor = 0;
  List<MapEntry> errorRanges = [];
  for (final match in matches) {
    if (cursor != match.start) {
      errorRanges.add(MapEntry(cursor, match.start));
    }
    cursor = match.end;
    final comparison = match.namedGroup('comparison');
    final arithmetic = match.namedGroup('arithmetic');
    final numbers = match.namedGroup('numbers');
    final variables = match.namedGroup('variables');
    final functions = match.namedGroup('function');

    if (comparison != null) {
      print('Comparison: $comparison, Range: ${match.start} - ${match.end}');
    }
    if (arithmetic != null) {
      print('Arithmetic: $arithmetic, Range: ${match.start} - ${match.end}');
    }
    if (numbers != null) {
      print('Numbers: $numbers, Range: ${match.start} - ${match.end}');
    }
    if (variables != null) {
      print('Variables: $variables, Range: ${match.start} - ${match.end}');
    }
    if (functions != null) {
      print('Variables: $functions, Range: ${match.start} - ${match.end}');
    }
  }
  print(errorRanges.toList());
  return "";
}
