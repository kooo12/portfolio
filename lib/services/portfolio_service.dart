import '../models/personal_info.dart';
import '../models/project.dart';
import '../models/skill.dart';
import '../models/experience.dart';

class PortfolioService {
  static PersonalInfo getPersonalInfo() {
    return PersonalInfo(
      name: "Aung Ko Oo",
      title: "Flutter Developer",
      bio:
          "Passionate Flutter developer with 3+ years of experience creating beautiful, responsive mobile and web applications. I love turning complex problems into simple, elegant solutions.",
      email: "agkooo.ako36@gmail.com",
      phone: "+95 9 969 687 330",
      location: "Mandalay , Myanmar",
      imageUrl: "assets/profile.jpeg",
      resumeUrl: "https://example.com/resume.pdf",
      socialLinks: {
        "github": "https://github.com/kooo12",
        "linkedin": "https://linkedin.com/in/johndoe",
        "twitter": "https://twitter.com/johndoe",
        "instagram": "https://instagram.com/johndoe",
      },
    );
  }

  static List<Project> getProjects() {
    return [
      Project(
        id: "1",
        title: "E-Commerce Mobile App",
        description:
            "A full-featured e-commerce application with real-time chat, payment integration, and admin panel. Built with Flutter and Firebase.",
        imageUrl:
            "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=600&h=400&fit=crop",
        technologies: ["Flutter", "Firebase", "Dart", "Provider", "Stripe"],
        githubUrl: "https://github.com/johndoe/ecommerce-app",
        liveUrl: "https://ecommerce-app.web.app",
        category: "Mobile",
      ),
      Project(
        id: "2",
        title: "Task Management Web App",
        description:
            "A collaborative task management platform with real-time updates, team collaboration features, and advanced analytics dashboard.",
        imageUrl:
            "https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=600&h=400&fit=crop",
        technologies: [
          "Flutter Web",
          "GetX",
          "Node.js",
          "MongoDB",
          "Socket.io"
        ],
        githubUrl: "https://github.com/johndoe/task-manager",
        liveUrl: "https://taskmanager.web.app",
        category: "Web",
      ),
      Project(
        id: "3",
        title: "Weather Forecast App",
        description:
            "Beautiful weather app with location-based forecasts, detailed weather maps, and customizable widgets. Features smooth animations and offline support.",
        imageUrl:
            "https://images.unsplash.com/photo-1504608524841-42fe6f032b4b?w=600&h=400&fit=crop",
        technologies: [
          "Flutter",
          "OpenWeather API",
          "BLoC",
          "SQLite",
          "Animations"
        ],
        githubUrl: "https://github.com/johndoe/weather-app",
        liveUrl: null,
        category: "Mobile",
      ),
      Project(
        id: "4",
        title: "Portfolio Website",
        description:
            "Modern, responsive portfolio website built with Flutter Web. Features smooth animations, dark/light theme, and contact form integration.",
        imageUrl:
            "https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=600&h=400&fit=crop",
        technologies: [
          "Flutter Web",
          "GetX",
          "Responsive Design",
          "Animations",
          "Contact Forms"
        ],
        githubUrl: "https://github.com/johndoe/portfolio",
        liveUrl: "https://johndoe.dev",
        category: "Web",
      ),
    ];
  }

  static List<Skill> getSkills() {
    return [
      // Programming Languages
      Skill(
          id: "1",
          name: "Dart",
          category: "Languages",
          proficiency: 95,
          iconUrl:
              "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/dart/dart-original.svg"),

      // Frameworks
      Skill(
          id: "2",
          name: "Flutter",
          category: "Frameworks",
          proficiency: 95,
          iconUrl:
              "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg"),

      // Tools & Technologies
      Skill(
          id: "3",
          name: "Firebase",
          category: "Backend Integration",
          proficiency: 90,
          iconUrl:
              "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/firebase/firebase-plain.svg"),
      Skill(
          id: "4",
          name: "REST API",
          category: "Backend Integration",
          proficiency: 90,
          iconUrl:
              "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/rest/rest-original.svg"),
      Skill(
          id: "5",
          name: "Git",
          category: "Version Control",
          proficiency: 90,
          iconUrl:
              "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg"),
      Skill(
          id: "6",
          name: "AWS",
          category: "Cloud & Database",
          proficiency: 25,
          iconUrl:
              "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/amazonwebservices/amazonwebservices-original.svg"),
      Skill(
          id: "7",
          name: "MongoDB",
          category: "Cloud & Database",
          proficiency: 25,
          iconUrl:
              "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mongodb/mongodb-original.svg"),
    ];
  }

  static List<Experience> getExperiences() {
    return [
      Experience(
        id: "1",
        company: "Tech Plus Solutions Inc.",
        position: "Senior Flutter Developer",
        duration: "2022 - Present",
        description:
            "Leading mobile app development team and architecting scalable Flutter applications for enterprise clients.",
        achievements: [
          "Led development of 5+ mobile applications serving 100K+ users",
          "Improved app performance by 40% through code optimization",
          "Mentored 3 junior developers and established best practices",
          "Implemented CI/CD pipeline reducing deployment time by 60%",
        ],
        logoUrl:
            "https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=100&h=100&fit=crop",
      ),
      Experience(
        id: "2",
        company: "Digital Agency Pro",
        position: "Flutter Developer",
        duration: "2021 - 2022",
        description:
            "Developed cross-platform mobile applications and contributed to web projects using Flutter Web.",
        achievements: [
          "Built 8+ mobile applications from concept to deployment",
          "Collaborated with UI/UX designers to implement pixel-perfect designs",
          "Integrated third-party APIs and payment gateways",
          "Reduced app size by 25% through optimization techniques",
        ],
        logoUrl:
            "https://images.unsplash.com/photo-1553877522-43269d4ea984?w=100&h=100&fit=crop",
      ),
      Experience(
        id: "3",
        company: "StartupXYZ",
        position: "Junior Flutter Developer",
        duration: "2020 - 2021",
        description:
            "Started career as Flutter developer, working on various mobile projects and learning best practices.",
        achievements: [
          "Developed first commercial mobile application",
          "Learned state management patterns (Provider, BLoC, GetX)",
          "Contributed to open-source Flutter packages",
          "Completed Flutter certification and advanced courses",
        ],
        logoUrl:
            "https://images.unsplash.com/photo-1559136555-9303baea8ebd?w=100&h=100&fit=crop",
      ),
    ];
  }
}
