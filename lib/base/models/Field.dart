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
}
