//
//  File.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

var somethingWentWrong: String {
    ErrorMessages.somethingWentWrong.showableDescription }

enum NSURLErrors: Int,Error,CaseIterable,Codable {
    
    case NSURLErrorFileOutsideSafeArea = -1104
    case NSURLErrorUnknown = -1
    case NSURLErrorCancelled = -999
    case NSURLErrorBadURL = -1000
    case NSURLErrorTimedOut = -1001
    case NSURLErrorUnsupportedURL = -1002
    case NSURLErrorCannotFindHost = -1003
    case NSURLErrorCannotConnectToHost = -1004
    case NSURLErrorNetworkConnectionLost = -1005
    case NSURLErrorDNSLookupFailed = -1006
    case NSURLErrorHTTPTooManyRedirects = -1007
    case NSURLErrorResourceUnavailable = -1008
    case NSURLErrorNotConnectedToInternet = -1009
    case NSURLErrorRedirectToNonExistentLocation = -1010
    case NSURLErrorBadServerResponse = -1011
    case NSURLErrorUserCancelledAuthentication = -1012
    case NSURLErrorUserAuthenticationRequired = -1013
    case NSURLErrorZeroByteResource = -1014
    case NSURLErrorCannotDecodeRawData = -1015
    case NSURLErrorCannotDecodeContentData = -1016
    case NSURLErrorCannotParseResponse = -1017
    case NSURLErrorAppTransportSecurityRequiresSecureConnection = -1022
    case NSURLErrorFileDoesNotExist = -1100
    case NSURLErrorFileIsDirectory = -1101
    case NSURLErrorNoPermissionsToReadFile = -1102
    case NSURLErrorDataLengthExceedsMaximum  = -1103
    
    // SSL errors
    case NSURLErrorSecureConnectionFailed = -1200
    case NSURLErrorServerCertificateHasBadDate = -1201
    case NSURLErrorServerCertificateUntrusted = -1202
    case NSURLErrorServerCertificateHasUnknownRoot = -1203
    case NSURLErrorServerCertificateNotYetValid = -1204
    case NSURLErrorClientCertificateRejected = -1205
    case NSURLErrorClientCertificateRequired = -1206
    case NSURLErrorCannotLoadFromNetwork = -2000
    
    // Download and file I/O errors
    case NSURLErrorCannotCreateFile = -3000
    case NSURLErrorCannotOpenFile = -3001
    case NSURLErrorCannotCloseFile = -3002
    case NSURLErrorCannotWriteToFile = -3003
    case NSURLErrorCannotRemoveFile = -3004
    case NSURLErrorCannotMoveFile = -3005
    case NSURLErrorDownloadDecodingFailedMidStream = -3006
    case NSURLErrorDownloadDecodingFailedToComplete = -3007
    case NSURLErrorInternationalRoamingOff = -1018
    case NSURLErrorCallIsActive = -1019
    case NSURLErrorDataNotAllowed  = -1020
    case NSURLErrorRequestBodyStreamExhausted = -1021
    case NSURLErrorBackgroundSessionRequiresSharedContainer = -995
    case NSURLErrorBackgroundSessionInUseByAnotherProcess = -996
    case NSURLErrorBackgroundSessionWasDisconnected = -997
    
    ///Server statusCode
    case unauthorise = 401
    case notFound = 404
    case unprocessable = 422
    case invalidRequest = 400
    case forbidden = 403
    case methodNotFound = 405
    case requestTimedOut = 408
    case tooManyRequests = 429
    case internalServerError = 500
}

extension NSURLErrors {
    
    var showableError: APIManagerError {
        switch self {
        case .NSURLErrorCallIsActive,
                .NSURLErrorNetworkConnectionLost,
                .NSURLErrorNotConnectedToInternet,
                .NSURLErrorDataNotAllowed:
            return .offline
        default:
            return .NextStepURLErrors(nxtSterpError: self)
        }
    }
    
    var showableDescription: String {
        if isDeveloperMode {
            return self.errorDescription
        } else {
            switch self {
            case .NSURLErrorCallIsActive,
                    .NSURLErrorNetworkConnectionLost,
                    .NSURLErrorNotConnectedToInternet,
                    .NSURLErrorDataNotAllowed:
                return self.errorDescription
            default:
                return somethingWentWrong
            }
        }
    }
    
