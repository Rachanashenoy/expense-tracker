import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/newtransactions.dart';
import './widgets/chart.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.yellowAccent,
        fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
        title: TextStyle(fontFamily: 'OpenSans',  //All the titles text should be themed like this
            fontSize: 18,
            fontWeight:FontWeight.bold ),
     button: TextStyle(color: Colors.white) //All the button's text should be themed like this
          ),
        appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight:FontWeight.bold)
      ))
      ),
      home: Homepage(),
    );
  }
}
class Homepage extends StatefulWidget{
 //String textinput1;
 //String priceinput1;
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  bool _showchart=false;
  final List<Transaction> _userTransactions = [
//    Transaction(
//    id: '1234R',
//    title: 'Gucci bag',
//    price: 85000,
//    date: DateTime.now(),
//  ),
//  Transaction(
//    id: '1482Q',
//    title: 'PENCIL HEELS BY BLAK',
//    price: 8000,
//    date: DateTime.now(),
//  ),
  ];
  List<Transaction> get _recenttransactions{     //to return a shorlisted usertransactionlist which only has transactions done within a week
    return _userTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  void _addTransactions (String txtitle,double txprice,DateTime chosendate) //To add new transactions into the list
  {
    final newtx=Transaction(id: DateTime.now().toString(), title:txtitle, price:txprice , date:chosendate);
    setState(() {
      _userTransactions.add(newtx);
    });
  }
  void startAddNewTransactions(BuildContext ctx){    //to display modalbottomsheet
    showModalBottomSheet(context:ctx, builder: (_){
      return  GestureDetector(
          onTap:(){},child:NewTransactions(_addTransactions),
          behavior:HitTestBehavior.opaque,
      );
    });
  }
  void deletetransactions(String id)
  {setState(() {
    _userTransactions.removeWhere((tx){
      return tx.id==id;
    }
    );
  });
  }
 List<Widget> landscapebuilder(MediaQueryData mediaQuery,AppBar appBar,Widget txListWidget ){
    return [Row(children:[
      Text("Show chart"),
      Switch(
          value: _showchart,
          onChanged: (val){
        setState(() {
          _showchart=val;
        });
        }
      )
    ],
    ),
    _showchart?Container(
        height:(mediaQuery.size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
        child: Chart(_recenttransactions)
    )
        :txListWidget
    ];
  }
  List<Widget>portraitmodebuilder(MediaQueryData mediaQuery,AppBar appBar,Widget txListWidget ){
    return  [ Container(
        height:(mediaQuery.size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
        child: Chart(_recenttransactions)
    ),txListWidget
    ];
  }
  Widget _appBar(){
    return AppBar(
      title: Text('Expense Tracker',style: TextStyle(fontFamily: 'OpenSans'),),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add),onPressed:()=>startAddNewTransactions(context))
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery=MediaQuery.of(context);
    final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    final PreferredSizeWidget appBar=_appBar();
    final txListWidget=Container( height:(mediaQuery.size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
        child: TransactionList(_userTransactions.reversed.toList(),deletetransactions));
    return Scaffold(
      appBar: appBar,
      body:  SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              if(isLandscape) ... landscapebuilder(mediaQuery, appBar,txListWidget),
               if(!isLandscape) ... portraitmodebuilder(mediaQuery, appBar,txListWidget),

            ],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child:Icon(Icons.add),onPressed: ()=> startAddNewTransactions(context)),
    );
  }
}

