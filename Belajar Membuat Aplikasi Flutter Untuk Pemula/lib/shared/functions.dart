part of 'shared.dart';

Future<bool> showConfirmationAlert({required BuildContext context, required String question}) async{
  return await confirm(
      context,
      content: Text(
        question,
        style: GoogleFonts.rubik(fontSize: 13)
      ),
      textOK: Text(
        "OK",
        style: GoogleFonts.rubik(
          color: Colors.green,
          fontWeight: FontWeight.w700,
          fontSize: 13
        )
      ),
      textCancel: Text(
        "Batal",
        style: GoogleFonts.rubik(
          color: Colors.red,
          fontWeight: FontWeight.w700,
          fontSize: 13
        )
      )
  );
}

String dateParsing(String date){
  date = date.substring(0, 10);
  List<String> dates = date.split("-");
  return "${int.parse(dates[2])} ${monthParsing(int.parse(dates[1]))} ${dates[0]}";
}

String timeParsing(String date){
  String time = date.substring(11,16);
  return time;
}

String monthParsing(int intMonth){
  if(intMonth == 1){
    return "Januari";
  }else if(intMonth == 2){
    return "Februari";
  }else if(intMonth == 3){
    return "Maret";
  }else if(intMonth == 4){
    return "April";
  }else if(intMonth == 5){
    return "Mei";
  }else if(intMonth == 6){
    return "Juni";
  }else if(intMonth == 7){
    return "Juli";
  }else if(intMonth == 8){
    return "Agustus";
  }else if(intMonth == 9){
    return "September";
  }else if(intMonth == 10){
    return "Oktober";
  }else if(intMonth == 1){
    return "November";
  }else if(intMonth == 12){
    return "Desember";
  }else{
    return '';
  }
}