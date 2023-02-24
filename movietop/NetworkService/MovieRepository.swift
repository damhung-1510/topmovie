//
//  MovieRepository.swift
//  movietop
//
//  Created by Dam Hung on 21/02/2023.
//

import Foundation


let authorizationKey = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2M2Y0MzgwY2ZiZTM2ZjAwZDRjNjdjYWIiLCJuYmYiOjE2NzY5NjI0NjksImF1ZCI6IjYwNDQ5MTEyMzA2MWYyZjljNDAwZDI0NDdlYmE4Y2ViIiwianRpIjoiNTYxOTExMyIsInNjb3BlcyI6WyJhcGlfcmVhZCIsImFwaV93cml0ZSJdLCJ2ZXJzaW9uIjoxfQ.yKiex0v2O_uI4u2pCq0z6P4ZcPm86rUoNL3UN6Owy5k"

// MARK: Recommend Movies
func getMovieRecommend(completionHandler:@escaping ([MovieRecommend]) -> Void){
    
    let url = URL(string: "\(baseUrl)/4/account/\(accountId)/movie/favorites?page=1")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue(authorizationKey, forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    
    
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
        if (error != nil) {
            print(error!)
        } else {
            let httpResponse = response
            print(httpResponse ?? "")
            
            do {
                let model = try JSONDecoder().decode(ArrayResponse<MovieRecommend>.self, from: data!)
                print("Đây là Recommend \(model.results?[0].name ?? "huhu")")
                completionHandler(model.results ?? [])
            } catch {
                print("Error")
            }
        }
    })
    
    task.resume()
}

// MARK: Upcoming Movies
func getUpcomingMovies(completionHandler:@escaping ([MovieRecommend]) -> Void){
    
    let url = URL(string: "\(baseUrl)/4/account/\(accountId)/movie/watchlist?page=1")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue(authorizationKey, forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    
    
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
        if (error != nil) {
            print(error!)
        } else {
            let httpResponse = response
            print(httpResponse ?? "")
            
            do {
                let model = try JSONDecoder().decode(ArrayResponse<MovieRecommend>.self, from: data!)
                print("Đây là Upcoming \(model.results?[0].name ?? "huhu")")
                
                completionHandler(model.results ?? [])
            } catch {
                print("Error Get Upcoming Movies")
            }
        }
    })
    
    task.resume()
}

    // MARK: Movie Detail
func getMovieDetail (movieId: Int ,completionHandler:@escaping (MovieDetail) -> Void){
    
    let url = URL(string: "\(baseUrl)/3/movie/\(movieId)?api_key=\(apiKey)&language=en-US")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue(authorizationKey, forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    
    
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
        if (error != nil) {
            print(error!)
        } else {
            let httpResponse = response
            print(httpResponse ?? "")
            
            do {
                let model = try JSONDecoder().decode(MovieDetail.self, from: data!)
                completionHandler(model)
            } catch let error {
                print("Error Get Movie Detail \(error)")
            }
        }
    })
    
    task.resume()
}


// MARK: Movie credits
func getMovieCredits (movieId: Int ,completionHandler:@escaping (MovieCredit) -> Void){
    
    let url = URL(string: "\(baseUrl)/3/movie/\(movieId)/credits?api_key=\(apiKey)&language=en-US")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue(authorizationKey, forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    
    
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
        if (error != nil) {
            print(error!)
        } else {
            let httpResponse = response
            print(httpResponse ?? "")
            
            do {
                let model = try JSONDecoder().decode(MovieCredit.self, from: data!)
                completionHandler(model)
            } catch {
                print("Error Get Movie Credits ")
            }
        }
    })
    
    task.resume()
}

