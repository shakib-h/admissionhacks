import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix/components/constant.dart';
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
                    text: "exam and circular",
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
                color: kShadowColor,
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
                        color: tInfectedColor,
                        number: documentFields["admissionupdate"]["cluster"],
                        title: "Cluster",
                      ),
                      Counter(
                        color: tDeathColor,
                        number: documentFields["admissionupdate"]["published"],
                        title: "Published",
                      ),
                      Counter(
                        color: tRecovercolor,
                        number: documentFields["admissionupdate"]["formfillup"],
                        title: "Form Fill Up",
                      ),
                      Counter(
                        color: tDeathColor,
                        number: documentFields["admissionupdate"]["ended"],
                        title: "Ended",
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
