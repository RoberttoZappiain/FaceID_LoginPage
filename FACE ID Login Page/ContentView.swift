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
                Login()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Login()
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
        }

    }
}

