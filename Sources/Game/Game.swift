import CSDL2

public func gameMain() -> Int32 {
    print("Hello SDL!")
    
    guard 0 == SDL_Init(UInt32(SDL_INIT_VIDEO)) else {
        fatalError()
    }

    return 0
}

@_cdecl("SDL_main")
public func SDL_main(argc: Int32, argv: OpaquePointer) -> Int32 {
    return gameMain()
}

