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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Multi step & Logbook Counter")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Total Hitungan:"),
            Text('${_controller.value}', style: const TextStyle(fontSize: 50)),

            const SizedBox(height: 50),

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
                  onPressed: () =>
                      setState(() => _controller.decrement()),
                  child: const Text("-"),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => _controller.increment()),
                  child: const Text("+"),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => _controller.reset()),
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
                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(_controller.history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
  
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //     FloatingActionButton(
      //       heroTag: "decrement",
      //       onPressed: () => setState(() => _controller.decrement()),
      //       child: const Icon(Icons.remove),
      //     ),
      //     FloatingActionButton(
      //       heroTag: "reset",
      //       onPressed: () => setState(() => _controller.reset()),
      //       child: const Icon(Icons.refresh),
      //     ),
      //     FloatingActionButton(
      //       heroTag: "increment",
      //       onPressed: () => setState(() => _controller.increment()),
      //       child: const Icon(Icons.add),
      //     ),
      //   ],
      // ),
    );
  }
}
