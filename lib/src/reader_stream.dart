import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../io.dart' as I;
import '../stream.dart' as S;
import 'reader.dart' as R;
import 'reader_io.dart' as RIO;

final class ReaderStream<ENV, A> {
  const ReaderStream(this._f);

  final Stream<A> Function(ENV) _f;
  Stream<A> call(ENV env) => _f(env);
}

// Constructors

ReaderStream<ENV, ENV> ask<ENV>() => ReaderStream(Stream.value);

ReaderStream<ENV, A> asks<ENV, A>(
  R.Reader<ENV, A> f,
) =>
    ReaderStream((env) => Stream.value(f(env)));

// Helpers

R.Reader<ENV, Stream<A>> toReader<ENV, A>(ReaderStream<ENV, A> rs) =>
    R.Reader(rs.call);

ReaderStream<ENV, A> fromReaderIO<ENV, A>(RIO.ReaderIO<ENV, A> rio) =>
    ReaderStream((env) => S.fromIO(rio(env)));

ReaderStream<ENV, A> fromReader<ENV, A>(R.Reader<ENV, Stream<A>> rio) =>
    ReaderStream(rio.call);

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) map<A, B>(
  B Function(A) f,
) =>
    <ENV>(ra) => ReaderStream(
          (r) => ra(r).map(f),
        );

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) switchMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => ReaderStream(
          (r) => ra(r).switchMap(f),
        );

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) switchMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => ReaderStream(
          (r) => ra(r).switchMap(
            (a) => f(a)(r),
          ),
        );

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) flatMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => ReaderStream(
          (r) => ra(r).flatMap(f),
        );

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) flatMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => ReaderStream((r) => ra(r).flatMap((a) => f(a)(r)));

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) concatMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => ReaderStream((r) => ra(r).asyncExpand(f));

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) concatMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => ReaderStream((r) => ra(r).asyncExpand((a) => f(a)(r)));

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) exhaustMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => ReaderStream((r) => ra(r).exhaustMap(f));

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) exhaustMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => ReaderStream((r) => ra(r).exhaustMap((a) => f(a)(r)));

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) transformStream<A, B>(
  Stream<B> Function(Stream<A>) f,
) =>
    <ENV>(ra) =>
        ReaderStream((r) => ra(r).transform(StreamTransformer.fromBind(f)));

ReaderStream<ENV, A> Function<ENV, A>(ReaderStream<ENV, A>) doOnListenIO(
  I.IO<void> f,
) =>
    <A, ENV>(ra) => ReaderStream((r) => ra(r).doOnListen(f));

ReaderStream<ENV, A> Function<A>(ReaderStream<ENV, A>) doOnListen<ENV>(
  RIO.ReaderIO<ENV, void> f,
) =>
    <A>(ra) => ReaderStream((r) => ra(r).doOnListen(f(r)));

ReaderStream<ENV, A> Function<ENV>(ReaderStream<ENV, A>) doOnDataIO<A>(
  I.IO<void> Function(A) f,
) =>
    <ENV>(ra) => ReaderStream((r) => ra(r).doOnData((a) => f(a)()));

ReaderStream<ENV, A> Function(ReaderStream<ENV, A>) doOnData<ENV, A>(
  RIO.ReaderIO<ENV, void> Function(A) f,
) =>
    (ra) => ReaderStream((r) => ra(r).doOnData((a) => f(a)(r)()));

ReaderStream<ENV, A> Function<ENV>(ReaderStream<ENV, A>) startWith<A>(
  A a,
) =>
    <ENV>(ra) => ReaderStream((r) => ra(r).startWith(a));

ReaderStream<ENV, T> Function<ENV, A>(ReaderStream<ENV, A>) whereType<T>() =>
    <ENV, A>(ra) => ReaderStream((r) => ra(r).whereType<T>());

ReaderStream<ENV, A> Function<ENV>(ReaderStream<ENV, A>) where<A>(
  bool Function(A) predicate,
) =>
    <ENV>(ra) => ReaderStream((r) => ra(r).where(predicate));

ReaderStream<ENV, Never> ignoreElements<ENV, A>(ReaderStream<ENV, A> ra) =>
    ReaderStream((r) => ra(r).ignoreElements());

ReaderStream<ENV, A> asksReaderStream<ENV, A>(
  ReaderStream<ENV, A> f,
) =>
    ReaderStream((env) => f(env));
