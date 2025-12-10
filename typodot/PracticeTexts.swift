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

        "Coffee has become an essential part of daily life for millions of people around the world. From espresso to cold brew, there are countless ways to enjoy this beloved beverage. Cafes serve as gathering places where friends meet and work gets done. The aroma of freshly roasted beans can brighten any morning.",

        "Books open doors to new worlds and perspectives we might never encounter otherwise. Reading expands vocabulary and improves comprehension skills. Libraries provide free access to knowledge for everyone in the community. Whether fiction or nonfiction, every book offers something valuable to discover and learn from.",

        "Exercise keeps both body and mind healthy and strong. Regular physical activity reduces stress and improves sleep quality. Walking, swimming, cycling, and yoga are just a few options available. Finding an activity you enjoy makes it easier to maintain a consistent fitness routine throughout your life.",

        "Cooking at home allows you to control ingredients and create healthier meals. Learning basic techniques opens up endless possibilities in the kitchen. Fresh vegetables, quality proteins, and whole grains form the foundation of nutritious dishes. Sharing homemade food with family and friends brings people together.",

        "Travel broadens our understanding of different cultures and ways of life. Exploring new places creates lasting memories and meaningful experiences. Planning a trip involves research, budgeting, and careful preparation. Whether near or far, every journey offers opportunities for growth and personal discovery.",

        "Photography captures moments that would otherwise fade from memory. Digital cameras and smartphones make it easier than ever to document our lives. Understanding light, composition, and timing helps create more compelling images. A single photograph can tell a powerful story without using any words at all.",

        "Learning a new language opens doors to communication with people from different backgrounds. Grammar rules and vocabulary take time to master through consistent study. Immersion and practice accelerate the learning process significantly. Speaking multiple languages enhances career opportunities and cultural understanding.",

        "Science helps us understand the world around us through observation and experimentation. From physics to biology, each discipline reveals different aspects of reality. Curiosity drives researchers to ask questions and seek answers. Scientific discoveries have improved human life in countless ways throughout history.",

        "Art expresses human creativity in forms both visual and abstract. Painters, sculptors, and digital artists each bring unique visions to life. Museums and galleries preserve works for future generations to appreciate. Creating art can be therapeutic and fulfilling regardless of technical skill level.",

        "Sleep is essential for physical health and mental wellbeing. Adults typically need seven to nine hours of quality rest each night. Establishing a consistent bedtime routine helps improve sleep quality over time. Avoiding screens before bed and keeping the room dark promotes deeper, more restful slumber.",

        "Gardening connects us with nature and provides fresh produce for our tables. Plants require proper soil, water, and sunlight to thrive and grow. Starting small with herbs or tomatoes builds confidence for larger projects. The satisfaction of harvesting homegrown vegetables makes the effort worthwhile.",

        "Writing clearly communicates ideas and helps organize our thoughts. Whether composing emails, reports, or creative stories, good writing skills matter. Editing and revision transform rough drafts into polished final products. Reading widely exposes us to different styles and expands our own writing abilities.",

        "History teaches us about past events and helps us understand the present. Studying different eras reveals patterns in human behavior and society. Primary sources like letters and photographs bring historical figures to life. Learning from past mistakes helps us make better decisions for the future.",

        "Friendship enriches our lives with support, laughter, and shared experiences. Building strong relationships requires time, trust, and genuine care for others. Good friends celebrate our successes and comfort us during difficult times. Maintaining connections takes effort but rewards us with lifelong bonds.",

        "Innovation drives progress and solves problems in creative new ways. Entrepreneurs identify needs and develop products or services to meet them. Technology startups have transformed industries from transportation to communication. Taking calculated risks and learning from failure are essential parts of the process.",
    ]

    static func random() -> String {
        texts.randomElement() ?? texts[0]
    }
}
