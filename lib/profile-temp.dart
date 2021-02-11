

class Profile{

  Profile( {
    this.first,
    this.last,
    this.email,
    this.password
  });

  final String first;
  final String last;
  final String email;
  final String password;


  set first (String value){
    first = value;
  }

  set second (String value){
    second = value;
  }

  set email (String value){
    email = value;
  }
  set password (String value){
    password = value;
  }


  String get firstName => first;
  String get lastName => last;
  String get userEmail => email;
  String get userPassword => password;


  bool get isValid => first != null && last !=null && email !=null && password != null;

}

Profile User = new Profile(first: 'Jane', last: 'Doe',email: 'janedoe23@gmail.com', password: '12345');