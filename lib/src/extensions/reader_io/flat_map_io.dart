import '../../../io.dart' as I;
import '../../../reader_io.dart' as RI;

extension FlatMapIOReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> flatMapIO<B>(
    I.IO<B> Function(A) f,
  ) =>
      RI.flatMapIO(f)(this);
}
