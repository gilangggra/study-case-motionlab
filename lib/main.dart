import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Task Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class Task {
  String judul;
  bool selesai;

  Task({
    required this.judul,
    this.selesai = false,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController inputController = TextEditingController();

  List<Task> daftarTugas = [
    Task(judul: 'Belajar dasar Flutter'),
    Task(judul: 'Mengerjakan studi kasus Motion Lab', selesai: true),
    Task(judul: 'Review alur program'),
  ];

  void tambahTugas() {
    String text = inputController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        daftarTugas.add(Task(judul: text));
        inputController.clear();
      });
    }
  }

  void tandaiSelesai(int index) {
    setState(() {
      daftarTugas[index].selesai = !daftarTugas[index].selesai;
    });
  }

  void hapusTugas(int index) {
    setState(() {
      daftarTugas.removeAt(index);
    });
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Task Tracker'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputController,
                    decoration: const InputDecoration(
                      labelText: 'Tugas Baru',
                      hintText: 'Tulis judul tugas...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => tambahTugas(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: tambahTugas,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  child: const Text('Simpan'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Expanded(
              child: daftarTugas.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada catatan tugas.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: daftarTugas.length,
                      itemBuilder: (context, index) {
                        final item = daftarTugas[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                          child: ListTile(
                            leading: Checkbox(
                              value: item.selesai,
                              onChanged: (_) => tandaiSelesai(index),
                            ),
                            title: Text(
                              item.judul,
                              style: TextStyle(
                                decoration: item.selesai
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: item.selesai ? Colors.grey : Colors.black87,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => hapusTugas(index),
                            ),
                          ),
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
