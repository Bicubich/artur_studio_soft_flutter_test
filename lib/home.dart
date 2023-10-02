import 'package:artur_studio_soft_flutter_test/authorization_page.dart';
import 'package:artur_studio_soft_flutter_test/calculator_page.dart';
import 'package:artur_studio_soft_flutter_test/weather_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  Widget myAuth = const MyAuthorization();
  Widget myCalculator = const MyCalculator();
  Widget myWeather = const MyWeather();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.exit_to_app,
            ),
            label: "Authorization",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calculate_rounded,
            ),
            label: "Calculator",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cloud,
            ),
            label: "Weather",
          ),
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return myAuth;
    } else if (selectedIndex == 1) {
      return myCalculator;
    } else {
      return myWeather;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class MyAuthorization extends StatelessWidget {
  const MyAuthorization({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthorizationPage();
  }
}

class MyCalculator extends StatelessWidget {
  const MyCalculator({super.key});
  @override
  Widget build(BuildContext context) {
    return const CalculatorPage();
  }
}

class MyWeather extends StatelessWidget {
  const MyWeather({super.key});
  @override
  Widget build(BuildContext context) {
    return const WeatherPage();
  }
}
