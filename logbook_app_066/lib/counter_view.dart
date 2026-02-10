import 'package:flutter/material.dart';
import 'counter_controller.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});
  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();
  final TextEditingController _stepInput = TextEditingController(text: "1");
  final Color pastelBlue = const Color.fromARGB(255, 101, 150, 210);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Multi step & Logbook Counter",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 83, 119, 177),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Total Hitungan:"),
            Text('${_controller.value}', style: const TextStyle(fontSize: 100)),

            const SizedBox(height: 60),

            TextField(
              controller: _stepInput,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Step",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final step = int.tryParse(value) ?? 1;
                setState(() => _controller.setStep(step));
              },
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBFDBFE),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(90, 50),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () => setState(() => _controller.decrement()),
                  child: const Text("-"),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBFDBFE),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(90, 50),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () => setState(() => _controller.increment()),
                  child: const Text("+"),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBFDBFE),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(90, 50),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Konfirmasi Reset"),
                        content: const Text(
                          "Apakah kamu yakin ingin mereset counter?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Batal"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Reset"),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      setState(() => _controller.reset());

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Counter berhasil di-reset"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text("Reset"),
                ),
              ],
            ),

            const SizedBox(height: 50),
            const Divider(),
            const Text(
              "Riwayat Aktivitas",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: _controller.history.length,
                itemBuilder: (context, index) {
                  final item = _controller.history[index];

                  Color textColor;
                  IconData icon;

                  if (item.contains("menambah")) {
                    textColor = const Color.fromARGB(255, 92, 168, 94);
                    icon = Icons.add_circle;
                  } else if (item.contains("mengurangi")) {
                    textColor = const Color.fromARGB(255, 226, 115, 107);
                    icon = Icons.remove_circle;
                  } else {
                    textColor = const Color.fromARGB(255, 145, 145, 145);
                    icon = Icons.refresh;
                  }

                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(item, style: TextStyle(color: textColor)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
