//
//  LoginViewModel.swift
//  FACE ID Login Page
//
//  Created by Robertto Flores on 24/11/21.
//

import SwiftUI
import LocalAuthentication

class LoginViewModel : ObservableObject{
    @Published var email = ""
    @Published var password = ""

    //PARA ALERTAS
    @Published var alert = false
    @Published var alertMsg = ""
    
    //DATOS USUARIO
    @AppStorage("stored_User") var Stored_User = ""
    @AppStorage("stored_Password") var Stored_Password = ""
    @AppStorage("status") var logged = false
    //
    
    //FUNCION STATUS FACE ID
    func getBioMetricStatus() -> Bool{
        let scanner = LAContext()
        if email == Stored_User && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none){
            
            return true
        }
        return false
    }
    //
    
    //FUNCION AUTENTICACION USUARIO
    func authenticateUser(){
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Para desbloquear\(email)"){(status, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
           
        }
    }
    //
}
