//To create the transaction list by accepting the values and then formatiing the list
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget{
  final List<Transaction>Transactions;
  Function deletetx;

  TransactionList(this.Transactions,this.deletetx);
 @override
  Widget build(BuildContext context){
    return Transactions.isEmpty?
    LayoutBuilder(builder: (ctx,contraints){
      return Column(children: <Widget>[
        Text(
            'You haven\'t added any items yet :)'
        ),
        SizedBox(
          height: 2,
        ),
        Container(
            height: contraints.maxHeight*0.6,
            child:Align(alignment: Alignment.center,
                child:Image.asset('assets/Images/timetoshop.png',fit: BoxFit.cover,height: 300,width:300)))
      ],);
    }): ListView.builder(itemBuilder:(ctx,index)
    {
      return Card(
        margin: EdgeInsets.symmetric(vertical:8,horizontal: 10),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: FittedBox(child: Text('\$${Transactions[index].price}')),
          ),
          title: Text(Transactions[index].title,style:Theme.of(context).textTheme.title,),
          subtitle: Text(DateFormat.yMMMMd().format(Transactions[index].date),
          ),
          trailing:MediaQuery.of(context).size.width>360?FlatButton.icon(
              textColor:Theme.of(context).errorColor,onPressed: ()=>deletetx(Transactions[index].id), icon:Icon(Icons.delete), label: Text("Delete")):
          IconButton(icon: Icon(Icons.delete), color:Theme.of(context).errorColor,onPressed:()=>deletetx(Transactions[index].id)),
        ),
      );
    },

      //To make only the list scrollable//        return Card(
//          color: Colors.yellow,
//          child: Row(                       //to hold value box and title next to each other
//            children: <Widget>[
//              Container(                    //value box is a container
//                margin:EdgeInsets.symmetric(
//                  vertical:10,
//                  horizontal:15,
//                ),
//                decoration: BoxDecoration(
//                    border: Border.all(
//                      color: Theme.of(context).primaryColor,
//                      width:2,
//                    )
//                ),
//                padding:EdgeInsets.all(5.0),
//                child: Text(                                    //Text inside value box
//                  '\$ ${Transactions[index].price.toStringAsFixed(2)}',
//                  style: TextStyle(color:  Theme.of(context).primaryColor,
//                    fontWeight: FontWeight.bold,
//                    fontStyle: FontStyle.normal,
//                    fontSize:10,
//                  ),
//                ),
//              ),
//              Column(                                            //This Column lies inside Row
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text(Transactions[index].title,
//                    style: Theme.of(context).textTheme.title,),
//                  Text(
//                    DateFormat.yMMMMd().format(Transactions[index].date),
//                    style: TextStyle(color: Colors.blueGrey,
//                      fontSize: 10,),),
//                ],
//              ),
//            ],
//          ),
//        );
      //   },                     //Function of listviewbuilder ends
      itemCount:Transactions.length,
    );
  }
}

