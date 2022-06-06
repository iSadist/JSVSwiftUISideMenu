//
//  JSVSwiftUISideMenu.swift
//  JSVSwiftUISideMenu
//
//  Created by Jan Svensson on 2022-06-06.
//

import SwiftUI

/// A Hamburger menu implemented in SwiftUI
public struct JSVSwiftUISideMenu<Content: View, SideBarContent: View>: View {
    /// A flag for the open state of the side menu
    @Binding public var showMenu: Bool
    /// A state
    @State public var openMenuValue: CGFloat = 0

    public var sideBarWidthMultiplier = 0.7
    public var content: Content
    public var sideBar: SideBarContent

    public var body: some View {
        let drag = DragGesture()
            .onChanged {
                openMenuValue = $0.translation.width
            }
            .onEnded {
                if $0.translation.width > 180 { // Open the menu
                    withAnimation {
                        openMenuValue = 0
                        self.showMenu = true
                    }
                } else if $0.translation.width < -100 { // Close the menu
                    withAnimation {
                        openMenuValue = 0
                        self.showMenu = false
                    }
                } else {
                    withAnimation { // Reset the menu to last state
                        openMenuValue = 0
                    }
                }
            }

        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                content
                    .offset(x: showMenu ?
                                geometry.size.width * sideBarWidthMultiplier + max(min(openMenuValue, 0), -geometry.size.width * sideBarWidthMultiplier) :
                                max(min(openMenuValue, geometry.size.width * sideBarWidthMultiplier), 0),
                            y: 0)

                sideBar
                    .frame(width: geometry.size.width * sideBarWidthMultiplier,
                           height: geometry.size.height)
                    .offset(x: showMenu ?
                                max(min(openMenuValue, 0), -geometry.size.width * sideBarWidthMultiplier) :
                                -geometry.size.width * sideBarWidthMultiplier + min(max(openMenuValue, 0), geometry.size.width * sideBarWidthMultiplier),
                            y: 0)
            }
            .gesture(drag)
        }
    }
}

