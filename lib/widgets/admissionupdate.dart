import 'package:admissionhacks/widgets/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admissionhacks/widgets/constant.dart';

class AdmissionUpdate extends StatelessWidget {
  const AdmissionUpdate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  Map<String, dynamic> documentFields = snapshot.data!.data()!;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Counter(
                        color: tClusterColor,
                        number: documentFields["admissionupdate"]["cluster"],
                        title: "Cluster",
                        onpress: () {},
                      ),
                      Counter(
                        color: tPublishedColor,
                        number: documentFields["admissionupdate"]["published"],
                        title: "Published",
                        onpress: () {},
                      ),
                      Counter(
                        color: tApplyColor,
                        number: documentFields["admissionupdate"]
                            ["application"],
                        title: "Apply",
                        onpress: () {},
                      ),
                      Counter(
                        color: tEndedColor,
                        number: documentFields["admissionupdate"]["ended"],
                        title: "Ended",
                        onpress: () {},
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
