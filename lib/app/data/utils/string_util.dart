import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

extension StringUtils on String {
  // String parseAndFormatNumbers() {
  //   final RegExp regex = RegExp(r'\b\d+\b');
  //   return replaceAllMapped(regex, (match) {
  //     final original = match.group(0);
  //     final formatted = formatNumber(int.parse(original ?? ''));
  //     return formatted;
  //   });
  // }

  List<double> parseToDoubleList() {
    List<double> resultList = [];

    // Split the input string by comma and whitespace
    List<String> parts = split(RegExp(r'[,\s]+'));

    for (String part in parts) {
      try {
        double value = double.parse(part);
        resultList.add(value);
      } catch (e) {
        // Handle any parsing errors here if needed
      }
    }

    return resultList;
  }

  int compareVersion(String current) {
    List<int> existParts = replaceAll('+', '').split('.').map(int.parse).toList();
    List<int> currentParts = current.replaceAll('+', '').split('.').map(int.parse).toList();

    // Compare major version
    if (currentParts[0] > existParts[0]) {
      return 1; // current is greater
    } else if (currentParts[0] < existParts[0]) {
      return -1; // exist is greater
    }

    // If major versions are equal, compare minor version
    if (currentParts[1] > existParts[1]) {
      return 1; // current is greater
    } else if (currentParts[1] < existParts[1]) {
      return -1; // exist is greater
    }

    // If both major and minor versions are equal, compare patch version
    if (currentParts[2] > existParts[2]) {
      return 1; // current is greater
    } else if (currentParts[2] < existParts[2]) {
      return -1; // exist is greater
    }

    // Versions are equal
    return 0;
  }

  int parseTimeStringToMinutes() {
    List<String> timeParts = split(':');

    if (timeParts.length != 3) {
      throw const FormatException("Invalid time format");
    }

    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    int seconds = int.parse(timeParts[2]);

    int totalMinutes = (hours * 60) + minutes + (seconds / 60).round();

    return totalMinutes;
  }

  bool hasSequentialDigits(int limit) {
    final allowedSequences = List.generate(10 - limit + 1, (index) {
      return List.generate(limit, (i) => (index + i).toString()).join();
    });

    return allowedSequences.any((sequence) => contains(sequence));
  }

  bool hasConsecutive(int limit) {
    int count = 1;
    for (int i = 1; i < length; i++) {
      if (this[i] == this[i - 1]) {
        count++;
        if (count > limit) {
          return true;
        }
      } else {
        count = 1;
      }
    }
    return false;
  }

  bool isValidPhoneNumber() {
    String sanitizedNumber = replaceAll(RegExp(r'\D'), '');

    List<String> blockedNumbers = ['11111', '22222', '33333'];
    if (blockedNumbers.contains(sanitizedNumber)) {
      return false;
    }

    if (sanitizedNumber.contains(RegExp(r'(\d)\1{6,}'))) {
      return false;
    }

    if (sanitizedNumber == '123456789') {
      return false;
    }

    if (sanitizedNumber.length < 6) {
      return false;
    }

    return true;
  }

  String removeTokoPrefix() {
    final prefixes = ['Toko', 'tk', 'Tk', 'Tk.', 'TK', 'TK.'];
    for (final prefix in prefixes) {
      if (startsWith(prefix)) {
        return substring(prefix.length).trim();
      }
    }
    return this;
  }

  // String toWhatsappFormat({String prefix = '62'}) {
  //   final parsedNumber = replaceAll(Regex.nonDigits, '');
  //   if (parsedNumber.startsWith('0')) {
  //     return '$prefix${parsedNumber.substring(1)}';
  //   } else if (parsedNumber.startsWith('+62')) {
  //     return '$prefix${parsedNumber.substring(3)}';
  //   } else if (parsedNumber.startsWith('62')) {
  //     return parsedNumber;
  //   }
  //   return parsedNumber;
  // }

  String addPrefix(String prefix) {
    return '$prefix$this';
  }

  String addSuffix(String suffix) {
    return '$this$suffix';
  }

