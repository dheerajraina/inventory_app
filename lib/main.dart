

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Inventory App",

      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  
  
  bool stockRecord=true;
  bool history=false;
  bool addnew=false;

  String name='';
  String price='';
  String discountedPrice='';
  String quantity='';
  String stockUnits='';
  String category='';
  String description='';

  List inventoryList=[];

  List historyList=[];

  int updateIndex=-10000;

  bool update=false;
  // final myController =TextEditingController();

  // late final  ScrollController _scrollController;

  bool _isSearching=false;
  String searchText='';
  List searchList=[];
  
  // @override
  // void initState(){
  //   super.initState();
  //   _scrollController=new ScrollController();
  // }
  // @override
  // void dispose(){
  //   // myController.dispose();
  //   _scrollController.dispose();

  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    
    searchFunction(searchText){
      for (int i=0;i<inventoryList.length;i++){
        var data=inventoryList[i]['Name'];
        data=data.toLowerCase();
        searchText=searchText.toLowerCase();
        if(data.contains(searchText)){
          searchList.add(inventoryList[i]);
          print(searchList);
          print(inventoryList);

        }
        // setState(() {
        //   _isSearching=false;
        // });
        // searchText='';
      }
    
    
  }
    var size=MediaQuery.of(context).size;
    // print("name = $name");
    // print("price = $price");
    // print("discounted = $discountedPrice");
    // print("quantity = $quantity");
    // print("stocks= $stockUnits");
    // print("category= $category");
    // print("description= $description");
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Inventory")
            ),
          
      ),

      body: Container(
            height: size.height,
            width: size.width,

            decoration: BoxDecoration(
              // color: Colors.red,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.amber,
                  child: Row(
                    children: [
                      SizedBox(
                          width: size.width*0.1,
                        ),
                        Container(
                        decoration: BoxDecoration(
                          color: stockRecord? Colors.blue[50]:Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              
                              stockRecord=true;
                            history=false;
                            addnew=false;
                            });
                          }, 
                          child: Text(
                            "Stock Record",
                            style: TextStyle(
                              fontSize: size.width*0.035,
                            ),
                            )
                          ),
                      ),
                        SizedBox(
                          width: size.width*0.1,
                        ),
                        Container(
                          decoration: BoxDecoration(
                          color: history ? Colors.blue[50]:Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                          child: TextButton(
                          onPressed: (){
                            setState(() {
                              
                              stockRecord=false;
                            history=true;
                            addnew=false;
                            });
                          }, 
                          child: Text(
                            "History",
                            style: TextStyle(
                              fontSize: size.width*0.035,
                            ),
                            )
                          ),
                        ),
                        SizedBox(
                          width: size.width*0.1,
                        ),
                        Container(
                          decoration: BoxDecoration(
                          color: addnew? Colors.blue[50]:Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                          child: TextButton(
                          onPressed: (){
                            setState(() {
                                
                                stockRecord=false;
                              history=false;
                              addnew=true;
                              });
                          }, 
                          child: Text(
                            "Add New",
                            style: TextStyle(
                              fontSize: size.width*0.035,
                            ),
                            )
                          ),
                        ),
                    ],
                  ),
                ),
              stockRecord? Container(
                  margin: EdgeInsets.all(20),
                  child: CupertinoSearchTextField(
                    onSubmitted: (val){
                      searchFunction(val);
                      
                      setState(() {
                        _isSearching=true;
                        
                      });
                    },
                    onSuffixTap: (){
                      setState(() {
                        _isSearching=false;
                        searchList=[];
                      });
                    },
                  ),
                  ):Container(),

                stockRecord? Flexible(
                  child: Container(
                    color:Colors.amberAccent,
                    width: size.width*0.9,
                    height: size.height*0.9,
                      child:StockRecord(context)
                  ),
                ): Container(),
                history? Flexible(
                  child: Container(
                    color:Colors.amberAccent,
                    width: size.width*0.9,
                    height: size.height*0.9,
                      child:History(context)
                  ),
                ): Container(),
                
                addnew? Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: size.height*0.01),
                    color:Colors.amberAccent,
                    width: size.width,
                    height: size.height*0.8,
                      child:AddNew(context)
                  ),
                ): Container(),
                  
              ],
            ),
      ),
    );
  }









