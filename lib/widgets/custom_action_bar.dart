import 'package:a_commerce/constants.dart';
import 'package:a_commerce/screens/cart_page.dart';
import 'package:a_commerce/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackGround;
  CustomActionBar({
    required this.title,
    required this.hasBackArrow,
    required this.hasTitle,
    required this.hasBackGround,
  });
  
  FireBaseServices _fireBaseServices = FireBaseServices();
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");
  
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool _hasBackArrow = hasBackArrow;
    bool _hasTitle = hasTitle;
    bool _hasBackGround = hasBackGround;

    return Container(
      child: Container(
        decoration: BoxDecoration(
            gradient: _hasBackGround
                ? LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0),
                    ],
                    begin: Alignment(0, 0),
                    end: Alignment(0, 1),
                  )
                : null),
        padding: EdgeInsets.only(
          top: 56.0,
          left: 24.0,
          right: 24.0,
          bottom: 42.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (hasBackArrow)
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 42.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage("assets/images/back_arrow.png"),
                    color: Colors.white,
                    width: 16.0,
                    height: 16.0,
                  ),
                ),
              ),
            if (_hasTitle)
              Text(
                "Home",
                style: Constants.boldHeading,
              ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
              },
              child: Container(
                  width: 42.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: StreamBuilder<QuerySnapshot>(
                      stream:
                          _usersRef.doc(_fireBaseServices.getUserId()).collection("Cart").snapshots(),
                      builder: (context, snapshot) {
                        int _totalItems = 0;
            
                        if (snapshot.connectionState == ConnectionState.active) {
                          List _documents = snapshot.data!.docs;
            
                          _totalItems = _documents.length;
                        }
                        return Text(
                          "$_totalItems",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }
}
