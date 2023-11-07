import '../../../reader_io.dart' as RI;

extension MapReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      RI.map(f)(this);
}