    var showableErrorDescription: String {
        switch self {
        case .NSURLErrorCallIsActive:
            return ErrorMessages.onCall.text
        case .NSURLErrorNetworkConnectionLost:
            return ErrorMessages.requestTimedOut.text
        case .NSURLErrorNotConnectedToInternet,.NSURLErrorDataNotAllowed:
            return ErrorMessages.offline.text
        default:
            return ErrorMessages.somethingWentWrong.text
        }
    }
    
    var serverErrorDescription: String {
        switch self {
        case .unprocessable:
            return "Unprocesable Entity."
        case .notFound:
            return isDeveloperMode ? "Resource Not Found, Cant decode the JS Items" : "Resource Not Found"
        case .unauthorise:
            return "You are unauthorised for this call, permission denied"
        case .invalidRequest:
            return isDeveloperMode ? "The URL request is invalid" : somethingWentWrong
        case .forbidden:
            return isDeveloperMode ? "This region is forbidden or ypo may need some authorisation." : somethingWentWrong
        case .methodNotFound:
            return isDeveloperMode ? "The Http Method requested was not found, try other." : somethingWentWrong
        case .requestTimedOut:
            return isDeveloperMode ? "An asynchronous operation timed out." : somethingWentWrong
        case .tooManyRequests:
            return isDeveloperMode ?  "Too many requests were made to server." : somethingWentWrong
        case .internalServerError:
            return isDeveloperMode ? "Internal Server Error,This was not suppossed to Happen" : somethingWentWrong
        default:
            return "Server Error"
        }
    }
    
