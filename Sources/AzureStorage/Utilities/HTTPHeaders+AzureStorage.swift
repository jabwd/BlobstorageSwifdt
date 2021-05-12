//
//  HTTPHeaders+AzureStorage.swift
//  
//
//  Created by Antwan van Houdt on 12/05/2021.
//

import Vapor

extension HTTPHeaders {

  /// By default all requests need to have a date (in as pecific format)
  /// and version header attached, this static variable provides the default set for most requests
  static var defaultAzureStorageHeaders: HTTPHeaders {
    HTTPHeaders([
      (AzureStorage.dateHeader, Date().xMSDateFormat),
      (AzureStorage.versionHeader, AzureStorage.version),
    ])
  }


  /// Adds the authorization headers to this instance of `HTTPHeaders`
  /// - Parameters:
  ///   - method: HTTPMethod used in the request
  ///   - url: Destination URL
  ///   - config: Azure storage configuration object
  mutating func authorizeFor(
    method: HTTPMethod,
    url: URI,
    config: StorageConfiguration
  ) {
    let authorization = StorageAuthorization(method, headers: self, url: url, config: config)
    self.add(name: .authorization, value: authorization.headerValue)
  }

}
