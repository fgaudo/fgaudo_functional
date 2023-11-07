import '../../../reader.dart' as R;

extension FlatMapReaderExtension<ENV, A> on R.Reader<ENV, A> {
  R.Reader<ENV, B> flatMap<B>(
    R.Reader<ENV, B> Function(A) f,
  ) =>
      R.flatMap(f)(this);
}
