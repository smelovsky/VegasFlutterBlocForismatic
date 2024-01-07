

class Forismatic {

  String quoteText = "";
  String quoteAuthor = "";
  String senderLink = "";
  String quoteLink = "";

  Forismatic({required this.quoteText, required this.quoteAuthor, required this.senderLink, required this.quoteLink});

  factory Forismatic.fromJson(Map<String, dynamic> json) {
    return Forismatic(
      quoteText: json['quoteText'],
      quoteAuthor: json['quoteAuthor'],
      senderLink: json['senderLink'],
      quoteLink: json['quoteLink'],
    );
  }
}