  double stringSimilarity(String keyword) {
    // Convert both strings to lowercase
    String current = toLowerCase();
    keyword = keyword.toLowerCase();

    // Calculate the length of the longer string
    int maxLength = current.length > keyword.length ? current.length : keyword.length;

    // Calculate the number of matching characters
    int numMatchingChars = 0;
    for (int i = 0; i < maxLength; i++) {
      if (i < current.length && i < keyword.length && this[i] == keyword[i]) {
        numMatchingChars++;
      }
    }

    // Calculate the similarity score
    double similarity = numMatchingChars / maxLength;

    // Return the similarity score
    return similarity;
  }

  String get snakeCaseToText {
    return split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
  }

  String get purePersonName {
    List<String> commonPrefixesAndSuffixes = [
      "Mr.",
      "Ms.",
      "Dr.",
      "Jr.",
      "Sr.",
      "Ph.D",
      "Tn.",
      "Ny.",
      "Prof.",
      "Hj.",
      "Ir.",
      "Bapak",
      "Ibu",
      "Mas",
      "Mbak",
      "Saudara",
      "Saudari"
    ];
    String pattern = "(${commonPrefixesAndSuffixes.join("|")})";
    String withoutTitle = replaceAll(RegExp(pattern), '');
    return withoutTitle.replaceAll(RegExp(r'^[^a-zA-Z ]*|[^a-zA-Z ]*$'), '');
  }

  // String get getNickname {
  //   List<String> names = purePersonName.trim().split(' ');
  //   String nickname = '';
  //   for (int i = 0; i < names.length; i++) {
  //     String name = names[i];
  //     if (i == 0) {
  //       if (abbreviatedNames.contains(name.toLowerCase())) {
  //         nickname += '${name[0]}. ';
  //       } else {
  //         nickname += '$name ';
  //       }
  //     } else {
  //       List<String> tmp = nickname.split(' ');
  //       if (tmp.length == 2 && tmp.first.length <= 2) {
  //         nickname += ' $name ';
  //       } else {
  //         nickname += ' ${name[0]}. ';
  //       }
  //     }
  //   }

  //   return nickname.trim();
  // }

  String? get raw {
    return trim().toLowerCase();
  }

  int levenshteinDistance(String other) {
    final int m = length;
    final int n = other.length;
    final List<List<int>> dp = List.generate(m + 1, (_) => [n + 1]);

    for (int i = 0; i <= m; i++) {
      for (int j = 0; j <= n; j++) {
        if (i == 0) {
          dp[i][j] = j;
        } else if (j == 0) {
          dp[i][j] = i;
        } else if (this[i - 1] == other[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] = math.min(dp[i - 1][j], math.min(dp[i][j - 1], dp[i - 1][j - 1])) + 1;
        }
      }
    }

    return dp[m][n];
  }

  String getWords([int n = 1]) {
    List<String> words = trim().split(" ");
    if (words.length < n) {
      return this;
    }
    return words.sublist(0, n).join(" ");
  }

  String get firstWord => split(" ").first;

  String get toMd5 {
    return md5.convert(utf8.encode(this)).toString();
  }

  // bool get isEmail {
  //   return Regex.email.hasMatch(this);
  // }

  // bool get isPhone {
  //   return Regex.phone.hasMatch(this);
  // }

  bool get isNotEmpty {
    return this.isNotEmpty;
  }

  // bool get isUrl {
  //   return Regex.url.hasMatch(this);
  // }

  // String toSlug({String separator = '-'}) {
  //   String slug = toLowerCase().trim();
  //   slug = slug.replaceAll(Regex.slug, separator);
  //   return slug;
  // }

  String toTitleCase() {
    String titleCase = '';
    bool nextTitleCase = true;

    for (int i = 0; i < length; i++) {
      String currentChar = this[i];
      String previousChar = i > 0 ? this[i - 1] : '';

      if (currentChar == ' ') {
        nextTitleCase = true;
      } else if (nextTitleCase || previousChar == '-') {
        currentChar = currentChar.toUpperCase();
        nextTitleCase = false;
      } else {
        currentChar = currentChar.toLowerCase();
      }

      titleCase += currentChar;
    }

    return titleCase;
  }

