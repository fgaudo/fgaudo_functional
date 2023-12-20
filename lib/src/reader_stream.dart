import 'dart:async';

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

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) mapStream<A, B>(
  Stream<B> Function(Stream<A>) f,
) =>
    <ENV>(ra) => (r) => ra(r).transform(StreamTransformer.fromBind(f));

ReaderStream<ENV2, A> Function<A>(ReaderStream<ENV1, A>) local<ENV1, ENV2>(
  ENV1 Function(ENV2) f,
) =>
    <A>(r) => (env2) => r(f(env2));
