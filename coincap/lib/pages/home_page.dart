import 'dart:convert';

import 'package:coincap/pages/details_page.dart';
import 'package:coincap/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {


@override
  State<StatefulWidget> createState() {
   return _HomePageState();
  }
  
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  HTTPService? _http;
  String? _selectedCoin = "bitcoin";

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPService>();
  }

  @override
  Widget build(BuildContext context) { 
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width; 
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoinCap'),
      ),
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _coinDropDown(),
          _getdata(),
        ],
      ),),
    );
  }

  Widget _coinDropDown() {

    List<String> _coins = ["bitcoin", "ethereum", "litecoin","tether","cardano","ripple"];
    List<DropdownMenuItem<String>> _dropdownItems = _coins.map((String value) => DropdownMenuItem(value: value, child: Text(value,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600,),),)).toList();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 30),
    decoration: BoxDecoration(
      color: Colors.blue, // Background color of the button
      borderRadius: BorderRadius.circular(10), // Optional: rounded corners
    ),
      child: DropdownButton<String>(
        value: _selectedCoin,
        items: _dropdownItems,
        onChanged: (dynamic _value) {
          setState(() {
            _selectedCoin = _value;
          });
        },
        dropdownColor: Colors.blue,
        iconSize: 30,
        icon: const Icon(
          Icons.arrow_drop_down_sharp,
          color: Colors.white,
        ),
        underline: Container(),
      ),
    );
  }

  Widget _getdata() {
    return Center(
      child: FutureBuilder(
        future: _http!.get("/coins/$_selectedCoin"),
        builder:(BuildContext _context, AsyncSnapshot _snapshot) {
          if(_snapshot.hasData){
            Map _data = jsonDecode(
              _snapshot.data.toString(),
            );
            num _usdPrice = _data["market_data"]["current_price"]["usd"];
            num _change24h = _data["market_data"]["price_change_percentage_24h"];
            Map _exhangeRates = _data["market_data"]["current_price"];
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext _context) {
                          return DetailsPage(rates: _exhangeRates);
                        },
                      ),
                    );
                  },
                  child: _coinImageWidget(
                    _data["image"]["large"],
                  ),
                ),
                _currentPriceWidget(_usdPrice),
                _percentageChangeWidget(_change24h),
                _descriptionCardWidget(
                  _data["description"]["en"],
                ),
              ],
            );
          }else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
      }
      ),
    );
  }
    Widget _currentPriceWidget(num _rate) {
    return Text(
      "${_rate.toStringAsFixed(2)} USD",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _percentageChangeWidget(num _change) {
    return Text(
      "${_change.toString()} %",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _coinImageWidget(String _imgURL) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.02,
      ),
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_imgURL),
        ),
      ),
    );
  }

  Widget _descriptionCardWidget(String _description) {
    return Container(
      height: _deviceHeight! * 0.45,
      width: _deviceWidth! * 0.90,
      margin: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.05,
      ),
      padding: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.01,
        horizontal: _deviceHeight! * 0.01,
      ),
      color: const Color.fromRGBO(83, 88, 206, 0.5),
      child: SingleChildScrollView(
        child: Text(
        _description,
        style: const TextStyle(color: Colors.white),
      )
      ),
    );
  }
}


