extension displayDoubles on double {
  String smartRoundToString(){
    if(this == roundToDouble()){
      return toInt().toString();
    }
    return toString();
  }
}