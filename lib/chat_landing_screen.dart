// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weask/chat_screen.dart';

class ChatLandingScreen extends StatefulWidget {
  const ChatLandingScreen({Key? key}) : super(key: key);

  @override
  State<ChatLandingScreen> createState() => _ChatLandingScreenState();
}

class _ChatLandingScreenState extends State<ChatLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tanya",
                textAlign: TextAlign.center,
                style: GoogleFonts.syne(
                  color: const Color(0xFF2945FF),
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                "s'Mbah",
                textAlign: TextAlign.center,
                style: GoogleFonts.syne(
                  color: const Color(0xFF2945FF),
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              Text(
                'Let’s find the answer just for you.',
                textAlign: TextAlign.center,
                style: GoogleFonts.syne(
                  color: const Color(0xFF111111),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 36.0,
              ),
              Container(
                width: 292,
                height: 265,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/shiny.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 102.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChatScreen();
                  }));
                },
                child: Container(
                  width: 200,
                  height: 54,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 44, vertical: 16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF2945FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Get started',
                      style: GoogleFonts.syne(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
              // https://makersuite.google.com/
            ],
          ),
        ),
      ),
    );
  }
}
