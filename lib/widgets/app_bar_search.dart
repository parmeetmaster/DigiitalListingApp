import 'package:flutter/material.dart';

class AppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  Function onClickCategory;
  Function onClickCity;
  Function onClickSubmit;
  TextEditingController searchtextController;
  TextEditingController citytextController;
  TextEditingController categorytextController;

  @override
  AppBarSearch(
      {Key key,
      this.onClickCategory,
      this.onClickCity,
      this.searchtextController,
      this.citytextController,
      this.categorytextController,
      this.onClickSubmit})
      : preferredSize = Size.fromHeight(kToolbarHeight + 150),
        super(key: key);

  @override
  _AppBarSearchState createState() => _AppBarSearchState();

  @override
  final Size preferredSize;
}

class _AppBarSearchState extends State<AppBarSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Column(
        children: [
  /*        Align(
            alignment: Alignment.topLeft,
            child: Container(
            padding: EdgeInsets.only(top:50,left: 20),
            child: Icon(Icons.close),),),
          */
          Padding(
            padding: EdgeInsets.only(top: 50, left: 10, right: 10),
            child: TextField(
              controller: widget.searchtextController,
              textAlign: TextAlign.center,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(
                    color: Colors.grey[800],
                  ),
                  hintText: "Search...",
                  fillColor: Colors.white70),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.onClickCategory();
                    },
                    child: AbsorbPointer(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          controller: widget.categorytextController,
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(0.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(
                              color: Colors.grey[800],
                            ),
                            hintText: "Category",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.onClickCity();
                    },
                    child: AbsorbPointer(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          controller: widget.citytextController,
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(0.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(
                              color: Colors.grey[800],
                            ),
                            hintText: "City",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                widget.onClickSubmit();

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search,color: Colors.white,),
                  SizedBox(width: 5,),
                  Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
