
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'buy_gold_controller.dart';

class BuyGoldScreen extends StatefulWidget {
  const BuyGoldScreen({super.key});

  @override
  State<BuyGoldScreen> createState() => _BuyGoldScreenState();
}

class _BuyGoldScreenState extends State<BuyGoldScreen> {
  final BuyGoldController controller = Get.put(BuyGoldController());
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    // initialize with controller's selectedValue
    _textController = TextEditingController(
      text: controller.enteredAmount.value > 0
          ? controller.enteredAmount.value.toString()
          : controller.selectedValue.value,
    );

    // listen to text changes and update controller immediately
    _textController.addListener(() {
      final text = _textController.text.trim();
      final intVal = int.tryParse(text) ?? 0;
      // update controller on every keystroke
      controller.updateEnteredAmount(intVal);
    });

    // if selectedValue changes (e.g. toggle or programmatic), update text field
    ever(controller.selectedValue, (val) {
      // if user did not type custom (enteredAmount == 0) or quick-select action,
      // reflect selectedValue in the textfield. Also reflect when we programmatically
      // change selection (safe because listener will parse same int)
      if (controller.enteredAmount.value == 0) {
        _textController.text = val ?? '';
        _textController.selection = TextSelection.collapsed(offset: _textController.text.length);
      }
    });

    // when mode toggles, immediately reflect the new selection in textfield
    ever(controller.isRupees, (_) {
      final sel = controller.selectedValue.value;
      _textController.text = sel;
      _textController.selection = TextSelection.collapsed(offset: _textController.text.length);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Buy Gold", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: BackButton(color: Colors.black, onPressed: () => Get.back()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle Rupees/Grams
            Obx(() => Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF0A2A4D),
                  ),
                  child: Row(
                    children: [
                      _buildToggleButton("Rupees", true),
                      _buildToggleButton("Grams", false),
                    ],
                  ),
                )),
            const SizedBox(height: 20),

            // Input TextField (only digits)
            Card(
              elevation: 4,
              child: TextField(
                controller: _textController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: "Enter amount",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                // no onChanged required because listener handles it
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Quick Select",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Quick select list
            Obx(() => Wrap(
                  spacing: 12,
                  children: (controller.isRupees.value ? controller.rupeesOptions : controller.gramsOptions)
                      .map((option) {
                    final isSelected = controller.selectedValue.value == option;
                    return GestureDetector(
                      onTap: () {
                        // use controller.selectValue to update both selectedValue and enteredAmount
                        controller.selectValue(option);
                        // reflect immediately in text field
                        _textController.text = option;
                        _textController.selection = TextSelection.collapsed(offset: option.length);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.amber : Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          controller.isRupees.value ? "₹$option" : "$option gm",
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.black : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )),

            const SizedBox(height: 20),

            // Display selected (shows exactly what is selected/typed)
            Obx(() {
              final display = controller.enteredAmount.value > 0
                  ? controller.enteredAmount.value.toString()
                  : controller.selectedValue.value;
              return Text(
                "Selected: ${controller.isRupees.value ? display : '$display gm'}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              );
            }),

            const Spacer(),

            // Proceed button -> pass integer amount only
            ElevatedButton(
              onPressed: () {
                final amountToSend = controller.getAmountForApi();
                if (amountToSend <= 0) {
                  Get.snackbar("Error", "Please enter/select a valid amount");
                  return;
                }

                Get.toNamed('/payment', arguments: {
                  "amount": amountToSend, // integer
                  "source": "buy_gold",
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A2A4D),
                minimumSize: const Size(double.infinity, 50),
                shape: const StadiumBorder(),
              ),
              child: const Text(
                "Proceed",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isRupeesTab) {
    final selected = controller.isRupees.value == isRupeesTab;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.toggleMode(isRupeesTab);
          // update the text field to reflect new selection
          final sel = controller.selectedValue.value;
          _textController.text = sel;
          _textController.selection = TextSelection.collapsed(offset: sel.length);
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: selected ? Colors.amber : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
