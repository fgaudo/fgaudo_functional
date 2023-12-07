import '../../reader.dart' as R;
import '../../reader_stream.dart' as RS;
import '../../reader_task.dart' as RT;
import '../../task.dart' as T;

extension AskReaderTaskExtension<ENV, A> on RT.ReaderTask<ENV, A> {
  RT.ReaderTask<ENV, ENV> ask() => RT.ask();
}

extension AsksReaderTaskExtension<ENV, A> on RT.ReaderTask<ENV, A> {
  RT.ReaderTask<ENV, ENV2> asks<ENV2>(
    ENV2 Function(ENV) f,
  ) =>
      RT.asks(f);
}

extension BracketReaderTaskExtension<ENV, A> on RT.ReaderTask<ENV, A> {
  RT.ReaderTask<ENV, B> bracket<B>({
    required RT.ReaderTask<ENV, void> Function(A) release,
    required RT.ReaderTask<ENV, B> Function(A) use,
  }) =>
      RT.bracket(
        use: use,
        release: release,
      )(this);
}

extension FlatMapIOReaderTaskExtension<ENV, A> on RT.ReaderTask<ENV, A> {
  RT.ReaderTask<ENV, B> flatMapTask<B>(
    T.Task<B> Function(A) f,
  ) =>
      RT.flatMapTask(f)(this);
}

extension FlatMapReaderTaskExtension<ENV, A> on RT.ReaderTask<ENV, A> {
  RT.ReaderTask<ENV, B> flatMap<B>(
    RT.ReaderTask<ENV, B> Function(A) f,
  ) =>
      RT.flatMap(f)(this);
}

extension MapReaderTaskExtension<ENV, A> on RT.ReaderTask<ENV, A> {
  RT.ReaderTask<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      RT.map(f)(this);
}

extension ToReaderReaderTaskExtension<ENV, A> on RT.ReaderTask<ENV, A> {
  R.Reader<ENV, T.Task<A>> toReader() => RT.toReader(this);
}

extension ToReaderStreamReaderTaskExtension<ENV, A> on RT.ReaderTask<ENV, A> {
  RS.ReaderStream<ENV, A> toReaderStream() => RS.fromReaderTask(this);
}

extension LocalReaderTaskExtension<ENV1, A> on RT.ReaderTask<ENV1, A> {
  RT.ReaderTask<ENV2, A> local<ENV2>(
    ENV1 Function(ENV2) f,
  ) =>
      RT.local(f)(this);
}
