//
//  OnBoarding.swift
//  FoxusApp
//
//  Created by AlJawharh AlOtaibi on 20/05/1445 AH.
//

import SwiftUI
extension Color {
    static let customColor = Color(red: 53.0/255, green: 89.0/255, blue: 149.0/255)
}
struct Page : Identifiable {
    var id : Int
    var image : String
    var title : String
    var descrip : String
}
var Data = [
    Page(id: 0, image: "ob1", title: "Overwhelmed by life’s complexity?", descrip: "Foxus aim to make your life less chaotic and more organized."),
    Page(id: 1, image: "ob2", title: "When everything’s chasing you...", descrip: " Foxus rearranges your Taskitems based on your input, understands your priorities."),
    Page(id: 2, image: "ob3", title: "Let Foxus simplify your life ", descrip: "Foxus handles conflicts and rescheduling automatically.")
]
struct OnBoardingView: View {
    @State var showSheetView = false
    @State private var currentPage = 0
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor =   .blue
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<Data.count) { index in
                        GeometryReader { geometry in
                            VStack {
                                Image(Data[index].image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 350, height: 400)
                                    //.clipped()
                                Text(Data[index].title)
                                    .font(.title).bold()
                                    .padding()
                                    .multilineTextAlignment(.center)
                                    
                                Text(Data[index].descrip)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                
                              
                            }
                            .opacity(Double(geometry.frame(in: .global).minX) / 200 + 1)
                            .frame(width: UIScreen.main.bounds.width)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: currentPage == Data.count - 1 ? .never : .always))
               .edgesIgnoringSafeArea(.top)
                if currentPage == Data.count - 1 {
                                   NavigationLink(destination: MainPage()) {
                                       Text("Start")
                                           .font(.headline)
                                           .frame(width: 300, height: 50)
                                           .foregroundColor(.white)
                                           .background(Color.customColor)
                                           .cornerRadius(10)
                                           .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                    }
                }
                Spacer(minLength: 40)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: skipButton)
        }
    }
private var skipButton: some View {
        if currentPage < 2 {
            return AnyView(NavigationLink(destination: MainPage()) {
                Text("Skip")
                    .font(.headline)
                    .padding(.trailing, 15)
                    .foregroundColor(Color.customColor)
            })
        } else {
            return AnyView(EmptyView())
        }
    }
}
struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}


