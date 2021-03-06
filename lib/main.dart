

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'datetime.dart';
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
      // scrollBehavior: ,
    );
  }
}



class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _controller=TextEditingController();
  //variables for top app bar
  
  bool stockRecord=true;
  bool history=false;
  bool addnew=false;

  //variables for data to to stored
  String name='';
  String price='';
  String discountedPrice='';
  String quantity='';
  String stockUnits='';
  String category='';
  String description='';
  
  //for list of Inventory
  List inventoryList=[];
  
  //for keeping track of History
  List historyList=[
    {
                      'Name':"one week",
                      'Price':"20",
                      'Discounted Price' :"15",
                      'Quantity':"100",
                      'Units':"1 ",
                      'Category': "Dont know",
                      'Description':"Too Long",
                      'Date Stamp': (DateTime.now()).subtract(Duration(days: 7)),
                    },
                    {
                      'Name':"one month",
                      'Price':"30",
                      'Discounted Price' :"20",
                      'Quantity':"100 ",
                      'Units':"200",
                      'Category': "Dont know",
                      'Description':"Too Long",
                      'Date Stamp': DateTime(now.year,now.month-1,now.day),
                    },

                    {
                      'Name':"one year",
                      'Price':"100",
                      'Discounted Price' :"50",
                      'Quantity':"350",
                      'Units':"15",
                      'Category': "Dont know",
                      'Description':"Too Long",
                      'Date Stamp': DateTime(now.year-1,now.month,now.day),
                    }
  ];

  
  //to store the index of item to be updated using popup menu
  int updateIndex=-10000;

  bool update=false;
  
  //for the search operation in Inventory list 
  bool _isSearching=false;
  String searchText='';
  List searchList=[];
  

  // for implementing filter the list of history
  bool filter=false;
  List filterList=[];
  String _selectedFilter='';


  @override
  Widget build(BuildContext context) {

  // heart of the search functionality
    
    searchFunction(searchText){
      for (int i=0;i<inventoryList.length;i++){
        var data=inventoryList[i]['Name'];
        data=data.toLowerCase();
        searchText=searchText.toLowerCase();
        if(data.contains(searchText)){
          searchList.add(inventoryList[i]);
          // print(inventoryList);

        }
        
      }
    }

  //heart of the filter functionality

    filterFunction(value){
      // print("filterval $value");
      var now = new DateTime.now();
      var past_1w = now.subtract(Duration(days: 7)); 
      var past_1m = new DateTime(now.year, now.month-1, now.day);
      var past_1y = new DateTime(now.year-1, now.month, now.day);

      for (int i=0;i<historyList.length;i++){
          var date=historyList[i]['Date Stamp'];
          if (value=="Last Week"){
            if  (past_1w.isBefore(date)){
            filterList.add(historyList[i]);
          }
          }else if (value=="Last Month"){
            if  (past_1m.isBefore(date)){
            filterList.add(historyList[i]);
          }
          
          }else if(value=="Last Year"){
            if  (past_1y.isBefore(date)){
                filterList.add(historyList[i]);
      }
    }}}

    //declaring variable for using MediaQuery
    var size=MediaQuery.of(context).size;
    
    return size.width < 600 && size.width>350? Scaffold(
      appBar: history?AppBar(
        title: Center(
          child: Text(
            "Inventory")
            ),
          actions: [
            
            // popup menu in order to choose how to filter List
            PopupMenuButton(
              
              icon: Icon(Icons.sort),
              itemBuilder: (context){
              List sortOptions=['None','Last Month','Last Week','Last Year'];
              return List.generate(4, (index) {
                return PopupMenuItem(
                  value: sortOptions[index],
                  child: Text(sortOptions[index]),
                  );
              });
            },
            //recieving data from the popup menu
            onSelected: (value) {
              // print(value);
              if (value!="None"){
                   setState(() {
                  filterList=[];
                _selectedFilter=value.toString();
                filter=true;
                filterFunction(_selectedFilter);
              });
              }else{

                setState(() {
                  filter=false;
                });;

              }
             
            },
            ),
          ],
      ): AppBar(title: Center(child: Text("Inventory"),),),

      body: Container(
            height: size.height,
            width: size.width,

            decoration: BoxDecoration(
              // color: Colors.red,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

//------------------------- code for top app bar starts--------------------------


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
            
//---------------------code for top app bar ends-----------------------------


//----------------code for search bar starts-------------------------------------


              stockRecord? Container(
                
                  margin: EdgeInsets.all(20),
                  child: CupertinoSearchTextField(
                    controller: _controller,
                    onSubmitted: (val){
                      searchFunction(val);
                      
                      setState(() {
                        _isSearching=true;
                        
                      });
                    },

                    //resetting the searchlist and _isSearching on tapping cut icon

                    onSuffixTap: (){
                      setState(() {
                        _isSearching=false;
                         _controller.clear();
                        searchList=[];
                      });
                    },
                  ),
                  ):Container(),



//---------------code for search bar ends------------------------



//-------------code for Stock Record Page Starts--------------------------
                stockRecord? Flexible(
                  child: Container(
                    color:Colors.amberAccent,
                    width: size.width*0.9,
                    height: size.height*0.9,
                      child:StockRecord(context)
                  ),
                ): Container(),

//-----------------code for Stock Record Page ends-----------------

////-----------------code for History Page starts-----------------

                history? Flexible(
                  child: Container(
                    
                    color:Colors.amberAccent,
                    width: size.width*0.9,
                    height: size.height*0.9,
                      child:History(context)
                  ),
                ): Container(),

//-----------------code for History Page ends----------------- 

 //------------------- code for Add New Page Starts-----------------------------
               
                addnew? Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: size.height*0.01),
                    color:Colors.amberAccent,
                    width: size.width,
                    height: size.height*0.8,
                      child:AddNew(context)
                  ),
                ): Container(),

//-----------------code for AddNew Page ends-----------------------               
              ],
            ),
      ),
    ) :Container();
  }

