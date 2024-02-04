import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:icons_plus/icons_plus.dart';

class donationPostDetails extends StatefulWidget {
  final String? doner_profile_picture;
  final String doner_name;
  final DateTime post_time;
  final String title;

  const donationPostDetails(
      {key,
      this.doner_profile_picture,
      required this.doner_name,
      required this.post_time,
      required this.title})
      : super(key: key);

  @override
  State<donationPostDetails> createState() => _donationPostDetailsState();
}

class _donationPostDetailsState extends State<donationPostDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: new EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 12.0),
                        child: widget.doner_profile_picture==null ? Container() : ProfilePicture(
                          name: ' ',
                          radius: 20,
                          fontsize: 21,
                          random: true,
                          count: 2,
                          img: widget.doner_profile_picture,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(
                            widget.doner_name,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 35, 35, 35)),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.verified,
                                color: Colors.blue,
                              ),
                              Text(
                                'Verified',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.more_horiz,
                          color: Color.fromARGB(255, 154, 154, 154),
                        ),
                        Text(
                          widget.post_time.day.toString(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 154, 154, 154),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1.0,
                    color: const Color.fromARGB(255, 131, 131, 131)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                widget.title,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(195, 79, 79, 79),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 8.0,
                runSpacing: 10.0,
                children: [
                  Container(
                    height: 30,
                    // width: 70,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 242, 84, 84),
                      ),
                      color: const Color.fromARGB(255, 255, 215, 215),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'Non-Veg',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 242, 84, 84),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    // width: 45,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 76, 126, 58),
                      ),
                      color: const Color.fromARGB(255, 221, 253, 196),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'Veg',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 76, 126, 58),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    constraints:
                        const BoxConstraints(minWidth: 50, maxWidth: 100),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(100, 79, 79, 79),
                      ),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Bootstrap.bell,
                          size: 15.0,
                          color: Colors.amber,
                        ),
                        Text(
                          '50 meals',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(150, 79, 79, 79),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    constraints:
                        const BoxConstraints(minWidth: 30, maxWidth: 60),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(100, 79, 79, 79),
                      ),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Bootstrap.geo_alt,
                          size: 15.0,
                          color: Color.fromARGB(255, 242, 84, 84),
                        ),
                        Text(
                          '2km',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(150, 79, 79, 79),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    constraints:
                        const BoxConstraints(minWidth: 50, maxWidth: 110),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 255, 215, 215),
                      ),
                      color: const Color.fromARGB(255, 255, 215, 215),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Bootstrap.clock,
                          size: 15.0,
                          color: Color.fromARGB(255, 242, 84, 84),
                        ),
                        Text(
                          'Exp 20 min',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 242, 84, 84),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 253, 241, 203),
                      ),
                      color: const Color.fromARGB(255, 248, 228, 198),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      '3+',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
