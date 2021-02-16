

class Profile{

  Profile( {
    this.first,
    this.last,
    this.email,
    this.password
  });

  String first;
  String last;
  String email;
  String password;


  set firstName (String value){
    first = value;
  }

  set lastName (String value){
    last = value;
  }

  set newEmail (String value){
    email = value;
  }
  set newPassword (String value){
    password = value;
  }


  String get firstName => first;
  String get lastName => last;
  String get userEmail => email;
  String get userPassword => password;


  bool get isValid => first != null && last !=null && email !=null && password != null;

}

Profile User = new Profile(first: 'Jane', last: 'Doe',email: 'janedoe23@gmail.com', password: '12345');