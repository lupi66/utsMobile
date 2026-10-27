import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const _ink = Color(0xFF3D2B1F);
const _cinnamon = Color(0xFFB6532F);
const _saffron = Color(0xFFE7A83E);
const _cream = Color(0xFFFFF8EE);
const _muted = Color(0xFF826F61);

void main() {
  runApp(const CanteenMenuApp());
}

class CanteenMenuApp extends StatelessWidget {
  const CanteenMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Menu Kantin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _cinnamon,
          primary: _cinnamon,
          secondary: _saffron,
          surface: _cream,
        ),
        scaffoldBackgroundColor: _cream,
        appBarTheme: const AppBarTheme(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFF0E3D4)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: _muted),
          hintStyle: const TextStyle(color: Color(0xFFB2A397)),
          prefixIconColor: _cinnamon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE6D7C8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE6D7C8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: _cinnamon, width: 1.8),
          ),
        ),
        useMaterial3: true,
      ),
      home: const MenuListPage(),
    );
  }
}

class MenuEntry {
  const MenuEntry({required this.name, required this.price});

  final String name;
  final int price;
}

// Font Poppins memberi tampilan modern, tegas, dan tetap nyaman dibaca.
// Nuansa krem, kayu, dan kayu manis menghadirkan tampilan hangat seperti kedai.
class AppText extends StatelessWidget {
  const AppText(
    this.value, {
    super.key,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.color = _ink,
  });

  final String value;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

class MenuListPage extends StatefulWidget {
  const MenuListPage({super.key});

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  final List<MenuEntry> _menus = [
    const MenuEntry(name: 'Nasi Goreng Spesial', price: 18000),
    const MenuEntry(name: 'Ayam Geprek', price: 15000),
    const MenuEntry(name: 'Soto Ayam', price: 14000),
    const MenuEntry(name: 'Mie Goreng', price: 12000),
    const MenuEntry(name: 'Es Teh Manis', price: 5000),
  ];

  Future<void> _openAddMenu() async {
    final newMenu = await Get.to<MenuEntry>(() => const AddMenuPage());
    if (newMenu != null && mounted) {
      setState(() {
        _menus.add(newMenu);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          'Menu Kantin',
          fontSize: 21,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: AppText(
              'Pilihan menu hari ini',
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: _cinnamon,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),
              itemCount: _menus.length,
              itemBuilder: (context, index) {
                final menu = _menus[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.restaurant_menu,
                      color: _cinnamon,
                    ),
                    title: AppText(
                      menu.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    subtitle: AppText(
                      _formatPrice(menu.price),
                      fontSize: 14,
                      color: _muted,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: _saffron,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    onTap: () {
                      Get.to<void>(() => MenuDetailPage(menu: menu));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddMenu,
        tooltip: 'Tambah menu',
        backgroundColor: _saffron,
        foregroundColor: _ink,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MenuDetailPage extends StatelessWidget {
  const MenuDetailPage({super.key, required this.menu});

  final MenuEntry menu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          'Detail Menu',
          fontSize: 21,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.restaurant,
                  size: 52,
                  color: _cinnamon,
                ),
                const SizedBox(height: 16),
                AppText(
                  menu.name,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(height: 8),
                AppText(
                  _formatPrice(menu.price),
                  fontSize: 19,
                  color: _muted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Get.back<MenuEntry>(
      result: MenuEntry(
        name: _nameController.text.trim(),
        price: int.parse(_priceController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          'Tambah Menu',
          fontSize: 21,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama menu',
                  hintText: 'Contoh: Bakso Kuah',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.restaurant_menu),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama menu tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  hintText: 'Contoh: 15000',
                  prefixText: 'Rp ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Harga harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _cinnamon,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const AppText(
                  'Simpan Menu',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatPrice(int price) {
  final digits = price.toString();
  final formatted = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return 'Rp $formatted';
}
