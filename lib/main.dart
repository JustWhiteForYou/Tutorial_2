import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class Car {
  final String title;
  final String description;
  final int price;

  Car(this.title, this.description, this.price);
}

class _MyAppState extends State<MyApp> {
  final List<Car> _cars = [
    Car('BMW', 'Germany Car', 15000),
    Car("Toyota", 'Japan Car', 20000),
    Car('Renault', 'French Car', 10000),
  ];

  late String _newTitle;
  late String _newDescription;
  late int _newPrice;

  void _addCar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a Car'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  _newTitle = value;
                },
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) {
                  _newDescription = value;
                },
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                onChanged: (value) {
                  _newPrice = value.isEmpty ? 0 : int.parse(value);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _cars.add(Car(
                    _newTitle,
                    _newDescription,
                    _newPrice,
                  ));
                });
              },
              child: Text('Add'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('End'),
            ),
          ],
        );
      },
    );
  }



  void _deleteCar(int index) {
    setState(() {
      _cars.removeAt(index);
    });
  }

  void _viewCar(BuildContext context, Car car) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(car.title),
            content: Text(car.description),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('End this'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to the club'),
          actions: [
            IconButton(
              onPressed: _addCar,
              icon: const Icon(
                Icons.add,
                size: 38,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: _cars.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_cars[index].title),
                subtitle: Text('\₴${_cars[index].price}'),
                onTap: () => _viewCar(context, _cars[index]),
                trailing: IconButton(
                  onPressed: () => _deleteCar(index),
                  icon: const Icon(
                    Icons.delete,
                    size: 26,
                    color: Colors.orange,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
