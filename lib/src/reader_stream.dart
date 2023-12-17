import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../common.dart';
import '../io.dart' as I;
import '../reader_task.dart' as RT;

import '../stream.dart' as S;
import 'reader.dart' as R;
import 'reader_io.dart' as RIO;

typedef ReaderStream<ENV, A> = Stream<A> Function(ENV);

// Constructors

ReaderStream<ENV, ENV> ask<ENV>() => Stream.value;

ReaderStream<ENV, A> asks<ENV, A>(
  R.Reader<ENV, A> f,
) =>
    (env) => Stream.value(f(env));

// Helpers

ReaderStream<ENV, A> fromReaderIO<ENV, A>(RIO.ReaderIO<ENV, A> rio) =>
    (env) => S.fromIO(rio(env));

ReaderStream<ENV, A> fromReaderTask<ENV, A>(RT.ReaderTask<ENV, A> rt) =>
    (env) => S.fromTask(rt(env));

ReaderStream<ENV, A> fromReader<ENV, A>(R.Reader<ENV, Stream<A>> rio) =>
    rio.call;

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) map<A, B>(
  B Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).map(f);

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) switchMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).switchMap(f);

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) switchMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => (r) => ra(r).switchMap(
          (a) => f(a)(r),
        );

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) flatMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).flatMap(f);

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) flatMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => (r) => ra(r).flatMap((a) => f(a)(r));

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) concatMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).asyncExpand(f);

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) concatMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => (r) => ra(r).asyncExpand((a) => f(a)(r));

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) exhaustMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).exhaustMap(f);

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) exhaustMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => (r) => ra(r).exhaustMap((a) => f(a)(r));

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) transformStream<A, B>(
  Stream<B> Function(Stream<A>) f,
) =>
    <ENV>(ra) => (r) => ra(r).transform(StreamTransformer.fromBind(f));

ReaderStream<ENV, A> Function<ENV, A>(ReaderStream<ENV, A>) doOnListenIO(
  I.IO<void> f,
) =>
    <A, ENV>(ra) => (r) => ra(r).doOnListen(f.call);

ReaderStream<ENV, A> Function<A>(ReaderStream<ENV, A>) doOnListen<ENV>(
  RIO.ReaderIO<ENV, void> f,
) =>
    <A>(ra) => (r) => ra(r).doOnListen(f(r));

ReaderStream<ENV, A> Function<ENV>(ReaderStream<ENV, A>) doOnDataIO<A>(
  I.IO<void> Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).doOnData((a) => f(a)());

ReaderStream<ENV, A> Function(ReaderStream<ENV, A>) doOnData<ENV, A>(
  RIO.ReaderIO<ENV, void> Function(A) f,
) =>
    (ra) => (r) => ra(r).doOnData((a) => f(a)(r)());

ReaderStream<ENV, A> Function<ENV>(ReaderStream<ENV, A>) startWith<A>(
  A a,
) =>
    <ENV>(ra) => (r) => ra(r).startWith(a);

ReaderStream<ENV, T> Function<ENV, A>(ReaderStream<ENV, A>) whereType<T>() =>
    <ENV, A>(ra) => (r) => ra(r).whereType<T>();

ReaderStream<ENV, A> Function<ENV>(ReaderStream<ENV, A>) where<A>(
  bool Function(A) predicate,
) =>
    <ENV>(ra) => (r) => ra(r).where(predicate);

ReaderStream<ENV, Never> ignoreElements<ENV, A>(ReaderStream<ENV, A> ra) =>
    (r) => ra(r).ignoreElements();

ReaderStream<ENV, A> asksReaderStream<ENV, A>(
  ReaderStream<ENV, A> f,
) =>
    (env) => f(env);

ReaderStream<ENV2, A> Function<A>(ReaderStream<ENV1, A>) local<ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    <A>(r) => (env2) => r(f(env2));

final ReaderStream<ENV, A> Function<ENV, A>(ReaderStream<ENV, A>)
    asBroadcastStream = <ENV, A>(r) => (env) => r(env).asBroadcastStream();

ReaderStream<ENV, A> Function<A>(ReaderStream<ENV, A>) apFirst<ENV, B>(
  ReaderStream<ENV, B> rs1,
) =>
    <A>(rs2) => pipe2(
          rs2,
          flatMap(
            (a) => pipe2(
              rs1,
              map<B, A>((_) => a),
            ),
          ),
        );

ReaderStream<ENV, B> Function<A>(ReaderStream<ENV, A>) apSecond<ENV, B>(
  ReaderStream<ENV, B> rs1,
) =>
    <A>(rs2) => pipe2(
          rs2,
          flatMap(
            (_) => rs1,
          ),
        );
