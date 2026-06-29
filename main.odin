package main

import rl "vendor:raylib"
import la "core:math/linalg"

SCREEN_W  :: 800
SCREEN_H  :: 600
TARGET_FPS :: 12
PLAYER_SPEED :: f32(200)

main :: proc() {
	rl.InitWindow(SCREEN_W, SCREEN_H, "Cool cats game")
	defer rl.CloseWindow()

	rl.SetTargetFPS(TARGET_FPS)

	player := rl.LoadTexture("player.png")
	player_pos: [2]f32

	for !rl.WindowShouldClose() {
		input: [2]f32

		if rl.IsKeyDown(.UP) {
			input.y -= 1
		}
		if rl.IsKeyDown(.DOWN) {
			input.y += 1
		}
		if rl.IsKeyDown(.LEFT) {
			input.x -= 1
		}
		if rl.IsKeyDown(.RIGHT) {
			input.x += 1
		}

		player_pos += la.normalize0(input) * PLAYER_SPEED * rl.GetFrameTime()
		// NEW BLOCK END

		rl.BeginDrawing()
		rl.ClearBackground({160, 200, 255, 255})
		// MODIFIED LINE (use player_pos):
		rl.DrawTextureV(player, player_pos, rl.WHITE)
		rl.EndDrawing()
	}


}
