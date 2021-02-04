import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_detail.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _ProductList();
  }
}

class _ProductList extends State {
  var dbHelper=DbHelper();
  List<Product> products;
  int productCount=0;

@override
  void initState() {
  getProducts();

  }
  /*
    @override
  void initState() {//Bu fonksiyon uygulama her başlatıldığında çalışır ve ürünleri listeler.
      getProducts();
    //super.initState();// super ile başka fonksiyonları da çağırabiliriz.
    //Şuan bu fonksiyonun içinde olduğumuz için bu fonksiyonu tekrar çağırmaya gerek yoktur.
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){goToProductAdd();},
        child:Icon(Icons.add),
        tooltip: "Yeni ürün ekle",
      ),
      
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder:(BuildContext context,int position){
          return Card(
            color: Colors.deepOrange,
            elevation: 2.0,
            child:ListTile(
              leading: CircleAvatar(backgroundColor: Colors.black12,child: Text("p"),),
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
              onTap: (){
                gotoDetail(this.products[position]);
              }
            )
          );
        }
    );
  }
  void goToProductAdd() async {
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductAdd()));
    if(result != null){//geri butonuna basılmışsa result null döner,onun kontrolünü sağoladık
      if(result){
        getProducts();
      }
    }
  }
  void getProducts() async{//Ürünleri çekmek için
      var productsFuture=dbHelper.getProducts();
      productsFuture.then((data){
        setState(() {
          this.products=data;
          productCount=data.length;
        });

    });
  }
  void gotoDetail(Product product) async {
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product)));
    if(result!=null){
      if(result){
        getProducts();
      }
    }
  }
}
