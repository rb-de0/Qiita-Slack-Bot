import PackageDescription

let package = Package(
    name: "Qiita-Slack-Bot",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 4)
    ]
)
