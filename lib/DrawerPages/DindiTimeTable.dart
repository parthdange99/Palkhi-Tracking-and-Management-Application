import 'package:flutter/material.dart';

class DindiSchedulePage extends StatefulWidget {
  @override
  _DindiSchedulePageState createState() => _DindiSchedulePageState();
}

class _DindiSchedulePageState extends State<DindiSchedulePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Separate schedules for each tab
  final List<Map<String, String>> gyaneshwarSchedule = [
    {

      "date": "११/०६/२०२३",
      "day": "रविवार",
      "departure": "आळंदी",
      "via": ".....",
      "stay": "गांधीभवन देवस्थान आळंदी"
    },
    {
      "date": "१२/०६/२०२३",
      "day": "सोमवार",
      "departure": "आळंदी",
      "via": "पुणे नगर",
      "stay": "पाटसह टिळक मंदिर भक्ति वेड पुणे"
    },
    {
      "date": "१३/०६/२०२३",
      "day": "मंगळवार",
      "departure": "पुणे शहर",
      "via": "पुणे शहर",
      "stay": "पुणे शहर"
    },
    {
      "date": "१४/०६/२०२३",
      "day": "बुधवार",
      "departure": "पुणे शहर",
      "via": "हडपसर",
      "stay": "सासवड"
    },
    {
      "date": "११/०६/२०२३",
      "day": "रविवार",
      "departure": "आळंदी",
      "via": ".....",
      "stay": "गांधीभवन देवस्थान आळंदी"
    },
    {
      "date": "१२/०६/२०२३",
      "day": "सोमवार",
      "departure": "आळंदी",
      "via": "पुणे नगर",
      "stay": "पाटसह टिळक मंदिर भक्ति वेड पुणे"
    },
    {
      "date": "१३/०६/२०२३",
      "day": "मंगळवार",
      "departure": "पुणे शहर",
      "via": "पुणे शहर",
      "stay": "पुणे शहर"
    },
    {
      "date": "१४/०६/२०२३",
      "day": "बुधवार",
      "departure": "पुणे शहर",
      "via": "हडपसर",
      "stay": "सासवड"
    },
    {
      "date": "१५/०६/२०२३",
      "day": "गुरुवार",
      "departure": "सासवड",
      "via": "सासवड",
      "stay": "सासवड"
    },
    {
      "date": "१६/०६/२०२३",
      "day": "शुक्रवार",
      "departure": "सासवड",
      "via": "वराई शिवरी",
      "stay": "जेऊरी"
    },
    {
      "date": "१७/०६/२०२३",
      "day": "शनिवार",
      "departure": "जेऊरी",
      "via": "बाल्हे",
      "stay": "बाल्हे"
    },
    {
      "date": "१८/०६/२०२३",
      "day": "रविवार",
      "departure": "बाल्हे",
      "via": "निरा",
      "stay": "लोणंद"
    },
    {
      "date": "१९/०६/२०२३",
      "day": "सोमवार",
      "departure": "लोणंद",
      "via": "लोणंद",
      "stay": "लोणंद"
    },
    {
      "date": "२०/०६/२०२३",
      "day": "मंगळवार",
      "departure": "लोणंद",
      "via": "लोणंद",
      "stay": "तरडगाव"
    },
    {
      "date": "२१/०६/२०२३",
      "day": "बुधवार",
      "departure": "तरडगाव",
      "via": "निंभोरे ओढा",
      "stay": "विमानतळ फलटण"
    },
    {
      "date": "२२/०६/२०२३",
      "day": "गुरुवार",
      "departure": "विमानतळ फलटण",
      "via": "विमानतळ फलटण",
      "stay": "बरड"
    },
    {
      "date": "२३/०६/२०२३",
      "day": "शुक्रवार",
      "departure": "बरड",
      "via": "वरड",
      "stay": "नातेपुते"
    },
    {
      "date": "२४/०६/२०२३",
      "day": "शनिवार",
      "departure": "नातेपुते",
      "via": "नातेपुते",
      "stay": "माळशिरस"
    },
    {
      "date": "२५/०६/२०२३",
      "day": "रविवार",
      "departure": "माळशिरस",
      "via": "माळशिरस",
      "stay": "वेळापूर"
    },
    {
      "date": "२६/०६/२०२३",
      "day": "सोमवार",
      "departure": "वेळापूर",
      "via": "",
      "stay": "भंडीशेगांव"
    },
    {
      "date": "२७/०६/२०२३",
      "day": "मंगळवार",
      "departure": "भंडीशेगांव",
      "via": "--",
      "stay": "बाखरी"
    },
    {
      "date": "२८/०६/२०२३",
      "day": "बुधवार",
      "departure": "वाखरी",
      "via": "",
      "stay": "पंढरपूर"
    },
    {
      "date": "२९/०६/२०२३",
      "day": "गुरुवार",
      "departure": "पंढरपूर मुक्कामी",
      "via": "",
      "stay": "आपटी सोहळा"
    },
  ];

  final List<Map<String, String>> tukaramSchedule = [
    {
      "date": "१०/०६/२०२३",
      "day": "शनिवार",
      "departure": "देहू",
      "via": "विसावा देहू",
      "stay": "इनामदारसाहेब वाडा, श्री क्षेत्र देहू"
    },
    {
      "date": "११/०६/२०२३",
      "day": "रविवार",
      "departure":" इनामदारसाहेब वाडा, श्री क्षेत्र देहू ",
      "via":"निगडी ",
      "stay":" आकुर्डी श्री. विठ्ठल मंदिर "
    },
    {
      "date": "१२/०६/२०२३",
      "day": "सोमवार",
      "departure": "आकुर्डी श्री. विठ्ठल मंदिर",
      "via": "दापोडी",
      "stay": "श्री. निवडुंगा विट्ठल मंदिर नानापेठ, पुणे"
    },
    {
      "date": "१३/०६/२०२३",
      "day": "मंगळवार",
      "departure": "श्री. निवडुंगा विट्ठल मंदिर नानापेठ, पुणे",
      "via": "",
      "stay": "श्री. निवडुंगा विट्ठल मंदिर नानापेठ, पुणे"
    },
    {
      "date": "१४/०६/२०२३",
      "day": "बुधवार",
      "departure": "श्री. निवडुंगा विट्ठल मंदिर नानापेठ, पुणे",
      "via": "हडपसर",
      "stay": "लोणी काळभोर, श्री. विठ्ठल मंदिर"
    },
    {
      "date": "१५/०६/२०२३",
      "day": "गुरुवार",
      "departure": "लोणी काळभोर, श्री. विठ्ठल मंदिर",
      "via": "उरुळी कांचन",
      "stay": "यवत श्री. भैरवनाथ मंदिर"
    },
    {
      "date": "१६/०६/२०२३",
      "day": "शुक्रवार",
      "departure": "यवत श्री. भैरवनाथ मंदिर",
      "via": "भाडगाव फाटा",
      "stay": "वरवंड, श्री. विठ्ठल मंदिर"
    },
    {
      "date": "१७/०६/२०२३",
      "day": "शनिवार",
      "departure": "वरवंड, श्री. विठ्ठल मंदिर",
      "via": "पाटस",
      "stay": "उंडवडी गवळ्याची"
    },
    {
      "date": "१८/०६/२०२३",
      "day": "रविवार",
      "departure": "उंडवडी गवळ्याची",
      "via": "बऱ्हाणपूर",
      "stay": "बारामती, शारदा विद्यालय प्रांगण"
    },
    {
      "date": "१९/०६/२०२३",
      "day": "सोमवार",
      "departure": "बारामती, शारदा विद्यालय प्रांगण",
      "via": "काटेवाडी",
      "stay": "सणसर, मारुती मंदिर"
    },
    {
      "date": "२०/०६/२०२३",
      "day": "मंगळवार",
      "departure": "सणसर, मारुती मंदिर",
      "via": "बेलवंडी",
      "stay": "अंथुर्णे"
    },
    {
      "date": "२१/०६/२०२३",
      "day": "बुधवार",
      "departure": "अंथुर्णे",
      "via": "गोतंडी",
      "stay": "निमगाव केतकी"
    },
    {
      "date": "२२/०६/२०२३",
      "day": "गुरुवार",
      "departure": "निमगाव केतकी",
      "via": "इंदापूर (गोल रिंगण)",
      "stay": "इंदापूर"
    },
    {
      "date": "२३/०६/२०२३",
      "day": "शुक्रवार",
      "departure": "इंदापूर",
      "via": "बावडा",
      "stay": "सराटी"
    },
    {
      "date": "२४/०६/२०२३",
      "day": "शनिवार",
      "departure": "सराटी (निरा स्नान)",
      "via": "अकलूजमाने विद्यालय",
      "stay": "अकलूजमाने विद्यालय"
    },
    {
      "date": "२५/०६/२०२३",
      "day": "रविवार",
      "departure": "अकलूज",
      "via": "",
      "stay": "बोरगाव"
    },
    {
      "date": "२७/०६/२०२३",
      "day": "मंगळवार",
      "departure": "पिराची कुरोली",
      "via": "",
      "stay": "वाखरी"
    },
    {
      "date": "२८/०६/२०२३",
      "day": "बुधवार",
      "departure": "पाखरी",
      "via": "",
      "stay": "पंढरपूर"
    },
    {
      "date": "२९/०६/२०२३",
      "day": "गुरुवार",
      "departure": "पंढरपूर मुक्कामी",
      "via": "",
      "stay": "आपटी सोहळा"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dindi Schedule"),
        backgroundColor: Colors.orange,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: "ज्ञानेश्वर महाराज"),
            Tab(text: "तुकाराम महाराज"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildScheduleList(gyaneshwarSchedule),
          buildScheduleList(tukaramSchedule),
        ],
      ),
    );
  }

  Widget buildScheduleList(List<Map<String, String>> schedule) {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: schedule.length,
      itemBuilder: (context, index) {
        final item = schedule[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item['date']} (${item['day']})",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 8),
                buildInfoRow("प्रस्थान :", item['departure']!),
                buildInfoRow("विषय :", item['via']!),
                buildInfoRow("मुकाम :", item['stay']!),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
