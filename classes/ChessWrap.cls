/**
 * Created by dusan on 12/18/2017.
 */

public with sharing class ChessWrap {
    public Chess__c chess {get;set;}
    public List<String> listOfRows{get;set;}
    public List<List<String>> listOfFields{get;set;}
   // public Chess__c oneChess {get;set;}



    public ChessWrap(Chess__c ch,List<String> lor,List<List<String>>  lof){
        this.chess=ch;
        this.listOfRows=lor;
        this.listOfFields=lof;
    }



}