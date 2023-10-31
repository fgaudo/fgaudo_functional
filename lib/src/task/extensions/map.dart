import '../task.dart' as T;

extension MapTaskExtension<A1> on T.Task<A1> {
  T.Task<A2> map<A2>(
    A2 Function(A1) mapper,
  ) =>
      T.map(mapper)(this);
}
