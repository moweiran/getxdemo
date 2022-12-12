import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthDemoPage extends StatefulWidget {
  const LocalAuthDemoPage({super.key});

  @override
  State<LocalAuthDemoPage> createState() => _LocalAuthDemoPageState();
}

class _LocalAuthDemoPageState extends State<LocalAuthDemoPage> {
  final LocalAuthentication auth = LocalAuthentication();
  @override
  void initState() {
    super.initState();
  }

  void canCheckBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void getAvailableBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }
  }

  void _authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(
          // biometricOnly: true,
          stickyAuth: true,
        ),
      );
      print(didAuthenticate);
      // ···
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void _authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      print(authenticated);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Auth Demo')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: canCheckBiometrics,
            child: const Text('canCheckBiometrics'),
          ),
          ElevatedButton(
            onPressed: getAvailableBiometrics,
            child: const Text('getAvailableBiometrics'),
          ),
          ElevatedButton(
            onPressed: _authenticate,
            child: const Text('authenticate'),
          ),
          ElevatedButton(
            onPressed: _authenticateWithBiometrics,
            child: const Text('authenticateWithBiometrics'),
          )
        ],
      ),
    );
  }
}
