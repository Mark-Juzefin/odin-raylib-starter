package main

import rl "vendor:raylib"
import la "core:math/linalg"

SCREEN_W     :: 800
SCREEN_H     :: 600
TARGET_FPS   :: 60
PLAYER_SPEED :: f32(200)
JUMP_SPEED   :: f32(600)
GRAVITY      :: f32(2000)

PLAYER_FACING_RIGHT :: f32(1)
PLAYER_FACING_LEFT  :: f32(-1)

SPRITE_SCALE :: f32(4)

VISUAL_DEBUG_MODE :: true

Player :: struct {
	pos:      [2]f32, // top-left of the collision box, world space
	vel:      [2]f32,
	size:     [2]f32, // collision box — NOT derived from the sprite
	grounded: bool,
	facing:   f32,    // +1 / -1, used only at draw time
}

player_body :: proc(p: Player) -> rl.Rectangle {
	return {p.pos.x, p.pos.y, p.size.x, p.size.y}
}

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

	player_run_texture := rl.LoadTexture("cat_run.png")
	defer rl.UnloadTexture(player_run_texture)

	player_run_num_frames := 4
	player_run_frame_w := f32(player_run_texture.width) / f32(player_run_num_frames)
	player_run_frame_h := f32(player_run_texture.height)

	player_run_frame_timer: f32
	player_run_current_frame: int
	player_run_frame_length := f32(0.1)

	player := Player {
		pos    = {SCREEN_W / 2, SCREEN_H},
		size   = {player_run_frame_w * SPRITE_SCALE, player_run_frame_h * SPRITE_SCALE},
		facing = PLAYER_FACING_RIGHT,
	}

	for !rl.WindowShouldClose() {
		dt := rl.GetFrameTime()

		// --- input ---
		input: [2]f32

		if rl.IsKeyDown(.LEFT) {
			input.x -= 1
			player.facing = PLAYER_FACING_LEFT
		}
		if rl.IsKeyDown(.RIGHT) {
			input.x += 1
			player.facing = PLAYER_FACING_RIGHT
		}

		if player.grounded && rl.IsKeyPressed(.SPACE) {
			player.vel.y = -JUMP_SPEED
		}

		// --- simulation ---
		prev_feet := player.pos.y + player.size.y

		player.vel.y += GRAVITY * dt
		player.pos += (la.normalize0(input) * PLAYER_SPEED + player.vel) * dt

		ground_y := get_ground_y(prev_feet, player_body(player), platforms)

		if player.pos.y > ground_y {
			player.pos.y = ground_y
			player.vel.y = 0
			player.grounded = true
		} else {
			player.grounded = false
		}

		// --- animation ---
		player_run_frame_timer += dt
		if player_run_frame_timer > player_run_frame_length {
			player_run_current_frame += 1
			player_run_frame_timer = 0

			if player_run_current_frame == player_run_num_frames {
				player_run_current_frame = 0
			}
		}

		// --- draw ---
		body := player_body(player)

		// A negative source width is raylib's "mirror the UVs" convention. It is a
		// rendering flag, not a size, so it must not escape this expression.
		src := rl.Rectangle {
			x      = f32(player_run_current_frame) * player_run_frame_w,
			y      = 0,
			width  = player_run_frame_w * player.facing,
			height = player_run_frame_h,
		}

		sprite_w := player_run_frame_w * SPRITE_SCALE
		sprite_h := player_run_frame_h * SPRITE_SCALE
		dst := rl.Rectangle {
			x      = body.x + body.width/2 - sprite_w/2, // sprite centered on the body
			y      = body.y + body.height - sprite_h,    // sprite standing on the body's feet
			width  = sprite_w,
			height = sprite_h,
		}

		rl.BeginDrawing()
		rl.ClearBackground({160, 200, 255, 255})

		for rec in platforms {
			rl.DrawRectangleRec(rec, rl.BLACK)
		}

		rl.DrawTexturePro(player_run_texture, src, dst, 0, 0, rl.WHITE)

		if VISUAL_DEBUG_MODE {
			rl.DrawRectangleLinesEx(body, 1, rl.GREEN)
			feet_y := i32(ground_y + body.height)
			rl.DrawLine(0, feet_y, SCREEN_W, feet_y, rl.RED)
		}

		rl.EndDrawing()
	}
}

// `body` is the player after this frame's movement; `prev_feet` is where the feet
// were before it. Landing needs both: you may only land on a platform you were
// still above last frame, otherwise a fast fall would tunnel straight through it.
get_ground_y :: proc(prev_feet: f32, body: rl.Rectangle, platforms: []rl.Rectangle) -> f32 {
	ground_y := f32(rl.GetScreenHeight()) - body.height

	for rec in platforms {
		top := rec.y - body.height
		overlaps_x := body.x < rec.x + rec.width && body.x + body.width > rec.x
		if overlaps_x && prev_feet <= rec.y && top < ground_y {
			ground_y = top
		}
	}
	return ground_y
}
