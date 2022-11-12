import 'package:flutter/material.dart';
import '../constants.dart';
import '../util/my_box.dart';
import '../util/my_tile.dart';
import 'auth_page.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  get child => null;
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = true;
  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            myDrawer,

            // first half of page
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // first 4 boxes in grid
                  // child: Row(crossAxisAlignment: CrossAxisAlignment.start)

                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(255, 189, 189, 189)),
                    child: Row(children: [
                      Expanded(
                        child: Container(
                          color: Color.fromARGB(255, 189, 187, 187),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .redAccent, //background color of button
                                  side: BorderSide(
                                      width: 3,
                                      color: Colors
                                          .brown), //border width and color
                                  elevation: 6, //elevation of button
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.all(
                                      30) //content padding inside button
                                  ),
                              onPressed: showToast,
                              child: Text("Book A Trip"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color.fromARGB(255, 189, 187, 187),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .redAccent, //background color of button
                                  side: BorderSide(
                                      width: 3,
                                      color: Colors
                                          .brown), //border width and color
                                  elevation: 3, //elevation of button
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.all(
                                      30) //content padding inside button
                                  ),
                              onPressed: () {},
                              child: Text("Booking History"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color.fromARGB(255, 189, 187, 187),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .redAccent, //background color of button
                                  side: BorderSide(
                                      width: 3,
                                      color: Colors
                                          .brown), //border width and color
                                  elevation: 3, //elevation of button
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.all(
                                      30) //content padding inside button
                                  ),
                              onPressed: () {},
                              child: Text("Current Booking"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color.fromARGB(255, 189, 187, 187),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .redAccent, //background color of button
                                  side: BorderSide(
                                      width: 3,
                                      color: Colors
                                          .brown), //border width and color
                                  elevation: 3, //elevation of button
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.all(
                                      30) //content padding inside button
                                  ),
                              onPressed: () {},
                              child: Text("Refund Status"),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  // list of previous days
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: 7,
                  //     itemBuilder: (context, index) {
                  //       return const MyTile();
                  //     },
                  //   ),
                  // ),
                  Visibility(
                    visible: !_isVisible,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.person),
                              hintText: 'Enter your name',
                              labelText: 'Name',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.phone),
                              hintText: 'Enter a phone number',
                              labelText: 'Phone',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.calendar_today),
                              hintText: 'Enter your date of birth',
                              labelText: 'Dob',
                            ),
                          ),
                          new Container(
                              padding:
                                  const EdgeInsets.only(left: 150.0, top: 40.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      child: Text('Submit'),
                                      onPressed: null,
                                    ),
                                    ElevatedButton(
                                      child: Text('Cancel'),
                                      onPressed: showToast,
                                    )
                                  ])),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // second half of page
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: ImageIcon(AssetImage('assets/images/logo.png'),
                            size: 1600)),
                  ),
                  // list of stuff
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 146, 141, 141),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
