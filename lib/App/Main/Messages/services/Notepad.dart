

// LOW MESSAGE


// library message;

// import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// import 'package:intl/intl.dart'; // Import intl package for date formatting
// import 'package:trestapkmamabot/App/Main/Dashboard/screen/DashboardScreen.dart';
// import 'package:trestapkmamabot/App/Main/Messages/controller/chatbot_controller.dart';
// import 'package:trestapkmamabot/App/Main/Messages/model/color.dart'; // Import AppColors

// part '../widget/buble_chat.dart';
// part '../widget/input_chat.dart';
// part '../widget/background_messagesscreen.dart';
// part '../widget/appBar_message.dart';

// class MessagesScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> messages;
//   const MessagesScreen({Key? key, required this.messages}) : super(key: key);

//   @override
//   _MessagesScreenState createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen> {
//   final TextEditingController _controller = TextEditingController();
//   late ChatbotController chatbotController;
//   double _textSize = 15.0;
//   bool _showInitialBox = true;

//   @override
//   void initState() {
//     super.initState();
//     chatbotController = ChatbotController();
//   }

//   void _increaseTextSize() {
//     setState(() {
//       _textSize += 1;
//     });
//   }

//   void _decreaseTextSize() {
//     setState(() {
//       if (_textSize > 10) {
//         // Minimum text size limit
//         _textSize -= 1;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Stack(
//         children: [
//           _BackgroundImageMessage(),
//           Column(
//             children: [
//               _AppBarMessage(
//                 increaseTextSize: _increaseTextSize,
//                 decreaseTextSize: _decreaseTextSize,
//                 textSize: _textSize,
//               ),
//               Expanded(
//                 child: Stack(
//                   children: [
//                     ListView.builder(
//                       itemCount: widget.messages.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           margin: EdgeInsets.all(10),
//                           child: chatBubble(
//                             message: widget.messages[index]['message'],
//                             time: widget.messages[index]['time'],
//                             isUserMessage: widget.messages[index]
//                                 ['isUserMessage'],
//                             w: w,
//                             textSize: _textSize,
//                           ),
//                         );
//                       },
//                     ),
//                     if (_showInitialBox)
//                       Center(
//                         child: Container(
//                           padding: EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black26,
//                                 blurRadius: 10,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Text(
//                             "ketik mamabot untuk memulai percakapan",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               inputChat(
//                 controller: _controller,
//                 sendMessage: sendMessage,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void sendMessage(String text) async {
//     if (text.isEmpty) {
//       print('Message is empty');
//     } else {
//       String currentTime = DateFormat('hh:mm a').format(DateTime.now());
//       setState(() {
//         addMessage({
//           'message': text,
//           'isUserMessage': true,
//           'time': currentTime,
//         });
//         _showInitialBox = false; // Hide the initial box
//       });

//       Map<String, dynamic> responseMessage =
//           await chatbotController.sendMessage(text);
//       if (responseMessage.isNotEmpty) {
//         responseMessage['time'] = DateFormat('hh:mm a').format(DateTime.now());
//         setState(() {
//           addMessage(responseMessage);
//         });
//       }
//     }
//   }

//   void addMessage(Map<String, dynamic> message) {
//     setState(() {
//       widget.messages.add(message);
//     });
//   }
// }







//////// LOW DASHBOARD SCREEN ///////////////////////////////////////
///
///// import 'package:trestapkmamabot/App/Main/Messages/screen/Messages.dart';
// import 'package:trestapkmamabot/App/Main/Profile/screen/ProfileScreen.dart';

// class Dashboard extends StatefulWidget {
//   final List<Map<String, dynamic>> messages; // Declare messages here
//   const Dashboard({Key? key, required this.messages}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Dashboard> {
//   // int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             'assets/images/DotGrid.png',
//             fit: BoxFit.cover,
//             width: MediaQuery.of(context).size.width,
//             height: 480,
//           ),
//           // BoxDecoration(

//           // ),
//           // Positioned(
//           //   bottom: 46,
//           //   width: MediaQuery.of(context).size.width,
//           //   child: SizedBox(
//           //     width: 400,
//           //     height: 300,
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
// }

