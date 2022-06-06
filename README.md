# SwiftUISideMenu

A simple side menu / hamburger menu for SwiftUI.
To use it, simple import the package

import SwiftUISideMenu

and use it like this

JSVSwiftUISideMenu(showMenu: Binding<Bool>,
                   contentView: some View,
                   sideBarView: some View,
                   sideBarWidthMultiplier: Double)
