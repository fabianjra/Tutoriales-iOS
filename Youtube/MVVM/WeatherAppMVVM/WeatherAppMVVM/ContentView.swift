//
//  ContentView.swift
//  WeatherAppMVVM
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        
        VStack {
            Text(viewModel.weatherVM.timeZone)
                .font(.system(size: 32))
            
            Text(viewModel.weatherVM.temperature)
                .font(.system(size: 44))
            
            Text(viewModel.weatherVM.title)
                .font(.system(size: 24))
            
            Text(viewModel.weatherVM.description)
                .font(.system(size: 24))
        }
        .task {
            await viewModel.fetchWeather("Boston")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
