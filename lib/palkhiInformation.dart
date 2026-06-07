import 'package:flutter/material.dart';

class DindiListPage extends StatelessWidget {
  final List<Map<String, String>> dindis = [
    {"name": "संत तुकाराम महाराज पंढरपूर वारी", "id": "1"},
    {"name": "संत ज्ञानेश्वर महाराज पंढरपूर वारी", "id": "2"},
    {"name": "संत मुक्ताबाई पंढरपूर वारी", "id": "3"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("डिंडी माहिती"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: dindis.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4, // Shadow effect
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: ListTile(
                title: Text(
                  dindis[index]["name"]!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward, color: Colors.orange),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DindiDetailsPage(
                        dindiName: dindis[index]["name"]!,
                        dindiId: dindis[index]["id"]!,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class DindiDetailsPage extends StatelessWidget {
  final String dindiName;
  final String dindiId;

  DindiDetailsPage({required this.dindiName, required this.dindiId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dindiName),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General Information
            buildSectionCard(
              title: "सामान्य माहिती",
              content:
              "प्रारंभ तारीख: १० जून २०२४\nसमाप्त तारीख: १५ जून २०२४\nमार्ग: आळंदी ते पंढरपूर",
            ),

            // Historical Context
            buildSectionCard(
              title: "ऐतिहासिक संदर्भ",
              content:
"परथसार्थी दास (डिंडी व्यवस्थापक)\nपंढरपूर वारी ही महाराष्ट्रातील पंढरपूरधामकडे जाणारी एक यात्रा आहे. ही ७००-८०० वर्षांची परंपरा श्रीविठोबा (पंढरंग) यांना सन्मान देण्यासाठी घेतली जाते. यात संत ज्ञानेश्वर आणि संत तुकाराम यांच्या पंढरपूरवासी व्रत (पालकी) मध्ये पादुका (भारताची पारंपारिक चपल) घेऊन त्यांच्याच समाधी स्थळांपासून पंढरपूरकडे आणले जातात.वारी करणारा म्हणजे व्रकरी  जो वारी करतो, असा एक मराठी शब्द आहे आणि महाराष्ट्रभरातून अनेक व्रकरी एकत्र येतात. ही यात्रा पंढरपूरकडे पंढरपूर वारीसाठी पंढरपूर धामकडे चालत जात आहे. ती २१ दिवस चालते. मार्गावर अनेक पालक्यांमध्ये इतर पालकी दोन प्रमुख पालक्यांमध्ये सामील होतात – संत ज्ञानेश्वराची पालकी आळंदीहून व संत तुकारामाची पालकी देहूहून सुरू होते. ही वारी पंढरपूरच्या विठोबा मंदिरात (जे श्रीविठोब-रुक्मिणी मंदिर म्हणूनही ओळखले जाते) शयनी एकादशीस, म्हणजे १७ जुलै रोजी संपते.भोळ्या, संतांच्या गाथा गाऊन व विठोबाची महिमा गाऊन, व्रकरी पंढरपूरकडे चालतात आणि त्यांना पंढरपूरला पोहोचल्यावर पवित्र भीमा नदीत स्नान करतात आणि मंदिराच्या दर्शनासाठी जातात, जिथे त्यांना श्री पंढरंग यांचे दर्शन मिळते.आमचं मोठं भाग्य आहे की ISKCON च्या माध्यमातून तीन डिंड्या - देहू, आळंदी आणि सासवड (जे मागील वर्षी सुरू झाले) - पंढरपूरला जात आहेत. या तिन्ही डिंड्या २९ जून रोजी त्यांच्या विशिष्ट स्थानांहून सुरू झाल्या आणि १ जुलै रोजी पुण्याच्या श्री श्री राधाकुंजबिहारी मंदिरावरून पंढरपूरकडे रवाना झाल्या.अनेक भक्त डिंडीत सामील होतात. हे एक उत्कृष्ट अनुभव आहे, ज्यामध्ये श्रीविठोबासाठी प्रेम असलेल्या भक्तांने पंढरपूरला पोहोचण्यासाठी १९ दिवस चालून व नाचून जायचं असतं. डिंडीला खास वैशिष्ट्ये आहेत – एक पूर्ण सकाळी कार्यक्रम, तीन वेळेस स्वादिष्ट प्रसाद (साथीत फिल्टर्ड पाणी), चांगली निवास व्यवस्था (लहान शुल्कावर), सतत हरिविष्णु संकीर्तन, उत्साही नृत्य, एक गतिमान युवक गटाची सहभागिता, मोठा पुस्तके वितरण, बैल गाडी प्रक्रियेचा समावेश, दररोज सार्वजनिक कार्यक्रम, आणि अद्भुत नाटके व लघुनाटके.वारी करणाऱ्या व्रकऱ्यांना पावसामुळे अनेक अडचणींचा सामना करावा लागतो, पण ते श्रीविठोबाची कृपा समजून त्यांना पंढरपूरसाठी प्रेमाने चालतात. जेव्हा ते एखाद्या गावात पोहोचतात, तेव्हा स्थानिक लोक त्यांना मोठ्या प्रमाणावर स्वागत करतात. काही गावकरी, जे इतकी दूर चालू शकत नाहीत, ते व्रकऱ्यांची सेवा करून स्वतःला भाग्यशाली मानतात. डिंडीमध्ये वयाचा अडथळा नाही – येथे महिलाही, वृद्ध लोक आणि अगदी लहान मुलेही डिंडीत सामील होतात. एकच पात्रता म्हणजे श्रीविठोबासाठी प्रेम.प्रकारे, वारीमध्ये चालणे म्हणजे श्रीविठोबाचे आशीर्वाद मिळवणे. श्रीविठोबा हे पंढरपूरचे श्री कृष्ण आहेत, जे अनेक वेळा हातात एक brick घेऊन उभे असतात, ज्याला मराठीत विटा म्हणून ओळखले जाते, त्यामुळे त्यांचे नाव 'विठोबा' झाले आहे.जो जन्म आणि मृत्यू नाकारतो, तो वारी आहे. म्हणून वारीत चालल्याने आत्मा जन्म आणि मृत्यूच्या चक्रातून मुक्त होतो आणि त्याला दुसऱ्या जन्मांत चालण्याची आवश्यकता नाही. त्यानुसार, आम्ही डिंडीला Dynamic Investment to Nurture Detachment and Intimacy म्हणून पाहतो.काही लोक डिंडीला एक डायनॅमिक गुंतवणूक म्हणून प्रश्न विचारतात, आणि विचारतात की पंढरपूरला चालायला का जायचं, त्यांची कामं सोडून? त्यांना वाटतं की हे वेळेचा वाया जाणं आहे. नाही, हे वेळेचा वाया जाणं नाही, हे एक गुंतवणूक आहे. भक्त त्यांचा वेळ श्रीविठोबाला आणि आमच्या हरे कृष्ण संकीर्तन डिंडीला देतात. आम्ही सतत संकीर्तन करतो.हेही एक व्यसनमुक्त डिंडी आहे, कारण त्यात चार नियम आहेत: मद्यपान नाही, मांसाहार नाही, जुगार नाही, आणि व्यभिचार नाही. या डिंडीत अनेक तंत्रज्ञानाने शिक्षित लोक आहेत जे त्यांच्या सांसारिक आणि भौतिक जीवनाचे बलिदान देऊन श्रीविठोबाच्या पायाशी समर्पित झाले आहेत. ते भक्ती, हरीनाम प्रचार, कीर्तन आणि पुस्तके व प्रसाद वितरणात व्यस्त आहेत. ही १९ दिवसांची पवित्र चाल म्हणजे एक तप आहे, जी लोकांना साधी जीवनशैली आणि उच्च विचार शिकवते.तर, आमच्यासोबत येऊन श्रीविठोबाशी भेटा, कारण येथे तप आहे आणि जिथे प्रेम आहे, तिथे धोका आहे. चला, डिंडी मध्ये चालायला चला आणि पंढरपूरकडे जाऊया!" ),

            // Nearby Facilities
            buildSectionCard(
              title: "जवळील सुविधा",
              content:
              "वैद्यकीय मदत: उपलब्ध\nस्नानगृह: स्थानिक ५०० मीटर अंतरावर",
            ),

            // Gallery Section
            Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "गॅलरी",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.image, size: 40),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.image, size: 40),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Feedback Section
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("फीडबॅक फॉर्म लवकरच उपलब्ध होईल!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                  EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("फीडबॅक द्या"),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildSectionCard({required String title, required String content}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: DindiListPage()));