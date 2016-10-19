import PackageDescription

let package = Package(
    name: "Game",
    targets: [
        Target(
            name: "CSDL2",
            dependencies: []),
        Target(
            name: "Game",
            dependencies: ["CSDL2"]),
        Target(
            name: "Main",
            dependencies: ["Game"]),
    ]
)