Widget StockRecord(context){
  var size=MediaQuery.of(context).size;
  return Scaffold(

        body: !_isSearching? Stack(
          children:[
          inventoryList.length>0?  ListView.builder(
          itemCount:  inventoryList.length,
          itemBuilder: (context,index){
        return InkWell(
          onLongPress: (){
        setState(() {
          update=!update;
          // print(inventoryList[index]['Name']);
            updateIndex=index;
        });
          },
          


          onTap:(){

            setState(() {
              updateIndex=index;
            });

            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context)=>editPage(context)
                ),
              );

          },
          child: Container(
        margin: EdgeInsets.only(bottom: size.height*0.02),
        width: size.width,
        height: size.height*0.12,
        decoration: BoxDecoration(
          color: Colors.black38,
          
          borderRadius: BorderRadius.circular(20),
        
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.01,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top:5,left: 20),
                  child: Text(
                    inventoryList[index]['Name'],
                    
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    ),
                ),
                SizedBox(
                  width: size.width*0.4,
                ),
                Container(
                  margin: EdgeInsets.only(top:5,left: 5),
                  child: Text(
                    "Stock",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    ),
                ),
              ],
            ),

          SizedBox(
                  height: size.height*0.01,
                ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top:5,left: 6),
                  child: Text(
                   "Rs." +  inventoryList[index]['Discounted Price'],
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    ),
                ),
                SizedBox(
                  width: size.width*0.4,
                ),
                Container(
                  margin: EdgeInsets.only(top:5,left: 6),
                  child: Text(
                    // "Stock",
                    inventoryList[index]['Units'],
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    ),
                ),
                // Text((inventoryList[index]['Date Stamp']).toString()),
              ],
            ),
          ],
        ),
          ),
        );
          }
        ): Container(child: Center(child: Text("Add Items"),),),

          update?Dialog(
            // backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child:Container(
                width: size.width*0.7,
                height: size.height*0.5,
                // margin: EdgeInsets.only(top: size.height*0.1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child:Column(
                  children: [
                    Text(
                      // "Update your "+inventoryList[index]['Name']+" stock",
                      "Update "+ inventoryList[updateIndex]["Name"]+" Stock",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(
                        height:size.height*0.02,
                      ),
                    Text(
                      ((DateTime.now().toIso8601String()).split("T"))[0],
                        style: TextStyle(
                          fontSize: 30,
                        ),                      
                      ),
                    Text(
                      ((((DateTime.now().toIso8601String()).split("T"))[1]).split("."))[0],
                        style: TextStyle(
                          fontSize: 30,
                        ),                      
                      ),
                      SizedBox(
                        height:size.height*0.02,
                      ),
                      Container(
                        width: size.width*0.5,
                        child: TextField(
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            hintText: "Enter Stock"
                          ),
                          onChanged: (val){
                            setState(() {
                              inventoryList[updateIndex]['Units']=val;
                            });
                          },
                        ),
                        
                      ),

                    SizedBox(
                      height: size.height*0.1,
                    ),
                     InkWell(
                        child: Container(
                          width:size.width*0.4,
                          height: size.height*0.1,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text
                            (
                              "Update",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        ),
                        onTap: (){
                      var date=((DateTime.now().toIso8601String()).split("T"))[0];
                      date=date.toString();
                          historyList.add(
                          {
                            'Name':inventoryList[updateIndex]['Name'],
                            'Price':inventoryList[updateIndex]['Price'],
                            'Discounted Price' :inventoryList[updateIndex]['Discounted Price'],
                            'Quantity':inventoryList[updateIndex]['Quantity'],
                            'Units':inventoryList[updateIndex]['Units'],
                            'Category': inventoryList[updateIndex]['Category'],
                            'Description':inventoryList[updateIndex]['Description'],
                            'Date Stamp': date,
                          }
                          );
                          setState(() {
                            update=!update;
                          });
                        },
                     ), 
                  ],
                )
          ),
          ):Container(),
          ],
        ):
        


          Stack(
          children:[
          searchList.length>0?  ListView.builder(
          itemCount:  searchList.length,
          itemBuilder: (context,index){
        return InkWell(
        //   onLongPress: (){
        // setState(() {
        //   update=!update;
        //   // print(inventoryList[index]['Name']);
        //     updateIndex=index;
        // });
        //   },
          


          // onTap:(){

          //   setState(() {
          //     updateIndex=index;
          //   });

          //   Navigator.push(
          //     context, 
          //     MaterialPageRoute(
          //       builder: (context)=>editPage(context)
          //       ),
          //     );

          // },
          child: Container(
        margin: EdgeInsets.only(bottom: size.height*0.02),
        width: size.width,
        height: size.height*0.12,
        decoration: BoxDecoration(
          color: Colors.black38,
          
          borderRadius: BorderRadius.circular(20),
        
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.01,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top:5,left: 20),
                  child: Text(
                    searchList[index]['Name'],
                    
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    ),
                ),
                SizedBox(
                  width: size.width*0.4,
                ),
                Container(
                  margin: EdgeInsets.only(top:5,left: 5),
                  child: Text(
                    "Stock",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    ),
                ),
              ],
            ),

          SizedBox(
                  height: size.height*0.01,
                ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top:5,left: 6),
                  child: Text(
                   "Rs." +  searchList[index]['Discounted Price'],
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    ),
                ),
                SizedBox(
                  width: size.width*0.4,
                ),
                Container(
                  margin: EdgeInsets.only(top:5,left: 6),
                  child: Text(
                    // "Stock",
                    searchList[index]['Units'],
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    ),
                ),
                // Text((inventoryList[index]['Date Stamp']).toString()),
              ],
            ),
          ],
        ),
          ),
        );
          }
        ): Container(child: Center(child: Text("No Results"),),),

          update?Dialog(
            // backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child:Container(
                width: size.width*0.7,
                height: size.height*0.5,
                // margin: EdgeInsets.only(top: size.height*0.1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child:Column(
                  children: [
                    Text(
                      // "Update your "+inventoryList[index]['Name']+" stock",
                      "Update "+ inventoryList[updateIndex]["Name"]+" Stock",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(
                        height:size.height*0.02,
                      ),
                    Text(
                      ((DateTime.now().toIso8601String()).split("T"))[0],
                        style: TextStyle(
                          fontSize: 30,
                        ),                      
                      ),
                    Text(
                      ((((DateTime.now().toIso8601String()).split("T"))[1]).split("."))[0],
                        style: TextStyle(
                          fontSize: 30,
                        ),                      
                      ),
                      SizedBox(
                        height:size.height*0.02,
                      ),
                      Container(
                        width: size.width*0.5,
                        child: TextField(
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            hintText: "Enter Stock"
                          ),
                          onChanged: (val){
                            setState(() {
                              inventoryList[updateIndex]['Units']=val;
                            });
                          },
                        ),
                        
                      ),

                    SizedBox(
                      height: size.height*0.1,
                    ),
                     InkWell(
                        child: Container(
                          width:size.width*0.4,
                          height: size.height*0.1,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text
                            (
                              "Update",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        ),
                        onTap: (){
                      var date=((DateTime.now().toIso8601String()).split("T"))[0];
                      date=date.toString();
                          historyList.add(
                          {
                            'Name':inventoryList[updateIndex]['Name'],
                            'Price':inventoryList[updateIndex]['Price'],
                            'Discounted Price' :inventoryList[updateIndex]['Discounted Price'],
                            'Quantity':inventoryList[updateIndex]['Quantity'],
                            'Units':inventoryList[updateIndex]['Units'],
                            'Category': inventoryList[updateIndex]['Category'],
                            'Description':inventoryList[updateIndex]['Description'],
                            'Date Stamp': date,
                          }
                          );
                          setState(() {
                            update=!update;
                          });
                        },
                     ), 
                  ],
                )
          ),
          ):Container(),
          ],
        ),

  );
}















