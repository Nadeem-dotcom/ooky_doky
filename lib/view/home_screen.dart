import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ooky_doky/view/user_account_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/cupertino.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? isComplete;


  WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse('https://ooky-dooky-8efd.myshopify.com'));
    
  bool? isIos;
  Widget build(BuildContext context) {
    reloadScreen();
    isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return WillPopScope(
      onWillPop: () async{
        var canGoBack =  await controller.canGoBack();
        if (canGoBack) {
          await controller.goBack();
        } else if(canGoBack == false) {
          bool? exit = await showExitConfirmationDialog();
          return exit;
        }
        return false;
      },

      child: CupertinoPageScaffold(
      navigationBar: appBar(),
        child:
            SafeArea(child: WebViewWidget(controller: controller, )),
      ),
    );
    
  }

 Future<bool> showExitConfirmationDialog() async {
    return await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to exit the app?'),
          actions: [
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            CupertinoDialogAction(
              child: Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }


  
  reloadScreen() async{
    await controller.setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) async{
        // Update loading bar.
        await controller.runJavaScript("document.getElementsByTagName('footer')[0].style.display='none'");
      },
      onPageFinished: (String url)  async{
      },
    ),
  );
  }





  CupertinoNavigationBar appBar() {
    return CupertinoNavigationBar(
      leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.person), 
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserAccountScreen()),
            );;
          }),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.refresh), 
          onPressed: () async{
            await controller.reload();
          }),
        middle: Text('Ooky Doky'),
        automaticallyImplyLeading: false,
      );
  }

}

