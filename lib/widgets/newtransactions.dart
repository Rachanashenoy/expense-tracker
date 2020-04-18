//To accept new transaction data through textfields
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransactions extends StatefulWidget{
  final Function addtx;
  NewTransactions(this.addtx);
  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _textinput2=TextEditingController();
  final _priceinput2=TextEditingController();
DateTime _Selecteddate;
  void SubmitData(){
    if(_priceinput2.text==null)
      {
        return;
      }
    final title=_textinput2.text;
    final price=double.parse(_priceinput2.text);
    if(title.isEmpty||price<=0|| _Selecteddate==null)
      return;
    widget.addtx(title,price,_Selecteddate);
    Navigator.of(context).pop();
    }
void _presentDatepicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate:DateTime.now()).then((pickeddate) {
      if (pickeddate == null)
        return;
      setState(() {
        _Selecteddate = pickeddate;
      });

    }
    );
}
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Card(
        elevation: 15.0,
        child:Container(
          padding: EdgeInsets.only(top:10,left:10,right:10,bottom:MediaQuery.of(context).viewInsets.bottom+10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(decoration: InputDecoration(labelText: 'ITEM'),
                //onChanged: (value){textinput1=value;},
                controller: _textinput2,
              ),
              TextField(decoration: InputDecoration(labelText: 'PRICE'),
                //onChanged:(value){priceinput1=value;}
                controller: _priceinput2,
                keyboardType: TextInputType.number,
                onSubmitted:(_)=>SubmitData(),
              ),
              Flexible(
                fit:FlexFit.tight,
                child: Row(children: <Widget>[
                  Flexible(
                    fit:FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_Selecteddate==null?"No date chosen":"Picked date:${DateFormat.yMd().format(_Selecteddate)}",style: TextStyle(fontWeight: FontWeight.bold),),
                      )),
                  RaisedButton(onPressed: _presentDatepicker,child: Text('Pick a date',style: TextStyle(fontWeight: FontWeight.bold),),)
                ],),
              ),
              RaisedButton(
                onPressed:SubmitData,
                child: Text('ADD TRANSACTION',style: TextStyle(fontFamily: 'OpenSans'),),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ],),
        ),
      ),
    ) ;
  }
}