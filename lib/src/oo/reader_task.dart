import '../../reader_stream.dart' as RS;
import '../../reader_task.dart' as RT;
import '../../task.dart' as T;
import 'reader.dart' as RX;
import 'reader_stream.dart' as RSX;

final class ReaderTaskBuilder<ENV, A> {
  const ReaderTaskBuilder(this._f);

  final RT.ReaderTask<ENV, A> _f;

  RT.ReaderTask<ENV, A> build() => _f;

  ReaderTaskBuilder<ENV, B> bracket<B>({
    required RT.ReaderTask<ENV, void> Function(A) release,
    required RT.ReaderTask<ENV, B> Function(A) use,
  }) =>
      ReaderTaskBuilder(
        RT.bracket(
          use: use,
          release: release,
        )(_f),
      );

  ReaderTaskBuilder<ENV, B> flatMapTask<B>(
    T.Task<B> Function(A) f,
  ) =>
      ReaderTaskBuilder(RT.flatMapTask(f)(_f));

  ReaderTaskBuilder<ENV, B> flatMap<B>(
    RT.ReaderTask<ENV, B> Function(A) f,
  ) =>
      ReaderTaskBuilder(RT.flatMap(f)(_f));

  ReaderTaskBuilder<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      ReaderTaskBuilder(RT.map(f)(_f));

  RX.ReaderBuilder<ENV, T.Task<A>> toReader() => RX.ReaderBuilder(_f);

  RSX.ReaderStreamBuilder<ENV, A> toReaderStream() =>
      RSX.ReaderStreamBuilder(RS.fromReaderTask(_f));

  ReaderTaskBuilder<ENV2, A> local<ENV2>(
    ENV Function(ENV2) f,
  ) =>
      ReaderTaskBuilder(RT.local(f)(_f));
}

ReaderTaskBuilder<ENV, ENV> ask<ENV>() => ReaderTaskBuilder(RT.ask());

ReaderTaskBuilder<ENV, ENV2> asks<ENV, ENV2>(
  ENV2 Function(ENV) f,
) =>
    ReaderTaskBuilder(RT.asks(f));

ReaderTaskBuilder<ENV, Iterable<A>> sequenceArray<ENV, A>(
  Iterable<RT.ReaderTask<ENV, A>> arr,
) =>
    ReaderTaskBuilder(RT.sequenceArray(arr));

extension ToReaderTaskBuilderReaderExtension<ENV, A> on RT.ReaderTask<ENV, A> {
  ReaderTaskBuilder<ENV, A> toReaderTaskBuilder() => ReaderTaskBuilder(this);
}
