class Contact {
  String name;
  int accountNumber;
  int id;

  Contact(this.id, this.name, this.accountNumber);

  @override
  String toString() {
    return 'Contact: { id:$id, name:$name , account:$accountNumber }';
  }
}
