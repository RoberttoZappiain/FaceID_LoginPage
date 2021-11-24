//
//  Login.swift
//  FACE ID Login Page
//
//  Created by Robertto Flores on 24/11/21.
//

import SwiftUI
import LocalAuthentication
//VISTA PRINCIPAL
struct Login  : View{
    //VARIABLES
    @StateObject var LoginModel = LoginViewModel()
    //ESTOS VIENEN DEL VIEWMODEL
    @AppStorage("stored_User") var Stored_User = ""
    @AppStorage("stored_Password") var Stored_Password = ""
    
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
                TextField("Correo Electronico", text: $LoginModel.email)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(LoginModel.email == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            //
            
            //STACK DE FIELD PASSWORD
            HStack{
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width:35)
                SecureField("Contrasena", text: $LoginModel.password)
                    .autocapitalization(.none)

            }
            .padding()
            .background(Color.white.opacity(LoginModel.password == "" ? 0 : 0.12))
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
                    .opacity(LoginModel.email != "" && LoginModel.password != "" ? 1 : 0.5)
                    .disabled(LoginModel.email != "" && LoginModel.password != "" ? false : true)
                
                if LoginModel.getBioMetricStatus(){
                    Button(action: LoginModel.authenticateUser, label: {
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
}
//
