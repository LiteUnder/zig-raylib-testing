usingnamespace @import("raylib");

pub const Origin = enum {
    TopLeft,
    Center,
};

pub const Entity = struct {
    sprite: Texture2D,
    sprite_rect: Rectangle,
    origin_type: Origin,
    origin: Vector2,
    scale_rect: Rectangle,
    scale: Vector2,
    rotation: f32,
    f_width: f32,
    f_height: f32,

    pub fn init(sprite_path: [*c]const u8, origin: Origin) Entity {
        var e = Entity {
            .sprite = LoadTexture(sprite_path),
            .sprite_rect = Rectangle {
                .x = 0.0,
                .y = 0.0,
                .width = undefined,
                .height = undefined,
            },
            .origin_type = origin,
            .origin = undefined,
            .scale_rect = Rectangle {
                .x = 0.0,
                .y = 0.0,
                .width = undefined,
                .height = undefined,
            },
            .scale = Vector2 {
                .x = 1.0,
                .y = 1.0,
            },
            .rotation = 0.0,
            .f_width = undefined,
            .f_height = undefined,
        };

        e.f_width = @intToFloat(f32, e.sprite.width);
        e.f_height = @intToFloat(f32, e.sprite.height);

        e.sprite_rect.width = e.f_width;
        e.sprite_rect.height = e.f_height;
        
        switch (origin) {
            Origin.TopLeft => {
                e.origin = Vector2 {
                    .x = 0.0,
                    .y = 0.0,
                };
            },
            Origin.Center => {
                e.origin = Vector2 {
                    .x = e.f_width/2.0,
                    .y = e.f_width/2.0,
                };
            }
        }

        e.scale_rect.width = e.f_width;
        e.scale_rect.height = e.f_height;

        return e;
    }

    pub fn setScale(self: *Entity, x: f32, y: f32) void {
        self.scale.x = x;
        self.scale.y = y;

        self.scale_rect.width = self.f_width * self.scale.x;
        self.scale_rect.height = self.f_height * self.scale.y;

        if (self.origin_type == Origin.Center) {
            self.origin = Vector2 {
                .x = (self.f_width*self.scale.x)/2.0,
                .y = (self.f_width*self.scale.x)/2.0,
            };
        }
    }

    pub fn stretchScale(self: *Entity, x: f32, y: f32) void {
        self.scale.x += x;
        self.scale.y += y;

        self.scale_rect.width = self.f_width * self.scale.x;
        self.scale_rect.height = self.f_height * self.scale.y;

        if (self.origin_type == Origin.Center) {
            self.origin = Vector2 {
                .x = (self.f_width*self.scale.x)/2.0,
                .y = (self.f_width*self.scale.y)/2.0,
            };
        }
    }

    pub fn draw(self: *Entity, tint: Color) void {
        DrawTexturePro(
            self.*.sprite,
            self.*.sprite_rect,
            self.*.scale_rect,
            self.*.origin,
            self.*.rotation,
            tint,
        );
    }
};