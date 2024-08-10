import 'package:url_launcher/url_launcher.dart';

class WhatsappRedirect {

  Future<void> openWhatsapp({ required String phone, required String text}) async {
    if (!await launchUrl(Uri.parse("https://wa.me/$phone?text=$text"))) {
      throw Exception('Could not open whatsapp $phone');
    }
  }

} 