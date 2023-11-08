import '../../../io.dart' as I;
import '../../../reader_stream.dart' as RS;

extension DoOnDataReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnData(
    I.IO<void> Function(A) f,
  ) =>
      RS.doOnData(f)(this);
}
