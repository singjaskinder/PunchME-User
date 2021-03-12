import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NearBy extends StatefulWidget {
  NearBy({Key key}) : super(key: key);

  @override
  _NearByState createState() => _NearByState();
}

class _NearByState extends State<NearBy> with SingleTickerProviderStateMixin {
  bool showPicker = false;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: Text("text"),
            onPressed: () {
              showPicker = !showPicker;
              if (showPicker) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
          SizeTransition(
            sizeFactor: _controller,
            child: Container(
              height: 150,
              child: CupertinoPicker(
                backgroundColor: Colors.transparent,
                itemExtent: 40,
                children: List<Widget>.generate(
                    98,
                    (index) => Center(
                          child: Text(
                            '${index + 2}',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        )),
                onSelectedItemChanged: (item) {
                  print((item + 2).toString());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
