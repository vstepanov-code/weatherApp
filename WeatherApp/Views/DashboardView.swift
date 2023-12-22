//
//  ContentView.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 21/12/2023.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let currentTemperatureTitle = viewModel.currentTemperatureTitle,
                       let currentCityTitle = viewModel.currentCityTitle {
                        VStack(alignment: .trailing) {
                            Text(Date.now.formatted(.dateTime.day().month(.abbreviated).weekday(.abbreviated)))
                                .titleTextStyle()
                            Text("NOW")
                                .headerTextStyle3()
                            Text(currentTemperatureTitle)
                                .headerTextStyle1()
                            Text(currentCityTitle.uppercased())
                                .headerTextStyle2()
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(height: 250)
                        .padding()
                        .padding(.bottom, 64)
                    }
                    
                    TabView {
                        ForEach(viewModel.dailyForecastList, id: \.dayTitle) { dayForecast in
                            DashboardDailyItemView(viewModel: dayForecast)
                                .frame(height: 100)
                                .background(.white)
                                .cardStyle()
                                .padding(.horizontal)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .frame(height: 200)
                }
            }
            .onAppear {
                viewModel.loadForecast()
            }
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
}

#Preview {
    DashboardView(viewModel: DashboardViewModel())
}
