import '../../public/backend_market_inventory.dart';
import '../models/backend_item.dart';

class BackendInventoryService {
  static final BackendInventoryService _instance =
      BackendInventoryService._internal();
  factory BackendInventoryService() => _instance;
  BackendInventoryService._internal();

  final Set<String> _ownedItemIds = {};

  bool isOwned(String id) => _ownedItemIds.contains(id);

  void addItem(String id) {
    _ownedItemIds.add(id);
  }

  List<BackendItem> get items => backendMarketItems
      .where((item) => _ownedItemIds.contains(item.id))
      .toList();
}
