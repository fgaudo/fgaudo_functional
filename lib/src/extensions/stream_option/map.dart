import '../../../stream_option.dart' as SO;

extension MapStreamOptionExtension<A> on SO.StreamOption<A> {
  SO.StreamOption<B> map<B>(
    B Function(A) mapper,
  ) =>
      SO.map(mapper)(this);
}
