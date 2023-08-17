import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'api_data/data.dart';

class Homepage extends HookConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dataList = ref.watch(productsProvider);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 218, 217, 217),
        appBar: AppBar(
          title: const Text("Product"),
          backgroundColor: Color.fromARGB(255, 107, 26, 173),
        ),
        body: dataList.when(
          data: (data) {
            return ListView.builder(
              itemBuilder: (context, index) {
                var item = data[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Product(
                    url: item['thumbnail'],
                    description: item['description'],
                    left: item['stock'],
                    name: item['title'],
                    price: item['price'],
                  ),
                );
              },
              itemCount: data.length,
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text("error happend"),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
        //
        );
  }
}

class Product extends StatelessWidget {
  const Product({
    super.key,
    required this.description,
    required this.left,
    required this.name,
    required this.price,
    required this.url,
  });
  final String url;
  final String name;
  final String description;
  final int price;
  final int left;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),

      //padding: EdgeInsets.all(20),
      height: 150,
      width: size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            this.url,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    this.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Text(
                      this.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${this.price}\$',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 20,
                        ),
                      ),
                      Text(
                        '${this.left} left in stock',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
