import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ooky_doky/model/userModel.dart';
import 'package:ooky_doky/view/home_screen.dart';
class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({super.key});

  @override
  State<UserAccountScreen> createState() => UserAccountScreenState();
}

class UserAccountScreenState extends State<UserAccountScreen> {
   final _formKey = GlobalKey<FormState>();
   TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? userID;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    return CupertinoPageScaffold(
      navigationBar: appBar(),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Container(
                width: wid,
                height: hei * 0.3,
                child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(height: 10,),
              Text('Delete Account',
              style: TextStyle(fontSize: 25),),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                child: CupertinoTextField(
                  padding: EdgeInsets.all(12),
                  placeholder: "Email",
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: CupertinoTextField(
                  padding: EdgeInsets.all(12),
                  placeholder: "Password",
                  keyboardType: TextInputType.emailAddress,
                  controller: passwordController,
                ),
              ),
              SizedBox(height: 20,),
              isLoading ? CupertinoActivityIndicator(animating: true,) : CupertinoButton(child: Text('Delete My Account'), 
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
              if (emailController.text.isEmpty) {
                showMyDialog('Please enter your email');
                setState(() {
                  isLoading = false;
                });
              }else if (passwordController.text.isEmpty) {
               showMyDialog('Please enter your password');
               setState(() {
                  isLoading = false;
                });
              } 
              else {
                getUserDetails(emailController.text.toString());
                setState(() {
                  isLoading = false;
                });
              }  
              },)
            ],
          ),
        ),
      ),

    );
  }


getUserDetails (String email) async{
    final response = await http.get(Uri.parse('https://ooky-dooky-8efd.myshopify.com/admin/api/2023-04/customers/search.json?query=email:$email'),
    headers: {
      'Content-Type':'application/json',
      'X-Shopify-Access-Token':'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',
    }
    );
    try {
      if (response.statusCode == 200) {
        
        var data = userFromJson(response.body.toString());
        userID = data.customers[0].id.toString();
        deleteAccountConfirmationDialog();

        return data;
      }
    } catch (e) {
      showMyDialog('Please check your email or password');
    }
  }




  showMyDialog(String text) {
    return  showCupertinoDialog(
   context: context,
   builder: (context) {
     return CupertinoAlertDialog(
       title: Text('Error'),
       content: Text(text),
       actions: <Widget>[
         CupertinoButton(
             onPressed: () {
               Navigator.of(context).pop();
             },
             child: Text('ok'))
       ],
     );
   });
  }

   CupertinoNavigationBar appBar() {
    return CupertinoNavigationBar(
      leading: CupertinoButton(
          // padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back), 
          onPressed: () {
            Navigator.pop(context);
          }),
        // trailing: CupertinoButton(
        //   padding: EdgeInsets.zero,
        //   child: Icon(CupertinoIcons.refresh), 
        //   onPressed: () async{
        //     // await controller.reload();
        //   }),
        middle: Text('Ooky Doky'),
        automaticallyImplyLeading: false,
      );
  }



deleteAccountConfirmationDialog() async {
    return await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete your account?'),
          actions: [
            CupertinoDialogAction(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Yes, Delete'),
              onPressed: () {
                Navigator.of(context).pop();
               deleteShopifyUserById(userID.toString());

              },
            ),
          ],
        );
      },
    );
  }


  Future<void> deleteShopifyUserById(String userId) async {
  const api_Key = 'e5387bb4a4b93ec3b105ea3688ded5b8';
  const access_token = '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';
  const api_version = '2023-04';
  const url = 'ooky-dooky-8efd.myshopify.com';
  try {
  final respone = await http.delete(Uri.parse('https://$api_Key:$access_token@$url/admin/api/$api_version/customers/$userId.json'));
    if (respone.statusCode == 200) {
      deletedAccountMsg();
    }
  } catch (e) {
    showMyDialog('User Not Found');
  }

}

deletedAccountMsg() {
    return  showCupertinoDialog(
   context: context,
   builder: (context) {
     return CupertinoAlertDialog(
      //  title: Text(''),
       content: Text('Account deleted successfully'),
       actions: <Widget>[
         CupertinoButton(
             onPressed: () {
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
             },
             child: Text('ok'))
       ],
     );
   });
  }


}