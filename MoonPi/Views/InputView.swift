//
//  InputView.swift
//  MoonPi
//
//  Created by Gabriel Santos on 28/10/25.
//

import SwiftUI

struct InputView: View {
    @State var name: String
    @Binding var value: String
    var autocorrectionDisabled: Bool = false
    var useSecureField: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("", text: $value)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(autocorrectionDisabled)
                    .onAppear(perform: {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    })
            }
        }
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var test: String = ""
    InputView(name: "About", value: $test)
}
