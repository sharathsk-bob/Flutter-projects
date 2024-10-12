import 'package:flutter/material.dart';
import 'package:frivia/pages/home_page.dart';
import 'package:frivia/provider/game_page_provider.dart';

class MainPage extends StatefulWidget {
  @override
  State createState() => _MainPageSlider();
}

class _MainPageSlider extends State<MainPage> {
  HomePageProvider? _homePageProvider;
  double? _deviceHeight,_deviceWidth;
  double _sliderValue = 0;

  // Map the slider value to the corresponding difficulty level
  String getDifficultyText() {
    switch (_sliderValue.round()) {
      case 0:
        return 'easy';
      case 1:
        return 'medium';
      case 2:
        return 'difficult';
      default:
        return 'easy';
    }
  }
  @override
  Widget build(BuildContext context) {
     _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: SafeArea(
        //padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text('Frivia',style: TextStyle(fontSize: 45.0,color: Colors.white,fontWeight: FontWeight.w400),),
                ),
                Center(
                  child: Text(getDifficultyText(),style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.w400),),
                ),
                _sliderfunction(),
                 _startButton(),
          
              ],
            ),
        ),
      ),
    );
  }

  Widget _sliderfunction(){
    return Slider(
              value: _sliderValue,
              min: 0,
              max: 2,
              divisions: 2, // Divides the slider into 3 parts: Easy, Medium, Difficult
              label: getDifficultyText(),
              onChanged: (newValue) {
                setState(() {
                  _sliderValue = newValue;
                });
              },
            );
  }

  Widget _startButton(){
    return MaterialButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder:(context) => HomePage(diffciultyLevel: getDifficultyText(),)));
      },
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text('Start',style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.w400),),
    );
  }
}