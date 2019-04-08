class BaseFlavor {
  const BaseFlavor();
}

class Flavor extends BaseFlavor {
  final String name;

  const Flavor(this.name);

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Flavor && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
