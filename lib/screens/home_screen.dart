import 'package:flutter/material.dart';
import 'pesan_tiket_screen.dart';
import 'informasi_jadwal_bus.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final TextEditingController dariController = TextEditingController();
  final TextEditingController tujuanController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildHomePageContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pemesanan Tiket',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 12),
              TextField(
                controller: dariController,
                decoration: InputDecoration(
                  labelText: 'Dari',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: tujuanController,
                decoration: InputDecoration(
                  labelText: 'Tujuan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              SizedBox(height: 12),
              InkWell(
                onTap: () => _pickDate(context),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.grey[700]),
                      SizedBox(width: 12),
                      Text(
                        selectedDate == null
                            ? 'Pilih Tanggal'
                            : '${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}',
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedDate == null
                              ? Colors.grey
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (dariController.text.isEmpty ||
                        tujuanController.text.isEmpty ||
                        selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                          Text('Mohon isi Dari, Tujuan, dan Pilih Tanggal'),
                        ),
                      );
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Pencarian Tiket'),
                        content: Text(
                            'Cari tiket dari ${dariController.text} ke ${tujuanController.text} pada tanggal ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Tutup'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Cari Bus'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Jadwal Bus',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            TextButton(
              onPressed: () {
                // TODO: Tambahkan navigasi Selengkapnya jika perlu
              },
              child: Text('Selengkapnya'),
            ),
          ],
        ),

        SizedBox(height: 12),

        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _busScheduleBox(
                busName: 'Bus Ekspres A',
                departure: 'Jakarta',
                arrival: 'Bandung',
                time: '08:00',
              ),
              _busScheduleBox(
                busName: 'Bus Antar Kota B',
                departure: 'Surabaya',
                arrival: 'Malang',
                time: '09:30',
              ),
              _busScheduleBox(
                busName: 'Bus Pariwisata C',
                departure: 'Yogyakarta',
                arrival: 'Solo',
                time: '10:45',
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.travel_explore, color: Colors.white, size: 40),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TRIP Planner',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    Text('Buat perencanaan terbaik untuk perjalananmu.',
                        style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade300),
                onPressed: () {},
                child: Text('BUAT'),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Promo Terbaru',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextButton(
              onPressed: () {},
              child: Text('Lihat Semua'),
            )
          ],
        ),

        SizedBox(height: 8),

        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _promoCard("600.000", "Promo Spesial"),
              _promoCard("50%", "Promo Spesial"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _busScheduleBox({
    required String busName,
    required String departure,
    required String arrival,
    required String time,
  }) {
    return Container(
      width: 220,
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            busName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 8),
          Text('Keberangkatan: $departure'),
          Text('Tujuan: $arrival'),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.blue.shade700),
              SizedBox(width: 4),
              Text(
                time,
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _promoCard(String title, String subtitle) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('assets/promo.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
              Text(subtitle, style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        setState(() {
          _selectedIndex = 0;
        });
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PesanTiketScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InformasiJadwalBusScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double backgroundHeight = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hi Josua'),
        backgroundColor: Colors.deepPurple.withOpacity(0.5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: backgroundHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/stasiun.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.deepPurple.withOpacity(0.5), BlendMode.srcOver),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -backgroundHeight * 0.5),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _buildHomePageContent(),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Beranda", 0),
            _buildNavItem(Icons.confirmation_num, "Ticket", 1),
            _buildNavItem(Icons.info, "Informasi", 2),
            _buildNavItem(Icons.person, "Profi", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData iconData, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    final color = isSelected ? Colors.deepPurple : Colors.grey;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 28,
            color: color,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
