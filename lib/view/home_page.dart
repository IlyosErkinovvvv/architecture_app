import 'package:architecture_app/data/repository/get_currency_repository.dart';
import 'package:architecture_app/data/service/get_currency_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Architecture App")),
      body: RefreshIndicator(
        onRefresh: CurrencyRepository.getRepository,
        child: FutureBuilder(
          future: CurrencyService().getCurrency(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(CurrencyRepository.currencyBox!
                          .get(index)!
                          .title
                          .toString()),
                    ),
                  );
                },
                itemCount: CurrencyRepository.currencyBox!.length,
              );
            }
          },
        ),
      ),
    );
  }
}
