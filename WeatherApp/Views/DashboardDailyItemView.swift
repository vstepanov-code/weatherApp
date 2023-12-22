//
//  DashboardDailyItemView.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 22/12/2023.
//

import SwiftUI

struct DashboardDailyItemView: View {
    
    @State var viewModel: ForecastDayItem
    
    var body: some View {
        HStack {
            Text(viewModel.dayTitle)
                .subtitleTextStyle()
                .frame(width: 100, alignment: .leading)
                .padding(.trailing, 16)
            
            HStack(spacing: 4) {
                Text(viewModel.humidityTitle)
                    .plainTextStyle()
                
                Image(systemName: "drop.degreesign.fill")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundStyle(.accent)
                    .frame(width: 16, height: 16)
            }
            
            HStack {
                
                AsyncImage(url: viewModel.iconURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                } placeholder: {
                    ProgressView() // Show a loader while the image is loading
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Spacer()
                Text(viewModel.maxTempTitle)
                    .plainTextStyle()
                Text(viewModel.minTempTitle)
                    .plainTextStyle()
                Spacer()
            }
            
        }
        .background(.clear)
        .padding(.horizontal, 16)
    }
}

#Preview {
    DashboardDailyItemView(viewModel: ForecastDayItem(dayTitle: "title", maxTemp: 1, minTemp: 0, humidity: 2, description: "sunny", iconName: "10d"))
}
