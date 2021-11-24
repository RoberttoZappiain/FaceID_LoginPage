//
//  ContentView.swift
//  FACE ID Login Page
//
//  Created by Robertto Flores on 24/11/21.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @AppStorage ("status") var logged = false
    var body: some View {
        NavigationView{
            if logged {
                Text("Usuario correctamente logueado")
                .navigationTitle("Inicio")
                .navigationBarHidden(false)
                .preferredColorScheme(.light)
            }
            else{
                Home()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Home()
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
        }

    }
}

//VISTA PRINCIPAL
struct Home  : View{
    //VARIABLES
    @State var userName = ""
    @State var passWord = ""
    @AppStorage("stored_User") var user = "reply.kavsoft@gmail.com"
    @AppStorage("status") var logged = false
    
    var body: some View{
        VStack{
            Spacer(minLength: 0)
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            //IMAGEN DINAMICA/RESPONSIVA
                .padding(.horizontal,35)
                .padding(.vertical)
            HStack{
                VStack(alignment: .leading, spacing: 12, content: {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Por favor inicie sesion para continuar")
                        .foregroundColor(Color.white.opacity(0.5))
                })
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.leading, 15)
            
            //STACK DE FIELD CORREO
            HStack{
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width:35)
                TextField("Correo Electronico", text: $userName)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            //
            
            //STACK DE FIELD PASSWORD
            HStack{
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width:35)
                SecureField("Contrasena", text: $passWord)
                    .autocapitalization(.none)

            }
            .padding()
            .background(Color.white.opacity(passWord == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.top)
            //
            
            HStack(spacing: 15){
                Button(action: {}, label: {
                    Text("Ingresar")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color("green"))
                        .clipShape(Capsule())
                })
                    .opacity(userName != "" && passWord != "" ? 1 : 0.5)
                    .disabled(userName != "" && passWord != "" ? false : true)
                
                if getBioMetricStatus(){
                    Button(action: authenticateUser, label: {
                        //OBTENIENDO BIOMETRICTYPE
                        Image(systemName: LAContext().biometryType == .faceID ?  "faced" : "touchid")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color("green"))
                            .clipShape(Circle())
                    })
                }
            }
            .padding(.top)
            
            //BOTON RESTABLECER PASSWORD
            Button(action: {}, label: {
                Text("Olvidaste tus datos?")
                    .font(.title2)
                    .foregroundColor(Color("green"))
            })
                .padding(.top, 8)
            //
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6){
                Text("Aun no tienes cuenta?")
                    .foregroundColor(Color.white.opacity(0.6))
                Button(action: {}, label: {
                    Text("Registrate")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("green"))
                })
            }
            .padding(.vertical)
        }
        .background(Color("bg").ignoresSafeArea(.all,edges: .all))
        .animation(.easeOut)
    }
    
    //FUNCION STATUS FACE ID
    func getBioMetricStatus() -> Bool{
        let scanner = LAContext()
        if userName == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none){
            
            return true
        }
        return false
    }
    //
    
    //FUNCION AUTENTICACION USUARIO
    func authenticateUser(){
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Para desbloquear\(userName)"){(status, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            //CONFIGURACION ESTADO LOGGEADO TRUE
            withAnimation(.easeOut){logged = true}
        }
    }
    //
}
//
