import 'package:appthoitiet/ui/get_started.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register.dart'; // Import giao diện đăng ký

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  String _loi = '';
  bool _login = false;

  Future<void> _dangNhap() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email.text, password: _pass.text);
      setState(() {
        _login = true;
      });
    } catch (error) {
      setState(() {
        _loi = 'Lỗi đăng nhập tài khoản';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgr.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ĐĂNG NHẬP',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Chữ màu đen
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black),
                            filled: true,
                            fillColor: Colors.white, // Nền trắng
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _pass,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: 'Mật khẩu',
                            labelStyle: TextStyle(color: Colors.black),
                            filled: true,
                            fillColor: Colors.white, // Nền trắng
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await _dangNhap();
                            if (_login) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GetStarted()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(_loi),
                                    backgroundColor: Colors.amber),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Nền trắng
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.black), // Viền đen
                            ),
                          ),
                          child: Text(
                            'Đăng nhập',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white, // Nền trắng
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    side: BorderSide(color: Colors.black), // Viền đen
                  ),
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
