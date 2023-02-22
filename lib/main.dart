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

  Car(this.title,this.description,this.price);
}

class _MyAppState extends State<MyApp>{
  final List<Car> _cars = [
    Car('BMW', 'Germany Car', 15000),
    Car("Toyota", 'Japan Car', 20000),
    Car('Renault', 'French Car', 10000),
  ];

  void _addCar(){
    setState((){
      _cars.add(
          Car('Unknown', 'model', 404));
    });
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
                  child: Text('End this'))
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
          title:Text('Wlecome to the club'),
          actions:[
            IconButton(
                onPressed: _addCar,
                icon: const Icon(
                  Icons.add,
                  size: 38,
                  color: Colors.yellow,)
            ),
          ],
        ),
        body: ListView.builder(
            itemCount:_cars.length,
            itemBuilder:(BuildContext context, int index) {
              return ListTile(
                title: Text(_cars[index].title),
                subtitle: Text('\₴${_cars[index].price}'),
                onTap: () => _viewCar(context, _cars[index]),
                trailing:IconButton(
                    onPressed:() => _deleteCar(index),
                    icon: const Icon(
                      Icons.delete,
                      size: 26,
                      color: Colors.orange,
                    ),
                ),
              );
            }
        ),
      ),
    );
  }
}
