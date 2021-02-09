local Piece = require 'tetris.components.piece'
local Ruleset = require 'tetris.rulesets.arika_ti'

local ARS = Ruleset:extend()

ARS.name = "ACE-ARS2"
ARS.hash = "ArikaACE2"
ARS.spawn_above_field = true

function ARS:onPieceCreate(piece, grid)
	piece.floorkick = 0
	piece.manipulations = 0
end

function ARS:onPieceMove(piece, grid)
	piece.lock_delay = 0 -- move reset
	if piece:isDropBlocked(grid) then
		piece.manipulations = piece.manipulations + 1
		if piece.manipulations >= 128 then
			piece:dropToBottom(grid)
			piece.locked = true
		end
	end
end

function ARS:onPieceRotate(piece, grid)
	piece.lock_delay = 0 -- rotate reset
	if piece:isDropBlocked(grid) then
		piece.manipulations = piece.manipulations + 1
		if piece.manipulations >= 128 then
			piece:dropToBottom(grid)
			piece.locked = true
		end
	end
	if piece.floorkick >= 1 then
		piece.floorkick = piece.floorkick + 1
	end
end

function ARS:get180RotationValue() return 3 end

function ARS:getDefaultOrientation() return 3 end  -- downward facing pieces by default

return ARS
