import '../../../option.dart' as O;

final class OptionBuilder<A> {
  const OptionBuilder(this._option);

  final O.Option<A> _option;

  O.Option<A> build() => _option;

  OptionBuilder<B> map<B>(
    B Function(A) some,
  ) =>
      OptionBuilder(
        O.map(some)(_option),
      );

  B match<B>({
    required B onNone,
    required B Function(A) onSome,
  }) =>
      O.match(
        onNone: onNone,
        onSome: onSome,
      )(_option);
}

extension ToBuilderOptionExtension<A> on O.Option<A> {
  OptionBuilder<A> toOptionBuilder() => OptionBuilder(this);
}
