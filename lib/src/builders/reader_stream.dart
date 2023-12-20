import '../../reader_stream.dart' as RS;
import 'reader.dart' as RR;

final class ReaderStreamBuilder<ENV, A> {
  const ReaderStreamBuilder(this._f);

  final RS.ReaderStream<ENV, A> _f;

  RS.ReaderStream<ENV, A> build() => _f;

  ReaderStreamBuilder<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.map(f)(_f));

  ReaderStreamBuilder<ENV2, A> local<ENV2>(
    ENV Function(ENV2) f,
  ) =>
      ReaderStreamBuilder(RS.local(f)(_f));

  ReaderStreamBuilder<ENV, B> transform<B>(
    RS.ReaderStream<ENV, B> Function(RS.ReaderStream<ENV, A>) f,
  ) =>
      ReaderStreamBuilder(f(this._f));

  ReaderStreamBuilder<ENV, B> mapStream<B>(
    Stream<B> Function(Stream<A>) f,
  ) =>
      ReaderStreamBuilder(RS.mapStream(f)(this._f));

  RR.ReaderBuilder<ENV, Stream<A>> toReader() => RR.ReaderBuilder(_f);
}

extension ToBuilderReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  ReaderStreamBuilder<ENV, A> toReaderStreamBuilder() =>
      ReaderStreamBuilder(this);
}
