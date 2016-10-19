import CSDL2

public func gameMain() -> Int32 {
    print("Hello SDL!")
    return 0
}

@_cdecl("SDL_main")
public func SDL_main(argc: Int32, argv: OpaquePointer) -> Int32 {
    return gameMain()
}

