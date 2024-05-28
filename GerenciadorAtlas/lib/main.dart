import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/atlas_keep_logo.png', // Certifique-se de adicionar seu logo ao diretório assets e atualizar este caminho.
                height: 100,
              ),
              SizedBox(height: 50),
              ToggleButtons(
                borderColor: Colors.black,
                fillColor: Colors.black,
                borderWidth: 2,
                selectedBorderColor: Colors.black,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Registro'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Login'),
                  ),
                ],
                isSelected: [!isLogin, isLogin],
                onPressed: (int index) {
                  setState(() {
                    isLogin = index == 1;
                  });
                },
              ),
              SizedBox(height: 20),
              if (!isLogin)
                Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Primeiro Nome',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Segundo Nome',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Data de Nascimento',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Repetir Senha',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              if (isLogin)
                Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Ação do botão Prosseguir
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
                child: Text('Prosseguir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