  String toCamelCase() {
    List<String> parts = split(RegExp(r'[\s_\-]+'));
    String camelCase = parts[0].toLowerCase();
    for (int i = 1; i < parts.length; i++) {
      camelCase += parts[i][0].toUpperCase() + parts[i].substring(1).toLowerCase();
    }
    return camelCase;
  }

  String fromCamelCase({String separator = '_'}) {
    String result = '';
    for (var i = 0; i < length; i++) {
      String char = this[i];
      if (char == char.toUpperCase() && char.toLowerCase() != char.toUpperCase()) {
        result += separator + char.toLowerCase();
      } else {
        result += char;
      }
    }
    return result;
  }

  String get toTitleString {
    final words = split(RegExp(r'[_\s]')).where((word) => word.isNotEmpty).toList();
    return words.map((word) {
      final firstLetter = word[0].toUpperCase();
      final restOfWord = word.substring(1).toLowerCase();
      return '$firstLetter$restOfWord';
    }).join(' ');
  }

  String get bracketsToCurlyBraces {
    return replaceAll('[', '{').replaceAll(']', '}');
  }

  // String get removeAllBrackets {
  //   return replaceAll(Regex.bracket, '');
  // }

  String get removeExtension {
    int dotIndex = lastIndexOf('.');
    if (dotIndex != -1) {
      return substring(0, dotIndex);
    } else {
      return this;
    }
  }

  // String get contentType {
  //   switch (getAttachmentType) {
  //     case AttachmentType.image:
  //       return "image/$getExtension";
  //     case AttachmentType.doc:
  //     case AttachmentType.excel:
  //     case AttachmentType.pdf:
  //       return "application/$getExtension";
  //     default:
  //       return getExtension;
  //   }
  // }

  // String get getExtension {
  //   int index = lastIndexOf(".");
  //   return index != -1 ? substring(index + 1) : "";
  // }

  // AttachmentType get getAttachmentType {
  //   switch (getExtension) {
  //     case 'pdf':
  //       return AttachmentType.pdf;
  //     case 'doc':
  //     case 'docx':
  //       return AttachmentType.doc;
  //     case 'xls':
  //     case 'xlsx':
  //       return AttachmentType.excel;
  //     case 'jpg':
  //     case 'jpeg':
  //     case 'png':
  //     case 'gif':
  //       return AttachmentType.image;
  //     default:
  //       return AttachmentType.other;
  //   }
  // }

  String get replaceSpacesInsideBrackets {
    RegExp regex = RegExp(r'([\[\({].*?[\]\)}])'); // match text inside parentheses, square brackets, or curly braces
    String replacedText = replaceAllMapped(regex, (match) {
      String? insideParentheses = match.group(1);
      String replacedInside = insideParentheses!.replaceAll(' ', '_');
      return '($replacedInside)';
    });
    return replacedText;
  }

