public class chessClass  {
    public Chess__c newTable { get; set; }
    public Chess__c che { get; set; }
    public String tid {get;set;}
    List<ChessWrap> ch=new List<ChessWrap>();


    public List<ChessWrap> getChessWraps(){
       return ch;
    }

    public chessClass(ApexPages.StandardController ch){
        newTable = (Chess__c)ch.getRecord();
    }
    public chessClass() {
       Integer i = 0;
        List<String> listOfRows;
        Integer total = 0;
        Boolean bool = true;
        String p = '';
        for (Chess__c c : [select Name,Fen__c,Side_To_Move__c FROM Chess__c]) {
            i++;
            listOfRows = c.Fen__c.split('/');
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

            ChessWrap cw=new ChessWrap(c,listOfRows,listOfFields);
            ch.add(cw);

        }
    }

    public PageReference deleteTable(){
        /*Chess__c c=[SELECT Id,Fen__c,Name,Side_To_Move__c FROM Chess__c WHERE Id=:selectedTableId];
        delete c;*/
        String tid=ApexPages.currentPage().getParameters().get('tid');
        Chess__c c=[SELECT Id,Fen__c,Name,Side_To_Move__c FROM Chess__c WHERE Id=:tid];
        System.debug(c);
        if (tid !=null && c.Id !=null) {
            delete c;
        }
        return new PageReference('https://dusanproba-dev-ed--c.eu11.visual.force.com/apex/chessPage');
    }
    public PageReference createT(){
        return new PageReference('https://dusanproba-dev-ed--c.eu11.visual.force.com/apex/createTable');
    }
    public PageReference createTable() {
        Chess__c c=new Chess__c();
        c.Name=newTable.Name;
        c.Fen__c=newTable.Fen__c;
        c.Side_To_Move__c=newTable.Side_To_Move__c;
        insert c;
        return new PageReference('https://dusanproba-dev-ed--c.eu11.visual.force.com/apex/chessPage');

    }

    public PageReference read(){
        String Id=(Id)ApexPages.currentPage().getParameters().get('tid');

        return new PageReference('https://dusanproba-dev-ed--c.eu11.visual.force.com/apex/readChess?chId='+Id+'&flipT=false');
    }




}