import '../../../reader.dart' as R;
import '../../io.dart';
import 'reader_io.dart' as RIX;
import 'reader_stream.dart' as RSX;

final class ReaderBuilder<ENV, A> {
  const ReaderBuilder(this._f);

  final R.Reader<ENV, A> _f;

  R.Reader<ENV, A> build() => _f;

  ReaderBuilder<ENV, B> flatMap<B>(
    R.Reader<ENV, B> Function(A) f,
  ) =>
      ReaderBuilder(R.flatMap(f)(_f));

  ReaderBuilder<ENV2, A> local<ENV2>(
    ENV Function(ENV2) f,
  ) =>
      ReaderBuilder(R.local(f)(_f));

  ReaderBuilder<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      ReaderBuilder(R.map(f)(_f));
}

extension ToReaderStreamReaderExtension<ENV, A>
    on ReaderBuilder<ENV, Stream<A>> {
  RSX.ReaderStreamBuilder<ENV, A> toReaderStream() =>
      RSX.ReaderStreamBuilder(_f);
}

extension ToReaderIOReaderExtension<ENV, A> on ReaderBuilder<ENV, IO<A>> {
  RIX.ReaderIOBuilder<ENV, A> toReaderIO() => RIX.ReaderIOBuilder(_f);
}

ReaderBuilder<ENV, ENV> ask<ENV>() => ReaderBuilder(R.ask());

ReaderBuilder<ENV, ENV2> asks<ENV, ENV2>(
  ENV2 Function(ENV) f,
) =>
    ReaderBuilder(R.asks(f));

ReaderBuilder<ENV, Iterable<A>> sequenceArray<ENV, A>(
  Iterable<R.Reader<ENV, A>> arr,
) =>
    ReaderBuilder(R.sequenceArray(arr));

extension ToReaderBuilderReaderExtension<ENV, A> on R.Reader<ENV, A> {
  ReaderBuilder<ENV, A> toReaderBuilder() => ReaderBuilder(this);
}