Widget History(context){
  var size=MediaQuery.of(context).size;
  return Scaffold(
        
        body:  Column(
          children: [

            Container(
              
            ),
            historyList.length>0 ? ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context,index){

                return Container(
                  width:size.width*0.2,
                  height: size.height*0.15,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(30),
                    
                  ),
                  margin:EdgeInsets.only(top: 20,bottom:20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:10,left: 30),
                            child: Text(
                              historyList[index]['Name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),

                            ),
                          ),
                          
                        ],
                      ),
                      
                      SizedBox(
                        height: size.height*0.01,
                      ),
                         
                          Row(
                            children:[
                              Container(
                            margin: EdgeInsets.only(top:2,left: size.width*0.05),
                            child: Text(
                              "Units",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:10,left: size.width*0.5),
                            child: Text(
                              historyList[index]['Units'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),

                            ),
                          ),
                            ],
                          ),

                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:2,left: size.width*0.04),
                            child: Text(
                              "Updated On  "+ historyList[index]['Date Stamp'],
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),

                            ),
                          ),
                        ],
                      ),
                          
                    ],
                  ),
                );

              }):Container(child: Center(child: Text("No History"),),),
          ],
        ),
        

  );
}


















Widget AddNew(context){
  var size =MediaQuery.of(context).size;
  return Scaffold(

        body:Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                // apple
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Item name",
                  
                ),
                onChanged: (val){
                  setState(() {
                    name=val;
                  });
                },
              ),
              SizedBox(
                     height: size.height*0.02,
                   ),
               Row(
                 children: [
                   Container(
                     width: size.width*0.4,
                     child: TextField(
                        // apple
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Price",
                          
                        ),
                        onChanged: (value){
                          setState(() {
                            price=value;
                          });
                        },
                      ),
                   ),
                   SizedBox(
                     width: size.width*0.1,
                   ),
                   Container(
                     width: size.width*0.4,
                     child: TextField(
                        // apple
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Discounted Price",
                          
                        ),
                        onChanged: (val){
                          setState(() {
                            
                            discountedPrice=val;
                          });
                        },
                      ),
                   ),
                 ],
               ),
              
              SizedBox(
                     height: size.height*0.02,
                   ),
               Row(
                 children: [
                   Container(
                     width: size.width*0.4,
                     child: TextField(
                        // apple
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Quantity in Kgs",
                          
                        ),
                        onChanged: (val){
                          setState(() {
                            quantity=val;
                          });
                        },
                      ),
                   ),
                   SizedBox(
                     width: size.width*0.1,
                   ),
                   Container(
                     width: size.width*0.4,
                     child: TextField(
                        // apple
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Stock Units",
                          
                        ),

                        onChanged: (value) {
                          setState(() {
                            stockUnits=value;
                          });
                        },
                      ),
                   ),
                 ],
               ),
                SizedBox(
                     height: size.height*0.02,
                   ),
               TextField(
                // apple
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Category",
                ),
                onChanged: (value) {
                  setState(() {
                    category=value;
                  });
                },
              ),
              SizedBox(
                     height: size.height*0.02,
                   ),
          
              TextField(
                // apple
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Description",
                ),
                onChanged:(value){
                    setState(() {
                      description=value;
                    });
                }
              ),
          
              SizedBox(
                     height: size.height*0.03,
                   ),

              InkWell(
                onTap: (){
                  // print(myController.text);
                  if (name.length>0 && price.length>0 && quantity.length>0 && stockUnits.length>0 && category.length>0){
                  var date=((DateTime.now().toIso8601String()).split("T"))[0];
                  date=date.toString();
                   setState(() {
                  inventoryList.add(
                    {
                      'Name':name,
                      'Price':price,
                      'Discounted Price' :discountedPrice,
                      'Quantity':quantity,
                      'Units':stockUnits,
                      'Category': category,
                      'Description':description,
                      
                    }
                  );
                  //  name.length>0 && price.length>0 && quantity.length>0 && stockUnits.length>0 && category.length>0 ? 
                   historyList.add(
                    {
                      'Name':name,
                      'Price':price,
                      'Discounted Price' :discountedPrice,
                      'Quantity':quantity,
                      'Units':stockUnits,
                      'Category': category,
                      'Description':description,
                      'Date Stamp': date,
                    })/*:Container()*/;

                  // name.length>0 && price.length>0 && quantity.length>0 && stockUnits.length>0 && category.length>0?
                  
                    addnew=!addnew;
                    stockRecord=!stockRecord;
                  })/*:Container()*/;

                  }else{
                    noData();
                                     // print(inventoryList[0]['name']);
                }},
                child: Container(
                  width: size.width*0.5,
                  height: size.height*0.07,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "Add Item",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      ),
                      ),
                ),
              ),
            ],
          ),
        ),  
        

  );
}

