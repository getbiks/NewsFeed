//
//  ErrorMessages.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 21/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import Foundation

enum ErrorMessages : String, Error {
    case apiKeyMissing = "API Key is required to run the application"
    case invalidURL = "Invalid URL"
    case checkInternet = "Unable to complete your request. Please check your internet connection"
    case invalidServerResponse = "Invalid Response from the server. Please try again"
    case invalidData = "The data recieved from server is Invalid. Please try again"
    case decodeError = "Error decoding the data"
}
