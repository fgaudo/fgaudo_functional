import '../../../reader.dart' as R;

extension MapReaderExtension<ENV, A> on R.Reader<ENV, A> {
  R.Reader<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      R.map(f)(this);
}
