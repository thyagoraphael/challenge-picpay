//
//  NetworkError.swift
//  Interview
//
//  Created by Thyago Raphael on 10/05/23.
//  Copyright © 2023 PicPay. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(error: Error)
    case requestFailedWithData(errorData: Data)
    case decodeError
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "A URL é inválida"
        case .invalidResponse:
            return "A resposta da requisição é inválida"
        case .requestFailed(let error):
            return "A requisição falhou: \(error.localizedDescription)"
        case .requestFailedWithData(let errorData):
            let dataString = String(data: errorData, encoding: .utf8) ?? "Nenhum dado encontrado"
            return "A requisição falhou com os seguintes dados: \(dataString)"
        case .decodeError:
            return "Erro ao decodificar os dados recebidos"
        }
    }
}

