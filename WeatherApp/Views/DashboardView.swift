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
                        Group {
                            Text(currentCityTitle)
                                .headerTextStyle()
                            Text(currentTemperatureTitle)
                                .titleTextStyle()
                        }
                        .frame(alignment: .trailing)
                        .frame(height: 200)
                    }
                    
                    TabView {
                        ForEach(viewModel.dailyForecastList, id: \.dayTitle) { dayForecast in
                            DashboardDailyItemView(viewModel: dayForecast)
                                .background(Color.white)
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
        .background(.yellow)
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
