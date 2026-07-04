package main

import rl "vendor:raylib"
import la "core:math/linalg"

SCREEN_W     :: 800
SCREEN_H     :: 600
TARGET_FPS   :: 60
PLAYER_SPEED :: f32(200)
JUMP_SPEED   :: f32(600)
GRAVITY      :: f32(2000)

main :: proc() {
	rl.InitWindow(SCREEN_W, SCREEN_H, "Cool cats game")
	defer rl.CloseWindow()

	rl.SetTargetFPS(TARGET_FPS)

	platforms := []rl.Rectangle{
		{50,  530, 200, 16},
		{280, 460, 180, 16},
		{100, 380, 160, 16},
		{420, 380, 200, 16},
		{580, 300, 180, 16},
		{300, 250, 160, 16},
	}

	player := rl.LoadTexture("player.png")
	player_pos: [2]f32 = {SCREEN_W / 2, SCREEN_H}
	player_vel: [2]f32
	player_grounded: bool

	for !rl.WindowShouldClose() {
		input: [2]f32

		if rl.IsKeyDown(.LEFT) {
			input.x -= 1
		}
		if rl.IsKeyDown(.RIGHT) {
			input.x += 1
		}

		if player_grounded && rl.IsKeyPressed(.SPACE) {
			player_vel.y = -JUMP_SPEED
		}

		player_vel.y += GRAVITY * rl.GetFrameTime()

		old_pos := player_pos
		player_pos += (la.normalize0(input) * PLAYER_SPEED + player_vel) * rl.GetFrameTime()

		ground_y := get_ground_y(old_pos, player, platforms)
		if player_pos.y > ground_y {
			player_pos.y = ground_y
			player_vel.y = 0
			player_grounded = true
		} else {
			player_grounded = false
		}

		rl.BeginDrawing()
		rl.ClearBackground({160, 200, 255, 255})

		for rec in platforms {
			rl.DrawRectangleRec(rec, rl.BLACK)
		}

		rl.DrawTextureV(player, player_pos, rl.WHITE)
		rl.EndDrawing()
	}
}

get_ground_y :: proc(player_pos: [2]f32, player: rl.Texture2D, platforms: []rl.Rectangle) -> f32 {
	player_feet := player_pos.y + f32(player.height)
	ground_y := f32(rl.GetScreenHeight() - player.height)
	for rec in platforms {
		if (rec.y - f32(player.height)) < ground_y &&
			player_feet <= rec.y &&
			player_pos.x < rec.x + rec.width &&
			player_pos.x + f32(player.width) > rec.x {
			ground_y = rec.y - f32(player.height)
		}
	}
	return ground_y
}
