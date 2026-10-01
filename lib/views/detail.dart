import 'package:flutter/material.dart';
import '../models/data.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}


class _DetailPageState extends State<DetailPage> {
    int _counter = 1;

    void _incrementCounter() {
        setState(() {
          _counter++;
        });
      }

    void _incrementCounter2() {
        setState(() {
          _counter--;
        });
      }


  @override
  Widget build(BuildContext context) {
    Product product = widget.product;



    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                height: 320,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 220,
                    color: Colors.grey[300],
                    child: Icon(Icons.fastfood, size: 60),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
            Text(
              product.productName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(product.type, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            Text(
              product.price,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            SizedBox(height: 15),
            Text(
              "Jumlah Produk : $_counter",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

          
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            

            SizedBox(height: 10),

            IconButton(onPressed: () {
              setState(() {
                product.isFavorite = !product.isFavorite;
              });
            },
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),),

            Text(
              "Jumlah Like ${product.likeCount}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), 
            ),

            Text(
              "Stok : ${product.stock}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), 
            ),

            Text(
              "Ukuran : ${product.sizes}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), 
            ),

            

            SizedBox(height: 15),
            Text(
              "Deskripsi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(product.details),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter2,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
