import '../../io.dart' as I;
import '../../io.dart';
import '../../reader_io.dart' as RI;
import '../../reader_stream.dart' as RS;
import '../../reader_task.dart' as RT;
import 'reader.dart' as RX;
import 'reader_stream.dart' as RSX;
import 'reader_task.dart' as RTX;

final class ReaderIO<ENV, A> {
  const ReaderIO(this._f);

  final RI.ReaderIO<ENV, A> _f;

  ReaderIO<ENV, ENV> ask() => ReaderIO(RI.ask());

  ReaderIO<ENV, ENV2> asks<ENV2>(
    ENV2 Function(ENV) f,
  ) =>
      ReaderIO(RI.asks(f));

  ReaderIO<ENV, B> bracket<B>({
    required RI.ReaderIO<ENV, void> Function(A) release,
    required RI.ReaderIO<ENV, B> Function(A) use,
  }) =>
      ReaderIO(
        RI.bracket(
          use: use,
          release: release,
        )(_f),
      );

  ReaderIO<ENV, B> flatMapIO<B>(
    I.IO<B> Function(A) f,
  ) =>
      ReaderIO(RI.flatMapIO(f)(_f));

  ReaderIO<ENV, B> flatMap<B>(
    RI.ReaderIO<ENV, B> Function(A) f,
  ) =>
      ReaderIO(RI.flatMap(f)(_f));

  ReaderIO<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      ReaderIO(RI.map(f)(_f));

  RX.Reader<ENV, IO<A>> toReader() => RX.Reader(_f);

  RSX.ReaderStream<ENV, A> toReaderStream() =>
      RSX.ReaderStream(RS.fromReaderIO(_f));

  RTX.ReaderTask<ENV, A> toReaderTask() => RTX.ReaderTask(RT.fromReaderIO(_f));

  ReaderIO<ENV2, A> local<ENV2>(
    ENV Function(ENV2) f,
  ) =>
      ReaderIO(RI.local(f)(_f));

  ReaderIO<ENV, A> apFirst<B>(
    RI.ReaderIO<ENV, B> second,
  ) =>
      ReaderIO(RI.apFirst(second)(_f));

  ReaderIO<ENV, B> apSecond<B>(
    RI.ReaderIO<ENV, B> second,
  ) =>
      ReaderIO(RI.apSecond(second)(_f));
}
