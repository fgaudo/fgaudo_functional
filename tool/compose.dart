import 'dart:io';

const int N = 50;

void generatePipe(String path) {
  final s = StringBuffer();

  for (var i = 2; i < N; ++i) {
    s.write('A${i + 1} pipe${i + 1}<');

    for (var j = 1; j <= i + 1; ++j) {
      s.write('A$j');

      if (j != (i + 1)) {
        s.write(',');
      }
    }

    s.write('>(A1 a1, ');

    for (var j = 1; j <= i; ++j) {
      s.write('A${j + 1} Function(A$j) f$j,');
    }

    s.write(') => ');

    for (var j = i; j >= 1; --j) {
      s.write('f$j(');
    }

    s.write('a1');

    for (var j = 1; j <= i; ++j) {
      if (j != 1) {
        s.write(',');
      }
      s.write(')');
    }

    s.write(';\n\n');
  }

  File(path).writeAsStringSync(s.toString());
}

void generateFlow(String path) {
  final s = StringBuffer();

  for (var i = 2; i < N; ++i) {
    s.write('A${i + 1} Function(A1) flow$i<');

    for (var j = 1; j <= i + 1; ++j) {
      s.write('A$j');

      if (j != (i + 1)) {
        s.write(',');
      }
    }

    s.write('>(');

    for (var j = 1; j <= i; ++j) {
      s.write('A${j + 1} Function(A$j) f$j,');
    }

    s.write(') => (a1) => ');

    for (var j = i; j >= 1; --j) {
      s.write('f$j(');
    }

    s.write('a1');

    for (var j = 1; j <= i; ++j) {
      if (j != 1) {
        s.write(',');
      }
      s.write(')');
    }

    s.write(';\n\n');
  }

  File(path).writeAsStringSync(s.toString());
}

void main() {
  generatePipe('lib/src/pipe.dart');
  generateFlow('lib/src/flow.dart');
}
