import 'package:fgaudo_functional/extensions/reader_io/flat_map.dart';
import 'package:fgaudo_functional/extensions/reader_io/map.dart';
import 'package:fgaudo_functional/reader_io.dart';
import 'package:test/test.dart';

void main() {
  test('.map() transforms correctly', () {
    var run = false;

    final test1 = ((int env) {
      run = true;
      return () => (env, 3);
    }).map(
      (value) => value.$1 * value.$2,
    )(2);

    expect(run, equals(true), reason: 'Not eager');

    final test2 = test1();

    expect(test2, equals(6), reason: 'Wrong value');
  });

  test('.flatMap() transforms correctly', () {
    var run = false;

    final test1 = ((int env) {
      run = true;
      return () => (3, env);
    }).flatMap(
      (value) => (env) => () => value.$1 * value.$2 * env,
    )(2);

    expect(run, equals(true), reason: 'Not eager');

    final test2 = test1();

    expect(test2, equals(12), reason: 'Wrong value');
  });

  test('Do() is just a constructor', () {
    Do<dynamic>(); // there's not much to test here..
  });
}
