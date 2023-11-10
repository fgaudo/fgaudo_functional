import 'package:fgaudo_functional/extensions/reader_io/asks.dart';
import 'package:fgaudo_functional/extensions/reader_io/flat_map.dart';
import 'package:fgaudo_functional/extensions/reader_io/flat_map_io.dart';
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

    expect(run, true, reason: 'Not eager');

    final test2 = test1();

    expect(test2, 6, reason: 'Wrong value');
  });

  test('.flatMap() transforms correctly', () {
    var run1 = false;
    var run2 = false;

    final test1 = ((int env) {
      run1 = true;
      return () {
        run2 = true;
        return (3, env);
      };
    }).flatMap(
      (value) => (env) => () => value.$1 * value.$2 * env,
    )(2);

    expect(run1, true, reason: 'Not eager');
    expect(run2, false, reason: 'Not lazy');

    final test2 = test1();

    expect(test2, 12, reason: 'Wrong value');
  });

  test('.flatMapIO() transforms correctly', () {
    var run1 = false;
    var run2 = false;

    final test1 = ((int env) {
      run1 = true;
      return () {
        run2 = true;
        return (3, env);
      };
    }).flatMapIO(
      (value) => () => value.$1 * value.$2,
    )(2);

    expect(run1, true, reason: 'Not eager');
    expect(run2, false, reason: 'Not lazy');

    final test2 = test1();

    expect(test2, 6, reason: 'Wrong value');
  });

  test('.asks() behaves correctly', () {
    var run1 = false;
    var run2 = false;

    final test1 = ((int env) {
      run1 = true;
      return () => (3, env);
    }).asks(
      (value) {
        run2 = true;
        return value * 3;
      },
    )(2);

    expect(run1, false, reason: 'Should not run');
    expect(run2, true, reason: 'Not eager');

    final test2 = test1();

    expect(run1, false, reason: 'Should not run');
    expect(test2, 6, reason: 'Wrong value');
  });

  test('Do() is just a constructor', () {
    Do<dynamic>(); // there's not much to test here..
  });
}