    var errorDescription: String {
        switch self {
        case .NSURLErrorUnknown:
            return "The URL Loading System encountered an error that it can’t interpret."
        case .NSURLErrorCancelled:
            return "An asynchronous load has been canceled."
        case .NSURLErrorBadURL:
            return "A malformed URL prevented a URL request from being initiated."
        case .NSURLErrorTimedOut:
            return "An asynchronous operation timed out."
        case .NSURLErrorUnsupportedURL:
            return "A properly formed URL couldn’t be handled by the framework."
        case .NSURLErrorCannotFindHost:
            return "The host name for a URL couldn’t be resolved."
        case .NSURLErrorCannotConnectToHost:
            return "An attempt to connect to a host failed."
        case .NSURLErrorNetworkConnectionLost:
            return "A client or server connection was severed in the middle of an in-progress load."
        case .NSURLErrorDNSLookupFailed:
            return "The host address couldn’t be found via DNS lookup."
        case .NSURLErrorHTTPTooManyRedirects:
            return "A redirect loop was detected or the threshold for number of allowable redirects was exceeded (currently 16)."
        case .NSURLErrorResourceUnavailable:
            return "A requested resource couldn’t be retrieved."
        case .NSURLErrorNotConnectedToInternet:
            return "A network resource was requested but an internet connection has not been established and can’t be established automatically."
        case .NSURLErrorRedirectToNonExistentLocation:
            return "A redirect was specified by way of server response code but the server didn’t accompany this code with a redirect URL."
        case .NSURLErrorBadServerResponse:
            return "The URL Loading System received bad data from the server."
        case .NSURLErrorUserCancelledAuthentication:
            return "An asynchronous request for authentication has been canceled by the user."
        case .NSURLErrorUserAuthenticationRequired:
            return "Authentication was required to access a resource."
        case .NSURLErrorZeroByteResource:
            return "A server reported that a URL has a non-zero content length but terminated the network connection gracefully without sending any data."
        case .NSURLErrorCannotDecodeRawData:
            return "Content data received during a connection request couldn’t be decoded for a known content encoding."
        case .NSURLErrorCannotDecodeContentData:
            return "Content data received during a connection request had an unknown content encoding."
        case .NSURLErrorCannotParseResponse:
            return "A response to a connection request couldn’t be parsed."
        case .NSURLErrorAppTransportSecurityRequiresSecureConnection:
            return "App Transport Security disallowed a connection because there is no secure network connection."
        case .NSURLErrorFileDoesNotExist:
            return "The specified file doesn’t exist."
        case .NSURLErrorFileIsDirectory:
            return "A request for an FTP file resulted in the server responding that the file is not a plain file but a directory."
        case .NSURLErrorNoPermissionsToReadFile:
            return "A resource couldn’t be read because of insufficient permissions."
        case .NSURLErrorDataLengthExceedsMaximum:
            return "The length of the resource data exceeded the maximum allowed."
        case .NSURLErrorSecureConnectionFailed:
            return "An attempt to establish a secure connection failed for reasons that can’t be expressed more specifically."
        case .NSURLErrorServerCertificateHasBadDate:
            return "A server certificate is expired or is not yet valid."
        case .NSURLErrorServerCertificateUntrusted:
            return "A server certificate was signed by a root server that isn’t trusted."
        case .NSURLErrorServerCertificateHasUnknownRoot:
            return "A server certificate wasn’t signed by any root server."
        case .NSURLErrorServerCertificateNotYetValid:
            return "A server certificate isn’t valid yet."
        case .NSURLErrorClientCertificateRejected:
            return "A server certificate was rejected."
        case .NSURLErrorClientCertificateRequired:
            return "A client certificate was required to authenticate an SSL connection during a connection request."
        case .NSURLErrorCannotLoadFromNetwork:
            return "A specific request to load an item only from the cache couldn't be satisfied."
        case .NSURLErrorCannotCreateFile:
            return "A download task couldn’t create the downloaded file on disk because of an I/O failure."
        case .NSURLErrorCannotOpenFile:
            return "A downloaded file on disk couldn’t be opened."
        case .NSURLErrorCannotCloseFile:
            return "A download task couldn’t close the downloaded file on disk."
        case .NSURLErrorCannotWriteToFile:
            return "A download task couldn’t write the file to disk."
        case .NSURLErrorCannotRemoveFile:
            return "A downloaded file couldn’t be removed from disk."
        case .NSURLErrorCannotMoveFile:
            return "A downloaded file on disk couldn’t be moved."
        case .NSURLErrorDownloadDecodingFailedMidStream:
            return "A download task failed to decode an encoded file during the download."
        case .NSURLErrorDownloadDecodingFailedToComplete:
            return "A download task failed to decode an encoded file after downloading."
        case .NSURLErrorInternationalRoamingOff:
            return "The attempted connection required activating a data context while roaming but international roaming is disabled."
        case .NSURLErrorCallIsActive:
            return "A connection was attempted while a phone call was active on a network that doesn’t support simultaneous phone and data communication such as EDGE or GPRS."
        case .NSURLErrorDataNotAllowed:
            return "The cellular network disallowed a connection."
        case .NSURLErrorRequestBodyStreamExhausted:
            return "A body stream was needed but the client did not provide one."
        case .NSURLErrorBackgroundSessionRequiresSharedContainer:
            return "The shared container identifier of the URL session configuration is needed but hasn’t been set."
        case .NSURLErrorBackgroundSessionInUseByAnotherProcess:
            return "An app or app extension attempted to connect to a background session that is already connected to a process."
        case .NSURLErrorBackgroundSessionWasDisconnected:
            return "The app is suspended or exits while a background data task is processing."
        case .NSURLErrorFileOutsideSafeArea:
            return "An internal file operation failed."
        case .unauthorise,.notFound,.unprocessable:
            return "\(self.serverErrorDescription) ErrorCode: \(self.rawValue)"
        case .invalidRequest:
            return "The URL request is invalid"
        case .forbidden:
            return "This region is forbidden or ypo may need some authorisation."
        case .methodNotFound:
            return "The Http Method requested was not found, try other."
        case .requestTimedOut:
            return "An asynchronous operation timed out."
        case .tooManyRequests:
            return "Too many requests were made to server."
        case .internalServerError:
            return "Internal Server Error,This was not suppossed to Happen"
        }
    }
    
    var toURLErrors: APIManagerError {
        return .URLErrors(statusCode: self.rawValue)
    }
}



