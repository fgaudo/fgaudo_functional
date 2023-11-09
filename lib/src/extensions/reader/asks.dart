import '../../../reader.dart' as R;

extension AsksReaderExtension<ENV, A> on R.Reader<ENV, A> {
  R.Reader<ENV, ENV2> asks<ENV2>(
    R.Reader<ENV, ENV2> f,
  ) =>
      R.asks(f);
}
