import '../../../reader.dart' as R;
import '../../../reader_stream.dart' as RS;

extension FlatMapStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> flatMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      RS.flatMap(f)(this);

  RS.ReaderStream<ENV, B> reader_flatMap<B>(
    RS.ReaderStream<ENV, B> Function(Stream<A>) f,
  ) =>
      R.flatMap(f)(this);
}
