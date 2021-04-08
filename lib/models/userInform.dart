class UserInformation {
  String email;
  String username;
  String firstname;
  String lastname;
  bool trainer;
  String registrationdate;
  bool active;
  bool confirmed;
  bool delete;

  UserInformation.formJson(Map<String, dynamic> json) {
    if (json == null) return;
    email = json['email'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    trainer = json['trainer'];
    registrationdate = json['registrationdate'];
    active = json['active'];
    confirmed = json['confirmed'];
    delete = json['delete'];
    Map<String, dynamic> toJson() => {
          'email': email,
          'username': username,
          'firstname': firstname,
          'lastname': lastname,
          'trainer': trainer,
          'registrationdate': registrationdate,
          'active': active,
          'confirmed': confirmed,
          'delete': delete
        };
  }
}
