import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool _isLoading = false;
  bool _rememberMe = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // 模拟登录请求

    if (mounted) {
      if (_emailCtrl.text == 'test@example.com' && _passwordCtrl.text == '123456') {
        // 成功
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('登录成功')));
      } else {
        // 失败
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('邮箱或密码错误')));
      }
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '欢迎使用云笔记',
                  style: GoogleFonts.notoSans(fontSize: 28, fontWeight: FontWeight.bold),
                ).animate().fadeIn().slideY(begin: -0.5),
                const SizedBox(height: 32),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailCtrl,
                        decoration: const InputDecoration(
                          labelText: '邮箱',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.isEmpty) return '请输入邮箱';
                          if (!val.contains('@')) return '邮箱格式错误';
                          return null;
                        },
                      ).animate().fadeIn().slideX(begin: -0.3),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordCtrl,
                        decoration: const InputDecoration(
                          labelText: '密码',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (val) {
                          if (val == null || val.isEmpty) return '请输入密码';
                          if (val.length < 6) return '密码长度至少6位';
                          return null;
                        },
                      ).animate().fadeIn().slideX(begin: 0.3),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() => _rememberMe = value!);
                      },
                    ),
                    const Text('记住我'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('忘记密码功能未实现')));
                      },
                      child: const Text('忘记密码？'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _login,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.login),
                    label: Text(_isLoading ? '登录中...' : '登录'),
                  ),
                ).animate().fadeIn().scale(delay: 300.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
