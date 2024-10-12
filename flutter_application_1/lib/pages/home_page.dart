import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_dropdown_buttons.dart';

class HomePage extends StatelessWidget {
  late double _deviceheight,_devicewidth;
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceheight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body:SafeArea(child: Container(
        height: _deviceheight,
        width: _devicewidth,
        padding: EdgeInsets.symmetric(horizontal: _devicewidth * 0.05),
        child: Stack(
          children: [
            Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextContainer(),
            _bookRideWidget(),
          ],
        ),
        Align(
              alignment: Alignment.centerRight,
              child: _assetImageContainer(),
            ),
          ],
        )
      )),
    );
  }
  Widget TextContainer() {
    return Container(
      child: const Text(
        '#GoMoon',
        style: TextStyle(
          color: Colors.white,
          fontSize: 70.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  } 
  Widget _assetImageContainer() {
    return Container(
      height: _deviceheight*0.5,
      width: _devicewidth*0.65,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/astro_moon.png'),
        ),
      )
    );
  }

  Widget _dropdownMenu() {
    const List<String> itemsList = ['Item 1', 'Item 2', 'Item 3'];

   return CustomDropdownButtons(itemsList: itemsList, width: _devicewidth);
  }

  Widget _dropdownMenuNew() {
    const List<String> itemsListNew = ['1', '2', '3'];
    const List<String> itemsListNew2 = ['Economy', 'Business', 'First'];

   return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       CustomDropdownButtons(itemsList: itemsListNew, width: _devicewidth*0.45),
       CustomDropdownButtons(itemsList: itemsListNew2, width: _devicewidth*0.40),
     ],
   );
  }

  Widget _bookRideWidget(){
    return Container(
      height: _deviceheight * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_dropdownMenu(), _dropdownMenuNew(),_rideButton()],
      ),
    );
   }

   Widget _rideButton(){
    return Container(
      // height: _deviceheight * 0.08,
      margin: EdgeInsets.only(bottom: _deviceheight * 0.005),
      width: _devicewidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: MaterialButton(onPressed: () {}, child: const Text('Book Ride',style: TextStyle(color: Colors.black),)),
    );
   }
}