#include <iostream>

#include "module/utils.h"

#if defined(PLATFORM_WEB)
#include <emscripten/emscripten.h>
#endif

//const int screenWidth = 800;
//const int screenHeight = 450;

int main(void)
{
    std::cout << "Hello\n";
    std::cout << my_function(true) << "\n";
    std::cout << my_function(false) << "\n";
    return 0;
}