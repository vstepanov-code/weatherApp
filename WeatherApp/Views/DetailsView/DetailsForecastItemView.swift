//
//  DetailsItemView.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 23/12/2023.
//

import SwiftUI

struct DetailsForecastItemView: View {
    
    var viewModel: DetailsForecastItemViewModel
    
    var body: some View {
        HStack {
            timeView
            Spacer()
            infoView
        }
        .background(.clear)
    }
    
    private var timeView: some View {
        HStack {
            Text(viewModel.timeTitle)
                .plainTextStyle()
                .frame(width: 80)
                .padding(.trailing, 8)
            
            iconImage
        }
    }
    
    private var iconImage: some View {
        AsyncImage(url: viewModel.iconURL) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
        } placeholder: {
            Image(systemName: "nosign")
                .foregroundStyle(.accent)
        }
    }
    
    private var infoView: some View {
        HStack {
            Text(viewModel.maxTempTitle)
                .plainTextStyle()
            Text(viewModel.minTempTitle)
                .plainTextStyle()
            humidityView
        }
    }
    
    private var humidityView: some View {
        HStack(spacing: 4) {
            Text(viewModel.humidityTitle)
                .plainTextStyle()
            
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
    DetailsForecastItemView(viewModel: DetailsForecastItemViewModel(date: Date(), maxTemp: 10, minTemp: 0, humidity: 20, description: nil, iconName: nil))
}
