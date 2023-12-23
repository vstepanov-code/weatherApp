//
//  DetailsView.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 22/12/2023.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var viewModel: DetailsViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                contentView
                    .padding()
            }
        }
        .mainNavigationBarStyle()
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var contentView: some View {
        VStack(alignment: .leading) {
            ForEach(Array(viewModel.detailedForecastList.keys.sorted()), id: \.self) { date in
                forecastSection(for: date)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.white)
        .cardStyle()
    }
    
    private func forecastSection(for date: Date) -> some View {
        Section(header: Text(date.formatted(.dateTime.day().month().weekday(.abbreviated))).titleTextStyle()) {
            ForEach(viewModel.detailedForecastList[date] ?? [], id: \.date) { forecastModel in
                DetailsForecastItemView(viewModel: forecastModel)
                    .padding(4)
                    .frame(height: 64)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
            }
        }
    }
}

#Preview {
    DetailsView(viewModel: DetailsViewModel(forecast: Forecast(list: [], city: City(id: 0, name: "", country: ""))))
}
