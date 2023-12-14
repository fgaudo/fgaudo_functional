import '../../io.dart' as I;
import '../../reader_io.dart' as RIO;
import '../../reader_stream.dart' as RS;
import 'reader.dart' as RR;

final class ReaderStream<ENV, A> {
  const ReaderStream(this._f);

  final RS.ReaderStream<ENV, A> _f;

  ReaderStream<ENV, B> concatMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      ReaderStream(RS.concatMapStream(f)(_f));

  ReaderStream<ENV, B> concatMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      ReaderStream(RS.concatMap(f)(_f));

  ReaderStream<ENV, A> doOnDataIO(
    I.IO<void> Function(A) f,
  ) =>
      ReaderStream(RS.doOnDataIO(f)(_f));

  ReaderStream<ENV, A> doOnData(
    RIO.ReaderIO<ENV, void> Function(A) f,
  ) =>
      ReaderStream(RS.doOnData(f)(_f));

  ReaderStream<ENV, A> doOnListenIO(
    I.IO<void> f,
  ) =>
      ReaderStream(RS.doOnListenIO(f)(_f));

  ReaderStream<ENV, A> doOnListen(
    RIO.ReaderIO<ENV, void> f,
  ) =>
      ReaderStream(RS.doOnListen(f)(_f));

  ReaderStream<ENV, B> exhaustMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      ReaderStream(RS.exhaustMapStream(f)(_f));

  ReaderStream<ENV, B> exhaustMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      ReaderStream(RS.exhaustMap(f)(_f));

  ReaderStream<ENV, B> flatMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      ReaderStream(RS.flatMapStream(f)(_f));

  ReaderStream<ENV, B> flatMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      ReaderStream(RS.flatMap(f)(_f));

  ReaderStream<ENV, Never> ignoreElements() =>
      ReaderStream(RS.ignoreElements(_f));

  ReaderStream<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      ReaderStream(RS.map(f)(_f));

  ReaderStream<ENV, A> startWith(
    A a,
  ) =>
      ReaderStream(RS.startWith(a)(_f));

  ReaderStream<ENV, B> switchMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      ReaderStream(RS.switchMapStream(f)(_f));

  ReaderStream<ENV, B> switchMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      ReaderStream(RS.switchMap(f)(_f));

  ReaderStream<ENV, B> transformStream<B>(
    Stream<B> Function(Stream<A>) f,
  ) =>
      ReaderStream(RS.transformStream(f)(_f));

  ReaderStream<ENV, T> whereType<T>() => ReaderStream(RS.whereType<T>()(_f));

  ReaderStream<ENV, A> where(bool Function(A) predicate) =>
      ReaderStream(RS.where(predicate)(_f));

  ReaderStream<ENV2, A> local<ENV2>(
    ENV Function(ENV2) f,
  ) =>
      ReaderStream(RS.local(f)(_f));

  ReaderStream<ENV, A> asBroadcastStream() =>
      ReaderStream(RS.asBroadcastStream(_f));

  RR.Reader<ENV, Stream<A>> toReader() => RR.Reader(_f);
}

ReaderStream<ENV, ENV> ask<ENV>() => ReaderStream(RS.ask());

ReaderStream<ENV, ENV2> asks<ENV, ENV2>(
  ENV2 Function(ENV) f,
) =>
    ReaderStream(RS.asks(f));
