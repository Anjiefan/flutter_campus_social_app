class HttpError{
  static String getErrorData(Map data){
    List error_list=[];
    data.forEach((key,value){
      try{
        error_list.addAll(value);
      }
      catch(e){
        error_list.add(value);
      }
    });
    String error_mes='';
    for(var index=1;index<error_list.length+1;index++){
      error_mes=error_mes+'$index.'+error_list[index-1]+'\n';
    }
    return error_mes;
  }

  static String getListErrorData(List data){
    List error_list=data;
    String error_mes='';
    for(var index=1;index<error_list.length+1;index++){
      error_mes=error_mes+'$index.'+error_list[index-1]+'\n';
    }
    return error_mes;
  }
}