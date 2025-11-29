class Stock {
  String name;
  double price;
  int owned;
  List<double> history;

  Stock({
    required this.name,
    required this.price,
    this.owned = 0,
    List<double>? history,
  }) : history = history ?? [] {
    this.history.add(price); // start with initial price
  }

  // Update price and add to history
  void updatePrice(double newPrice) {
    price = newPrice;
    history.add(newPrice);
    if (history.length > 40) {
      history.removeAt(0); // keep graph short
    }
  }
}
