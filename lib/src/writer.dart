import 'functionally.dart';

typedef Writer<W, A> = (A, Monoid<W>);

Writer<W, void> tell<W>(Monoid<W> out) => (null, out);

Writer<W, B> Function(Writer<W, A>) flatMap<W, A, B>(
  Writer<W, B> Function(A) f,
) =>
    (w) {
      final wb = f(w.$1);
      return (
        wb.$1,
        wb.$2.append(w.$2.value),
      );
    };

Writer<List<String>, void> log(
  String text,
) =>
    tell(
      MonoidList(
        [text],
      ),
    );
