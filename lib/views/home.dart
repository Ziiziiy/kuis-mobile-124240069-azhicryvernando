import 'package:flutter/material.dart';
import '../models/data.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String keyword = ""; // untuk search menu
  String selectedCategory = "Semua"; // untuk filter kategori

  // Daftar pilihan filter
  List<String> categories = ["Semua", "T-Shirt", "Jacket", "Pants", "Bag", "Accessories", "Favorit"];

  @override
  Widget build(BuildContext context) {
    // Saring 
    List<Product> hasil = catalog.where((m) {
      bool cocokNama = m.productName.toLowerCase().contains(keyword.toLowerCase());

      bool cocokKategori;
      if (selectedCategory == "Semua") {
        cocokKategori = true;
      } else if (selectedCategory == "Favorit") {
        cocokKategori = m.isFavorite;
      } else {
        cocokKategori = m.type == selectedCategory;
      }

      return cocokNama && cocokKategori;
    }).toList();

    return Column(
      children: [
        // search
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                keyword = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Cari menu...",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        ),

        // Filter kategori
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: categories.map((kategori) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(kategori),
                  selected: selectedCategory == kategori,
                  onSelected: (value) {
                    setState(() {
                      selectedCategory = kategori;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),

        // Daftar menu 
        Expanded(
          child: hasil.isEmpty
              ? Center(child: Text("Produk tidak ditemukan"))
              : ListView.builder(
                  itemCount: hasil.length,
                  itemBuilder: (context, index) {
                    Product menu = hasil[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(product: menu),
                          ),
                        ).then((value) {
                          // Setelah kembali dari Detail, segarkan tampilan
                          // (siapa tahu status favorit berubah)
                          setState(() {});
                        });
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          menu.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[300],
                              child: Icon(Icons.fastfood),
                            );
                          },
                        ),
                      ),
                      title: Text(menu.productName),
                      subtitle: Text("${menu.type} • ${menu.price}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                menu.isFavorite = !menu.isFavorite;
                              });
                            },
                            icon: Icon(
                              menu.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
