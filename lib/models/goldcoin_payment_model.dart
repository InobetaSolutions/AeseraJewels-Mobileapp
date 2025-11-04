class GoldCoinPaymentModel {
  final Map<String, int> coinQuantities; // e.g., {"1gm": 8, "2gm": 4}
  final Map<String, double> totalWeights; // e.g., {"1gm": 8.0, "2gm": 8.0}
  final double totalGrams;
  final double totalValue;

  GoldCoinPaymentModel({
    required this.coinQuantities,
    required this.totalWeights,
    required this.totalGrams,
    required this.totalValue,
  });
}
