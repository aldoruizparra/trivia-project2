//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Aldo Ruiz Parra on 7/5/25.
//

import Foundation

class TriviaQuestionService {
  func fetchTriviaQuestions(completion: @escaping ([TriviaQuestion]) -> Void) {
    guard let url = URL(string: "https://opentdb.com/api.php?amount=5") else {
        print("Failed to capture URL")
      completion([])
      return
    }
      
    // begins the URL session with url
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let data = data,
        error == nil,
        let triviaAPIResponse = try? JSONDecoder().decode(TriviaAPIResponse.self, from: data)
      else {
        print("Failed to decode or fetch: \(error?.localizedDescription ?? "Unknown error")")
        completion([])
        return
      }

    let questions: [TriviaQuestion] = triviaAPIResponse.results.map {
        TriviaQuestion(
          category: $0.category,
          question: $0.question.htmlDecoded,
          correctAnswer: $0.correct_answer.htmlDecoded,
          incorrectAnswers: $0.incorrect_answers.map { $0.htmlDecoded }
          )
        
        }
      completion(questions)
    }.resume()
  }
}

// Internal structs to match OpenTriviaDB's API structure
struct TriviaAPIResponse: Decodable {
  let results: [TriviaQuestionDTO]
}

struct TriviaQuestionDTO: Decodable {
  let category: String
  let question: String
  let correct_answer: String
  let incorrect_answers: [String]
}
