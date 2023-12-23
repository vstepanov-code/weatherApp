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
            
            HStack {
                Text(viewModel.dayTitle)
                    .titleTextStyle()
                
                Spacer()
                
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
            
            HStack(alignment: .center) {
                Text(viewModel.maxTempTitle)
                    .subtitleTextStyle()
                Text(viewModel.minTempTitle)
                    .subtitleTextStyle()
                
                Spacer()
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
        .padding()
        .background(.clear)
    }
}

#Preview {
    DashboardDailyItemView(viewModel: ForecastDayItem(date: Date(), maxTemp: 1, minTemp: 0, humidity: 2, description: "sunny", iconName: "10d"))
}
