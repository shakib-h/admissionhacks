import 'package:flutter/material.dart';
import 'package:matrix/components/constant.dart';
import 'package:matrix/widgets/counter.dart';

class AdmissionUpdate extends StatelessWidget {
  final int cluster;
  final int published;
  final int formfillup;
  final int ended;
  const AdmissionUpdate({
    Key key,
    this.cluster,
    this.published,
    this.formfillup,
    this.ended,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Counter(
            color: kInfectedColor,
            number: cluster,
            title: "Cluster",
          ),
          Counter(
            color: kDeathColor,
            number: published,
            title: "Published",
          ),
          Counter(
            color: kRecovercolor,
            number: formfillup,
            title: "Form Fill Up",
          ),
          Counter(
            color: kDeathColor,
            number: ended,
            title: "Ended",
          ),
        ],
      ),
    );
  }
}
