const std = @import("std");
usingnamespace @import("raylib");

const warn = std.debug.warn;

pub fn main() anyerror!void {

    const screen_width = 1280;
    const screen_height = 720;

    InitWindow(screen_width, screen_height, "Window");

    const sprite = LoadTexture("res/zigfast.png");
    defer UnloadTexture(sprite);

    const f_width = @intToFloat(f32, sprite.width);
    const f_height = @intToFloat(f32, sprite.height);

    const src_rec = Rectangle {
        .x = 0.0, .y = 0.0,
        .width = @intToFloat(f32, sprite.width),
        .height = @intToFloat(f32, sprite.height),
    };

    var x_scale: f32 = 0.5;
    var y_scale: f32 = 0.5;

    const speed = 50.0;

    var dest_rec = Rectangle {
        .x = screen_width/2.0,
        .y = screen_height/2.0,
        .width = f_width * x_scale,
        .height = f_height * y_scale,
    };

    var origin = Vector2 {
        .x = (f_width*x_scale)/2.0,
        .y = (f_height*y_scale)/2.0,
    };

    var rotation: f32 = 0.0;

    // tick rate is 60 times per second
    // 16.66666... ms or 0.016667 seconds
    var delta_time: f32 = 0.0;
    const target_frame_time = 0.016667;


    SetTargetFPS(240); // fastest monitor refresh rate

    while (!WindowShouldClose()) {

        delta_time = GetFrameTime()/target_frame_time;

        if (IsKeyDown(KeyboardKey.KEY_A)) dest_rec.x -= speed*delta_time;
        if (IsKeyDown(KeyboardKey.KEY_D)) dest_rec.x += speed*delta_time;
        if (IsKeyDown(KeyboardKey.KEY_W)) dest_rec.y -= speed*delta_time;
        if (IsKeyDown(KeyboardKey.KEY_S)) dest_rec.y += speed*delta_time;

        // thicc
        if (IsKeyDown(KeyboardKey.KEY_T)) {
            x_scale += 0.01*delta_time;
            dest_rec.width = f_width * x_scale;
            origin.x = (f_width*x_scale)/2.0;
        }

        if (dest_rec.x > screen_width) dest_rec.x = 0;
        if (dest_rec.x < 0) dest_rec.x = screen_width;
        if (dest_rec.y > screen_height) dest_rec.y = 0;
        if (dest_rec.y < 0) dest_rec.y = screen_height;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawTexturePro(sprite, src_rec, dest_rec, origin, rotation, WHITE);
            
            DrawFPS(10, 10);
            DrawText("Press 'T' to T H I C C E N", 10, 30, 20, DARKGRAY);

        EndDrawing();
    }

    CloseWindow();
}
