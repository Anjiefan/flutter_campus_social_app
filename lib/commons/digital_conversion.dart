class DigitalConversion{
  static String longDigitalToShort(String digital){
    if(double.parse(digital)>=100){
      digital="${(double.parse(digital)/1000).toStringAsPrecision(1).toString()}K ";
    }
    else{
      digital=digital;
    }
    return digital;
  }

}