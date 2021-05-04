//
//  ApiError.swift
//  API
//
//  Created by NHN on 2021/05/04.
//

public enum ApiError: Error {
    case unexpectedError
    case serverRequestNotOk
    case jsonParseError
}
