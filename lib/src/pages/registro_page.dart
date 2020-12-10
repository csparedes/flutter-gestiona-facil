import 'package:flutter/material.dart';

import 'package:gestiona_facil/src/blocs/provider.dart';
import 'package:gestiona_facil/src/blocs/login_bloc.dart';
import 'package:gestiona_facil/src/providers/usuario_provider.dart';
import 'package:gestiona_facil/src/utils/utils.dart';

class RegistroPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 220,
            ),
          ),
          Container(
            width: size.width * 0.85,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0, 5),
                    spreadRadius: 3.0,
                  ),
                ]),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Crear Cuenta',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 30,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 30,
                ),
                _crearBoton(bloc),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            child: Text('¿Ya tienes Cuenta? Login'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Theme.of(context).primaryColor,
              ),
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Theme.of(context).primaryColor,
                ),
                labelText: 'Contraseña',
                errorText: snapshot.error,
                counterText: snapshot.data),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.fromValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          onPressed: snapshot.hasData ? () => register(bloc, context) : null,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 80,
              vertical: 15,
            ),
            child: Text('Crear Cuenta'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
        );
      },
    );
  }

  register(LoginBloc bloc, BuildContext context) async {
    // Navigator.pushReplacementNamed(context, 'home');
    final info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      mostrarAlerta(context, info['message']);
    }
  }

  _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.6,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(25, 128, 131, 1),
        Color.fromRGBO(25, 128, 131, 0.7),
      ])),
    );
    final circulo = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
    return Stack(
      children: [
        fondoMorado,
        Positioned(
          top: 90.0,
          left: 30.0,
          child: circulo,
        ),
        Positioned(
          top: -40.0,
          right: -30.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        Positioned(
          top: 50.0,
          right: 30.0,
          child: circulo,
        ),
        Positioned(
          top: 120.0,
          left: 20.0,
          child: circulo,
        ),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Icon(
                Icons.store,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'Gestiona Facil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
