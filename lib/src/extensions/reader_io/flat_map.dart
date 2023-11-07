import '../../../reader_io.dart' as RI;

extension FlatMapReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> flatMap<B>(
    RI.ReaderIO<ENV, B> Function(A) f,
  ) =>
      RI.flatMap(f)(this);
}
