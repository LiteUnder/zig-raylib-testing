const std = @import("std");
usingnamespace @import("raylib");
const entity = @import("entity.zig");

const warn = std.debug.warn;

pub fn main() !void {

    const screen_width = 1280;
    const screen_height = 720;

    InitWindow(screen_width, screen_height, "Window");
    defer CloseWindow();
    
    var ziggy_boi = entity.Entity.init("res/zigfast.png", entity.Origin.Center);
    defer ziggy_boi.deinit();

    ziggy_boi.setScale(0.5, 0.5);
    ziggy_boi.scale_rect.x = screen_width/2.0;
    ziggy_boi.scale_rect.y = screen_height/2.0;

    var robot_boi = entity.Entity.init("res/robot.png", entity.Origin.Center);
    defer robot_boi.deinit();

    robot_boi.setScale(2.5, 2.5);
    robot_boi.scale_rect.x = screen_width/2.0 + 100.0;
    robot_boi.scale_rect.y = screen_height/2.0;

    var rotation: f32 = 0.0;

    // tick rate is 60 times per second
    // frame time 16.66666 ms or 0.016667 seconds
    var delta_time: f32 = 0.0;
    const target_frame_time = 0.016667;

    const speed = 20.0;

    // TODO: VSync probably
    SetTargetFPS(240); // fastest monitor refresh rate

    while (!WindowShouldClose()) {

        delta_time = GetFrameTime()/target_frame_time;

        // movement
        if (IsKeyDown(KeyboardKey.KEY_D)) ziggy_boi.scale_rect.x += speed*delta_time;
        if (IsKeyDown(KeyboardKey.KEY_A)) ziggy_boi.scale_rect.x -= speed*delta_time;
        if (IsKeyDown(KeyboardKey.KEY_W)) ziggy_boi.scale_rect.y -= speed*delta_time;
        if (IsKeyDown(KeyboardKey.KEY_S)) ziggy_boi.scale_rect.y += speed*delta_time;

        // rotation
        if (IsKeyDown(KeyboardKey.KEY_Q)) ziggy_boi.rotation -= 2.5*delta_time;
        if (IsKeyDown(KeyboardKey.KEY_E)) ziggy_boi.rotation += 2.5*delta_time;

        // thicc
        if (IsKeyDown(KeyboardKey.KEY_T)) ziggy_boi.stretchScale(0.01*delta_time, 0.0);

        // if (dest_rec.x > screen_width) dest_rec.x = 0;
        // if (dest_rec.x < 0) dest_rec.x = screen_width;
        // if (dest_rec.y > screen_height) dest_rec.y = 0;
        // if (dest_rec.y < 0) dest_rec.y = screen_height;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            robot_boi.draw(WHITE);
            ziggy_boi.draw(WHITE);
            
            DrawFPS(10, 10);
            DrawText("use wasd to move", 10, 30, 20, DARKGRAY);
            DrawText("use q/e to rotate", 10, 50, 20, DARKGRAY);
            DrawText("hold t to thicc", 10, 70, 20, DARKGRAY);

        EndDrawing();
    }
}
