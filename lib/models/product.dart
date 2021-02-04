import 'package:flutter/material.dart';

class Product{
  int id;
  String name;
  String description;
  double unitPrice;//birimfiyatı
  Product({this.name,this.description,this.unitPrice});//contructer olduğu için metot adı class adı ile aynı
  //Farklı bir constructer kullanımı,böylede kullanılabilir.
  //this diyerek gelen değeri istediğimiz parametreye atama işlemi yapıyoruz.
  Product.withId({this.id,this.name,this.description,this.unitPrice});

  Map<String,dynamic>toMap(){
    var map=Map<String,dynamic>();
    map["name"]=name;
    map["description"]=description;
    map["unitPrice"]=unitPrice;
    if(id!=null){
      map["id"]=id;
    }
    return map;
  }
  Product.fromObject(dynamic o){
    this.id=o["id"];
    this.name=o["name"];
    this.description=o["description"];
    this.unitPrice=double.tryParse(o["unitPrice"].toString());
  }

}
