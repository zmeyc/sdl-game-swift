import Foundation
import CSDL2

func CSDL_GetError() -> String {
    return String(cString: SDL_GetError())
}
