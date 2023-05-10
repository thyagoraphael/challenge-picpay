import Foundation

/*
 Json Contract
[
  {
    "id": 1,
    "name": "Shakira",
    "photoURL": "https://api.adorable.io/avatars/285/a1.png"
  }
]
*/

class ListContactService {
    func fetchContacts(completion: @escaping (Result<[ContactModel], NetworkError>) -> Void) {
        let apiURL = "https://run.mocky.io/v3/d26d86ec-fb82-48a7-9c73-69e2cb728070"
        
        guard let api = URL(string: apiURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: api) { (data, response, error) in
            if let error = error {
                completion(.failure(NetworkError.requestFailed(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let jsonData = data else {
                completion(.failure(NetworkError.requestFailedWithData(errorData: Data())))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([ContactModel].self, from: jsonData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.decodeError))
            }
        }
        
        task.resume()
    }
}