  String truncate({int length = 20, String suffix = '...', bool truncateOnSpace = true}) {
    if (this.length <= length) {
      return this;
    } else {
      int index = -1;
      if (truncateOnSpace) {
        index = replaceSpacesInsideBrackets.lastIndexOf(" ", length);
      }
      if (index == -1) {
        return '${substring(0, length)}$suffix';
      } else {
        return '${substring(0, index)}$suffix';
      }
    }
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String pluralize({int count = 2}) {
    if (count == 1) {
      return this;
    }
    return "${this}s";
  }

  String get abbreviate {
    final words = split(" ");
    if (words.length <= 2) {
      return this;
    }
    return "${words.first} ${words.last[0]}.";
  }

  String initials({int max = 2}) {
    List<String> parts = split(" ");
    String result = "";
    int count = 0;
    for (String part in parts) {
      if (part.isNotEmpty && count < max) {
        result += part[0].toUpperCase();
        count++;
      }
    }
    return result;
  }

  String after(String search) {
    final index = indexOf(search);
    return index == -1 ? "" : substring(index + search.length);
  }

  String afterLast(String search) {
    final index = lastIndexOf(search);
    return index == -1 ? "" : substring(index + search.length);
  }

  String before(String search) {
    final index = indexOf(search);
    return index == -1 ? this : substring(0, index);
  }

  String beforeLast(String search) {
    final index = lastIndexOf(search);
    return index == -1 ? this : substring(0, index);
  }

  double toDouble() {
    if (int.tryParse(this) != null) {
      return int.tryParse(this)?.toDouble() ?? 0.0;
    } else {
      return double.tryParse(this) ?? 0.0;
    }
  }

  int toInt() {
    if (double.tryParse(this) != null) {
      return double.tryParse(this)?.toInt() ?? 0;
    } else {
      return int.tryParse(this) ?? 0;
    }
  }

  Color? get toColorNullable {
    try {
      return Color(int.parse('0xff${substring(1)}'));
    } catch (e) {
      return null;
    }
  }

  int? get toIntNullable {
    double? parsedValue = toDoubleNullable;
    if (parsedValue == null || parsedValue.truncate() != parsedValue) {
      return null;
    } else {
      return parsedValue.toInt();
    }
  }

  double? get toDoubleNullable {
    try {
      return double.parse(this);
    } catch (e) {
      return null;
    }
  }

  bool? get toBooleanNullable {
    if (toLowerCase() == 'true' || this == '1') {
      return true;
    } else if (toLowerCase() == 'false' || this == '0') {
      return false;
    }
    return null;
  }

  DateTime? get toDateTime {
    if (contains(RegExp(r'[:.]'))) {
      final now = DateTime.now();
      final parts = split(RegExp(r'[:.]'));
      return DateTime(
        now.year,
        now.month,
        now.day,
        int.tryParse(parts[0]) ?? 0,
        int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0,
        int.tryParse(parts.length > 2 ? parts[2] : '0') ?? 0,
      );
    }
    return DateTime.tryParse(this);
  }

  String censor({double censorPercentage = 0.5}) {
    if (contains("@")) {
      // Censor email address
      var parts = split("@");
      var emailUsername = parts[0];
      var emailDomain = parts[1];

      var censorLength = (emailUsername.length * censorPercentage).floor();

      var leftPart = emailUsername.substring(0, (emailUsername.length - censorLength) ~/ 2);
      var rightPart = emailUsername.substring((emailUsername.length + censorLength) ~/ 2);
      return "$leftPart${"*" * censorLength}$rightPart@$emailDomain";
    } else {
      // Censor phone number
      var censorLength = (length * censorPercentage).floor();
      var leftPart = substring(0, (length - censorLength) ~/ 2);
      var rightPart = substring((length + censorLength) ~/ 2);
      return leftPart + "*" * censorLength + rightPart;
    }
  }

  String generateAlias({int maxLength = 10}) {
    var nameParts = split(" ");
    var firstInitial = nameParts[0][0];
    var lastName = nameParts[nameParts.length - 1];

    var alias = "$firstInitial.$lastName";
    if (alias.length > maxLength) {
      alias = alias.substring(0, maxLength);
    }

    return alias;
  }

  String locale(String? locale) {
    String result = this;
    return result;
  }

  String get toPlainText {
    RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return replaceAll(exp, '');
  }

  Widget toHtmlText() {
    List<InlineSpan> textSpans = [];
    final regex = RegExp(r'<[^>]+>');
    final matches = regex.allMatches(this);

    int currentIndex = 0;
    for (Match match in matches) {
      String plainText = substring(currentIndex, match.start);
      if (plainText.isNotEmpty) {
        textSpans.add(TextSpan(text: plainText));
      }
      String tagText = match.group(0) ?? '';
      if (tagText.isNotEmpty) {
        if (tagText.contains('<strong>')) {
          textSpans.add(
              TextSpan(text: tagText.replaceAll('<strong>', ''), style: const TextStyle(fontWeight: FontWeight.bold)));
        } else if (tagText.contains('<em>')) {
          textSpans
              .add(TextSpan(text: tagText.replaceAll('<em>', ''), style: const TextStyle(fontStyle: FontStyle.italic)));
        }
      }
      currentIndex = match.end;
    }
    if (currentIndex < length) {
      textSpans.add(TextSpan(text: substring(currentIndex)));
    }

    return RichText(
      text: TextSpan(children: textSpans),
    );
  }
}

double getTextHeight(String text, TextStyle? style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 2, // Limit to at most 2 lines
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.height;
}
