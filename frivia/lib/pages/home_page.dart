import 'package:flutter/material.dart';
import 'package:frivia/provider/game_page_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget{
  double? _deviceHeight,_deviceWidth;
  HomePageProvider? _homePageProvider;
  final String diffciultyLevel;
  HomePage({required this.diffciultyLevel});
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(create: (_context) => HomePageProvider(context: context,difficultyLevel: diffciultyLevel,),child: _buildHomePage(),);
  }
  Widget _buildHomePage(){
    return Builder(
      builder: (_context) {
        _homePageProvider= _context.watch<HomePageProvider>();
        if(_homePageProvider!.questions != null){
          return Scaffold(
          body:SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _questionText(),
                  Column(
                    children: [
                      _trueButton(),
                      SizedBox(height: _deviceHeight! * 0.01,),
                      _falseButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
        }else{
          return const Center(child: CircularProgressIndicator(color: Colors.white,),);
        }
      }
    );
  }
  Widget  _questionText(){
    return Text(_homePageProvider!.getCurrentQuestionText(),style: const TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.w400),);
  }

  Widget _trueButton(){
    return MaterialButton(
      onPressed: (){
        _homePageProvider!.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text('True',style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.w400),),
    );
  }

  Widget _falseButton(){
    return MaterialButton(
      onPressed: (){
        _homePageProvider!.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text('False',style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.w400),),
    );
  }
}