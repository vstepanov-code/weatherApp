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
                VStack(spacing: 4) {
                    currentWeatherView
                    detailsLink
                    dailyForecastTabView
                }
            }
            .refreshable {
                await viewModel.refreshData()
            }
            .onAppear {
                Task {
                    await viewModel.refreshData()
                }
            }
        }
        .alert("Error", isPresented: Binding<Bool>(get: {
            viewModel.error != nil
        }, set: { _ in
            viewModel.error = nil
        }), presenting: viewModel.error) { error in
            Button("OK", role: .cancel) { }
        } message: { error in
            Text(error.localizedDescription)
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .mainNavigationBarStyle()
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ViewBuilder
    private var currentWeatherView: some View {
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
        }
    }
    
    @ViewBuilder
    private var detailsLink: some View {
        if let forecast = viewModel.forecast {
            HStack {
                Spacer()
                NavigationLink(destination: DetailsView(viewModel: DetailsViewModel(forecast: forecast))
                    .navigationBarTitle("Detailed Forecast", displayMode: .large)) {
                        Text("DETAILS")
                            .padding(.horizontal)
                            .frame(height: 36)
                            .primaryButtonStyle()
                    }
            }.padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private var dailyForecastTabView: some View {
        GeometryReader { geometry in
            if UIDevice.current.userInterfaceIdiom == .pad {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.dailyForecastList, id: \.dayTitle) { dayForecast in
                            DashboardDailyItemView(viewModel: dayForecast)
                                .frame(width: geometry.size.width / 3, height: 100)
                                .background(Color.white)
                                .cardStyle()
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                TabView {
                    ForEach(viewModel.dailyForecastList, id: \.dayTitle) { dayForecast in
                        DashboardDailyItemView(viewModel: dayForecast)
                            .frame(height: 100)
                            .background(Color.white)
                            .cardStyle()
                            .padding(.horizontal)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
        }
        .frame(height: 200)
    }
}

#Preview {
    DashboardView(viewModel: DashboardViewModel())
}
