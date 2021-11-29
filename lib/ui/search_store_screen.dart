import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/provider/store.dart';

class SearchStoreScreen extends StatefulWidget {
  const SearchStoreScreen({Key? key}) : super(key: key);

  @override
  _SearchStoreScreenState createState() => _SearchStoreScreenState();
}

class _SearchStoreScreenState extends State<SearchStoreScreen> {
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    var prov = Provider.of<StoreProvider>(context, listen: false);
    prov.getStoreInfo();
    _searchController.addListener(() {
      prov.searchStore(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<StoreProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverAppBar(
            title: const Text('Поиск магазина'),
            backgroundColor: Colors.green[300],
            //pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                    labelText: 'Поиск',
                    filled: true,
                    border: OutlineInputBorder()),
              ),
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return StoreInfoWidget(
                  title: prov.filtredList[index].title,
                  schedule: prov.filtredList[index].schedule,
                  index: index,
                );
              },
              childCount: prov.filtredList.length,
            ),
            itemExtent: 70,
          )
        ],
      ),
    );
  }
}

class StoreInfoWidget extends StatelessWidget {
  final String title;
  final String schedule;
  final int index;
  const StoreInfoWidget(
      {Key? key,
      required this.title,
      required this.schedule,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: index % 2 == 0 ? Colors.green[100]! : Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            Text(schedule),
          ],
        ),
      ),
    );
  }
}
