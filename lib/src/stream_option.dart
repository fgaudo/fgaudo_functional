import 'option.dart' as O;

typedef StreamOption<A> = Stream<O.Option<A>>;

Stream<B> Function(
  StreamOption<A>,
) match<A, B>({
  required B onNone,
  required B Function(A) onSome,
}) =>
    (option$) => option$.map(
          O.match(
            onNone: onNone,
            onSome: onSome,
          ),
        );

StreamOption<B> Function(
  StreamOption<A>,
) map<A, B>(
  B Function(A) onSome,
) =>
    (option$) => option$.map(
          O.map(onSome),
        );
