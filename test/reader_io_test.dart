/*
import 'package:functionally/extensions/reader_io/asks.dart';
import 'package:functionally/extensions/reader_io/bracket.dart';
import 'package:functionally/extensions/reader_io/flat_map.dart';
import 'package:functionally/extensions/reader_io/flat_map_io.dart';
import 'package:functionally/extensions/reader_io/map.dart';
import 'package:test/test.dart';

void main() {
  test('.map() transforms correctly', () {
    var run = false;
    final test1 = ((int env) {
      run = true;
      return () => (env, 3);
    }).map(
      (value) => value.$1 * value.$2 * 2,
    )(2);

    expect(run, true, reason: 'Not eager');

    final test2 = test1();

    expect(test2, 12, reason: 'Wrong value');
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
      (value) => (int env) => () => value.$1 * value.$2 * env * 2,
    )(2);

    expect(run1, true, reason: 'Not eager');
    expect(run2, false, reason: 'Not lazy');

    final test2 = test1();

    expect(test2, 24, reason: 'Wrong value');
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
      (value) => () => value.$1 * value.$2 * 2,
    )(2);

    expect(run1, true, reason: 'Not eager');
    expect(run2, false, reason: 'Not lazy');

    final test2 = test1();

    expect(test2, 12, reason: 'Wrong value');
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

  group('.bracket()', () {
    test('handles the same resource', () {
      List<int>? obj;
      List<int>? param1;
      List<int>? param2;

      ((int env) => () {
            final list = [3, 4];
            obj ??= list;
            return list;
          }).bracket(
        use: (value) => (r) {
          param1 = value;
          return () => 0;
        },
        release: (value) => (r) => () {
              param2 = value;
            },
      )(2)();

      expect(
        obj == param1 && obj == param2,
        true,
        reason: 'Used resource is not the same object as the released one',
      );
    });

    test('Uses and releases the resource in the correct order', () {
      var count = 0;

      int? run1;
      int? run2;

      ((int env) => () => [3, env]).bracket(
        use: (value) => (r) => () {
              run1 = count++;
            },
        release: (value) => (r) => () {
              run2 = count++;
            },
      )(2)();

      expect(run1, isNotNull, reason: 'Code never run');
      expect(run2, isNotNull, reason: 'Code never run');

      expect(
        [run1!, run2!],
        equals([0, 1]),
        reason:
            'Either used or released more than once or used and released in the wrong order',
      );
    });

    test('Evaluates reader eagerly', () {
      var run1 = false;

      ((int env) {
        run1 = true;
        return () => [3, env];
      }).bracket(
        use: (value) => (r) => () => value[0] * value[1] * 2,
        release: (value) => (r) => () {},
      )(2);

      expect(run1, true, reason: 'Not eager');
    });

    test('Returns correct value', () {
      final test = ((int env) => () => [3, env]).bracket(
        use: (value) => (r) => () => value[0] * value[1] * 2,
        release: (value) => (r) => () {},
      )(2)();

      expect(test, 12, reason: 'Wrong value');
    });
  });
}
*/
