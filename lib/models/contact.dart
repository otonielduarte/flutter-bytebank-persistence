class Contact {
  String name;
  int accountNumber;
  int id;

  Contact(this.id, this.name, this.accountNumber);

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        accountNumber = json['account_number'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'account_number': accountNumber,
      };

  @override
  String toString() {
    return 'Contact: { id:$id, name:$name , account:$accountNumber }';
  }
}
