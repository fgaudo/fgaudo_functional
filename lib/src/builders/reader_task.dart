import '../../reader_stream.dart' as RS;
import '../../reader_task.dart' as RT;

import '../../task.dart' as T;
import 'reader.dart' as RX;
import 'reader_stream.dart' as RSX;

final class ReaderTaskBuilder<ENV, A> {
  const ReaderTaskBuilder(this._f);

  final RT.ReaderTask<ENV, A> _f;

  RT.ReaderTask<ENV, A> build() => _f;

  ReaderTaskBuilder<ENV, B> transform<B>(
    RT.ReaderTask<ENV, B> Function(RT.ReaderTask<ENV, A>) f,
  ) =>
      ReaderTaskBuilder(f(this._f));

  RX.ReaderBuilder<ENV, T.Task<A>> toReader() => RX.ReaderBuilder(_f);

  RSX.ReaderStreamBuilder<ENV, A> toReaderStream() =>
      RSX.ReaderStreamBuilder(RS.fromReaderTask(_f));

  ReaderTaskBuilder<ENV2, A> local<ENV2>(
    ENV Function(ENV2) f,
  ) =>
      ReaderTaskBuilder(RT.local(f)(_f));
}

extension ToBuilderReaderTaskExtension<ENV, A> on RT.ReaderTask<ENV, A> {
  ReaderTaskBuilder<ENV, A> toReaderTaskBuilder() => ReaderTaskBuilder(this);
}
