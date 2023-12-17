import '../option.dart';

final class NonNegative {
  const NonNegative._(this.value);

  final int value;
}

Option<NonNegative> fromInt(int number) =>
    number >= 0 ? Some(NonNegative._(number)) : None();
