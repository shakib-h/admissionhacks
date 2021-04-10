import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix/components/constant.dart';
import 'package:matrix/widgets/browser.dart';
import 'package:matrix/widgets/counter.dart';

class AdmissionUpdate extends StatelessWidget {
  const AdmissionUpdate({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Admission Update\n",
                    style: tTitleTextstyle,
                  ),
                  TextSpan(
                    text: "tap on the numbers to learn more",
                    style: TextStyle(
                      color: tTextLightColor,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 30,
                color: tShadowColor,
              ),
            ],
          ),
          child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('admission')
                  .doc('t8VMXwG16TRLTsmZBtfS')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator(
                    backgroundColor: tPrimaryColor,
                  );
                } else {
                  Map<String, dynamic> documentFields = snapshot.data.data();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Counter(
                        color: tClusterColor,
                        number: documentFields["admissionupdate"]["cluster"],
                        title: "Cluster",
                        onpress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Browser(
                                title: "Cluster",
                                url:
                                    "https://app.admissionhacks.com/update/cluster",
                              ),
                            ),
                          );
                        },
                      ),
                      Counter(
                        color: tPublishedColor,
                        number: documentFields["admissionupdate"]["published"],
                        title: "Published",
                        onpress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Browser(
                                title: "Published",
                                url:
                                    "https://app.admissionhacks.com/update/published",
                              ),
                            ),
                          );
                        },
                      ),
                      Counter(
                        color: tApplyColor,
                        number: documentFields["admissionupdate"]
                            ["application"],
                        title: "Apply",
                        onpress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Browser(
                                title: "Apply",
                                url:
                                    "https://app.admissionhacks.com/update/application",
                              ),
                            ),
                          );
                        },
                      ),
                      Counter(
                        color: tEndedColor,
                        number: documentFields["admissionupdate"]["ended"],
                        title: "Ended",
                        onpress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Browser(
                                title: "Ended",
                                url:
                                    "https://app.admissionhacks.com/update/ended",
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              }),
        ),
      ],
    );
  }
}