noData(){
  return showDialog(
    context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Data Incomplete'),
          
          actions: <Widget>[
            
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
}


Widget editPage(context){
  var size =MediaQuery.of(context).size;
  return Scaffold(
        appBar: AppBar(),
        body:Container(
          height:size.height,
          width: size.width,
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                // apple
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: inventoryList[updateIndex]['Name'],
                  
                  
                ),
                onChanged: (val){
                  setState(() {
                    name=val;
                  });
                },
              ),
              SizedBox(
                     height: size.height*0.02,
                   ),
               Row(
                 children: [
                   Container(
                     width: size.width*0.4,
                     child: TextField(
                        // apple
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: inventoryList[updateIndex]['Price'],
                          
                        ),
                        onChanged: (value){
                          setState(() {
                            price=value;
                          });
                        },
                      ),
                   ),
                   SizedBox(
                     width: size.width*0.1,
                   ),
                   Container(
                     width: size.width*0.4,
                     child: TextField(
                        // apple
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: inventoryList[updateIndex]['Discounted Price'],
                          
                        ),
                        onChanged: (val){
                          setState(() {
                            
                            discountedPrice=val;
                          });
                        },
                      ),
                   ),
                 ],
               ),
              
              SizedBox(
                     height: size.height*0.02,
                   ),
               Row(
                 children: [
                   Container(
                     width: size.width*0.4,
                     child: TextField(
                        // apple
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: inventoryList[updateIndex]['Quantity'],
                          
                        ),
                        onChanged: (val){
                          setState(() {
                            quantity=val;
                          });
                        },
                      ),
                   ),
                   SizedBox(
                     width: size.width*0.1,
                   ),
                   Container(
                     width: size.width*0.4,
                     child: TextField(
                        // apple
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: inventoryList[updateIndex]['Units'],
                          
                        ),

                        onChanged: (value) {
                          setState(() {
                            stockUnits=value;
                          });
                        },
                      ),
                   ),
                 ],
               ),
                SizedBox(
                     height: size.height*0.02,
                   ),
               TextField(
                // apple
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: inventoryList[updateIndex]['Category'],
                ),
                onChanged: (value) {
                  setState(() {
                    category=value;
                  });
                },
              ),
              SizedBox(
                     height: size.height*0.02,
                   ),
          
              TextField(
                // apple
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: inventoryList[updateIndex]['Description'],
                ),
                onChanged:(value){
                    setState(() {
                      description=value;
                    });
                }
              ),
          
              SizedBox(
                     height: size.height*0.03,
                   ),

              InkWell(
                onTap: (){
                  var date=((DateTime.now().toIso8601String()).split("T"))[0];
                  date=date.toString();

                  setState(() {
                    name.length>0 ? inventoryList[updateIndex]['Name']=name:null;
                  price.length>0 ?  inventoryList[updateIndex]['Price']=price: null;
                  discountedPrice.length>0 ? inventoryList[updateIndex]['Discounted Price']=discountedPrice : null;
                  quantity.length>0 ? inventoryList[updateIndex]['Quantity']=quantity : null;
                  stockUnits.length>0 ?  inventoryList[updateIndex]['Units']=stockUnits : null;
                  category.length>0 ?  inventoryList[updateIndex]['Category']=category : null;
                  description.length>0 ?   inventoryList[updateIndex]['Description']=description : null;



                  historyList.add(
                    {
                      'Name':name.length>0 ? name: inventoryList[updateIndex]['Name'],
                      'Price':price.length>0 ? price: inventoryList[updateIndex]['Price'],
                      'Discounted Price' :discountedPrice.length>0 ? discountedPrice: inventoryList[updateIndex]['Discounted Price'],
                      'Quantity':quantity.length>0 ?quantity : inventoryList[updateIndex]['Quantity'],
                      'Units':stockUnits.length>0 ? stockUnits: inventoryList[updateIndex]['Units'],
                      'Category': category.length>0 ? category:  inventoryList[updateIndex]['Category'],
                      'Description':description.length>0 ? description:  inventoryList[updateIndex]['Description'],
                      'Date Stamp': date,
                    });
                    
                  });
                  
                  Navigator.pop(context);
                 },
                child: Container(
                  width: size.width*0.5,
                  height: size.height*0.07,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "Edit Item",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      ),
                      ),
                ),
              ),
            ],
          ),
        ),  
    

  );
}

}









