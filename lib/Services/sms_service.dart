import 'package:http/http.dart' as http;

class SmsService {
  sendSms(phoneNumber, orderNumber) async {
    var msgApi =
        "http://api.boom-cast.com/boomcast/WebFramework/boomCastWebService/externalApiSendTextMessage.php?masking=NOMASK&userName=fauziaali2000@gmail.com&password=80f50e35f83130f022e78a2862aab390&MsgType=TEXT&receiver='$phoneNumber'&message= " +
            "Your DAWN STATIONERY Order $orderNumber has been placed. Helpline: 09617617618";

    var msgApiForAdmin =
        "http://api.boom-cast.com/boomcast/WebFramework/boomCastWebService/externalApiSendTextMessage.php?masking=NOMASK&userName=fauziaali2000@gmail.com&password=80f50e35f83130f022e78a2862aab390&MsgType=TEXT&receiver=01815554790&message= " +
            "An order in DAWN STATIONERY has been placed. Order number $orderNumber  Helpline: 09617617618";

    var response = await http.get(
      Uri.parse(msgApi),
    );
    var responseForadmin = await http.get(
      Uri.parse(msgApiForAdmin),
    );
    if (response.statusCode == 200) {
      print("successfully sent message to user's phone");
    } else {
      print("sms to client's phone was not sent. error is ${response.body}");
    }

    if (responseForadmin.statusCode == 200) {
      print("successfully sent message to admin phone");
    } else {
      print("sms to admin phone was not sent. error is ${response.body}");
    }
  }
}
