//
//  SwiftUIView.swift
//  
//
//  Created by crexista on 2022/01/07.
//

import SwiftUI

public struct Sample: View {
    public var body: some View {
        VStack {
            Image(uiImage: Asset.icApple.image)
                .resizable()
                .frame(width: 120, height: 120)
            Text("Apple")
        }
    }

    public init() {}
}

struct SamplePreview: PreviewProvider {
    static var previews: some View {
        Sample()
    }
}
