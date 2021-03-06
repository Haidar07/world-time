import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments ;
    print(data);

    // set background
    String bgImage = data['isDaytime'] ? 'day.png': 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.lightBlue : Colors.indigo[200];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 120),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'flag': result['flag'],
                            'isDaytime': result['isDaytime'],
                          };
                        });
                      },
                      icon: Icon(Icons.edit_location,
                      color: Colors.grey[200],),
                      label: Text('Edit location',
                      style: TextStyle( color: Colors.grey[200])),
                      ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(data['location'],
                           style: TextStyle(
                             fontSize: 28,
                             letterSpacing: 2,
                             color: Colors.white,
                           ),)
                    ],

                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(data['time'],
                      style: TextStyle(
                        fontSize:50,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}
