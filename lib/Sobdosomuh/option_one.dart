import 'package:flutter/material.dart';
import 'package:siddikbhai_c/Constants.dart';
import 'package:siddikbhai_c/NetworkCall/model/sobdo.dart';
import 'package:siddikbhai_c/Sobdosomuh/one_single.dart';

import '../NetworkCall/remote_service.dart';




class OptionOne extends StatefulWidget {

  String? id;

  OptionOne(this.id);


  @override
  State<OptionOne> createState() => _OptionOneState();
}

class _OptionOneState extends State<OptionOne> {


  List<Sobdo>? allSobdo =[];
  List<OneSingle>? list2 =[];
  bool isLoaded = false;

  @override
  initState() {
    super.initState();
    setState(() {
      _getAllSobdo();
    });

  }

  Future<void> _getAllSobdo() async {
    allSobdo = await RemoteService().getSobdo();
    setState(() {
      // print all elements from allItems
      for(int i = 0; i < allSobdo!.length; i++)
      {
        if(allSobdo![i].catid == widget.id)
        {
          list2!.add(OneSingle( allSobdo![i].ctg,allSobdo![i].shabdasomuho));
        }
      }
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xF3F5F4F4),
      appBar: AppBar(
        backgroundColor: Constants.PRIMARYCOLOR,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("চাটগাঁ ও চলিত শব্দ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child:Text("dlkjflkdjd"),
        /*ListView.builder(
            itemCount: list2?.length,
            itemBuilder: (context,index){
              return list2.elementAt(index);
            }
        )*/
      ),
    );
  }
}
