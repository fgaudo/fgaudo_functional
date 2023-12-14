import '../../../reader.dart' as R;
import '../../io.dart';
import 'reader_io.dart' as RIX;
import 'reader_stream.dart' as RSX;

final class Reader<ENV, A> {
  const Reader(this._f);

  final R.Reader<ENV, A> _f;

  Reader<ENV, B> flatMap<B>(
    R.Reader<ENV, B> Function(A) f,
  ) =>
      Reader(R.flatMap(f)(_f));

  Reader<ENV2, A> local<ENV2>(
    ENV Function(ENV2) f,
  ) =>
      Reader(R.local(f)(_f));

  Reader<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      Reader(R.map(f)(_f));
}

extension ToReaderStreamReaderExtension<ENV, A> on Reader<ENV, Stream<A>> {
  RSX.ReaderStream<ENV, A> toReaderStream() => RSX.ReaderStream(_f);
}

extension ToReaderIOReaderExtension<ENV, A> on Reader<ENV, IO<A>> {
  RIX.ReaderIO<ENV, A> toReaderIO() => RIX.ReaderIO(_f);
}

Reader<ENV, ENV> ask<ENV>() => Reader(R.ask());

Reader<ENV, ENV2> asks<ENV, ENV2>(
  ENV2 Function(ENV) f,
) =>
    Reader(R.asks(f));
