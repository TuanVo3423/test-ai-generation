import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _keepSignedIn = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFE5FFD9),
        body: LayoutBuilder(
          builder: (context, constraints) {
            const topWrapperHeight = 142.0;
            const bottomSheetHeight = 666.0;

            final gap = (constraints.maxHeight - topWrapperHeight - bottomSheetHeight).clamp(0.0, double.infinity);

            return Stack(
              children: [
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFE5FFD9),
                          Color(0xFFE0F4D6),
                          Color(0xFFFFFFFF),
                          Color(0xFFECFFF5),
                        ],
                        stops: [0, 0.2022, 0.4663, 1],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: topWrapperHeight,
                      width: double.infinity,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: 561,
                              height: topWrapperHeight,
                              child: SvgPicture.asset(
                                'assets/images/sign_in_background.svg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              height: 70,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      width: 54,
                                      child: Text(
                                        '9:41',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.3,
                                          color: Color(0xFF484848),
                                        ),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/status_icons.svg',
                                      width: 82,
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -38,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/logo_mark.png',
                                    height: 50,
                                    width: 36,
                                  ),
                                  const SizedBox(width: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Image.asset(
                                      'assets/images/logo_word.png',
                                      height: 19,
                                      width: 181,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: gap),
                    _BottomSheet(
                      height: bottomSheetHeight,
                      bottomPadding: mediaQuery.viewInsets.bottom,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      keepSignedIn: _keepSignedIn,
                      obscurePassword: _obscurePassword,
                      onKeepSignedInChanged: (value) {
                        setState(() => _keepSignedIn = value);
                      },
                      onTogglePasswordVisibility: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    required this.height,
    required this.bottomPadding,
    required this.emailController,
    required this.passwordController,
    required this.keepSignedIn,
    required this.obscurePassword,
    required this.onKeepSignedInChanged,
    required this.onTogglePasswordVisibility,
  });

  final double height;
  final double bottomPadding;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool keepSignedIn;
  final bool obscurePassword;
  final ValueChanged<bool> onKeepSignedInChanged;
  final VoidCallback onTogglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        color: Color(0xFFFDFFFD),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 8 + bottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'おかえり！',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF484848),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'アプリ利用を続けるにはログインしてください。',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF667394),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: _inputDecoration(
                labelText: 'メールアドレス',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: obscurePassword,
              textInputAction: TextInputAction.done,
              decoration: _inputDecoration(
                labelText: 'パスワード',
                suffixIcon: IconButton(
                  onPressed: onTogglePasswordVisibility,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(width: 44, height: 44),
                  icon: SvgPicture.asset(
                    'assets/images/eye_icon.svg',
                    width: 26,
                    height: 26,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  foregroundColor: const Color(0xFF484848),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: const Text('パスワードをお忘れですか'),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                GestureDetector(
                  onTap: () => onKeepSignedInChanged(!keepSignedIn),
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE1E1E1)),
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.transparent,
                    ),
                    child: keepSignedIn
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Color(0xFF84C93F),
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'ログインしたままにする',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF667394),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF84C93F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: const Text('ログイン'),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 135,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFB9C0C9),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static InputDecoration _inputDecoration({
    required String labelText,
    Widget? suffixIcon,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFB8BCC6),
      ),
    );

    return InputDecoration(
      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: const TextStyle(
        fontSize: 12,
        color: Color(0xFF667394),
        fontWeight: FontWeight.w500,
      ),
      hintText: '',
      filled: true,
      fillColor: Colors.white,
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(
          color: Color(0xFF84C93F),
          width: 1.5,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 18,
      ),
      suffixIcon: suffixIcon,
    );
  }
}
