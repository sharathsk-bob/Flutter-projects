import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  double _borderRadius = 100;
  final Tween<double> _backgroundScale = Tween<double>(begin: 0.0, end: 1.0);

  AnimationController? _starIconAnimationController;

  @override
  void initState() {
    super.initState();
    _starIconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 4,
      ),
    );
    _starIconAnimationController!.repeat();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: 
        Stack(
          clipBehavior: Clip.none,
          children: [
            _pageBackground(),
             Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _animationbutton(),
                _starIcon(),
              ],
            )
          ],
        )
    );
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      tween: _backgroundScale,
      curve: Curves.easeInOutCubicEmphasized,
      duration: Duration(seconds: 1),
      builder: (_context, double _scale, _child) {
        return Transform.scale(
          scale: _scale,
          child: _child,
        );
      },
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  Widget _animationbutton(){
    return Center(
      child: GestureDetector(
        onTap: (){
          _borderRadius += _borderRadius == 200 ? -100 : 100;
          setState(() {
            
          });
        },
        child: AnimatedContainer(duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          width: _borderRadius,
          height: _borderRadius,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          child:const Center(
            child: Text('Click Me',style: TextStyle(fontSize: 20,color: Colors.white),),
          ),
        ),
      ),
    );
  }

   Widget _starIcon() {
    return AnimatedBuilder(
      animation: _starIconAnimationController!.view,
      builder: (_buildContext, _child) {
        return Transform.rotate(
          angle: _starIconAnimationController!.value * 2 * pi,
          child: _child,
        );
      },
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}