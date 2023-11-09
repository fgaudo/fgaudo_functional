import 'dart:async';

import '../../../reader_stream.dart' as RS;

extension TransformStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> transformStream<B>(
    Stream<B> Function(Stream<A>) f,
  ) =>
      RS.transformStream(f)(this);
}
