import '../../io.dart' as I;
import '../../reader_io.dart' as RIO;
import '../../reader_stream.dart' as RS;
import 'reader.dart' as RR;

final class ReaderStreamBuilder<ENV, A> {
  const ReaderStreamBuilder(this._f);

  final RS.ReaderStream<ENV, A> _f;

  RS.ReaderStream<ENV, A> build() => _f;

  ReaderStreamBuilder<ENV, B> concatMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.concatMapStream(f)(_f));

  ReaderStreamBuilder<ENV, B> concatMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.concatMap(f)(_f));

  ReaderStreamBuilder<ENV, A> doOnDataIO(
    I.IO<void> Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.doOnDataIO(f)(_f));

  ReaderStreamBuilder<ENV, A> doOnData(
    RIO.ReaderIO<ENV, void> Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.doOnData(f)(_f));

  ReaderStreamBuilder<ENV, A> doOnListenIO(
    I.IO<void> f,
  ) =>
      ReaderStreamBuilder(RS.doOnListenIO(f)(_f));

  ReaderStreamBuilder<ENV, A> doOnListen(
    RIO.ReaderIO<ENV, void> f,
  ) =>
      ReaderStreamBuilder(RS.doOnListen(f)(_f));

  ReaderStreamBuilder<ENV, B> exhaustMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.exhaustMapStream(f)(_f));

  ReaderStreamBuilder<ENV, B> exhaustMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.exhaustMap(f)(_f));

  ReaderStreamBuilder<ENV, B> flatMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.flatMapStream(f)(_f));

  ReaderStreamBuilder<ENV, B> flatMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.flatMap(f)(_f));

  ReaderStreamBuilder<ENV, Never> ignoreElements() =>
      ReaderStreamBuilder(RS.ignoreElements(_f));

  ReaderStreamBuilder<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.map(f)(_f));

  ReaderStreamBuilder<ENV, A> startWith(
    A a,
  ) =>
      ReaderStreamBuilder(RS.startWith(a)(_f));

  ReaderStreamBuilder<ENV, B> switchMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.switchMapStream(f)(_f));

  ReaderStreamBuilder<ENV, B> switchMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      ReaderStreamBuilder(RS.switchMap(f)(_f));

  ReaderStreamBuilder<ENV, B> transformStream<B>(
    Stream<B> Function(Stream<A>) f,
  ) =>
      ReaderStreamBuilder(RS.transformStream(f)(_f));

  ReaderStreamBuilder<ENV, T> whereType<T>() =>
      ReaderStreamBuilder(RS.whereType<T>()(_f));

  ReaderStreamBuilder<ENV, A> where(bool Function(A) predicate) =>
      ReaderStreamBuilder(RS.where(predicate)(_f));

  ReaderStreamBuilder<ENV2, A> local<ENV2>(
    ENV Function(ENV2) f,
  ) =>
      ReaderStreamBuilder(RS.local(f)(_f));

  ReaderStreamBuilder<ENV, A> asBroadcastStream() =>
      ReaderStreamBuilder(RS.asBroadcastStream(_f));

  RR.ReaderBuilder<ENV, Stream<A>> toReader() => RR.ReaderBuilder(_f);
}

ReaderStreamBuilder<ENV, ENV> ask<ENV>() => ReaderStreamBuilder(RS.ask());

ReaderStreamBuilder<ENV, ENV2> asks<ENV, ENV2>(
  ENV2 Function(ENV) f,
) =>
    ReaderStreamBuilder(RS.asks(f));

extension ToReaderStreamBuilderReaderExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  ReaderStreamBuilder<ENV, A> toReaderStreamBuilder() =>
      ReaderStreamBuilder(this);
}
