import '../../../reader.dart' as R;

extension AskReaderExtension<ENV, A> on R.Reader<ENV, A> {
  R.Reader<ENV, ENV> ask() => R.ask();
}

extension AsksReaderExtension<ENV, A> on R.Reader<ENV, A> {
  R.Reader<ENV, ENV2> asks<ENV2>(
    ENV2 Function(ENV) f,
  ) =>
      R.asks(f);
}

extension FlatMapReaderExtension<ENV, A> on R.Reader<ENV, A> {
  R.Reader<ENV, B> flatMap<B>(
    R.Reader<ENV, B> Function(A) f,
  ) =>
      R.flatMap(f)(this);
}

extension LocalReaderExtension<ENV1, A> on R.Reader<ENV1, A> {
  R.Reader<ENV2, A> local<ENV2>(
    ENV1 Function(ENV2) f,
  ) =>
      R.local(f)(this);
}

extension MapReaderExtension<ENV, A> on R.Reader<ENV, A> {
  R.Reader<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      R.map(f)(this);
}
