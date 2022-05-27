import 'package:flutter/material.dart';

class CustomErrorMessage extends StatelessWidget {
  final String message;
  final String title;

  const CustomErrorMessage(this.title, this.message, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(16),
                        height: 90,
                        decoration: const BoxDecoration(
                            color: Color(0xFFC72C41),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: [
                            const SizedBox(width: 48),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(title,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  Text(
                                    message,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
          },
          child: const Text('Show Message'),
        ),
      ),
    );
  }
}
