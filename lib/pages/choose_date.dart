import 'package:depenses/tools/date_utils.dart';
import 'package:depenses/tools/home_page_bloc.dart';
import 'package:flutter/material.dart';

class ChooseDate extends StatefulWidget {
  @override
  _ChooseDateState createState() => _ChooseDateState();
}

class _ChooseDateState extends State<ChooseDate> {
  HomePageBloc _homePageBloc;

  @override
  void initState() {
    _homePageBloc = HomePageBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue,
                  size: 35.0,
                ),
                onPressed: () {
                  _homePageBloc.subtractDate();
                },
              ),
              StreamBuilder(
                stream: _homePageBloc.dateStream,
                initialData: _homePageBloc.selectedDate,
                builder: (context, snapshot) {
                  return Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          formatterDayOfWeek.format(snapshot.data),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.blue,
                              letterSpacing: 1.2),
                        ),
                        Text(
                          formatterDate.format(snapshot.data),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                            letterSpacing: 1.3,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue,
                  size: 35.0,
                ),
                onPressed: () {
                  _homePageBloc.addDate();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
