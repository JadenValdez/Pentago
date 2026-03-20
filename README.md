# Pentago
A recreation of the 2-player board game Pentago. Will also try to implement PentagoXL if possible.

Goal:
	The goal of the game is to get five marbles in a row in any direction before your opponent does.

Rules:
	Choose a player to go first, then turns alternate between players. On their turn, a player must first place a ball of
	their color on any empty space on the board, then rotate any of the four blocks 90 degrees in either direction. 
	Rotating a block can be skipped if there are empty blocks on the board, or blocks that only have one marble in the
	middle (as rotating these blocks is the same as not rotating at all). A player wins if they place a marble that
	creates a five-in-a-row directly, or if they rotate a block to make a five-in-a-row without forming a five-in-a-row
	for the opponent. A tie can occur if a rotation creates a five-in-a-row for both players, or if all the spaces on 
	the board are filled and the last rotation does not form a five-in-a-row.