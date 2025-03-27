import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart'; // Import giao diện đăng nhập

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  String _loi = '';
  bool _register = false;

  Future<void> _dangKyTaiKhoan() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _email.text, password: _pass.text);
      setState(() {
        _loi = 'Đăng ký thành công';
        _register = true;
      });

      // Quay lại màn hình đăng nhập sau khi đăng ký thành công
      if (_register) {
        Navigator.pop(context);
      }
    } catch (error) {
      setState(() {
        _loi = 'Lỗi đăng ký tài khoản';
      });
      print('Lỗi $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hình nền
          Positioned.fill(
            child: Image.asset(
              'assets/backgr.png',
              fit: BoxFit.cover,
            ),
          ),
          // Nội dung đăng ký
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ĐĂNG KÝ',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Chữ màu đen
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _email,
                      style: TextStyle(color: Colors.black), // Chữ màu đen
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black), // Chữ màu đen
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9), // Nền sáng hơn
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _pass,
                      obscureText: true,
                      style: TextStyle(color: Colors.black), // Chữ màu đen
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Mật khẩu',
                        labelStyle: TextStyle(color: Colors.black), // Chữ màu đen
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9), // Nền sáng hơn
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await _dangKyTaiKhoan();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(_loi),
                              backgroundColor: Colors.amber),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Nền trắng
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.black), // Viền đen
                        ),
                      ),
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(color: Colors.black), // Chữ màu đen
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
