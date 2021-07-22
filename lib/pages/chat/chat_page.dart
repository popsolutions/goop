import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goop/pages/components/goop_drawer.dart';
import 'package:goop/utils/global.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: goopColors.red,
            tabs: [
              Tab(icon: Icon(Icons.date_range)),
              Tab(
                icon: Icon(
                  Icons.favorite,
                  color: goopColors.red,
                ),
              ),
              Tab(
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.red,
                        size: 27,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            enabled: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.red,
                              ),
                            ),
                            hintText: "Buscar...",
                            hintStyle: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(
                    "Mensagens",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text('Você ainda não possui mensagens'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
