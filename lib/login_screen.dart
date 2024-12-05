import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Importação do pacote flutter_svg

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: '101559261387424548082');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _name;
  String? _email;
  String? _photoUrl;

  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication googleAuth = await account.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Fazer login no Firebase com as credenciais do Google
        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        setState(() {
          _name = userCredential.user?.displayName;
          _email = userCredential.user?.email;
          _photoUrl = userCredential.user?.photoURL;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bem-vindo, ${account.displayName}!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              name: _name,
              email: _email,
              photoUrl: _photoUrl,
            ),
          ),
        );
      }
    } catch (error) {
      print('Erro ao fazer login com Google: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $error')),
      );
    }
  }

  void _login() {
    final String name = _nameController.text;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(
          name: name,
          email: null,
          photoUrl: null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bem-vindo!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Login',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _signInWithGoogle,
                icon: SvgPicture.asset(
                  'assets/google_icon.svg', // Certifique-se de ter o ícone SVG na pasta assets
                  height: 24,
                  width: 24,
                ),
                label: const Text('Entrar com Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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

class MyHomePage extends StatelessWidget {
  final String? name;
  final String? email;
  final String? photoUrl;

  const MyHomePage({super.key, this.name, this.email, this.photoUrl});

  void _signOut(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    await _googleSignIn.signOut();
    await _auth.signOut();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Você saiu com sucesso!')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal'),
        actions: [
          IconButton(
            onPressed: () => _signOut(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (photoUrl != null)
              CircleAvatar(
                backgroundImage: NetworkImage(photoUrl!),
                radius: 50,
              )
            else
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
            const SizedBox(height: 16),
            if (name != null)
              Text(
                name!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (email != null)
              Text(
                email!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 24),
            const Text(
              'Você está logado!',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}