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
            timeTitle
            iconImage
            Spacer()
            infoView
        }
        .background(.clear)
    }
    
    private var timeTitle: some View {
        Text(viewModel.timeTitle)
            .frame(width: 40, alignment: .leading)
            .plainTextStyle()
            .padding(.trailing, 12)
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
