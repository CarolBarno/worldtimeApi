import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; //ui name location
  String time; // time in that location
  String flag; //url for asset flag
  String url; //location url for api endpoint
  bool isDayTime; //true or false if daytime or not


  WorldTime({this.location, this.flag, this.url});

  
  Future<void > getTime() async {

    try{
      //make request
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);
    //print(data);
    

    //get properties form data
    String dateTime = data['datatime'];
    String offset = data['utc_offset'].substring(1,3);
   // print(dateTime);
   // print(offset);

   //create datetime object
   DateTime now = DateTime.parse(dateTime);
   now = now.add(Duration(hours: int.parse(offset)));
   
   //set time property
   isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
   time = DateFormat.jm().format(now);

    }
    catch(e)
    {
      print('caught error:  $e');
      time = 'could not get time';
      
    }

 }

}