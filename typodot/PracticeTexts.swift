//
//  PracticeTexts.swift
//  typodot
//

import Foundation

/// Sample texts for typing practice (embedded as code, no external file needed)
/// Each text is approximately 300 characters
enum PracticeTexts {
    static let texts: [String] = [
        "The quick brown fox jumps over the lazy dog. This pangram contains every letter of the alphabet at least once. Typing practice helps improve your speed and accuracy. With consistent practice, you can become a faster and more efficient typist. Keep your fingers on the home row and maintain good posture.",

        "Programming is the art of telling a computer what to do. Software developers write code in various languages like Swift, Python, and JavaScript. Each language has its own syntax and rules. Learning to type quickly helps programmers be more productive. Practice makes perfect when it comes to coding skills.",

        "The internet has revolutionized how we communicate and share information. Email, social media, and instant messaging connect people across the globe. Web browsers let us access millions of websites with just a few clicks. Search engines help us find exactly what we need. Technology continues to evolve rapidly.",

        "Music is a universal language that transcends cultural boundaries. From classical symphonies to modern pop songs, melodies have the power to evoke emotions. Musicians spend years perfecting their craft. Whether playing piano, guitar, or drums, practice and dedication are essential for mastery of any instrument.",

        "Nature offers endless wonders for those who take time to observe. Mountains rise majestically against the sky while rivers carve through valleys below. Forests provide homes for countless species of plants and animals. Protecting our environment ensures future generations can enjoy these natural treasures as we do today.",
    ]

    static func random() -> String {
        texts.randomElement() ?? texts[0]
    }
}
