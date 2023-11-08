import '../../../reader_stream.dart' as RS;
import '../../reader_io.dart' as RIO;

extension DoOnDataReaderReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnDataReader(
    RIO.ReaderIO<ENV, void> Function(A) f,
  ) =>
      RS.doOnDataReader(f)(this);
}
