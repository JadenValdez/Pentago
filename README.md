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


# Pentago XL
A larger variant of Pentago that allows up to four players and has 9 rotatable blocks instead of 4.

Goal: 
	The goal of the game is to get five marbles in a row of one of your owned colors in any direction before your 
	opponent(s) do.
	
Color Distribution:
	For three or four players, each player takes one of the four colors (Red, Blue, Yellow, Green)
	For two players, each player can take one color like normal, or play with 2 colors instead (ex. one player has Red
	and Green while the other player has Blue and Yellow)
	Team play is also possible for three players (1v2) or four players (2v2). Each team can take one or two colors,
	similar to how it would work for two players.
	
Rules:
	The rules are the same as Pentago except for the following changes:
		Turn order will now loop between all colors in play (Red, Blue, Yellow, Green)
		A player/team that owns two colors must make a five-in-a-row with one color. A five-in-a-row with two owned 
		colors will not win.
		If two or more five-in-a-rows are created with different colors, then the player/team who owns both colors will 
		be the winner. If the colors are owned by different players/teams, then it is a tie.