// Column(
//   children: [
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Row(
//         children: [
//           Text(
//             'Pembaruan',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(
//               width: 10), // Add spacing between "Updates" text and cards
//         ],
//       ),
//     ),
//     Container(
//       height: 250, // Set the height of the card list
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           SizedBox(width: 10), // Add initial spacing
//           buildCard(context, 'Card 1'),
//           buildCard(context, 'Card 2'),
//           buildCard(context, 'Card 3'),
//           SizedBox(width: 20), // Add final spacing
//         ],
//       ),
//     ),
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Row(
//         children: [
//           Text(
//             'Histori Chat',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(
//               width: 10), // Add spacing between "Updates" text and cards
//         ],
//       ),
//     ),
//     Container(
//       height: 250, // Set the height of the card list
//       child: ListView(
//         scrollDirection:
//             Axis.vertical, // Change scroll direction to vertical
//         children: [
//           SizedBox(height: 10), // Add initial spacing
//           historyCard(context, ''),
//           historyCard(context, ''),
//           historyCard(context, ''),
//           historyCard(context, ''),
//           SizedBox(height: 10), // Add final spacing
//         ],
//       ),
//     ),

//     // SizedBox(height: 20), // Add spacing between card list and text
//     // Center(
//     //   child: Text('Welcome to MamaBot!'), // Placeholder content
//     // ),
//   ],
// ),

//     bottomNavigationBar: BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.add),
//           label: 'Go to Chat',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_circle),
//           label: 'Profile',
//         ),
//       ],
//       currentIndex: _currentIndex, // Set the current index based on state
//       selectedItemColor: Colors.blue,
//       onTap: (int index) {
//         setState(() {
//           _currentIndex = index; // Update the current index
//         });
//         switch (index) {
//           case 0:
//             Navigator.popUntil(context, ModalRoute.withName('/'));
//             break;
//           case 1:
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MessagesScreen(
//                   messages: widget.messages,
//                 ), // Pass messages to MessagesScreen
//               ),
//             );
//             break;
//           case 2:
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     ProfileScreen(), // Navigate to ProfileScreen
//               ),
//             );
//             setState(() {
//               _currentIndex =
//                   index; // Update the current index to activate Profile icon
//             });
//             break;
//         }
//       },
//     ),
//   );
// }

// widget build card
// Widget buildCard(BuildContext context, String text) {
//   return Container(
//     width: MediaQuery.of(context).size.width * 0.8, // Set the card width
//     margin: EdgeInsets.symmetric(horizontal: 10),
//     child: Card(
//       child: Column(
//         mainAxisAlignment:
//             MainAxisAlignment.center, // Align content vertically center
//         children: [
//           Container(
//             width: 160, // Full width for the image container
//             height: 160, // Set the height of the image
//             margin: EdgeInsets.symmetric(
//                 vertical: 25), // Add margin to top and bottom
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                     "assets/images/mamabot1.png"), // Replace with your image path
//                 fit: BoxFit.cover, // Cover the entire container
//               ),
//               borderRadius: BorderRadius.circular(
//                   8), // Add border radius for the container
//             ),
//           ),
//           SizedBox(height: 25), // Add spacing between image and text
//           Text(
//             text,
//             style: TextStyle(fontSize: 0),
//           ),
//         ],
//       ),
//     ),
//   );
// }
// widget build card

// widget History Card
//   Widget historyCard(BuildContext context, String title) {
//     return Container(
//       width: double.infinity, // Set the width to match the parent container
//       height: 80, // Set the desired height for the card
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Add margin
//       decoration: BoxDecoration(
//         color: Color.fromRGBO(237, 242, 248, 1.000),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xEDF2F8).withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: Icon(Icons.message), // Add message icon on the left
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Messages 1:'), // Add messages text on the right
//                   Text(title), // Display card title
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// widget History Card



// LOW BOTTOM NAVBAR : 

// part of dashboard;

// class _BottomNavbar extends StatelessWidget {
//   _BottomNavbar({Key? key}) : super(key: key);

//   final _index = 0.obs;

//   final List<String> _routes = ['/Dashboard', '/profile'];

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => _customBackground(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5),
//           child: BottomNavigationBar(
//             onTap: (value) {
//               _index.value = value;
//               // Get.toNamed(_routes[value]);
//               _pushRoute(_routes[value], context); // Panggil fungsi _pushRoute
//             },
//             currentIndex: _index.value,
//             items: [
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.home_rounded), label: "Home"),
//               BottomNavigationBarItem(icon: SizedBox.shrink(), label: ""),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.account_circle), label: "Profile"),
//             ],
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             iconSize: 30,
//             unselectedItemColor: Colors.grey[500],
//           ),
//         ),
//       ),
//     );
//   }

//   void _pushRoute(String route, BuildContext context) {
//     switch (route) {
//       case '/Dashboard':
//         Navigator.pushReplacementNamed(context, route);
//         break;
//       case '/Profile':
//         Navigator.pushReplacementNamed(context, route);
//         break;
//       default:
//         break;
//     }
//   }

//   Widget _customBackground({required Widget child}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, -5),
//             color: Colors.black12,
//             blurRadius: 10,
//           )
//         ],
//       ),
//       child: child,
//     );
//   }
// }

// // library profile;

// // import 'package:dialog_flowtter/dialog_flowtter.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:trestapkmamabot/global/common/toast.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:trestapkmamabot/App/Main/Profile/model/color.dart';
// import 'package:trestapkmamabot/App/Main/Messages/screen/NewMessageScreen.dart';
// import 'package:trestapkmamabot/App/Main/Dashboard/screen/DashboardScreen.dart';
// // // Routes
// // import 'package:trestapkmamabot/App/Routes/app_routes.dart';

// // Widget/Component
// part '../widget/background_image.dart';
// part '../widget/header.dart';
// part '../widget/background_content.dart';
// part '../widget/Bottom_navbar.dart';
// // Controller

// // part '../controller/';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     void _showSnackBar(String message) {
//       final snackBar = SnackBar(
//         content: Text(message),
//         duration: Duration(seconds: 2),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }

//     return Scaffold(
//       // extendBodyBehindAppBar: true,
//       body: Stack(
//         children: [
//           _BackgroundImage(),
//           SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               children: [
//                 SizedBox(height: 57),
//                 _Header(),
//                 SizedBox(height: 100),
//                 _BackgroundContent(
//                   child: Column(
//                     children: [
//                       // _updateFiture(),
//                       // SizedBox(height: 10),
//                       // _historyChat(),
//                       GestureDetector(
//                         onTap: () {
//                           FirebaseAuth.instance.signOut();
//                           Navigator.pushNamedAndRemoveUntil(
//                             context,
//                             "/splashLoginSignUp",
//                             (Route<dynamic> route) => false,
//                           );
//                           _showSnackBar("Successfully signed out");
//                         },
//                         child: Container(
//                           height: 45,
//                           width: 100,
//                           decoration: BoxDecoration(
//                               color: Colors.blue,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Center(
//                             child: Text(
//                               "Sign out",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//       bottomNavigationBar: _BottomNavbar(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => MessagesScreen(
//                 messages: [],
//               ), // Pass messages to MessagesScreen
//             ),
//           );
//         },
//         child: Icon(Icons.add_comment_rounded),
//         backgroundColor: Colors.blue, // You can change the color as needed
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

