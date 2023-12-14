import '../../reader_stream.dart' as RS;
import '../../reader_task.dart' as RT;
import '../../task.dart' as T;
import 'reader.dart' as RX;
import 'reader_stream.dart' as RSX;

final class ReaderTask<ENV, A> {
  const ReaderTask(this._f);

  final RT.ReaderTask<ENV, A> _f;

  ReaderTask<ENV, ENV> ask() => ReaderTask(RT.ask());

  ReaderTask<ENV, ENV2> asks<ENV2>(
    ENV2 Function(ENV) f,
  ) =>
      ReaderTask(RT.asks(f));

  ReaderTask<ENV, B> bracket<B>({
    required RT.ReaderTask<ENV, void> Function(A) release,
    required RT.ReaderTask<ENV, B> Function(A) use,
  }) =>
      ReaderTask(
        RT.bracket(
          use: use,
          release: release,
        )(_f),
      );

  ReaderTask<ENV, B> flatMapTask<B>(
    T.Task<B> Function(A) f,
  ) =>
      ReaderTask(RT.flatMapTask(f)(_f));

  ReaderTask<ENV, B> flatMap<B>(
    RT.ReaderTask<ENV, B> Function(A) f,
  ) =>
      ReaderTask(RT.flatMap(f)(_f));

  ReaderTask<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      ReaderTask(RT.map(f)(_f));

  RX.Reader<ENV, T.Task<A>> toReader() => RX.Reader(_f);

  RSX.ReaderStream<ENV, A> toReaderStream() =>
      RSX.ReaderStream(RS.fromReaderTask(_f));

  ReaderTask<ENV2, A> local<ENV2>(
    ENV Function(ENV2) f,
  ) =>
      ReaderTask(RT.local(f)(_f));
}
