//
//  TabBar.swift
//  HammerApp
//
//  Created by Михаил Ганин on 23.07.2025.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        VStack {
            TabView {
                MenuView()
                    .tabItem {
                        Image(systemName: "person.2")
                    }
                Contacts()
                    .tabItem {
                        Image(systemName: "message")
                    }
                Profile()
                    .tabItem {
                        Image(systemName: "ellipsis")
                    }
                Trash()
                    .tabItem {
                        Image(systemName: "trash")
                    }
            }
        }
    }
}
