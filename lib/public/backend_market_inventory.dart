import '../game/models/backend_item.dart';

final List<BackendItem> backendMarketItems = [
  // Original items
  BackendItem(
    id: 'price_spike',
    name: 'UI Price Injector',
    description: 'Hack R&R to increase every stock by 100%',
    price: 500,
    imagePath: 'assets/images/UIPriceInjector.png',
    effect: BackendItemEffect.priceSpike,
  ),
  BackendItem(
    id: 'price_drop',
    name: 'UI Price Remover',
    description: 'Hack R&R to decrease every stock by 50%',
    price: 800,
    imagePath: 'assets/images/TrojanDemover.png',
    effect: BackendItemEffect.priceDrop,
  ),
  BackendItem(
    id: 'trojan_deposit',
    name: 'Trojan Deposit',
    description: 'Upload a payload of \$20,000 into R&R account',
    price: 1200,
    imagePath: 'assets/images/TrojanDeposit.png',
    effect: BackendItemEffect.trojanDeposit,
  ),
  BackendItem(
    id: 'market_freeze',
    name: 'Freeze Market',
    description: 'Disrupt R&R servers for 60 seconds',
    price: 1200,
    imagePath: 'assets/images/FreezeMarket.png',
    effect: BackendItemEffect.marketFreeze,
  ),

  // New items with specific values for effect implementation
  BackendItem(
    id: 'latency_injector',
    name: 'Latency Injector',
    description: 'Introduce artificial lag (10s) into trade execution',
    price: 900,
    imagePath: 'assets/images/LatencyInjector.png',
    effect: BackendItemEffect.latencyInject, // Apply 2s delay once
  ),
  BackendItem(
    id: 'packet_sniffer',
    name: 'Packet Sniffer',
    description: 'Doubles all stock prices',
    price: 700,
    imagePath: 'assets/images/PacketSniffer.png',
    effect: BackendItemEffect.packetSniff, // Sets bias on next tick
  ),
  BackendItem(
    id: 'spoof_orders',
    name: 'Spoof Orders',
    description: 'Create fake buy pressure, +20% volatility for 10s',
    price: 1000,
    imagePath: 'assets/images/SpoofOrders.png',
    effect: BackendItemEffect.spoofOrders, // Modify volatility once
  ),
  BackendItem(
    id: 'rollback_patch',
    name: 'Rollback Patch',
    description: 'Revert market to previous state instantly',
    price: 1400,
    imagePath: 'assets/images/RollBackPatch2.png',
    effect: BackendItemEffect.rollbackPatch, // Revert prices once
  ),
  BackendItem(
    id: 'data_poison',
    name: 'Data Poison',
    description: 'Confuse analytics, reduce prediction accuracy 50%',
    price: 1250,
    imagePath: 'assets/images/DataPoison50.png',
    effect: BackendItemEffect.dataPoison, // Reduce next tick accuracy
  ),
  BackendItem(
    id: 'Blackmail Release',
    name: 'BlackMail Release',
    description: 'Gradually crash every stock market to the ground.',
    price: 950,
    imagePath: 'assets/images/BlackmailRelease.png',
    effect: BackendItemEffect.clockSkew, // Modify tick rate temporarily
  ),
  BackendItem(
    id: 'sandbox_escape',
    name: 'Sandbox Escape',
    description: 'Allow unlimited buying for 30s',
    price: 1700,
    imagePath: 'assets/images/SandBoxEscape.png',
    effect: BackendItemEffect.sandboxEscape, // Enable unlimited buying
  ),
  BackendItem(
    id: 'dark_pool_access',
    name: 'Dark Pool Access',
    description: 'Gain 1.5x profit for 30s',
    price: 1900,
    imagePath: 'assets/images/DarkPoolAccess.png',
    effect: BackendItemEffect.darkPoolAccess, // Profit multiplier
  ),
];