//-----------------code of build function ends--------------------





//---------------------- Heart of stock records page-------------

Widget StockRecord(context){
  var size=MediaQuery.of(context).size;
  return Scaffold(

        body: !_isSearching? Stack(
          children:[
          inventoryList.length>0?  ListView.builder(
            shrinkWrap:true,
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
        width: size.width*0.9,
        height: size.height*0.16,
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
                  margin: EdgeInsets.only(top:size.height*0.01,left: size.width*0.01),
                  child: Text(
                    inventoryList[index]['Name'],
                    
                    style: TextStyle(
                      fontSize: size.width*0.06
                    ),
                    ),
                ),
                SizedBox(
                  width: size.width*0.4,
                ),
                Container(
                  margin: EdgeInsets.only(top:size.width*0.015,left: size.width*0.01),
                  child: Text(
                    "Stock",
                    style: TextStyle(
                      fontSize: size.width*0.05,
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
                  margin: EdgeInsets.only(top:size.height*0.01,left: size.width*0.02),
                  child: Text(
                   "Rs." +  inventoryList[index]['Discounted Price'],
                    style: TextStyle(
                      fontSize: size.width*0.06,
                    ),
                    ),
                ),
                SizedBox(
                  width: size.width*0.4,
                ),
                Container(
                  margin: EdgeInsets.only(top:size.height*0.01,left: size.width*0.03),
                  child: Text(
                    // "Stock",
                    inventoryList[index]['Units'],
                    style: TextStyle(
                      fontSize: size.width*0.05,
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


          //update dialog to appear on long press

          update?Dialog(
            
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child:Container(
                width: size.width*0.7,
                height: size.height*0.5,
                
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
                    Container(
                      margin:EdgeInsets.all(size.height*0.01),
                      child: Text(
                        // "Update your "+inventoryList[index]['Name']+" stock",
                        "Update "+ inventoryList[updateIndex]["Name"]+" Stock",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
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
                      // var date=((DateTime.now().toIso8601String()).split("T"))[0];
                      // date=date.toString();
                          historyList.add(
                          {
                            'Name':inventoryList[updateIndex]['Name'],
                            'Price':inventoryList[updateIndex]['Price'],
                            'Discounted Price' :inventoryList[updateIndex]['Discounted Price'],
                            'Quantity':inventoryList[updateIndex]['Quantity'],
                            'Units':inventoryList[updateIndex]['Units'],
                            'Category': inventoryList[updateIndex]['Category'],
                            'Description':inventoryList[updateIndex]['Description'],
                            'Date Stamp': DateTime.now(),
                          }
                          );
                          setState(() {
                            update=!update;
                            filter=false;
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
            shrinkWrap: true,
          itemCount:  searchList.length,
          itemBuilder: (context,index){
        return InkWell(
        
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
                  margin: EdgeInsets.only(top:size.height*0.01,left: size.width*0.02),
                  child: Text(
                    searchList[index]['Name'],
                    
                    style: TextStyle(
                      fontSize: size.width*0.05,
                    ),
                    ),
                ),
                SizedBox(
                  width: size.width*0.4,
                ),
                Container(
                  margin: EdgeInsets.only(top:size.height*0.01,left: size.width*0.02),
                  child: Text(
                    "Stock",
                    style: TextStyle(
                      fontSize: size.width*0.05,
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
                      fontSize: size.width*0.05,
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
                      fontSize: size.width*0.05,
                    ),
                    ),
                ),
                
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












//-------------------// Heart of history Page------------------


Widget History(context){
  var size=MediaQuery.of(context).size;
  return Scaffold(
        
        body:! filter?  Container(

            
          child:  historyList.length>0 ? ListView.builder(
            shrinkWrap: true,
              itemCount: historyList.length,
              itemBuilder: (context,index){

                return Container(
                  width:size.width*0.2,
                  height: size.height*0.2,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(size.width*0.09),
                    
                  ),
                  margin:EdgeInsets.only(top: size.height*0.01,bottom:size.height*0.01),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:10,left: 30),
                            child: Text(
                              historyList[index]['Name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: size.width*0.09,
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
                            margin: EdgeInsets.only(top:size.height*0.01,left: size.width*0.05),
                            child: Text(
                              "Units",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: size.width*0.05,
                              ),

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:size.height*0.01,left: size.width*0.5),
                            child: Text(
                              historyList[index]['Units'],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: size.width*0.05,
                              ),

                            ),
                          ),
                            ],
                          ),

                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:size.height*0.02,left: size.width*0.04),
                            child: Text(
                              "Updated On  "+ historyList[index]['Date Stamp'].toString(),
                              // "uPdated",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: size.width*0.04,
                              ),

                            ),
                          ),
                        ],
                      ),
                          
                    ],
                  ),
                );

              }):Container(
                // width: size.width*0.5,
                //     height: size.height*0.5,
                child: Center(
                  child: Text(
                    "No History"
                    ),),),
          
        

  ):

//--------------history to display when filter=true -----------------

  Container(

            
          child:  historyList.length>0 ? ListView.builder(
            shrinkWrap: true,
              itemCount: filterList.length,
              itemBuilder: (context,index){

                return Container(
                  width:size.width*0.2,
                  height: size.height*0.15,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(30),
                    
                  ),
                  margin:EdgeInsets.only(top: size.height*0.01,bottom:size.height*0.03),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:size.height*0.02,left: size.width*0.02),
                            child: Text(
                              filterList[index]['Name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width*0.05,
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
                            margin: EdgeInsets.only(top:size.height*0.01,left: size.width*0.01),
                            child: Text(
                              "Units",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: size.width*0.05,
                              ),

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:size.height*0.02,left: size.width*0.5),
                            child: Text(
                              filterList[index]['Units'],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: size.width*0.05,
                              ),

                            ),
                          ),
                            ],
                          ),

                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:size.height*0.01,left: size.width*0.04),
                            child: Text(
                              "Updated On  "+ filterList[index]['Date Stamp'].toString(),
                              // "uPdated",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: size.width*0.04,
                              ),

                            ),
                          ),
                        ],
                      ),
                          
                    ],
                  ),
                );

              }):Container(
                // width: size.width*0.5,
                //     height: size.height*0.5,
                child: Center(
                  child: Text(
                    "No History"
                    ),),),
          
        

  ),

  );
  
  
  }
















