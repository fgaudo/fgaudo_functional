import '../../io.dart' as I;
import '../../io.dart';
import '../../reader_io.dart' as RI;
import '../../reader_stream.dart' as RS;
import '../../reader_task.dart' as RT;
import 'reader.dart' as RX;
import 'reader_stream.dart' as RSX;
import 'reader_task.dart' as RTX;

final class ReaderIOBuilder<ENV, A> {
  const ReaderIOBuilder(this._f);

  final RI.ReaderIO<ENV, A> _f;

  static ReaderIOBuilder<ENV, ENV> ask<ENV>() => ReaderIOBuilder(RI.ask());

  static ReaderIOBuilder<ENV, ENV2> asks<ENV, ENV2>(
    ENV2 Function(ENV) f,
  ) =>
      ReaderIOBuilder(RI.asks(f));

  static ReaderIOBuilder<ENV, void> make<ENV>() =>
      ReaderIOBuilder((_) => () {});

  static ReaderIOBuilder<ENV, A> of<ENV, A>(A a) =>
      ReaderIOBuilder((_) => () => a);

  static ReaderIOBuilder<ENV, void> sequenceArray<ENV, A>(
    Iterable<RI.ReaderIO<ENV, A>> arr,
  ) =>
      ReaderIOBuilder(RI.sequenceArray(arr));

  RI.ReaderIO<ENV, A> build() => _f;

  ReaderIOBuilder<ENV, B> bracket<B>({
    required RI.ReaderIO<ENV, void> Function(A) release,
    required RI.ReaderIO<ENV, B> Function(A) use,
  }) =>
      ReaderIOBuilder(
        RI.bracket(
          use: use,
          release: release,
        )(_f),
      );

  ReaderIOBuilder<ENV, B> flatMapIO<B>(
    I.IO<B> Function(A) f,
  ) =>
      ReaderIOBuilder(RI.flatMapIO(f)(_f));

  ReaderIOBuilder<ENV, B> flatMap<B>(
    RI.ReaderIO<ENV, B> Function(A) f,
  ) =>
      ReaderIOBuilder(RI.flatMap(f)(_f));

  ReaderIOBuilder<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      ReaderIOBuilder(RI.map(f)(_f));

  RX.ReaderBuilder<ENV, IO<A>> toReader() => RX.ReaderBuilder(_f);

  RSX.ReaderStreamBuilder<ENV, A> toReaderStream() =>
      RSX.ReaderStreamBuilder(RS.fromReaderIO(_f));

  RTX.ReaderTaskBuilder<ENV, A> toReaderTask() =>
      RTX.ReaderTaskBuilder(RT.fromReaderIO(_f));

  ReaderIOBuilder<ENV2, A> local<ENV2>(
    ENV Function(ENV2) f,
  ) =>
      ReaderIOBuilder(RI.local(f)(_f));

  ReaderIOBuilder<ENV, A> apFirst<B>(
    RI.ReaderIO<ENV, B> second,
  ) =>
      ReaderIOBuilder(RI.apFirst(second)(_f));

  ReaderIOBuilder<ENV, B> apSecond<B>(
    RI.ReaderIO<ENV, B> second,
  ) =>
      ReaderIOBuilder(RI.apSecond(second)(_f));
}

extension ToReaderIOBuilderReaderExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  ReaderIOBuilder<ENV, A> toReaderIOBuilder() => ReaderIOBuilder(this);
}
