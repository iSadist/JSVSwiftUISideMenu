//
//  JSVSwiftUISideMenu.swift
//  JSVSwiftUISideMenu
//
//  Created by Jan Svensson on 2022-06-06.
//

import SwiftUI

/// A Hamburger menu implemented in SwiftUI
@available(iOS 13.0, *)
public struct JSVSwiftUISideMenu<Content: View, SideBarContent: View>: View {
    /// A flag indicating if the side menu should be visible or not
    @Binding public var showMenu: Bool
    /// A value indicating how much the side menu is visible, between the max and min state
    @State public var openMenuValue: CGFloat = 0

    /// The width of the side menu compared to the screen
    public var sideBarWidthMultiplier = 0.7
    /// The main content view
    public var content: Content
    /// The side menu view
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

