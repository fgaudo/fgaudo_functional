import '../../../reader_stream.dart' as RS;

extension ExhaustMapStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> exhaustMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      RS.exhaustMap(f)(this);
}
