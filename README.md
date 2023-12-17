This library introduces numerous pure functional types, much like [fp-ts](https://gcanti.github.io/fp-ts/)

## Features

Here are some examples of types which you may find

- Either
- IO
- Task
- Reader
- ReaderStream
- ...

Keep in mind that I will be adding more types as I continue development.
If you need one in particular, just open an issue.

## Usage

There are two ways to use this library.
1) A more object-oriented approach which uses builders to chain methods and build the functional types.
2) A more functional approach which sequentially pipes functions to get a result.

Object-oriented:
```dart
import 'package:functionally/builders.dart';

void main() {
  final readerStream =
        ReaderStreamBuilder.ask<String>()
          .map((hello) => '$hello World')
          .build();

  readerStream('Hello').listen(print);
}
```

Functional:
```dart
import 'package:functionally/reader_stream.dart' as RS;
import 'package:functionally/common.dart';

void main() {
  final readerStream = pipe2(
    RS.ask<String>(),
    RS.map((hello) => '$hello World'),
  );

  readerStream('Hello').listen(print);
}
```

## Examples
You may also find more examples in [Fridgy](https://github.com/fgaudo/fridgy), an app written with this library.

Anyway, these samples will probably not help you much if you don't have experience with pure functional paradigms.
If you have experience with typescript and want to learn more, i suggest searching online guides about `fp-ts`.
Otherwise consider learning [Haskell](https://www.haskell.org/) or [Scala](https://www.scala-lang.org/) :P.


