// login_controller.dart
class LoginController 
{
  final Map<String, String> _users = {
    "admin": "123",
    "alda": "456",
  };
  // Fungsi pengecekan (Logic-Only)
  // Fungsi ini mengembalikan true jika cocok, false jika salah.
  bool login(String username, String password) {
    if (_users.containsKey(username))
    {
      return _users[username] == password;
    }
    return false;
  }
}
