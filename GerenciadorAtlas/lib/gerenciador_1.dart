import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PasswordManagerScreen(),
    );
  }
}

class Password {
  String appName;
  String username;
  String password;

  Password({required this.appName, required this.username, required this.password});
}

class PasswordManagerScreen extends StatefulWidget {
  @override
  _PasswordManagerScreenState createState() => _PasswordManagerScreenState();
}

class _PasswordManagerScreenState extends State<PasswordManagerScreen> {
  final List<Password> passwords = [
    Password(appName: 'Facebook', username: 'user1', password: 'password1'),
    Password(appName: 'Instagram', username: 'user2', password: 'password2'),
    Password(appName: 'Twitter', username: 'user3', password: 'password3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gerenciador de Senhas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: passwords.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      passwords[index].appName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('Usuário: ${passwords[index].username}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPasswordScreen(password: passwords[index], onUpdate: (updatedPassword) {
                            setState(() {
                              passwords[index] = updatedPassword;
                            });
                            Navigator.pop(context);
                          }),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPasswordScreen(onSave: (newPassword) {
              setState(() {
                passwords.add(newPassword);
              });
            })),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletar Senha'),
          content: Text('Tem certeza de que deseja deletar esta senha?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  passwords.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Deletar'),
            ),
          ],
        );
      },
    );
  }
}

class AddPasswordScreen extends StatelessWidget {
  final Function(Password) onSave;

  AddPasswordScreen({required this.onSave});

  @override
  Widget build(BuildContext context) {
    String appName = '';
    String username = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar Nova Senha',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome do Aplicativo/Website',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) => appName = value,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Usuário/Email',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) => username = value,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              obscureText: true,
              onChanged: (value) => password = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onSave(Password(appName: appName, username: username, password: password));
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditPasswordScreen extends StatelessWidget {
  final Password password;
  final Function(Password) onUpdate;

  EditPasswordScreen({required this.password, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    String updatedUsername = password.username;
    String updatedPassword = password.password;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Editar Senha',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
          TextField(
          decoration: InputDecoration(
          labelText: 'Nome do Aplicativo/Website',
            border: OutlineInputBorder(),
            hintText: password.appName,
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Novo Usuário/Email',
            border: OutlineInputBorder(),
            hintText: password.username,
            filled: true,
            fillColor: Colors.grey[200],
          ),
          onChanged: (value) => updatedUsername = value,
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Nova Senha',
            border: OutlineInputBorder(),
            hintText: password.password,
            filled: true,
            fillColor: Colors.grey[200],
          ),
          obscureText: true,
          onChanged: (value) => updatedPassword = value,
        ),
        SizedBox(height: 20),
        ElevatedButton(
        onPressed: () {
      onUpdate(Password(appName: password.appName, username: updatedUsername, password: updatedPassword));
    },
    child: Text('Atualizar'),
        ),
            ],
          ),
        ),
    );
  }
}

