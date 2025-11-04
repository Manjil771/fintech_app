// import 'package:flutter/material.dart';
// import 'package:ismart/app/app_dev.dart';
// import 'package:ismart/common/constant/assets.dart';
// import 'package:ismart/common/constant/env.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';

// class ConfigApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'App Configuration',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: ConfigurationPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class ConfigurationPage extends StatefulWidget {
//   @override
//   _ConfigurationPageState createState() => _ConfigurationPageState();
// }

// class _ConfigurationPageState extends State<ConfigurationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _clientSecretController = TextEditingController();
//   final _clientCodeController = TextEditingController();
//   final _baseUrlController = TextEditingController();
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _clientSecretController.dispose();
//     _clientCodeController.dispose();
//     _baseUrlController.dispose();
//     super.dispose();
//   }

//   void _startMainApp() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       final dynamicCoop = CoOperative(
//         baseUrl: _baseUrlController.text.trim(),
//         clientCode: _clientCodeController.text.trim(),
//         clientSecret: _clientSecretController.text.trim(),
//         backgroundImage: "assets/global_background.png",
//         bannerImage: "assets/images/ismart_banner.png",
//         coOperativeLogo: Assets.ismartLogo,
//         splashImage: "assets/images/ismart_splash.png",
//         primaryColor: const Color(0xFF010C80),
//         packageName: "com.devanasoft.ismart",
//         appStoreID: "com.devanasoft.ismart",
//         shouldValidateCooperative: true,
//         coOperativeName: "ISMART DEMO APPKTM",
//         appTitle: "iSmart Devanasoft",
//       );

//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => AppDev(
//             env: dynamicCoop,
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('iSmart app Configuration'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 40),
//               const Icon(
//                 Icons.settings_applications,
//                 size: 80,
//                 color: Colors.blue,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Configure Your App',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 'Please enter your configuration details to continue',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 40),
//               TextFormField(
//                 controller: _clientSecretController,
//                 decoration: InputDecoration(
//                   labelText: 'Client Secret',
//                   hintText: 'Enter your client secret',
//                   prefixIcon: const Icon(Icons.lock),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter client secret';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _clientCodeController,
//                 decoration: InputDecoration(
//                   labelText: 'Client Code',
//                   hintText: 'Enter your client code',
//                   prefixIcon: const Icon(Icons.code),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter client code';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _baseUrlController,
//                 decoration: InputDecoration(
//                   labelText: 'Base URL',
//                   hintText: 'https://api.example.com',
//                   prefixIcon: const Icon(Icons.link),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 keyboardType: TextInputType.url,
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _startMainApp,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text(
//                         'Continue to App',
//                         style: TextStyle(fontSize: 18),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:ismart/app/app_dev.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ismart/app/config_app.dart';
import 'package:ismart/app/local_wrapper.dart';
import 'package:ismart/common/util/log.dart';

class ConfigApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Configuration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConfigurationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final _formKey = GlobalKey<FormState>();
  final _clientSecretController = TextEditingController();
  final _clientCodeController = TextEditingController();
  final _baseUrlController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedConfig();
  }

  Future<void> _loadSavedConfig() async {
    final prefs = await SharedPreferences.getInstance();
    _clientSecretController.text = prefs.getString('clientSecret') ?? '';
    _clientCodeController.text = prefs.getString('clientCode') ?? '';
    _baseUrlController.text = prefs.getString('baseUrl') ?? '';
  }

  Future<void> _saveConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('clientSecret', _clientSecretController.text.trim());
    await prefs.setString('clientCode', _clientCodeController.text.trim());
    await prefs.setString('baseUrl', _baseUrlController.text.trim());
  }

  Future<void> _startMainApp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await _saveConfig();

      final dynamicCoop = CoOperative(
        baseUrl: _baseUrlController.text.trim(),
        clientCode: _clientCodeController.text.trim(),
        clientSecret: _clientSecretController.text.trim(),
        backgroundImage: "assets/global_background.png",
        bannerImage: "assets/images/ismart_banner.png",
        coOperativeLogo: Assets.ismartLogo,
        splashImage: "assets/images/ismart_splash.png",
        primaryColor: const Color(0xFF010C80),
        packageName: "com.devanasoft.ismart",
        appStoreID: "com.devanasoft.ismart",
        coOperativeName: "ISMART DEMO APPKTM",
        appTitle: "iSmart Devanasoft",
      );
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => AppDev(env: dynamicCoop),
      //   ),
      // );
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
      runZonedGuarded(() {
        runApp(
          LocalWrapper(child: AppDev(env: dynamicCoop)),
        );
      }, (e, s) {
        Log.e(e);
        Log.d(s);
      });
    }
  }

  @override
  void dispose() {
    _clientSecretController.dispose();
    _clientCodeController.dispose();
    _baseUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iSmart App Configuration'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Icon(
                Icons.settings_applications,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                'Configure Your App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Please enter your configuration details to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _clientSecretController,
                decoration: InputDecoration(
                  labelText: 'Client Secret',
                  hintText: 'Enter your client secret',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter client secret';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _clientCodeController,
                decoration: InputDecoration(
                  labelText: 'Client Code',
                  hintText: 'Enter your client code',
                  prefixIcon: const Icon(Icons.code),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter client code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _baseUrlController,
                decoration: InputDecoration(
                  labelText: 'Base URL',
                  hintText: 'https://api.example.com',
                  prefixIcon: const Icon(Icons.link),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isLoading ? null : _startMainApp,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Continue to App',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
