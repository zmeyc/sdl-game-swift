import CSDL2

// Game coordinates
let gameWidth: Int32 = 768
let gameHeight: Int32 = 1024

// Actual window size
let windowWidth: Int32 = 768 / 2
let windowHeight: Int32 = 1024 / 2

public func gameMain() -> Int32 {
    print("Hello SDL!")
    
    guard 0 == SDL_Init(UInt32(SDL_INIT_VIDEO)) else {
        print("Unable to initialize SDL: \(CSDL_GetError())")
        return 1
    }
    defer { SDL_Quit() }

    var windowRect = SDL_Rect(x: 0, y: 0, w: windowWidth, h: windowHeight)
    var displayMode = SDL_DisplayMode()
    if 0 == SDL_GetCurrentDisplayMode(0, &displayMode) {
        print("SDL_GetCurrentDisplayMode: \(displayMode.w)x\(displayMode.h), \(displayMode.refresh_rate) hz")
        windowRect.w = displayMode.w
        windowRect.h = displayMode.h
    }

    guard let window = SDL_CreateWindow("Game",
        CSDL_WINDOWPOS_UNDEFINED, CSDL_WINDOWPOS_UNDEFINED,
        windowRect.w, windowRect.h,
        SDL_WINDOW_SHOWN.rawValue)
    else {
        print("Window could not be created! SDL_Error: \(CSDL_GetError())")
        return 1
    }
    defer { SDL_DestroyWindow(window) }

    guard let renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED.rawValue) else {
        print("Renderer could not be created! SDL Error: \(CSDL_GetError())")
        return 1
    }
    SDL_RenderSetLogicalSize(renderer, gameWidth, gameHeight)
    
    guard -1 != SDL_SetRenderDrawColor(renderer, 0xff, 0x00, 0x0, UInt8(SDL_ALPHA_OPAQUE)) else {
        print("SDL_SetRenderDrawColor error! SDL Error: \(CSDL_GetError())")
        return 1
    }

    var done = false
    var event = SDL_Event()
    while !done {
        while 0 != SDL_PollEvent(&event) {
            switch SDL_EventType(event.type) {
            case SDL_QUIT:
                done = true
            default:
                break
            }
        }
        
        SDL_RenderClear(renderer)

        SDL_RenderPresent(renderer)
    }
            
    return 0
}

@_cdecl("SDL_main")
public func SDL_main(argc: Int32, argv: OpaquePointer) -> Int32 {
    return gameMain()
}
