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
    case apiKeyInvalid = "Your API key is invalid or incorrect. Check your key, or go to https://newsapi.org to create a free API key"
    case apiKeyDisabled = "Your API key has been disabled"
    case apiKeyExhausted = "Your API key has no more requests available. Please try again tomorrow or consider changing the API key in the settings"
    case invalidURL = "Invalid URL"
    case checkInternet = "Unable to complete your request. Please check your internet connection"
    case invalidServerResponse = "Invalid Response from the server. Please try again"
    case invalidData = "The data recieved from server is Invalid. Please try again"
    case decodeError = "Error decoding the data"
    case badRequest = "The request was unacceptable, often due to a missing or misconfigured parameter"
    case unauthorized = "Your API key was missing from the request, or wasn't correct"
    case tooManyRequests = "You made too many requests within a window of time and have been rate limited. Back off for a while"
}