//-------------code for adding new item starts------------------------------

Widget AddNew(context){
  var size =MediaQuery.of(context).size;
  return Scaffold(

        body:Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: size.width*0.9,
                child: TextField(
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
                     width: size.width*0.07,
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
                     width: size.width*0.07,
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
                  

// what to do when submit "Add New " button is pressed 


                  if (name.length>0 && price.length>0 && quantity.length>0 && stockUnits.length>0 && category.length>0){
                  
                   setState(() {
                     filter=false;
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
                  
                   historyList.add(
                    {
                      'Name':name,
                      'Price':price,
                      'Discounted Price' :discountedPrice,
                      'Quantity':quantity,
                      'Units':stockUnits,
                      'Category': category,
                      'Description':description,
                      'Date Stamp': DateTime.now(),
                    });
                  
                    addnew=!addnew;
                    stockRecord=!stockRecord;
                  });

                  }else{

                // function call when "Add new"  form is Incomplete

                    noData();
                                     
                }},

                // Add new button

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

// function which tells what to do when the "Add New" form is Incomplete

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


// this is the "edit page" , app routes to this page when 
//an item from the 

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
                     width: size.width*0.07,
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
                     width: size.width*0.07,
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
                  // var date=((DateTime.now().toIso8601String()).split("T"))[0];
                  // date=date.toString();

                  setState(() {

                    filter=false;


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
                      'Date Stamp': DateTime.now(),
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









