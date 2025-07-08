import 'package:flutter/material.dart';

void main() {
  runApp(const BelanjaApp());
}

class BelanjaApp extends StatelessWidget {
  const BelanjaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Belanja Ariel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DaftarBelanjaArielPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DaftarBelanjaArielPage extends StatefulWidget {
  const DaftarBelanjaArielPage({super.key});

  @override
  State<DaftarBelanjaArielPage> createState() =>
      _DaftarBelanjaArielPageState();
}

class _DaftarBelanjaArielPageState extends State<DaftarBelanjaArielPage> {
  final List<Map<String, dynamic>> _items = [
    {
      'name': 'Beras',
      'count': 0,
      'price': 13000,
      'image':
      'https://tse1.mm.bing.net/th?q=Pengertian%20Merk%20Beras%20yang%20Bagus%20dan%20Murah',
    },
    {
      'name': 'Minyak Goreng',
      'count': 0,
      'price': 20000,
      'image':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1D6sOszvgOQuylWjQgr460cb459fc0ffSvg&s'
    },
    {
      'name': 'Telur',
      'count': 0,
      'price': 28000,
      'image':
      'https://media.suara.com/pictures/970x544/2023/07/29/92340-ilustrasi-telur-freepikfabrikasimf.jpg',
    },
    {
      'name': 'Baju Flanel',
      'count': 0,
      'price': 399000,
      'image':
      'https://s3-ap-southeast-1.amazonaws.com/cdn.jarvis-store.com/kalibre-upload/produk/large/20241201-161745.jpeg',


    },
    {
      'name': 'Celana Winter',
      'count': 0,
      'price': 599000,
      'image':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIsao1k1UcaUGtkGc_xJMQEXrMOvs2x-GhGg&s',


    },
  ];

  int get totalItems =>
      _items.fold(0, (sum, item) => sum + (item['count'] as int));

  int get totalHarga => _items.fold(
      0,
          (sum, item) =>
      sum + ((item['count'] as int) * (item['price'] as int)));

  String formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => "${match[1]}.",
    )}";
  }

  void _increment(int index) {
    setState(() {
      _items[index]['count']++;
    });
  }

  void _decrement(int index) {
    setState(() {
      if (_items[index]['count'] > 0) {
        _items[index]['count']--;
      }
    });
  }

  void _resetAll() {
    setState(() {
      for (var item in _items) {
        item['count'] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Belanja Ariel'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Semua',
            onPressed: _resetAll,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = _items[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          formatRupiah(item['price']),
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => _decrement(index),
                  ),
                  Text('${item['count']}'),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => _increment(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.blue.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Item: $totalItems',
                  style: const TextStyle(fontSize: 16)),
              Text('Total Harga: ${formatRupiah(totalHarga)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
