export 'common.g.dart';

T identity<T>(T x) => x;

final class Builder<A> {
  const Builder(this.a);

  final A a;

  Builder<B> transform<B>(B Function(A) f) => Builder(f(this.a));

  A build() => a;
}
