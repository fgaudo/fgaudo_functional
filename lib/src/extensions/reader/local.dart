import '../../../reader.dart' as R;

extension LocalReaderExtension<ENV1, A> on R.Reader<ENV1, A> {
  R.Reader<ENV2, A> local<ENV2>(
    ENV1 Function(ENV2) f,
  ) =>
      R.local(f)(this);
}
