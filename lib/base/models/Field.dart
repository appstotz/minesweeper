/// a field on the game panel
class Field {
  /// does this field contain a bomb
  final bool bomb;

  /// is the field revealed
  final bool revealed;

  /// is this field flagged to prevent revealing
  final bool flagged;

  /// the total count of the bombs on this and all surrounding fields
  final int totalBombs;

  /// the constructor
  const Field(this.bomb, this.revealed, this.flagged, this.totalBombs);

  /// create a copy with fagged set
  Field setFlagged(bool flagged) {
    return Field(bomb, revealed, flagged, totalBombs);
  }

  /// create a copy with revealed set
  Field setRevealed(bool revealed) {
    return Field(bomb, revealed, flagged, totalBombs);
  }
}
