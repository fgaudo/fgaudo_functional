import '../../../reader_stream.dart' as RS;
import '../../reader_io.dart' as RIO;

extension DoOnDataReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnData(
    RIO.ReaderIO<ENV, void> Function(A) f,
  ) =>
      RS.doOnData(f)(this);
}
