import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import'../widgets/chart_bar.dart';
import '../models/transaction.dart';
class Chart extends StatelessWidget{
 final List<Transaction> recenttransactions;
  Chart(this.recenttransactions);
  List<Map<String,Object>> get groupedtransactions{
    return List.generate(7, (index){
      final weekday=DateTime.now().subtract(Duration(days:index));
      double totalsum=0.0;
      for(var i=0;i<recenttransactions.length;i++)
        {
          if(recenttransactions[i].date.day==weekday.day&&recenttransactions[i].date.month==weekday.month&&recenttransactions[i].date.year==weekday.year)
        {
          totalsum+=recenttransactions[i].price;
        }
        }
        print(DateFormat.E().format(weekday).substring(0,1));                      //total sum= sum of transactions in a day
      print(totalsum);
      return{'day':DateFormat.E().format(weekday).substring(0,1),'amount':totalsum
      };
    }).reversed.toList();
  }
 double get totalspending{
    return groupedtransactions.fold(0.0,(sum,item){
      return sum + item['amount'];
    }
    );
 }
  @override
  Widget build(BuildContext context) {
    print(groupedtransactions);
    return Card(
        elevation: 6,
          margin: EdgeInsets.all(20),
        child:Padding(padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedtransactions.map((data){
            return Flexible(
              fit: FlexFit.tight,
                child: ChartBar(data['day'],data['amount'],totalspending==0.0?0.0:(data['amount'] as double)/totalspending));
            }).toList(),
          ),
        ),
      );
    }
}