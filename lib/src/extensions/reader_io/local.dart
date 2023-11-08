import '../../../reader_io.dart' as RI;

extension LocalReaderIOExtension<ENV1, A> on RI.ReaderIO<ENV1, A> {
  RI.ReaderIO<ENV2, A> local<ENV2>(
    ENV1 Function(ENV2) f,
  ) =>
      RI.local(f)(this);
}
