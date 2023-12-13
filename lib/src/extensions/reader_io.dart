import '../../io.dart' as I;
import '../../io.dart';
import '../../reader.dart' as R;
import '../../reader_io.dart' as RI;
import '../../reader_stream.dart' as RS;
import '../../reader_task.dart' as RT;

extension AskReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, ENV> ask() => RI.ask();
}

extension AsksReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, ENV2> asks<ENV2>(
    ENV2 Function(ENV) f,
  ) =>
      RI.asks(f);
}

extension BracketReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> bracket<B>({
    required RI.ReaderIO<ENV, void> Function(A) release,
    required RI.ReaderIO<ENV, B> Function(A) use,
  }) =>
      RI.bracket(
        use: use,
        release: release,
      )(this);
}

extension FlatMapIOReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> flatMapIO<B>(
    I.IO<B> Function(A) f,
  ) =>
      RI.flatMapIO(f)(this);
}

extension FlatMapReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> flatMap<B>(
    RI.ReaderIO<ENV, B> Function(A) f,
  ) =>
      RI.flatMap(f)(this);
}

extension MapReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      RI.map(f)(this);
}

extension ToReaderReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  R.Reader<ENV, IO<A>> toReader() => RI.toReader(this);
}

extension ToReaderStreamReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RS.ReaderStream<ENV, A> toReaderStream() => RS.fromReaderIO(this);
}

extension ToReaderTaskReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RT.ReaderTask<ENV, A> toReaderTask() => RT.fromReaderIO(this);
}

extension LocalReaderIOExtension<ENV1, A> on RI.ReaderIO<ENV1, A> {
  RI.ReaderIO<ENV2, A> local<ENV2>(
    ENV1 Function(ENV2) f,
  ) =>
      RI.local(f)(this);
}

extension ApFirstReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, A> apFirst<B>(
    RI.ReaderIO<ENV, B> second,
  ) =>
      RI.apFirst(second)(this);
}

extension ApSecondReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> apSecond<B>(
    RI.ReaderIO<ENV, B> second,
  ) =>
      RI.apSecond(second)(this);
}
