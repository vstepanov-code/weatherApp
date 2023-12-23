//
//  DashboardDailyItemView.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 22/12/2023.
//

import SwiftUI

struct DashboardDailyItemView: View {
    
    var viewModel: ForecastDayItem
    
    var body: some View {
        VStack(alignment: .leading) {
            dayTitleAndIcon
            temperatureAndHumidity
        }
        .padding()
        .background(.clear)
    }
    
    @ViewBuilder
    private var dayTitleAndIcon: some View {
        HStack {
            Text(viewModel.dayTitle)
                .titleTextStyle()
            
            Spacer()
            
            iconImage
        }
    }
    
    @ViewBuilder
    private var iconImage: some View {
        AsyncImage(url: viewModel.iconURL) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
        } placeholder: {
            Image(systemName: "nosign")
                .foregroundStyle(.accent)
        }
    }
    
    @ViewBuilder
    private var temperatureAndHumidity: some View {
        HStack(alignment: .center) {
            Text(viewModel.maxTempTitle)
                .subtitleTextStyle()
            Text(viewModel.minTempTitle)
                .subtitleTextStyle()
            
            Spacer()
            humidityView
        }
    }
    
    @ViewBuilder
    private var humidityView: some View {
        HStack(spacing: 4) {
            Text(viewModel.humidityTitle)
                .subtitleTextStyle()
            
            Image(systemName: "drop.degreesign.fill")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundStyle(.accent)
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    DashboardDailyItemView(viewModel: ForecastDayItem(date: Date(), maxTemp: 1, minTemp: 0, humidity: 2, description: "sunny", iconName: "10d"))
}
