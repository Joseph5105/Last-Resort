enum BackendItemEffect {
  priceSpike,
  priceDrop,
  trojanDeposit,
  marketFreeze,
  latencyInject,
  packetSniff,
  spoofOrders,
  rollbackPatch,
  dataPoison,
  clockSkew,
  sandboxEscape,
  darkPoolAccess,
}

class BackendItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final BackendItemEffect effect;

  const BackendItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.effect,
  });
}
