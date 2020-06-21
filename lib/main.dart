import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testcrossflutterapp/main/main_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
            create: (context) => MainBloc()..add(InitialMainEvent()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'ทดสอบ Scanner'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  MainBloc _mainBloc;


  @override
  Widget build(BuildContext context) {

    _mainBloc = BlocProvider.of<MainBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: GoogleFonts.itim(),
          ),
        ),
        body: BlocBuilder<MainBloc, MainState>(builder: (context, _state) {
          if (_state is NormalMainState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _state.barcode ?? "ไม่พบข้อมูล",
                    style: GoogleFonts.itim(fontSize: 30),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      _mainBloc.add(OpenScannerMainEvent());
                    },
                    color: Colors.blue,
                    elevation: 0,
                    child: Text(
                      "เริ่ม Scan",
                      style: GoogleFonts.itim(color: Colors.white,fontSize: 20),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container(
              color: Colors.black,
            );
          }
        }));
  }
}
