#include <iostream>

#include "raylib.h"

#include "module/utils.h"

#if defined(PLATFORM_WEB)
#include <emscripten/emscripten.h>
#endif

const int screenWidth = 800;
const int screenHeight = 450;

void UpdateFrame(void)
{
    BeginDrawing();
    ClearBackground(RAYWHITE);
    DrawFPS(screenWidth/2, screenHeight/2);
    EndDrawing();
}

int main(void)
{
    std::cout << "Hello\n";
    std::cout << my_function(true) << "\n";
    std::cout << my_function(false) << "\n";

    InitWindow(screenWidth, screenHeight, "Hello World");

#if defined(PLATFORM_WEB)
    emscripten_set_main_loop(UpdateFrame, 0, 1); // FPS Handled by the browser
#else
    SetTargetFPS(60); // Busy-wait, handled on EndDrawing()
    while (!WindowShouldClose())
    {
        UpdateFrame();
    }
#endif

    CloseWindow();
    return 0;
}