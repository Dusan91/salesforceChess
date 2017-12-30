/**
 * Created by dusan on 12/19/2017.
 */

public with sharing class chessClassOne {
    List<ChessWrapOne> chO=new List<ChessWrapOne>();
    public Chess__c updChess { get; set; }
    public Boolean flip { get; set; }
   // public Integer numberOFClicks {get{return numberOFClicks;}set{numberOFClicks=value;} }

    public List<ChessWrapOne> getChessWrapOnes(){
        return chO;
    }

    public chessClassOne(ApexPages.StandardController ch){
        updChess=(Chess__c)ch.getRecord();
    }


    public PageReference flip(){
        String Id=(Id)ApexPages.currentPage().getParameters().get('tid');
        Boolean flipT=Boolean.valueOf(ApexPages.currentPage().getParameters().get('flip'));
        flip=flipT;
        return new PageReference('https://dusanproba-dev-ed--c.eu11.visual.force.com/apex/readChess?chId='+Id+'&flipT='+flipT);
    }

    public chessClassOne(){
        String Id=(Id)ApexPages.currentPage().getParameters().get('chId');
        Boolean flipT=Boolean.valueOf(ApexPages.currentPage().getParameters().get('flipT'));
        flip=flipT;
        System.debug('*************** ' +flip);
        System.debug(flipT);
        Integer i = 0;
        List<String> listOfRows;
        Integer total = 0;
        String p = '';
        Chess__c c = [select Name,Fen__c,Side_To_Move__c FROM Chess__c WHERE Id=:Id];
        i++;
        if (flipT) {
            listOfRows = c.Fen__c.reverse().split('/');
        }else{
            listOfRows = c.Fen__c.split('/');
        }
        List<List<String>> listOfFields = new List<List<String>>();
        for (Integer j = 0; j < listOfRows.size(); j++) {
            List<String> l = listOfRows[j].split('');
            List<String> qq = new List<String>();
            Integer s = 0;
            ///// adding numbers to empty spaces
            for (Integer n = 0; n < l.size(); n++) {
                if (l[n].isNumeric() && integer.valueOf(l[n]) < 9) {
                    for (Integer v = 0; v < integer.valueOf(l[n]); v++) {
                        qq.add('' + s + '');
                        s++;
                    }
                } else {
                    qq.add(l[n]);
                    s++;
                }
            }
            for (Integer a = 0; a < 8; a++) {
                total = a + j;
                if (math.mod(total, 2) == 0) {
                    if (qq[a].isNumeric() && integer.valueOf(qq[a]) < 9) {
                        qq[a] = 'ew.gif';
                    } else {
                        if (qq[a].isAllLowerCase()) {
                            qq[a] = 'b' + qq[a] + 'w.gif';

                        } else if (qq[a].isAllUpperCase()) {
                            p = qq[a].toLowerCase();
                            qq[a] = 'w' + p + 'w.gif';
                        }
                    }
                } else {
                    if (qq[a].isNumeric() && integer.valueOf(qq[a]) < 9) {
                        qq[a] = 'eb.gif';
                    } else {
                        if (qq[a].isAllLowerCase()) {
                            qq[a] = 'b' + qq[a] + 'b.gif';

                        } else if (qq[a].isAllUpperCase()) {
                            p = qq[a].toLowerCase();
                            qq[a] = 'w' + p + 'b.gif';
                        }
                    }
                }

            }
            ////////
            listOfFields.add(qq);
        }
        ChessWrapOne cwO=new ChessWrapOne(c,listOfRows,listOfFields);
        this.chO.add(cwO);

    }

    public PageReference updChessTableGet(){
        String Id=(Id)ApexPages.currentPage().getParameters().get('tid');
        return new PageReference('https://dusanproba-dev-ed--c.eu11.visual.force.com/apex/updateChess?tid='+Id);

    }
    public Chess__c getC{
        get{
            String Id=(Id)ApexPages.currentPage().getParameters().get('tid');
            return [SELECT Name,Fen__c,Side_To_Move__c FROM Chess__c WHERE Id=:Id];
         }
        set;
    }
    public PageReference updChessTable(){
        String Id=(Id)ApexPages.currentPage().getParameters().get('tid');
        Chess__c c=[SELECT Name,Fen__c,Side_To_Move__c FROM Chess__c WHERE Id=:Id];

        if(updChess.Name=='' || updChess.Name==null){
            c.Name=c.Name;
        }else{
            c.Name=updChess.Name;
        }
        if(updChess.Fen__c==''|| updChess.Fen__c==null){
            c.Fen__c=c.Fen__c;
        }else{
            c.Fen__c=updChess.Fen__c;
        }
        System.debug('chess '+c.Side_To_Move__c+' updChess  ' + updChess.Side_To_Move__c);
        if(updChess.Side_To_Move__c==' '|| updChess.Side_To_Move__c==null){
            c.Side_To_Move__c=c.Side_To_Move__c;
        }else{
            c.Side_To_Move__c=updChess.Side_To_Move__c;
        }
        System.debug('side         '+c.Side_To_Move__c);
        System.debug(c);
        update c;
        return new PageReference('https://dusanproba-dev-ed--c.eu11.visual.force.com/apex/readChess?chId='+c.Id+'&flipT=false');

    }
}