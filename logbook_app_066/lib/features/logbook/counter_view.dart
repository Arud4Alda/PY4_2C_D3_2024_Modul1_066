import 'package:flutter/material.dart';
import 'package:logbook_app_001/features/logbook/counter_controller.dart';
import 'package:logbook_app_001/features/onboarding/onboarding_view.dart';

class CounterView extends StatefulWidget {
  final String username;
  const CounterView({super.key, required this.username});
  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();
  final TextEditingController _stepInput = TextEditingController(text: "1");

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  void _loadData() async {
    await _controller.loadLastValue(widget.username);
    setState(() {});
  }

  String getGreeting() 
  {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      return "Selamat Pagi";
    } else if (hour >= 12 && hour < 15) {
      return "Selamat Siang";
    } else if (hour >= 15 && hour < 18) {
      return "Selamat Sore";
    } else {
      return "Selamat Malam";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logbook",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 106, 160, 128),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Konfirmasi Logout"),
                    content: const Text("Apakah Anda yakin akan tetap logout?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context), 
                        child: const Text("Batal"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); 
                          
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const OnboardingView()),
                            (route) => false,
                          );
                        },
                        child: const Text("Ya, Keluar", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],

      ),
      backgroundColor: const Color(0xFFFFF8E7),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${getGreeting()}, ${widget.username} 🌿",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4F7C6D),
              ),),
            const SizedBox(height: 10),
            const Text("Total Hitungan:"),
            Text('${_controller.value}', style: const TextStyle(fontSize: 100)),

            const SizedBox(height: 50),

            TextField(
              controller: _stepInput,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Atur step counter",
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
                    backgroundColor: const Color.fromARGB(255, 106, 160, 128),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(90, 50),
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () => setState(() => _controller.decrement(widget.username)),
                  child: const Text("-"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 106, 160, 128),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(90, 50),
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () => setState(() => _controller.increment(widget.username)),
                  child: const Text("+"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 106, 160, 128),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(90, 50),
                    textStyle: const TextStyle(
                      fontSize: 17,
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
                      setState(() => _controller.reset(widget.username));

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
                    leading: const Icon(Icons.adb_sharp),
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
