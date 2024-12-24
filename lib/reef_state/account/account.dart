class ReefAccount {
  late String name;
  late String address;
  late bool isSelected;

  ReefAccount(this.name, this.address, this.isSelected);

      ReefAccount.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        address = json['address'],
        isSelected = json['isSelected']==true;

      Map<String, dynamic> toJson() {
        return {
          'name': name,
          'address': address,
          'isSelected': isSelected
        };
      }
}