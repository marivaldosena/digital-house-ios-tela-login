//
//  ViewController.swift
//  TelaLogin
//
//  Created by Marivaldo Sena on 15/09/20.
//  Copyright © 2020 Marivaldo Sena. All rights reserved.
//

import UIKit

//MARK: - Usuario
class Usuario {
    var email: String
    var senha: String
    
    init(email: String, senha: String) {
        self.email = email
        self.senha = senha
    }
    
    //TODO: Criar método para validar senha, alterar senha
}

// Criar repositório de usuário (classe)
//MARK: - UsuarioRepositorio
class UsuarioRepositorio {
     private var usuarios =  [Usuario]()
    
    func cadastrarUsuario(email: String, senha: String) {
            // Cadastrar funcionário
            //
            if !self.isUsuarioCadastrado(email: email) {
                self.salvarUsuarioNoRepositorio(email: email, senha: senha)
                print("Cadastrado com sucesso!")
            } else {
                print("Perdeu, playboy! Usuário já cadastrado!")
            }
        }
        
        private func salvarUsuarioNoRepositorio(email: String, senha: String) {
            let usuario = Usuario(email: email, senha: senha)
            self.usuarios.append(usuario)
        }
        
        func isUsuarioCadastrado(email: String) -> Bool {
            return self.usuarios.contains { $0.email == email }
    //
    //        contains equivale ao for abaixo:
    //
    //        for item in self.usuarios {
    //            if item.email == email {
    //                return true
    //                break
    //            }
    //        }
            //return false
        }
}

//MARK: - ViewController
class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    private var usuarioRepositorio = UsuarioRepositorio()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        senhaTextField.delegate = self
    }

    @IBAction func cadastrarButtonTapped(_ sender: UIButton) {
        let email = self.normalizarCampoDeTextoTextField(textField: emailTextField)
        let senha = self.normalizarCampoDeTextoTextField(textField: senhaTextField)
        
        if !self.usuarioRepositorio.isUsuarioCadastrado(email: email) {
            self.usuarioRepositorio.cadastrarUsuario(email: email, senha: senha)
        } else {
            self.notificarErroUsuarioCadastrado(textField: emailTextField)
        }
    }
    
    private func normalizarCampoDeTextoTextField(textField: UITextField) -> String {
        if let texto = textField.text, !texto.isEmpty {
            return texto
        } else {
            return ""
        }
    }
    
    private func limparCamposDeTextoTextField() {
        emailTextField.text = ""
        senhaTextField.text = ""
    }
    
    private func limparTodasNotificacoesErroUsuarioCadastradoOsCamposTextField() {
        self.limparNotificacaoErroUsuarioCadastrado(textField: emailTextField)
        self.limparNotificacaoErroUsuarioCadastrado(textField: senhaTextField)
    }
    
    private func notificarErroUsuarioCadastrado(textField: UITextField) {
        //Unobtrusive
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    private func limparNotificacaoErroUsuarioCadastrado(textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.clear.cgColor
    }
    
}

//MARK: - ViewController: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            self.avancarParaProximoTextField(antigo: emailTextField, novo: senhaTextField)
        case senhaTextField:
            self.avancarParaProximoTextField(antigo: senhaTextField, novo: nil)
        default:
            print("Deu merda!")
        }
        
        return true
    }
    
    private func avancarParaProximoTextField(antigo: UITextField?, novo: UITextField?) {
        antigo?.resignFirstResponder()
        novo?.becomeFirstResponder()
    }
}

