use anyhow::Context;
use serde_json::Value;
use std::collections::HashMap;

fn main() {
    if let Err(e) = actual_main() {
        eprintln!("Error: {}", e);
        std::process::exit(1);
    }
}

type JSON = HashMap<String, Value>;

const FLOAT_SCALE: f32 = 0.8;

fn actual_main() -> anyhow::Result<()> {
    let mut window: JSON = serde_json::from_str(&yabai::send("query --windows --window")?.unwrap())?;

    let window_id = window.remove("id").unwrap().as_i64().unwrap();
    let is_floating = window.remove("is-floating").unwrap().as_bool().unwrap();

    if is_floating {
        let display: JSON =
            serde_json::from_str(&yabai::send("query --displays --display")?.unwrap())?;

        let width = display.get("frame").unwrap().get("w").unwrap().as_f64().unwrap() as f32;
        let height = display.get("frame").unwrap().get("h").unwrap().as_f64().unwrap() as f32;

        let new_width = width * FLOAT_SCALE;
        let new_height = height * FLOAT_SCALE;

        let new_x = (width - new_width) / 2.0;
        let new_y = (height - new_height) / 2.0;

        let new_width = new_width as i32;
        let new_height = new_height as i32;
        let new_x = new_x as i32;
        let new_y = new_y as i32;

        yabai::send(&format!("window --resize abs:{}:{}", new_width, new_height))?;
        yabai::send(&format!("window --move abs:{}:{}", new_x, new_y))?;
    }

    Ok(())
}
