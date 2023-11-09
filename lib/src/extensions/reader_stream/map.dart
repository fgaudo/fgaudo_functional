import '../../../reader.dart' as R;
import '../../../reader_stream.dart' as RS;

extension MapReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      RS.map(f)(this);

  RS.ReaderStream<ENV, B> reader_map<B>(
    Stream<B> Function(Stream<A>) f,
  ) =>
      R.map(f)(this);
}
