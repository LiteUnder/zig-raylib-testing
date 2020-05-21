pub const Point = struct {
    x: f64,
    y: f64,

    pub fn create(x: f32, y: f32) Point {
        return Point {
            .x = x,
            .y = y,
        };
    }
};
