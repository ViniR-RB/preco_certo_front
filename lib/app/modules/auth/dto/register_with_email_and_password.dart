class RegisterWithEmailAndPassword {
  String email = "";
  String password = "";
  String name = "";

  RegisterWithEmailAndPassword({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, String> toJson() {
    return {"email": email, "password": password, "name": name};
  }
}
