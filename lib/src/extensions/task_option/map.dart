import '../../../task_option.dart' as TO;

extension MapTaskOptionExtension<A> on TO.TaskOption<A> {
  TO.TaskOption<B> map<B>(
    B Function(A) mapper,
  ) =>
      TO.map(mapper)(this);
}
